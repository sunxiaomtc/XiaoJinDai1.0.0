//
//  RewardRetailsVC.m
//  NiuduFinance
//
//  Created by 123 on 17/3/22.
//  Copyright © 2017年 liuyong. All rights reserved.
//

#import "RewardRetailsVC.h"
#import "RewardRetailsCell.h"
//测试
#import "DistributionController.h"

@interface RewardRetailsVC ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong)UIView * topView;
@property (nonatomic, strong)UILabel * xianLabel;
@property (nonatomic, strong)UILabel * quanLabel;

@property (nonatomic, strong)UIView * firstView;
@property (nonatomic, strong)UIView * lineOne;
@property (nonatomic, strong)UIView * lineTwo;
@property (nonatomic, strong)UIView * lineThree;

@property (nonatomic, strong)UILabel * friendsLabel;
@property (nonatomic, strong)UILabel * typeLabel;
@property (nonatomic, strong)UILabel * rewardLabel;
@property (nonatomic, strong)UILabel * noteLabel;

@property (nonatomic,assign)NSInteger start;
@property (nonatomic,assign)NSInteger limit;
@property (nonatomic,strong)NSMutableArray * customerArr;

@end

@implementation RewardRetailsVC

- (void)viewDidLoad {
    [super viewDidLoad];
    _start = 0;
    _limit = 10;
    _customerArr = [NSMutableArray array];
    
    _topView = [UIView new];
    [_topView setBackgroundColor:[UIColor whiteColor]];
    [self.tableView addSubview:_topView];
    [_topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH, 39));
    }];
    
    _xianLabel = [UILabel new];
//    [_xianLabel setText:@"现金奖励:30元"];
    [_xianLabel setFont:[UIFont systemFontOfSize:15]];
    [self.topView addSubview:_xianLabel];
    [_xianLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(10);
        make.left.mas_equalTo(15);
    }];
    
    _quanLabel = [UILabel new];
//    [_quanLabel setText:@"现金券奖励:20元"];
    [_quanLabel setFont:[UIFont systemFontOfSize:15]];
    [self.topView addSubview:_quanLabel];
    [_quanLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(10);
        make.right.mas_equalTo(-15);
    }];
    
    
    _firstView = [UIView new];
    [_firstView setBackgroundColor:[UIColor whiteColor]];
    [self.tableView addSubview:_firstView];
    [_firstView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(40);
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH, 44));
    }];
    
    _lineOne = [UIView new];
    [_lineOne setBackgroundColor:[UIColor blackColor]];
    [self.firstView addSubview:_lineOne];
    [_lineOne mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.bottom.mas_equalTo(0);
        make.size.mas_equalTo(CGSizeMake(1, _firstView.height));
        make.centerX.equalTo(self.firstView.mas_left).with.offset(SCREEN_WIDTH/4);
    }];
    
    _lineTwo = [UIView new];
    [_lineTwo setBackgroundColor:[UIColor blackColor]];
    [self.firstView addSubview:_lineTwo];
    [_lineTwo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.bottom.mas_equalTo(0);
        make.size.mas_equalTo(CGSizeMake(1, _firstView.height));
        make.centerX.mas_equalTo(0);
    }];
    
    _lineThree = [UIView new];
    [_lineThree setBackgroundColor:[UIColor blackColor]];
    [self.firstView addSubview:_lineThree];
    [_lineThree mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.bottom.mas_equalTo(0);
        make.size.mas_equalTo(CGSizeMake(1, _firstView.height));
        make.centerX.equalTo(self.firstView.mas_left).with.offset(SCREEN_WIDTH/4*3);
    }];
    
    _friendsLabel = [UILabel new];
    [_friendsLabel setText:@"好友"];
    [_friendsLabel setFont:[UIFont systemFontOfSize:14]];
    _friendsLabel.textAlignment = NSTextAlignmentCenter;
    [self.firstView addSubview:_friendsLabel];
    [_friendsLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.left.mas_equalTo(0);
        make.bottom.mas_equalTo(0);
        make.right.equalTo(_lineOne.mas_left);
    }];
    
    _typeLabel = [UILabel new];
    [_typeLabel setText:@"类型"];
    [_typeLabel setFont:[UIFont systemFontOfSize:14]];
    _typeLabel.textAlignment = NSTextAlignmentCenter;
    [self.firstView addSubview:_typeLabel];
    [_typeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.left.equalTo(_lineOne.mas_right);
        make.bottom.mas_equalTo(0);
        make.right.equalTo(_lineTwo.mas_left);
    }];
    
    _rewardLabel = [UILabel new];
    [_rewardLabel setText:@"我的奖励"];
    [_rewardLabel setFont:[UIFont systemFontOfSize:14]];
    _rewardLabel.textAlignment = NSTextAlignmentCenter;
    [self.firstView addSubview:_rewardLabel];
    [_rewardLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.left.equalTo(_lineTwo.mas_right);
        make.bottom.mas_equalTo(0);
        make.right.equalTo(_lineThree.mas_left);
    }];
    
    _noteLabel = [UILabel new];
    [_noteLabel setText:@"备注"];
    [_noteLabel setFont:[UIFont systemFontOfSize:14]];
    _noteLabel.textAlignment = NSTextAlignmentCenter;
    [self.firstView addSubview:_noteLabel];
    [_noteLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.left.equalTo(_lineThree.mas_right);
        make.bottom.mas_equalTo(0);
        make.right.mas_equalTo(0);
    }];
    
    [self getCustomerList];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self setupNavi];
    [self setupTableView];

}
- (void)setUserId:(int)userId
{
    _userId = userId;
    [self getCustomerList];
    [self setInviteReward];

}
- (void)setupNavi
{
    [self.navigationController setNavigationBarHidden:NO animated:NO];
    self.title = @"详情";
    UIButton *customView = [UIButton buttonWithType:UIButtonTypeCustom];
    customView.frame = CGRectMake(0, 0, 44, 44);
    customView.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [customView setImage:[UIImage imageNamed:@"nav_back_normal"] forState:UIControlStateNormal];
    [customView addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:customView];
}

- (void)setupTableView
{
    [self setupRefreshWithTableView:_tableView];
    [self.tableView registerNib:[UINib nibWithNibName:@"RewardRetailsCell" bundle:nil] forCellReuseIdentifier:@"RewardRetailsCell"];
}

- (void)setInviteReward
{
    
    [self.httpUtil requestDic4MethodNam:@"v2/accept/user/inviteReward" parameters:@{@"userId":@(_userId)} result:^(NSDictionary *dic, int status, NSString *msg) {
        NSLog(@"%@",dic);
        
        if (status == 0) {
            [MBProgressHUD showMessag:msg toView:self.view];
            if (_customerArr.count == 0) {
                self.hideNoNetWork = NO;
            }
        }else{
            self.hideNoNetWork = YES;
            _xianLabel.text = [NSString stringWithFormat:@"现金奖励:%@元",[dic objectForKey:@"cashBonusTotal"]];
            _quanLabel.text = [NSString stringWithFormat:@"现金券奖励:%@元",[dic objectForKey:@"cashCouponTotal"]];
        }
        [_tableView reloadData];
    }];
    
}

- (void)getCustomerList
{
    [self.httpUtil requestDic4MethodNam:@"v2/accept/user/inviteRewardList" parameters:@{@"limit":@(_limit),@"start":@(_start),@"userId":@(_userId)} result:^(id  dic, int status, NSString *msg) {
        NSLog(@"%@",dic);
        
        if (status == 0) {
            [MBProgressHUD showMessag:msg toView:self.view];
            if (_customerArr.count == 0) {
                self.hideNoNetWork = NO;
            }
        }else{
            self.hideNoNetWork = YES;
//            [_customerArr removeAllObjects];
            [_customerArr addObjectsFromArray:dic];
            [_tableView.mj_footer resetNoMoreData];

        }
        [_tableView reloadData];
        
    }];
    
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 84;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _customerArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    static NSString *cellID = @"RewardRetailsCell";
    
    RewardRetailsCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [[RewardRetailsCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (indexPath.row<_customerArr.count) {
        [cell setMyRewardDic:_customerArr[indexPath.row]];
    }
    return cell;

}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
     int  isAssign = [[_customerArr[indexPath.row]objectForKey:@"isAssign"]intValue];
    if (isAssign == 0) {
        DistributionController * vc = [DistributionController new];
        vc.Id = [[_customerArr[indexPath.row]objectForKey:@"id"]intValue];
        vc.userId = [[_customerArr[indexPath.row]objectForKey:@"userId"]intValue];
        [self.navigationController pushViewController:vc animated:YES];
    }
//    DistributionController * vc = [DistributionController new];
//    vc.Id = [[_customerArr[indexPath.row]objectForKey:@"id"]intValue];
//    vc.userId = [[_customerArr[indexPath.row]objectForKey:@"userId"]intValue];
//    [self.navigationController pushViewController:vc animated:YES];


    
}
- (void)headerRefreshloadData
{
    NSLog(@"%ld",_customerArr.count);
    NSLog(@"%ld",_limit);
    if (_customerArr.count<_limit) {
        [MBProgressHUD showMessag:@"没有更多数据了" toView:self.view];
        
        [_tableView.mj_header endRefreshing];
        return;
    }
    
    _start = _start +_limit;
    [self getCustomerList];
    [_tableView.mj_header endRefreshing];
}

- (void)footerRefreshloadData
{
    
    
    NSLog(@"%ld",_customerArr.count);
    NSLog(@"%ld",_limit);
    if (_customerArr.count-_start<_limit) {
        
        [MBProgressHUD showMessag:@"没有更多数据了" toView:self.view];
        
        [_tableView.mj_footer endRefreshing];
        return;
    }
    
    _start = _start +_limit;
    [self getCustomerList];
    [_tableView.mj_footer endRefreshing];
    
}
@end
