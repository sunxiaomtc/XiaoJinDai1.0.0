//
//  FundManagerController.m
//  NiuduFinance
//
//  Created by zhoupushan on 16/3/4.
//  Copyright © 2016年 liuyong. All rights reserved.
//

#import "FundManagerController.h"
#import "PSJumpNumLabel.h"
#import "FundManagerCell.h"
#import "UIView+Extension.h"
#import "NetWorkingUtil.h"
#import "NSString+Adding.h"
#import "PushMoneyViewController.h"
#import "BindingBankCardViewController.h"
#import "User.h"
#define NAVBAR_CHANGE_POINT 50
@interface FundManagerController ()<UIAlertViewDelegate>
@property (strong, nonatomic) IBOutlet UIView *headerView;
@property (weak, nonatomic) IBOutlet UIView *custemNavi;
@property (weak, nonatomic) IBOutlet PSJumpNumLabel *moneyLabel;

@property (strong, nonatomic) NetWorkingUtil *httpUtil;



@property (nonatomic,strong)NSDictionary *myViewBlanceDic;


@end

#define kHeaderViewHeight 156
static NSString *cellIdentifier = @"FundManagerCell";
@implementation FundManagerController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setupTableView];
    
    _myViewBlanceDic = [NSDictionary dictionary];

}


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:YES    animated:animated];
//    self.navigationController.navigationBarHidden = YES;
    [self totalAssets];
}



- (NetWorkingUtil *)httpUtil
{
    if (!_httpUtil) {
        _httpUtil = [NetWorkingUtil netWorkingUtil];
    }
    return _httpUtil;
}




- (void)totalAssets
{
    NetWorkingUtil *util = [NetWorkingUtil netWorkingUtil];
    [util requestDic4MethodNam:@"v2/accept/account/getUserAssetInfo" parameters:nil result:^(NSDictionary *dic, int status, NSString *msg) {
        
        if (status == 0) {
            [MBProgressHUD showMessag:msg toView:self.view];
        }else{
            _myViewBlanceDic = dic;
            _moneyLabel.jumpValue = [NSString stringWithFormat:@"%.2f",[[_myViewBlanceDic objectForKey:@"balance"] floatValue]];
        }
         [self.tableView reloadData];
    }];
    
}


#pragma mark - Set Up UI
- (void)setupTableView
{
    [self.tableView registerNib:[UINib nibWithNibName:cellIdentifier bundle:nil] forCellReuseIdentifier:cellIdentifier];
    self.tableView.contentInset = UIEdgeInsetsMake(kHeaderViewHeight, 0, 0, 0);
    [self.tableView setSeparatorColor:[UIColor colorWithHexString:@"#dedede"]];
    self.tableView.backgroundColor = [UIColor whiteColor];
    self.automaticallyAdjustsScrollViewInsets = NO;
    //添加 header view
    [self.tableView addSubview:_headerView];
    [_headerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.view).offset(-kHeaderViewHeight);
        make.left.equalTo(self.view);
        make.width.equalTo(self.view.mas_width);
        make.height.equalTo(@(kHeaderViewHeight));
    }];
}

#pragma mark - override
- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}


- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    [self.navigationController setNavigationBarHidden:YES animated:animated];
}

- (IBAction)backAction {
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    
    [self.navigationController popViewControllerAnimated:YES];
    
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat contentOffsetY = scrollView.contentOffset.y;
    if (contentOffsetY <= -kHeaderViewHeight)
    {
        [_custemNavi mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(@(contentOffsetY + kHeaderViewHeight));
        }];
    }
    else if (contentOffsetY <= -122)// -195 ~ -122 之间
    {
        CGFloat midValue = kHeaderViewHeight - 122;
        CGFloat offsetValue = midValue + 0.5 - (kHeaderViewHeight + contentOffsetY);
        _moneyLabel.alpha = offsetValue/midValue;
    }else if (contentOffsetY <= -121)
    {
        _moneyLabel.alpha = 0.0;
    }
}


- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    if (scrollView.contentOffset.y <= -260)
    {
        NSString *balanceStr = [NSString stringWithFormat:@"%@",[_myViewBlanceDic objectForKey:@"balance"]];
        if ( [[NSString stringWithFormat:@"%@",balanceStr] isEqualToString:@""]) {
            _moneyLabel.jumpValue = @"0.00";
        }else{
            _moneyLabel.jumpValue = [NSString stringWithFormat:@"%.2f",[[_myViewBlanceDic objectForKey:@"balance"] floatValue]];
        }
        
    }
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    _moneyLabel.alpha = 1.0;
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    _moneyLabel.alpha = 1.0;
}
#pragma mark - UITableViewDelegate & UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
        return 4;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    FundManagerCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    
    NSString *title;
    NSString *detailText;
    UIImage * image;
    FundManagerCellValueStyle valueStyle = -1;
    
    if (indexPath.section == 0 && indexPath.row == 0)
    {
        title = @"可用余额";
        NSString * str = [_myViewBlanceDic objectForKey:@"mayUseBalance"];
        float mayUseBalance = [str floatValue];
        detailText = [[NSString stringWithFormat:@"%.2f",mayUseBalance] strmethodComma];
        UIImage * imag = [UIImage imageNamed:@"pointer_green"];
        image = imag;
        NSLog(@"%@",detailText);
        valueStyle = FundManagerCellValueStyleBlack;
    }
    if (indexPath.section == 0 && indexPath.row == 1)
    {
        title = @"冻结资金";
        NSString * str = [_myViewBlanceDic objectForKey:@"frozen"];
        float frozen = [str floatValue];
        detailText = [[NSString stringWithFormat:@"%.2f",frozen] strmethodComma];
        UIImage * imag = [UIImage imageNamed:@"pointer_red.png"];
        image = imag;
        valueStyle = FundManagerCellValueStyleBlack;
    }
    if (indexPath.section == 0 && indexPath.row == 2)
    {
        title = @"待收本金";
        
        NSString * str = [_myViewBlanceDic objectForKey:@"receivablePrincipal"];
        float receivable = [str floatValue];
        detailText = [[NSString stringWithFormat:@"%.2f",receivable] strmethodComma];
        UIImage * imag = [UIImage imageNamed:@"pointer_blue.png"];
        image = imag;
        valueStyle = FundManagerCellValueStyleBlack;
    }
    if (indexPath.section == 0 && indexPath.row == 3)
    {
        title = @"待收利息";
        NSString * str = [_myViewBlanceDic objectForKey:@"receivableInterest"];
        float receivableInte = [str floatValue];
        detailText = [[NSString stringWithFormat:@"%.2f",receivableInte] strmethodComma];
        UIImage * imag = [UIImage imageNamed:@"pointer_yellow.png"];
        image = imag;
        valueStyle = FundManagerCellValueStyleBlack;
    }

    [cell setupTitle:title detailText:detailText pointer:image  valueStyle:valueStyle];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 15;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.01;
}

@end
