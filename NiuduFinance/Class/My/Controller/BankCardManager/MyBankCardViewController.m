//
//  MyBankCardViewController.m
//  NiuduFinance
//
//  Created by zhoupushan on 16/3/8.
//  Copyright © 2016年 liuyong. All rights reserved.
//

#import "MyBankCardViewController.h"
#import "AddBankCardViewController.h"
#import "NetWorkingUtil.h"
#import "User.h"
#import "RealNameCertificationViewController.h"
#import "BankCardTableViewCell.h"

@interface MyBankCardViewController ()<UITableViewDelegate,UITableViewDataSource,UIAlertViewDelegate>
@property (weak, nonatomic) IBOutlet UIView *noDataView;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (strong, nonatomic) NSMutableArray *bankCardsArr;
@property (nonatomic,strong)NSMutableDictionary *bankCardDic;


//h1

//单笔
@property (nonatomic, strong) UILabel * singleLabel;
//单日
@property (nonatomic, strong) UILabel * singleDayLabel;


//单笔价格
@property (nonatomic, strong) UILabel * singlLabel;
//单日价格
@property (nonatomic, strong) UILabel * singlDayLabel;
//h2



@end
static NSString * const cellIdentifer = @"BankCardTableViewCell";
@implementation MyBankCardViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupNavi];
    [self setupTableView];
    
    _bankCardsArr = [NSMutableArray array];
    _bankCardDic =   [NSMutableDictionary dictionary];

    _singleLabel     = [UILabel new];
    _singlLabel      = [UILabel new];
    _singleDayLabel  = [UILabel new];
    _singlDayLabel   = [UILabel new];

}


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.hideNaviBar = NO;
    [_bankCardsArr removeAllObjects];
    [self getMyBankCard];
    [self getMyBankCardPic];
    
}

- (void)getMyBankCard//卡号
{
    
    [self.httpUtil requestDic4MethodNam:@"v2/accept/user/getUserInfo" parameters:nil result:^(id dic, int status, NSString *msg) {
        
        NSLog(@"%d",status);
        NSLog(@"%@",dic);
        if (status == 0) {
            [MBProgressHUD showMessag:msg toView:self.view];
        }else{
            _bankCardDic=[NSMutableDictionary dictionaryWithDictionary:dic];

        }
        
        [_tableView reloadData];
    }];
    
}
- (void)getMyBankCardPic//单笔限额
{
    
    [self.httpUtil requestDic4MethodNam:@"v2/accept/user/queryPayQuota" parameters:nil result:^(id dic, int status, NSString *msg) {
        
        NSLog(@"%d",status);
        NSLog(@"%@",dic);
        
        if (status == 0) {
            [MBProgressHUD showMessag:msg toView:self.view];
        }else{
            [_bankCardsArr addObjectsFromArray:dic];
        }
        
        
        [_tableView reloadData];
    }];
    
}


#pragma mark - Set Up UI
- (void)setupTableView{
    _tableView.tableFooterView = [UIView new];
    [self setupHeaderRefresh:_tableView];
    _tableView.backgroundColor = [UIColor colorWithHexString:@"#F0EFF5"];
    _tableView.separatorColor = _tableView.backgroundColor;
    
    [_tableView registerNib:[UINib nibWithNibName:@"BankCardTableViewCell" bundle:nil] forCellReuseIdentifier:@"BankCardTableViewCell"];
}

- (void)setupNavi
{
    self.title = @"我的银行卡";
    [self backBarItem];
    //注释添加BarButton
//    [self setupBarButtomItemWithTitle:@"添加" target:self action:@selector(addBankCard) leftOrRight:NO];
}

#pragma mark - Action
- (void)addBankCard
{
    //跳转
    if ([User userFromFile].idValidate == 0) {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:nil message:@"您还没有实名认证，是否去实名认证" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        [alert show];
    }else{
        AddBankCardViewController *vc = [[AddBankCardViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1) {
        RealNameCertificationViewController *vc = [[RealNameCertificationViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }
}


#pragma mark - UITableViewDelegate & UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    switch (section){
            case 0:
                 return 1;
                 break;
            case 1:
                 return 2;
                 break;
            default:
                 return 0;
                 break;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    BankCardTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifer];
    if (!cell)
    {
        cell = [[BankCardTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifer];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }

    for (int i=0; i<_bankCardsArr.count; i++) {
        if ([[[_bankCardDic objectForKey:@"bankInfo"] objectForKey:@"bankIocn"] isEqualToString:[[_bankCardsArr objectAtIndex:i]objectForKey:@"OpenBankId"]]) {
            _singlLabel.text=[[_bankCardsArr objectAtIndex:i]objectForKey:@"SingleTransQuota"];
            _singlDayLabel.text=[[_bankCardsArr objectAtIndex:i]objectForKey:@"CardDailyTransQuota"];
            
        }
    }

    if (indexPath.section == 0 && indexPath.row == 0) {
        
        cell.bankCardNameLab.text = [[_bankCardDic objectForKey:@"bankInfo"] objectForKey:@"bankName"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        cell.bankCardNumberLab.text = [NSString stringWithFormat:@"%@",[[_bankCardDic objectForKey:@"bankInfo"] objectForKey:@"bankNumber"] ];
        
        NSString * bankIcon;
        bankIcon = [[_bankCardDic objectForKey:@"bankInfo"] objectForKey:@"bankIocn"];
        
        if (bankIcon!=nil) {
            NSString * str = [NetWorkingUtil mainURL];
            NSString * srtt = [[[[NSMutableString stringWithString:str]stringByAppendingString:@"resources/static/img/bankicon/" ]stringByAppendingString:bankIcon]stringByAppendingString:@".png"];
            NSLog(@"%@",srtt);
            [NetWorkingUtil setImage:cell.bankCardImageView url:srtt defaultIconName:@"bankInfo" successBlock:nil];
        }
        
      
        
        
    }else if (indexPath.section == 1 && indexPath.row == 0){

        [cell addSubview:_singleLabel];
        _singleLabel.text = @"单笔限额(万元)";
        [_singleLabel setFont:[UIFont systemFontOfSize:16]];
        [_singleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(@16);
            make.left.equalTo(@15);
            make.height.mas_equalTo(17);
        }];
        
        
        [cell addSubview:_singlLabel];
        [_singlLabel setTextAlignment:2];
        [_singlLabel setFont:[UIFont systemFontOfSize:15]];
        [_singlLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(cell.mas_right).with.offset(-15);
            make.top.equalTo(@17);
            make.height.mas_equalTo(12);
        }];
        
    }else if (indexPath.section == 1 && indexPath.row == 1){

        [cell addSubview:_singleDayLabel];
        _singleDayLabel.text = @"单日限额(万元)";
        [_singleDayLabel setFont:[UIFont systemFontOfSize:16]];
        [_singleDayLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(@16);
            make.left.equalTo(@15);
            make.height.mas_equalTo(17);
        }];
        
        [cell addSubview:_singlDayLabel];
        [_singlDayLabel setTextAlignment:2];
        [_singlDayLabel setFont:[UIFont systemFontOfSize:15]];
        [_singlDayLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(cell.mas_right).with.offset(-15);
            make.top.equalTo(@17);
            make.height.mas_equalTo(12);
        }];
        
    }
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0 && indexPath.row==0) {
        return 93;
    }else{
        return 45;
    }
    
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    
    return 10;
}

- (void)headerRefreshloadData
{
    [_tableView.mj_header endRefreshing];
}


- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return NO;
}

@end
