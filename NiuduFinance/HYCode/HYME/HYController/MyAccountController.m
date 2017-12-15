//
//  MyAccountController.m
//  NiuduFinance
//
//  Created by 123 on 17/8/2.
//  Copyright © 2017年 liuyong. All rights reserved.
//

#import "MyAccountController.h"
#import "MyAccountCell.h"
#import "WebPageVC.h"
#import "MailViewController.h"
#import "AddressViewController.h"
#import "ModifyPasswordViewController.h"
#import "LoginViewController.h"
#import "MyBankCardViewController.h"
#import "AppDelegate.h"
#import "BaseNavigationController.h"
#import "CheckLoginViewController.h"
#import "TabBarController.h"
@interface MyAccountController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) UIView * dhView;
@property (nonatomic, strong) UILabel * dhTitleLabe;
@property (nonatomic, strong) UIImageView * imageVie;

@property (nonatomic, strong) UIView * firstView;
@property (nonatomic, strong) UIImageView * imageView1;
@property (nonatomic, strong) UIImageView * imageView2;
@property (nonatomic, strong) UILabel * myCardLabel;
@property (nonatomic, strong) UILabel * cardNameLabel;
@property (nonatomic, strong) UILabel * cardNumLabel;


@property (nonatomic, strong)NSDictionary * myAccountDic;
@property (nonatomic, strong)NSString * realnameStr;
@property (nonatomic, strong)NSString * idnumberStr;
@property (nonatomic, strong)NSString * mobileStr;
@property (nonatomic, strong)NSString * realMobileStr;
@property (nonatomic,strong)UIButton * tndBtn;
@property (nonatomic,strong)UILabel * versionLabel;

@property (nonatomic, copy) NSString *emailStr;
@property (nonatomic, copy) NSString *addressStr;
@end

@implementation MyAccountController
- (void)viewWillAppear:(BOOL)animated
{
    [self setTableViewInfo];
    [self getAccountSaftData];
    //隐藏导航栏
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    [self getAddress];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _tndBtn = [UIButton new];
    _myAccountDic = [NSDictionary alloc];
    _dhView = [UIView new];
    [_dhView setBackgroundColor:[UIColor whiteColor]];
    [self.view addSubview:_dhView];
    [_dhView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH, 64));
    }];
    
    _dhTitleLabe = [UILabel new];
    [_dhTitleLabe setText:@"我的账户"];
    [_dhTitleLabe setFont:[UIFont systemFontOfSize:17]];
    [self.dhView addSubview:_dhTitleLabe];
    [_dhTitleLabe mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(0);
        make.top.mas_equalTo(34);
        make.height.mas_equalTo(16);
    }];
    
    _imageVie = [UIImageView new];
    UIImage * image = [UIImage imageNamed:@"jianq.png"];
    _imageVie.image = image;
    [self.dhView addSubview:_imageVie];
    [_imageVie mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(34);
        make.left.mas_equalTo(15);
        make.size.mas_equalTo(CGSizeMake(18, 18));
    }];
    
    UITapGestureRecognizer *labelTapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(labelClick)];
    [_imageVie addGestureRecognizer:labelTapGestureRecognizer];
    _imageVie.userInteractionEnabled = YES;
    
//    _tableView.tableHeaderView.height = 161;
    _firstView = [UIView new];
    [_firstView setBackgroundColor:[UIColor whiteColor]];
//    _tableView.tableHeaderView = _firstView;
    [self.tableView addSubview:_firstView];
    [_firstView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(1);
        make.centerX.mas_equalTo(0);
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH, 161));
    }];
    
    
    UITapGestureRecognizer * firstViewTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(firstViewClick)];
    [_tableView.tableHeaderView addGestureRecognizer:firstViewTap];
    
    
    _imageView1 = [UIImageView new];
    UIImage * image1 = [UIImage imageNamed:@"my_Bankcard"];
    _imageView1.image = image1;
    [self.firstView addSubview:_imageView1];
    [_imageView1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(0);
        make.centerY.mas_equalTo(0);
        make.left.mas_equalTo(32);
        make.top.mas_equalTo(10);
    }];
    
    _imageView2 = [UIImageView new];
    UIImage * image2 = [UIImage imageNamed:@"qiek.png"];
    _imageView2.image = image2;
    [self.imageView1 addSubview:_imageView2];
    [_imageView2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(16);
        make.top.mas_equalTo(20);
        make.size.mas_equalTo(CGSizeMake(38, 29));
    }];
    
    _myCardLabel = [UILabel new];
    [_myCardLabel setText:@"我的快捷卡"];
    [_myCardLabel setTextColor:[UIColor whiteColor]];
    [_myCardLabel setFont:[UIFont systemFontOfSize:12]];
    [self.imageView1 addSubview:_myCardLabel];
    [_myCardLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_imageView2.mas_top);
        make.left.equalTo(_imageView2.mas_right).with.offset(8);
        make.height.mas_equalTo(12);
    }];
    
    _cardNameLabel = [UILabel new];
    [_cardNameLabel setText:@"未设置"];
    [_cardNameLabel setTextColor:[UIColor whiteColor]];
    [_cardNameLabel setFont:[UIFont systemFontOfSize:12]];
    [self.imageView1 addSubview:_cardNameLabel];
    [_cardNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(_imageView2.mas_bottom);
        make.left.equalTo(_imageView2.mas_right).with.offset(8);
        make.height.mas_equalTo(12);
    }];
    
    _cardNumLabel = [UILabel new];
    [_cardNumLabel setTextColor:[UIColor whiteColor]];
    [_cardNumLabel setText:@"**** **** **** ****"];
    [_cardNumLabel setFont:[UIFont systemFontOfSize:11]];
    [self.imageView1 addSubview:_cardNumLabel];
    [_cardNumLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-16);
        make.bottom.mas_equalTo(-23);
        make.height.mas_equalTo(10);
    }];

}
- (void)labelClick
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)firstViewClick
{
    if ( [User userFromFile].bankCardCount == 0) {
        return;
        
    }else{
        MyBankCardViewController * VC = [MyBankCardViewController new];
        [self.navigationController pushViewController:VC animated:YES];
    }
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
            NSString * bankIcon;
            bankIcon = [[_myAccountDic objectForKey:@"bankInfo"] objectForKey:@"bankIocn"];
            
            if (bankIcon!=nil) {
                NSString * str = [NetWorkingUtil mainURL];
                NSString * srtt = [[[[NSMutableString stringWithString:str]stringByAppendingString:@"resources/static/img/bankicon/" ]stringByAppendingString:bankIcon]stringByAppendingString:@".png"];
                NSLog(@"%@",srtt);
                [NetWorkingUtil setImage:_imageView2 url:srtt defaultIconName:@"bankInfo" successBlock:nil];
            }
            NSString *bankName = _myAccountDic[@"bankInfo"][@"bankName"];
            if (bankName == nil) {
                _cardNameLabel.text = [NSString stringWithFormat:@"未设置"];
                _cardNumLabel.text = [NSString stringWithFormat:@"未设置"];
            }else {
                _cardNameLabel.text = [NSString stringWithFormat:@"%@",[[_myAccountDic objectForKey:@"bankInfo"] objectForKey:@"bankName"]];
                _cardNumLabel.text = [NSString stringWithFormat:@"%@",[[_myAccountDic objectForKey:@"bankInfo"] objectForKey:@"bankNumber"]];
            }
            self.emailStr = [[_myAccountDic objectForKey:@"user"] objectForKey:@"email"];
            _realnameStr = [[_myAccountDic objectForKey:@"userDetail"] objectForKey:@"realname"];
            _idnumberStr = [[_myAccountDic objectForKey:@"userDetail"] objectForKey:@"idnumber"];
            NSString * mobileStr = [[_myAccountDic objectForKey:@"user"] objectForKey:@"mobile"];
            _realMobileStr = [[_myAccountDic objectForKey:@"user"] objectForKey:@"mobile"];
            NSString * numberString = [mobileStr stringByReplacingCharactersInRange:NSMakeRange(3, 4) withString:@"****"];
            _mobileStr = numberString;
            if(![_realnameStr isKindOfClass:[NSNull class]])
            {
                [[NSUserDefaults standardUserDefaults] setObject:_realnameStr forKey:@"USERINFOREALName"];
                [[NSUserDefaults standardUserDefaults]synchronize];
            }
            if(![_realMobileStr isKindOfClass:[NSNull class]])
            {
                [[NSUserDefaults standardUserDefaults] setObject:_realMobileStr forKey:@"USERINFOREALPhone"];
                [[NSUserDefaults standardUserDefaults]synchronize];
            }
            
        }
        [self.tableView reloadData];
    }];
}

- (void)setTableViewInfo
{
    //_tableView.tableFooterView.height = 50;
    [_tableView registerNib:[UINib nibWithNibName:@"MyAccountCell" bundle:nil] forCellReuseIdentifier:@"MyAccountCell"];
    NSDictionary *infoDict = [[NSBundle mainBundle] infoDictionary];
    NSString *appVersion = infoDict[@"CFBundleShortVersionString"];
    UIView *footView = [[UIView alloc] init];
    footView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 40);
    _versionLabel = [UILabel new];
    [_versionLabel setText:[NSString stringWithFormat:@"版本V%@",appVersion]];
    _versionLabel.frame = CGRectMake(0, 10, SCREEN_WIDTH, 10);
    _versionLabel.textAlignment = NSTextAlignmentCenter;
    [_versionLabel setTextColor:UIcolors];
    [_versionLabel setFont:[UIFont systemFontOfSize:13]];
    [footView addSubview:_versionLabel];
    self.tableView.tableFooterView = footView;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 5;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section ==0) {
        return 4;
    }else if (section == 1)
    {
        return 2;
    }else if (section == 2)
    {
        return 2;
    }else if (section == 3)
    {
        return 1;
    }else if (section == 4)
    {
        return 1;
    }
    return 0;
}

- (nullable NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section;
{
    if (section == 0) {
        return @"实名资料";
    }else if (section == 1)
    {
        return @"身份认证";
    }else if (section == 2)
    {
        return @"补充资料";
    }
    return @"";
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return 161+18+21;
    }else
    return 18;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"MyAccountCell";
    MyAccountCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[MyAccountCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    self.tableView.showsVerticalScrollIndicator = NO;
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];

    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            cell.titileLabel.text = @"真实姓名";
            if (IsStrEmpty(_realnameStr)) {
                cell.nameLabel.text = @"未设置";
            }else{
                
                cell.nameLabel.text = [self yincangName:_realnameStr];
            }
        }else if (indexPath.row == 1)
        {
            cell.titileLabel.text = @"证件类型";
            cell.nameLabel.text = @"身份证";
        }else if (indexPath.row == 2)
        {
            cell.titileLabel.text = @"证件号码";
            if (IsStrEmpty(_idnumberStr)) {
                cell.nameLabel.text = @"未设置";
            }else{
                cell.nameLabel.text = _idnumberStr;
            }
        }else if (indexPath.row == 3)
        {
            cell.titileLabel.text = @"手机号码";
            if (IsStrEmpty(_mobileStr)) {
                cell.nameLabel.text = @"未设置";
            }else{
                cell.nameLabel.text = _mobileStr;
            }
        }
    }else if (indexPath.section == 1)
    {
        if (indexPath.row == 0) {
            cell.titileLabel.text = @"身份信息";
            if ([[User userFromFile].isOpenAccount integerValue] == 0)
            {
                cell.nameLabel.text = @"未认证";
            }else{
                [cell.nameLabel setTextColor:[UIColor colorWithHexString:@"#0096FF"]];
                cell.nameLabel.text = @"已认证";
            }
        }else if (indexPath.row == 1)
        {
            cell.titileLabel.text = @"进行实名认证";
            if ([[User userFromFile].isOpenAccount integerValue] == 0)
            {
                cell.nameLabel.text = @"未设置>";
            }else{
                cell.nameLabel.text = @"进入汇付>";
            }
        }
    }else if (indexPath.section == 2)
    {
        if (indexPath.row == 0) {
            cell.titileLabel.text = @"联系地址";
            //cell.nameLabel.text = self.addressStr;
            cell.nameLabel.text = @"设置>";
        }else if (indexPath.row == 1)
        {
            cell.titileLabel.text = @"电子邮箱";
            if (IsStrEmpty([User userFromFile].email))
            {
                cell.nameLabel.text = @"未设置>";
            }else {
                cell.nameLabel.text = [NSString stringWithFormat:@"%@>",self.emailStr];
            }
        }
    }else if (indexPath.section == 3)
    {
        if (indexPath.row == 0) {
            cell.titileLabel.text = @"登录密码";
            cell.nameLabel.text = @"修改密码>";
        }
    }else if (indexPath.section == 4)
    {
        if (indexPath.row == 0) {
            UITableViewCell *tndCell = [tableView dequeueReusableCellWithIdentifier:@"tndcell"];
            if (tndCell == nil) {
                tndCell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"tndcell"];
                [_tndBtn setTitle:@"安全退出" forState:UIControlStateNormal];
                [_tndBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
                _tndBtn.titleLabel.font = [UIFont systemFontOfSize:16.0];
                _tndBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
                [_tndBtn addTarget:self action:@selector(tndbutton) forControlEvents:UIControlEventTouchUpInside];
                [tndCell addSubview:_tndBtn];
                [_tndBtn mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.top.mas_equalTo(0);
                    make.left.mas_equalTo(0);
                    make.right.mas_equalTo(0);
                    make.bottom.mas_equalTo(0);
                }];
            }
            return tndCell;
        }
    }
    [cell setMyAccountDic:_myAccountDic];
    return cell;
}

//隐藏名字后面
-(NSString *)yincangName:(NSString *)name
{
    NSString *n1 = [name substringToIndex:1];
    NSString *n2 = [name substringFromIndex:1];
    for(int i = 0; i < n2.length; i ++)
    {
        n1 = [NSString stringWithFormat:@"%@*",n1];
    }
    return n1;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        if (indexPath.row == 0)
        {
            
        }else if (indexPath.row == 1)
            
        {
        }else if (indexPath.row == 2)
        {
           
        }else if (indexPath.row == 3)
        {
            
        }
    }else if (indexPath.section == 1)
    {
        if (indexPath.row == 0)
        {
            
        }else if (indexPath.row == 1)
        {
            //汇付托管账户
            if ([[User userFromFile].isOpenAccount integerValue] == 0) {
                WebPageVC *vc = [[WebPageVC alloc] init];
                vc.title = @"开通汇付账户";
                vc.name = @"huifu/openaccount";
                [self.navigationController pushViewController:vc animated:YES];
                
            }else {
                WebPageVC *vc = [[WebPageVC alloc] init];
                vc.title = @"汇付账户";
                vc.name = @"huifu/login";
                [self.navigationController pushViewController:vc animated:YES];
            }
        }
    }else if (indexPath.section == 2)
    {
        if (indexPath.row == 0)
        {
            AddressViewController *vc = [[AddressViewController alloc] init];
            //NSLog(@"%@,%@",[[_myAccountDic objectForKey:@"user"] objectForKey:@"mobile"],[[_myAccountDic objectForKey:@"userDetail"] objectForKey:@"realname"]);
            vc.mobileStr = _realMobileStr;
            vc.realName = [[_myAccountDic objectForKey:@"userDetail"] objectForKey:@"realname"];
            vc.title = @"地址认证";
            [self.navigationController pushViewController:vc animated:YES];
        }else if (indexPath.row == 1)
        {
            //电子邮箱
            if (![[User userFromFile].email isEqualToString:@""]) {
                //绑定邮箱
                MailViewController *vc = [[MailViewController alloc] init];
                vc.isOldMail = YES;
                vc.title = @"修改邮箱";
                vc.mailReturn = ^(NSString *mailReturn) {
                    User *user = [User shareUser];
                    user.email = mailReturn;
                    [user saveUser];
                    [self.tableView reloadData];
                };
                [self.navigationController pushViewController:vc animated:YES];
            }else{
                //修改邮箱
                MailViewController *vc = [[MailViewController alloc] init];
                vc.isOldMail = NO;
                vc.title = @"绑定邮箱";
                vc.mailReturn = ^(NSString *mailReturn) {
                    User *user = [User shareUser];
                    user.email = mailReturn;
                    [user saveUser];
                    [self.tableView reloadData];
                };
                [self.navigationController pushViewController:vc animated:YES];
            }
        }
    }else if (indexPath.section == 3)
    {
        //修改登录密码
        ModifyPasswordViewController *vc = [[ModifyPasswordViewController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
    }else if (indexPath.section == 4)
    {

    }

}
- (void)tndbutton{
    
    NSLog(@"被点击了");
    NetWorkingUtil *util = [NetWorkingUtil netWorkingUtil];
    [util requestDic4MethodNam:@"v2/open/user/appExit" parameters:nil result:^(NSDictionary *dic, int status, NSString *msg) {
        
        if (status == 0) {
            [MBProgressHUD showMessag:msg toView:self.view];
        }else {
            
        }
    }];
    [[User shareUser] saveExit];
    [[User shareUser] removeUser];
    [User shareUser].userId = 0;
    //    [PCCircleViewConst removeGesture:gestureFinalSaveKey];
    //安全退出   退出登录按钮
//    LoginViewController * loginVC = [[LoginViewController alloc] init];
//    loginVC.typeStr = @"exit";
//    [self.navigationController pushViewController:loginVC animated:YES];
    //  跳转登录
//    AppDelegate *app = (AppDelegate *)[UIApplication sharedApplication].delegate;
//    CheckLoginViewController*modifyVC = [[CheckLoginViewController alloc] init];
//    BaseNavigationController *baseNav = [[BaseNavigationController alloc] initWithRootViewController:modifyVC];
//    baseNav.navigationBar.barTintColor = Nav019BFF;
//    baseNav.navigationBar.barStyle = UIBarStyleBlackOpaque;
//    [app.window.rootViewController presentViewController:baseNav animated:YES completion:^{
//    }];
//    return;
    //
//    AppDelegate *app = (AppDelegate *)[UIApplication sharedApplication].delegate;
//    LoginViewController *loginVC = [[LoginViewController alloc] init];
//    loginVC.typeStr = @"exit";
//    BaseNavigationController *baseNav = [[BaseNavigationController alloc] initWithRootViewController:loginVC];
//    baseNav.navigationBar.barTintColor = Nav019BFF;
//    baseNav.navigationBar.barStyle = UIBarStyleBlackOpaque;
//    [app.window.rootViewController presentViewController:baseNav animated:YES completion:^{
//    }];
    
    //
    TabBarController *tabbarController = [[TabBarController alloc] init];
    APPDELEGATE.window.rootViewController = tabbarController;
}

- (void)getAddress{
    
    MBProgressHUD *hud = [MBProgressHUD showStatus:nil toView:self.view];
    
    [self.httpUtil requestDic4MethodName:@"user/useraddress" parameters:nil result:^(NSDictionary *dic, int status, NSString *msg) {
        
        if (status == 1 || status == 2) {
            [hud hide:YES];
            if (![dic objectForKey:@"provincename"]) {
                self.addressStr = @"未设置";
            }else {
                self.addressStr = [NSString stringWithFormat:@"%@-%@-%@-%@",[dic objectForKey:@"provincename"], [dic objectForKey:@"cityname"], [dic objectForKey:@"districtname"], [dic objectForKey:@"address"]];
            }
            [self.tableView reloadData];
        }else {
            [hud dismissErrorStatusString:msg hideAfterDelay:1.0];
        }
    }];
    
}

//修改状态栏为黑色
- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleDefault;
}

@end
