//
//  IntegralViewController.m
//  NiuduFinance
//
//  Created by andrewliu on 16/9/18.
//  Copyright © 2016年 liuyong. All rights reserved.
//

#import "IntegralViewController.h"
#import "IntegralHeaderView.h"
#import "ExchangeHBTableViewCell.h"
#import "IntegralLogTableViewCell.h"
#import "PSActionSheet.h"
#import "UIImage-Extensions.h"
#import "UIView+Extension.h"

#define ExchageShopCellID @"ExchangeHBTableViewCell"
#define IntegralCellID @"IntegralLogTableViewCell"


@interface IntegralViewController ()<UITableViewDelegate,UITableViewDataSource,UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *selectButtonArr;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic,strong) IntegralHeaderView *headerView;
@property (nonatomic,strong) UIButton *currentButton;

@property (nonatomic,strong) NSDictionary *saveIntegralDic;
@property (nonatomic,strong) NSDictionary *integralDic;
//积分可换购的产品
@property (nonatomic,strong) NSMutableArray *integralProjectArr;
//积分记录
@property (nonatomic,strong) NSMutableArray *logIntegralArr;

@property (nonatomic,assign) NSInteger PageSize;
@property (nonatomic,assign) NSInteger page;
@property (weak, nonatomic) IBOutlet UIButton *backBtn;
@property (weak, nonatomic) IBOutlet UIButton *qdBtn;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UIButton *iconButton;
@property (nonatomic,strong)NSDictionary *myImageDic;
@property (weak, nonatomic) IBOutlet UIImageView *chouImage;
@property (weak, nonatomic) IBOutlet UIImageView *jiImage;
@property (weak, nonatomic) IBOutlet UILabel *kyjfLabel;



@end

@implementation IntegralViewController
{
    NSInteger projectNum;
    int itemCounts;
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    [self getAccountSaftData];
    [self loadGiftData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _page = 1;
    _PageSize = 5;
    
    projectNum = -1;
    [self loadTableView];
    _currentButton = _selectButtonArr[0];
    _integralDic = [NSMutableDictionary dictionary];
    _saveIntegralDic = [NSMutableDictionary dictionary];
    _integralProjectArr = [NSMutableArray array];
    _logIntegralArr = [NSMutableArray array];
    _myImageDic = [NSDictionary dictionary];
    
    _qdBtn.layer.cornerRadius = 4.0f;
    _qdBtn.clipsToBounds = YES;
    [_qdBtn.layer setBorderWidth:1];
    _qdBtn.layer.borderColor = [UIColor whiteColor].CGColor;
    self.tableView.tableFooterView.height = 20;
}

- (void)getAccountSaftData {
    
    NetWorkingUtil *util = [NetWorkingUtil netWorkingUtil];
    [util requestDic4MethodNam:@"v2/accept/user/getUserInfo" parameters:nil result:^(NSDictionary *dic, int status, NSString *msg) {
        if (status == 0) {
            [MBProgressHUD showMessag:msg toView:self.view];
        }else {
            _myImageDic=dic;
            UIImageView *iconImageView = [[UIImageView alloc]init];
            NSString * url = [[dic objectForKey:@"user"] objectForKey:@"avatar"];
            if (![url isKindOfClass:[NSNull class]]) {
                [NetWorkingUtil setImage:iconImageView url:url defaultIconName:@"my_defaultIcon" successBlock:nil];
                UIImage *image = [iconImageView.image imageMakeRoundCornerSizeImageView:_iconButton.imageView];
                [_iconButton setImage:image forState:UIControlStateNormal];
            }
        }
        [self.tableView reloadData];
    }];
}

- (IBAction)backBtn:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)iconAction:(id)sender {
    PSActionSheet *actionSheet = [[PSActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"从相册选择",@"拍照", nil];
    [actionSheet showInView:self.view];
}

#pragma mark - UIActionSheetDelegate
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 2) {
        return;
    }
    //非法判断
    BOOL available;
    if (buttonIndex == 0) {
        // 从相册选择
        available = [UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary];
    }
    else if (buttonIndex == 1) {
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
    UIImage *image = info[@"UIImagePickerControllerEditedImage"];
    image = [image imageMakeRoundCornerSizeImageView:_iconButton.imageView];
    
    
    [picker dismissViewControllerAnimated:YES completion:nil];
    
    MBProgressHUD *hud = [MBProgressHUD showStatus:nil toView:nil];
    NetWorkingUtil *util = [NetWorkingUtil netWorkingUtil];
    [util requestImageMethodName:@"user/uploadavatar" parameters:@{@"UserId":@([User userFromFile].userId)} images:@[image] result:^(id obj, int status, NSString *msg) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
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
    if (offsetY < -10)
    {
        [self getAccountSaftData];
    }
}
//签到
- (IBAction)qdBtn:(id)sender {
    
    _qdBtn.userInteractionEnabled = NO;
    [_qdBtn setTitle:@"已签" forState:UIControlStateNormal];
    _qdBtn.backgroundColor = [UIColor clearColor];
    [self loadTodaySign];
    [self loadDataGiftDate];
}

- (void)loadTableView{
    
    [self setupRefreshWithTableView:_tableView];
    _tableView.tableFooterView = [UIView new];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorStyle = NO;
    [self.tableView registerNib:[UINib nibWithNibName:ExchageShopCellID bundle:nil] forCellReuseIdentifier:ExchageShopCellID];
    
    [self.tableView registerNib:[UINib nibWithNibName:IntegralCellID bundle:nil] forCellReuseIdentifier:IntegralCellID];
   
    [self loadIntegralData];
}
//也是一种方法
//- (void)loadHeaderView{
//
//    _headerView = [IntegralHeaderView viewFromXib];
////        _tableView.tableHeaderView = _headerView;
//    [self.tableView addSubview:_headerView];
//        [_headerView mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.left.equalTo(self.tableView);
//            make.top.equalTo(self.tableView).offset(0);
//            make.right.equalTo(self.view.mas_right);
//            make.height.mas_equalTo(120);
//        }];
//}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)selectAction:(id)sender {
    
    if (_currentButton == sender) {
        return;
    }else{
        
        [_currentButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];

    }
    _currentButton = sender;
    [_currentButton setTitleColor:NaviColor forState:UIControlStateNormal];

    if (_currentButton == _selectButtonArr[0]) {
        NSLog(@"抽奖领券");
        UIImage * image2 = [UIImage imageNamed:@"积分2.png"];
        _jiImage.image = image2;
        //加载积分换购数据
        [self loadIntegralData];
    }else if (_currentButton == _selectButtonArr[1]){
//        [_headerView removeAllSubviews];
        NSLog(@"积分记录");
        UIImage * image2 = [UIImage imageNamed:@"积分1.png"];
        _jiImage.image = image2;
        [self loadIntergralLog];
    }
}

#pragma mark -- 积分记录

- (void)loadIntergralLog{
    self.hideNoMsg = YES;
    _tableView.separatorStyle = YES;
//    MBProgressHUD *hud = [MBProgressHUD showStatus:@"" toView:self.view];
    [self.httpUtil requestDic4MethodName:@"integral/log" parameters:@{@"PageIndex":@(_page),@"PageSize":@(_PageSize)} result:^(NSDictionary *dic, int status, NSString *msg) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        if (status == 1 || status == 2) {
            self.hideNoNetWork = YES;
            [_tableView.mj_footer endRefreshing];
            [_tableView.mj_header endRefreshing];
            
            if (_page == 1) {
                [_logIntegralArr  removeAllObjects];
            }
           
           [_logIntegralArr addObjectsFromArray: [dic objectForKey:@"Data"]];
            NSLog(@"%ld",_logIntegralArr.count);
            itemCounts = [[dic objectForKey:@"RecordCount"] intValue];
            NSLog(@"%d",itemCounts);
            
            if (_integralProjectArr.count == 0) {
                
//                self.hideNoNetWork = NO;
//                self.noNetWorkView.top = 38;
//                self.noNetWorkView.height = SCREEN_HEIGHT - 38;
//                self.noNetWorkView.width = SCREEN_WIDTH;
            }
        }else{
            [MBProgressHUD showError:msg toView:self.view];
//            self.hideNoNetWork = NO;
//            self.noNetWorkView.top = 38;
//            self.noNetWorkView.height = SCREEN_HEIGHT - 38;
//            self.noNetWorkView.width = SCREEN_WIDTH;
        }
        [_tableView reloadData];
    }];
    
}

#pragma mark -- 签到

- (void)loadTodaySign{

    [self.httpUtil requestDic4MethodName:@"integral/todaysign" parameters:nil result:^(NSDictionary *dic, int status, NSString *msg) {
        NSLog(@"%@",dic);
        if (status == 1 || status == 2) {
             [MBProgressHUD show:@"签到成功" andShowLabel:msg icon:@"successPage"  view:self.view];
            [self headerRefreshloadData];
            [self loadDataGiftDate];
        }else {
            [MBProgressHUD showError:msg toView:self.view];
        }
         [self.tableView reloadData];
        [self loadGiftData];
    }];
}

#pragma mark -- 加载签到天数

- (void)loadGiftData{
    [self.httpUtil requestDic4MethodNam:@"v2/accept/integralActivity/sign" parameters:nil result:^(NSDictionary *dic, int status, NSString *msg) {
        _timeLabel.text = [NSString stringWithFormat:@"已连续签到%@天",[dic objectForKey:@"giftDate"]];
    }];
}

#pragma mark -- 加载我的积分
- (void)loadIntegralData{

    _tableView.separatorStyle = YES;
//    MBProgressHUD *hud = [MBProgressHUD showStatus:@"" toView:self.view];
    [self.httpUtil requestDic4MethodName:@"integral/myintegral" parameters:nil result:^(NSDictionary *dic, int status, NSString *msg) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        if (status == 1 || status == 2) {
            self.hideNoNetWork = YES;
            [_tableView.mj_footer resetNoMoreData];

            _saveIntegralDic = dic;
            
            if ([[_saveIntegralDic objectForKey:@"IsCansign"] integerValue] == 0) {
                _qdBtn.userInteractionEnabled = NO;
                [_qdBtn setTitle:@"已签" forState:UIControlStateNormal];
                _qdBtn.backgroundColor = [UIColor clearColor];
            }
            NSLog(@"%ld",[[_saveIntegralDic objectForKey:@"IsCansign"] integerValue]);
            NSLog(@"%ld",[[_saveIntegralDic objectForKey:@"Integral"] integerValue]);
            
            NSString * sjStr = [NSString stringWithFormat:@"可用积分：%@",[dic objectForKey:@"Integral"]];
            _kyjfLabel.text = sjStr;
            _integralProjectArr = [dic objectForKey:@"IntegralProducts"];
            NSLog(@"%ld",_integralProjectArr.count);
            
            if (_integralProjectArr.count == 0) {
                
//                self.hideNoNetWork = NO;
//                self.noNetWorkView.top = 120;
//                self.noNetWorkView.height = SCREEN_HEIGHT - 120;
//                self.noNetWorkView.width = SCREEN_WIDTH;
            }
        }else{
//            [MBProgressHUD showError:msg toView:self.view];
            
        }
        [_tableView reloadData];
        
    }];
    
}

#pragma mark -- 换购提交
- (void)loadExchangeShopData{
    
    [self.httpUtil requestDic4MethodName:@"integral/integralbuy" parameters:@{@"ProductId":[_integralProjectArr[projectNum] objectForKey:@"ProductId"] } result:^(NSDictionary *dic, int status, NSString *msg) {
        
        if (status == 1 || status == 2) {
            
            self.hideNoNetWork = YES;
            [_tableView.mj_footer resetNoMoreData];
            
            [MBProgressHUD showMessag:@"兑换成功" toView:self.view];
            [self headerRefreshloadData];
            
        }else{
            [MBProgressHUD showError:msg toView:self.view];
            
        }
        
        
        [_tableView reloadData];
        
    }];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (_currentButton == _selectButtonArr[0]) {
        return _integralProjectArr.count;
    }else{
       return 1;
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{

    if (_currentButton == _selectButtonArr[0]) {
        if (section == 0) {
            return 5;
        }else{
            return 15;
        }
    }
    return 0.1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (_currentButton == _selectButtonArr[0]) {
        return 1;
    }else{
        return _logIntegralArr.count;
    }
}

//- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
//{
//    if (_currentButton == _selectButtonArr[0]) {
//         static NSString *headerId = @"headerViewID";
//        _headerView = (IntegralHeaderView *)[tableView dequeueReusableHeaderFooterViewWithIdentifier:headerId];
//        if (_headerView == nil) {
//            _headerView = [[IntegralHeaderView alloc] init];
//        }
//        [self.tableView addSubview:_headerView];
//        [_headerView mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.left.equalTo(self.tableView);
//            make.top.equalTo(self.tableView).offset(5);
//            make.right.equalTo(self.view.mas_right);
//            make.height.mas_equalTo(373);
//        }];

//        _headerView.dic = _saveIntegralDic;
       
//        UIView * linVie = [UIView new];
//        linVie.backgroundColor = [UIColor colorWithHexString:@"#F5F5F5"];
//        [self.tableView addSubview:linVie];
//        [linVie mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.top.equalTo(_headerView.mas_bottom).with.offset(10);
//            make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH, 4));
//        }];
//        UILabel * dhLabel = [UILabel new];
//        [dhLabel setText:@"积分兑换"];
//        [dhLabel setFont:[UIFont systemFontOfSize:13]];
//        [self.tableView addSubview:dhLabel];
//        [dhLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.top.equalTo(linVie.mas_bottom).with.offset(20);
//            make.left.mas_equalTo(15);
//            make.height.mas_equalTo(13);
//        }];
        
//        return _headerView;
//    }else{
//        return nil;
//    }
   
//}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (_currentButton == _selectButtonArr[0]) {
        return 75;
    }
    
    return 75;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (_currentButton == _selectButtonArr[0]) {
        
        ExchangeHBTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ExchageShopCellID];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.hongbaoDic = _integralProjectArr[indexPath.section];
        cell.exchangeBtn.tag = indexPath.section;
        [cell.exchangeBtn addTarget:self action:@selector(commitExchange:) forControlEvents:UIControlEventTouchUpInside];
        return cell;
    }
    if (_currentButton == _selectButtonArr[1]) {
        
        IntegralLogTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:IntegralCellID];
        
            cell.dic = _logIntegralArr[indexPath.row];

        
        return cell;
    }
    
    return nil;
}

#pragma mark --  积分兑换券
- (void)commitExchange:(UIButton *)btn{
    
    projectNum = btn.tag;
    
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:nil message:@"是否兑换" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    [alert show];
    
    
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1) {
        [self loadExchangeShopData];
    }
}

- (void)headerRefreshloadData
{
    _page = 1;
    if (_currentButton == _selectButtonArr[0]) {
        
        [self loadIntegralData];
    }
    if (_currentButton == _selectButtonArr[1]) {
        
        
        [self loadIntergralLog];
    }
    
    [_tableView.mj_header endRefreshing];
}

- (void)footerRefreshloadData
{
    NSLog(@"%d",itemCounts);
    if (itemCounts -_logIntegralArr.count< _PageSize) {
        [MBProgressHUD showMessag:@"没有更多数据了" toView:self.view];
        [_tableView.mj_footer endRefreshingWithNoMoreData];
    }else{
        [_tableView.mj_footer resetNoMoreData];
        _page ++;
        if (_currentButton == _selectButtonArr[0]) {
            
            [self loadIntegralData];
        }
        if (_currentButton == _selectButtonArr[1]) {
            
            
            [self loadIntergralLog];
        }
        
        [_tableView.mj_footer endRefreshing];
    }
}

#pragma mark - 加载签到天数
- (void)loadDataGiftDate {
    NSString *url = [NSString stringWithFormat:@"%@v2/accept/integralActivity/sign",__API_HEADER__];
    [NSObject POST:url parameters:nil progress:^(NSProgress *downloadProgress) {
        
    } completionHandler:^(id responseObject, NSError *error) {
        if (error) {
            
        }else {
            self.timeLabel.text = [NSString stringWithFormat:@"已连续签到%@天",responseObject[@"data"][@"giftDate"]];
        }
    }];
}

@end
