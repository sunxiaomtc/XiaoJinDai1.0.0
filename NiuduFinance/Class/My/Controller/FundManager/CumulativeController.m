//
//  CumulativeController.m
//  NiuduFinance
//
//  Created by 123 on 17/2/16.
//  Copyright © 2017年 liuyong. All rights reserved.
//

#import "CumulativeController.h"
#import "PSJumpNumLabel.h"
#import "FundManagerCell.h"
#import "UIView+Extension.h"
#import "NetWorkingUtil.h"
#import "NSString+Adding.h"
#import "PushMoneyViewController.h"
#import "BindingBankCardViewController.h"
#import "User.h"
#define NAVBAR_CHANGE_POINT 50
@interface CumulativeController ()<UIAlertViewDelegate>
@property (strong, nonatomic) IBOutlet UIView *headerView;
@property (weak, nonatomic) IBOutlet UIView *custemNavi;
@property (weak, nonatomic) IBOutlet PSJumpNumLabel *moneyLabel;
@property (strong, nonatomic) NetWorkingUtil *httpUtil;
@property (nonatomic,strong)NSDictionary *myViewBlanceDic;
@end


#define kHeaderViewHeight 156
static NSString *cellIdentifier = @"FundManagerCell";

@implementation CumulativeController

- (void)viewDidLoad {
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
            
            NSString * str = [_myViewBlanceDic objectForKey:@"income"];
            float moneyLabel = [str floatValue];
            _moneyLabel.jumpValue = [NSString stringWithFormat:@"%.2f",moneyLabel];
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
        NSString * str = [_myViewBlanceDic objectForKey:@"income"];
        double moneyLabel = [str doubleValue];
        if ([[NSString stringWithFormat:@"%@",str] isEqualToString:@""]) {
            _moneyLabel.jumpValue = @"0.00";
        }else{
            _moneyLabel.jumpValue = [NSString stringWithFormat:@"%.2f",moneyLabel];
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
    
    return 3;
    
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
        title = @"已收利息";
        
        NSString * str = [_myViewBlanceDic objectForKey:@"incomedInterest"];
        float incomedInterest = [str floatValue];
        detailText = [[NSString stringWithFormat:@"%.2f",incomedInterest] strmethodComma];
        UIImage * imag = [UIImage imageNamed:@"pointer_green"];
        image = imag;
        NSLog(@"%@",detailText);
        valueStyle = FundManagerCellValueStyleBlack;
    }
    if (indexPath.section == 0 && indexPath.row == 1)
    {
        title = @"待收利息";
        NSString * str = [_myViewBlanceDic objectForKey:@"receivableInterest"];
        float receivableInte = [str floatValue];
        detailText = [[NSString stringWithFormat:@"%.2f",receivableInte] strmethodComma];
        UIImage * imag = [UIImage imageNamed:@"pointer_red.png"];
        image = imag;
        valueStyle = FundManagerCellValueStyleBlack;
    }
    if (indexPath.section == 0 && indexPath.row == 2)
    {
        title = @"已用奖励";
        NSString * str = [_myViewBlanceDic objectForKey:@"bounsAmount"];
        float bounsAmount = [str floatValue];
        detailText = [[NSString stringWithFormat:@"%.2f",bounsAmount] strmethodComma];
        UIImage * imag = [UIImage imageNamed:@"pointer_blue.png"];
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
