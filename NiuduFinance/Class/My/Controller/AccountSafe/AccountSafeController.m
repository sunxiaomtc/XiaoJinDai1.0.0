//
//  AccountSafeController.m
//  NiuduFinance
//
//  Created by zhoupushan on 16/3/4.
//  Copyright © 2016年 liuyong. All rights reserved.
//

#import "AccountSafeController.h"
//#import "MyContentCell.h"
#import "AccountSafCell.h"
#import "AccountSafeCell.h"
#import "PSActionSheet.h"
#import "UIImage-Extensions.h"
#import "RealNameCertificationViewController.h"
#import "ModifyPhoneOneViewController.h"
#import "ModifyPasswordViewController.h"
#import "IdentityTestViewController.h"
#import "GestureVerifyViewController.h"
#import "NetWorkingUtil.h"
#import "User.h"
#import "ModifyPhoneTwoViewController.h"
#import "MailViewController.h"
#import "AddressViewController.h"
#import "WebPageVC.h"

//h1

#import "PCCircleViewConst.h"
#import "LoginViewController.h"
#import "BankViewController.h"
#import "MyBankCardViewController.h"
//h2

@interface AccountSafeController ()<UITableViewDelegate,UITableViewDataSource,UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UIAlertViewDelegate>
@property (strong, nonatomic) IBOutlet UIView *headerView;
@property (weak, nonatomic) IBOutlet UIImageView *backImageView;
@property (weak, nonatomic) IBOutlet UIButton *iconButton;

@property (nonatomic,strong)NSDictionary *myAccountDic;
@property (nonatomic,strong)NSMutableDictionary *myAccountUserInfor;
//H1
@property (nonatomic,strong)UIButton * tndBtn;

//用户名
@property (weak, nonatomic) IBOutlet UILabel *userNameLabel;
//版本号
@property (nonatomic,strong)UILabel * versionLabel;

//H2


@end
#define kHeaderViewHeight 93
//static NSString *cellIdentifier = @"MyContentCell";
static NSString *accountSafCell=@"AccountSafCell";
static NSString *accountSafeCell=@"AccountSafeCell";
@implementation AccountSafeController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupNavi];
    [self setupTableView];
    
    _tndBtn = [UIButton new];
    
    _versionLabel = [UILabel new];

}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    _myAccountDic = [NSDictionary dictionary];
    _myAccountUserInfor = [NSMutableDictionary dictionaryWithCapacity:0];
    [self.navigationController setNavigationBarHidden:NO animated:NO];
    [self getAccountSaftData];
    
    
}


- (void)getAccountSaftData
{
    NetWorkingUtil *util = [NetWorkingUtil netWorkingUtil];
    [util requestDic4MethodNam:@"v2/accept/user/getUserInfo" parameters:nil result:^(NSDictionary *dic, int status, NSString *msg) {
        NSLog(@"_____%@",dic);
        
        if (status == 0) {
                [MBProgressHUD showMessag:msg toView:self.view];
        }else{
                _myAccountDic=dic;

                UIImageView *iconImageView = [[UIImageView alloc]init];
                
                NSString * url = [[dic objectForKey:@"user"] objectForKey:@"avatar"];
                
                if (![url isKindOfClass:[NSNull class]]) {
                    [NetWorkingUtil setImage:iconImageView url:url defaultIconName:@"my_defaultIcon" successBlock:nil];
                    UIImage *image = [iconImageView.image imageMakeRoundCornerSizeImageView:_iconButton.imageView];
                    [_iconButton setImage:image forState:UIControlStateNormal];
                }
                NSString * iconButton = [[dic objectForKey:@"user"] objectForKey:@"username"];
                if (![iconButton isKindOfClass:[NSNull class]]) {
                    
                    _iconButton.titleLabel.text = iconButton;
                    NSLog(@"%@",_iconButton.titleLabel.text);
                }
                _userNameLabel.text = _iconButton.titleLabel.text;
                
                User *user = [User shareUser];
                //头像名字
                NSString * realName = [[dic objectForKey:@"userDetail"] objectForKey:@"realname"];
                if (![realName isKindOfClass:[NSNull class]]) {
                    user.realName = realName;
                }
                
                NSString * str = [[dic objectForKey:@"user" ]objectForKey:@"mobile"];
                NSLog(@"%@",str);
                NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
                [userDefaults setObject:str forKey:@"mobile"];
                [userDefaults synchronize];
                
                
                
                _nameLabel.text = user.realName;
                NSLog(@"------%@",user.realName);
                
                user.idValidate = [[dic objectForKey:@"IdValidate"] intValue];
                NSLog(@"------%d",user.idValidate);
                
                
                NSString * bankInfo = [dic objectForKey:@"bankInfo"];
                if (![bankInfo isKindOfClass:[NSNull class]]) {
                    user.bankInfo = bankInfo;
                    NSLog(@"-----%@",user.bankInfo);
                }
                
                
                NSString * userAddress =  [dic objectForKey:@"UserAddress"];
                if (![userAddress isKindOfClass:[NSNull class]]) {
                    user.userAddress = userAddress;
                    NSLog(@"------%@",user.userAddress);
                }
                //电子邮箱
                NSString * email =[[dic objectForKey:@"user"] objectForKey:@"email"];
                if (![email isKindOfClass:[NSNull class]]) {
                    user.email = email;
                    NSLog(@"------%@",user.email);
                }
                [user saveUser];

            
            

        }
        [self.tableView reloadData];
    }];
}

- (void)viewDidLayoutSubviews
{
    // headerView
    [_headerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.tableView).offset(-kHeaderViewHeight-10);
        make.left.width.equalTo(self.tableView);
        make.height.equalTo(@(kHeaderViewHeight));
    }];
    
}

#pragma mark - Set Up UI
- (void)setupNavi
{
    [self.navigationController setNavigationBarHidden:NO animated:NO];
    self.title = @"个人中心";
    
    UIButton *customView = [UIButton buttonWithType:UIButtonTypeCustom];
    customView.frame = CGRectMake(0, 0, 44, 44);
    customView.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [customView setImage:[UIImage imageNamed:@"nav_back_normal"] forState:UIControlStateNormal];
    [customView addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:customView];
}

- (void)setupTableView
{
    self.tableView.contentInset = UIEdgeInsetsMake(kHeaderViewHeight, 0, 0, 0);
    [self.tableView addSubview:_headerView];
    //禁止滚动
    self.tableView.scrollEnabled = NO;
    // 注册Cell
    [self.tableView registerNib:[UINib nibWithNibName:accountSafCell bundle:nil] forCellReuseIdentifier:accountSafCell];
    
    [self.tableView registerNib:[UINib nibWithNibName:accountSafeCell bundle:nil] forCellReuseIdentifier:accountSafeCell];
    
}

#pragma mark - Actions
- (IBAction)headerRightArrowAction
{
    PSActionSheet *actionSheet = [[PSActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"从相册选择",@"拍照", nil];
    [actionSheet showInView:self.view];
}

- (IBAction)iconAction
{
    //
    PSActionSheet *actionSheet = [[PSActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"从相册选择",@"拍照", nil];
    [actionSheet showInView:self.view];
}

- (void)backAction
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - UIActionSheetDelegate
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 2)
    {
        return;
    }
    
    //非法判断
    BOOL available;
    if (buttonIndex == 0)
    {
        // 从相册选择
        available = [UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary];
        
    }
    else if (buttonIndex == 1)
    {
        // 拍照
        available = [UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera];
    }
    
    if (!available)
    {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"您的设备不支持该功能！" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alertView show];
        return;
    }
    
    UIImagePickerController *vc = [[UIImagePickerController alloc] init];
    if (buttonIndex == 1)
    {
        vc.sourceType = UIImagePickerControllerSourceTypeCamera;
    }
    vc.allowsEditing = YES;// 允许编辑
    vc.delegate = self;
    
    if ([[[UIDevice currentDevice] systemVersion] floatValue]>=8.0) {
        self.modalPresentationStyle=UIModalPresentationOverCurrentContext;
    }
    [self presentViewController:vc animated:YES completion:nil];
}

#pragma mark - UIImagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
    NSLog(@"%@",info);
    UIImage *image = info[@"UIImagePickerControllerEditedImage"];
    image = [image imageMakeRoundCornerSizeImageView:_iconButton.imageView];
    
    
    [picker dismissViewControllerAnimated:YES completion:nil];
    
    MBProgressHUD *hud = [MBProgressHUD showStatus:nil toView:nil];
    NetWorkingUtil *util = [NetWorkingUtil netWorkingUtil];
    [util requestImageMethodName:@"user/uploadavatar" parameters:@{@"UserId":@([User userFromFile].userId)} images:@[image] result:^(id obj, int status, NSString *msg) {
        
        if (status == 1 || status == 2) {
            [hud dismissSuccessStatusString:@"上传成功" hideAfterDelay:1.0];
            [_iconButton setImage:image forState:UIControlStateNormal];
        }else{
            [hud dismissErrorStatusString:msg hideAfterDelay:1.0];
        }
        
    }];
}


#pragma mark - UIScollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat offsetY = scrollView.contentOffset.y;
    if (offsetY < -kHeaderViewHeight)
    {
        [_backImageView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(offsetY+kHeaderViewHeight).priority(MASLayoutPriorityRequired);
        }];
        [self getAccountSaftData];
    }
}

#pragma mark - UITableViewDelegate & UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    switch (section) {
        case 0:
            return 2;
            break;
        case 1:
            return 3;
            break;
        case 2:
            return 1;
            break;
        case 3:
            return 1;
            break;
        default:
            return 0;
            break;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    if (indexPath.section == 0) {
        AccountSafCell *cell = [tableView dequeueReusableCellWithIdentifier:accountSafCell forIndexPath:indexPath];
        NSString *title;
        NSString *detailText;
        BOOL hideLine;
        BOOL jianTouImageView;
        BOOL zhegnjainLabel;
        if (indexPath.section == 0 && indexPath.row == 0)
        {

            if ([[User userFromFile].isOpenAccount integerValue] == 0) {
                detailText = @"未认证";

                jianTouImageView = YES;
            }else{
                detailText = [NSString stringWithFormat:@"%@**",[[[_myAccountDic objectForKey:@"userDetail"]objectForKey:@"realname"] substringToIndex:1]];
                jianTouImageView = YES;
                NSString * zhegnjainLabel = [[_myAccountDic objectForKey:@"userDetail"]objectForKey:@"idnumber" ];
                if (![zhegnjainLabel isKindOfClass:[NSNull class]]) {
                    cell.zhegnjainLabel.text=zhegnjainLabel;
                }
            }
            title = @"实名认证";
            hideLine = NO;
        }
        else if (indexPath.section == 0 && indexPath.row == 1)
        {
            if ([User userFromFile].bankCardCount == 0) {
                
                detailText = @"未绑定";
                jianTouImageView = YES;
            }else{
                detailText = [NSString stringWithFormat:@"%@",[[_myAccountDic objectForKey:@"bankInfo"]objectForKey:@"bankName" ] ];
                jianTouImageView = NO;
            }
            NSString * zhegnjainLabel = [[_myAccountDic objectForKey:@"bankInfo"] objectForKey:@"bankNumber"];
            if (![zhegnjainLabel isKindOfClass:[NSNull class]]) {
                cell.zhegnjainLabel.text=zhegnjainLabel;
            }
            title = @"银 行 卡";
            hideLine = YES;
         }
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        [cell setuptitle:title detailText:detailText hideLine:hideLine jianTouImageView:jianTouImageView  zhegnjainLabel:zhegnjainLabel];
        return cell;

    }else{
        AccountSafeCell *cell = [tableView dequeueReusableCellWithIdentifier:accountSafeCell forIndexPath:indexPath];
        NSString *title;
        NSString *detailText;
        BOOL hideLine;
        BOOL jianTouImageView;
        if(indexPath.section == 1 && indexPath.row == 0){
            //托管账户
            if ([[User userFromFile].isOpenAccount integerValue] == 0) {
                detailText = @"点此设置";
            }else{
                
                detailText = @"已设置";
                
            }
            title = @"托管账户";
            hideLine = NO;
            
        }else if (indexPath.section == 1 && indexPath.row == 1){
            
            
            if (IsStrEmpty([User userFromFile].email)) {
                
                detailText = @"点此设置";
                
            }else{
                
                detailText = @"已设置";
                
            }
            title = @"电子邮箱";
            
            hideLine = NO;
            

            
        }else if (indexPath.section == 1 && indexPath.row == 2){
            if ([[User userFromFile].userAddress integerValue] == 0) {
                
                detailText = @"点此设置";
                
            }else{
                
                detailText = @"已认证";
                
            }
            title = @"联系地址";
            hideLine = YES;
            
        }
        
        else if (indexPath.section == 2 && indexPath.row == 0)
        {
            title = @"登录密码";
            
            detailText = @"";
            hideLine = NO;
            
            
        }
//        else if (indexPath.section == 2 && indexPath.row == 1)
//        {
//            title = @"手势密码";
//            detailText = @"";
//            hideLine = YES;
//            
//        }
        else if (indexPath.section ==3){
            
            //        tndBtn.backgroundColor = [UIColor whiteColor];
            [_tndBtn setTitle:@"安全退出" forState:UIControlStateNormal];
            [_tndBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            _tndBtn.titleLabel.font = [UIFont systemFontOfSize:16.0];
            _tndBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
            [_tndBtn addTarget:self action:@selector(tndbutton) forControlEvents:UIControlEventTouchUpInside];
            [cell addSubview:_tndBtn];
            [_tndBtn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(0);
                make.left.mas_equalTo(0);
                make.right.mas_equalTo(0);
                make.bottom.mas_equalTo(0);
            }];
            
            jianTouImageView = YES;
            
            [_versionLabel setText:@"版本V3.0.5"];
            [_versionLabel setTextColor:[UIColor colorWithHexString:@"#25A9FE"]];
            [_versionLabel setFont:[UIFont systemFontOfSize:13]];
            [self.view addSubview:_versionLabel];
            [_versionLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(_tndBtn.mas_bottom).with.offset(10);
                make.centerX.equalTo(_tndBtn.mas_centerX).with.offset(0);
                make.height.mas_equalTo(10);
            }];
            
        }
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        [cell setuptitle:title detailText:detailText hideLine:hideLine jianTouImageView:jianTouImageView ];
 
        return cell;
    }
    
}

- (void)tndbutton{
    
    NSLog(@"被点击了");
    
    NetWorkingUtil *util = [NetWorkingUtil netWorkingUtil];
    [util requestDic4MethodNam:@"v2/open/user/appExit" parameters:nil result:^(NSDictionary *dic, int status, NSString *msg) {
        
        if (status == 0) {
            [MBProgressHUD showMessag:msg toView:self.view];
        }else{
            
        }
    }];

    
    [[User shareUser] saveExit];
    [[User shareUser] removeUser];
    [User shareUser].userId = 0;
//    [PCCircleViewConst removeGesture:gestureFinalSaveKey];
     LoginViewController*loginVC = [[LoginViewController alloc] init];
    loginVC.typeStr = @"exit";
    [self.navigationController pushViewController:loginVC animated:YES];
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.01;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 10.0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44.0;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0 && indexPath.row == 0)
    {

//        if ([[User userFromFile].isOpenAccount integerValue] == 0) {
//
//        }else{
//            RealNameCertificationViewController *vc = [[RealNameCertificationViewController alloc] init];
//            [self.navigationController pushViewController:vc animated:YES];
//        }
        
    }else if (indexPath.section == 0 && indexPath.row == 1){
        
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
        if ( [User userFromFile].bankCardCount == 0) {
            return;
            
        }else{
            MyBankCardViewController * VC = [MyBankCardViewController new];
            [self.navigationController pushViewController:VC animated:YES];
        }
     }else if (indexPath.section == 1 && indexPath.row == 0){

        //汇付托管账户
        if ([[User userFromFile].isOpenAccount integerValue] == 0) {
            WebPageVC *vc = [[WebPageVC alloc] init];
            vc.title = @"开通汇付账户";
            vc.name = @"huifu/openaccount";
            [self.navigationController pushViewController:vc animated:YES];
            
        }else{
            
            WebPageVC *vc = [[WebPageVC alloc] init];
            vc.title = @"汇付账户";
            vc.name = @"huifu/login";
            [self.navigationController pushViewController:vc animated:YES];
            
        }
            
    }
    
    else if (indexPath.section == 1 && indexPath.row == 1){
        //电子邮箱
        MailViewController *vc = [[MailViewController alloc] init];
        if (![[User userFromFile].email isEqualToString:@""]) {
            
            //绑定邮箱
            vc.title = @"验证原邮箱";
            
            vc.isOldMail = YES;
            
            
        }else{
            
            //修改邮箱
            vc.isOldMail = NO;
            vc.title = @"绑定邮箱";
            
        }
        
        [self.navigationController pushViewController:vc animated:YES];
        
    }else if(indexPath.section == 1 && indexPath.row == 2){
        //联系地址
        
            AddressViewController *vc = [[AddressViewController alloc] init];
            vc.mobileStr = [_myAccountDic objectForKey:@"mobile"];
            vc.realName = [NSString stringWithFormat:@"%@",[_myAccountDic objectForKey:@"realname"]];
            vc.title = @"地址认证";
            [self.navigationController pushViewController:vc animated:YES];
        
    }
    
    else if (indexPath.section == 2 && indexPath.row == 0)
    {
        //修改登录密码
        ModifyPasswordViewController *vc = [[ModifyPasswordViewController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
    }
    else if (indexPath.section == 2 && indexPath.row == 1)
    {
        //修改手势密码
        GestureVerifyViewController *gestureVerifyVc = [[GestureVerifyViewController alloc] init];
        gestureVerifyVc.isToSetNewGesture = YES;
        [self.navigationController pushViewController:gestureVerifyVc animated:YES];
    }
    else if (indexPath.section == 3)
    {
        [tableView deselectRowAtIndexPath:indexPath animated:NO];
    }
    
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1) {
        RealNameCertificationViewController *vc = [[RealNameCertificationViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }
}

@end
