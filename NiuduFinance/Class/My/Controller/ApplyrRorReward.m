//
//  ApplyrRorReward.m
//  NiuduFinance
//
//  Created by 123 on 17/3/21.
//  Copyright © 2017年 liuyong. All rights reserved.
//

#import "ApplyrRorReward.h"
#import "ApplyrRewardCell.h"
#import "ApplyRewardTailCell.h"
#import "ApplyrRewardMiddleCell.h"
@interface ApplyrRorReward ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong)UIView * firstView;
@property (nonatomic, strong)UIButton * sureBtn;
@property (nonatomic, strong)UILabel * sureLabel;
@property (nonatomic, strong)UIView * tailView;

@property (nonatomic,assign)NSInteger start;
@property (nonatomic,assign)NSInteger limit;
@property (nonatomic,strong)NSDictionary * customerDic;
@property (nonatomic,strong)NSMutableArray * customerArry;

@property (nonatomic,strong)NSArray * customerAr;
@end

@implementation ApplyrRorReward

- (void)viewDidLoad {
    [super viewDidLoad];

    _start = 0;
    _limit = 10;
    _customerDic = [NSDictionary new];
    _customerArry = [NSMutableArray array];
    _customerAr = [NSArray array];

    
    _firstView = [UIView new];
    _firstView.backgroundColor = [UIColor clearColor];
    [self.tableView addSubview:_firstView];
    [_firstView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH, 30));
    }];
    _sureLabel = [UILabel new];
    [_sureLabel setText:@"本次申请奖励好友明细"];
    [_sureLabel setFont:[UIFont systemFontOfSize:15]];
    [self.firstView addSubview:_sureLabel];
    [_sureLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(8);
        make.centerX.mas_equalTo(0);
    }];
    
    _tailView = [UIView new];
    _tailView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_tailView];
    [_tailView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(0);
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH, 60));
    }];
    _sureBtn = [UIButton new];
    _sureBtn.layer.cornerRadius = 6.0f;
    _sureBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [_sureBtn setTitle:@"确定申请" forState:UIControlStateNormal];
    [_sureBtn setBackgroundColor:[UIColor colorWithHexString:@"#019BFF"]];
    [_sureBtn addTarget:self action:@selector(sureBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.tailView addSubview:_sureBtn];
    [_sureBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(8);
        make.centerX.mas_equalTo(0);
        make.size.mas_equalTo(CGSizeMake(90, 35));
    }];
    
    [self getRewardDetail];

}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self setupNavi];
    [self setupTableView];
}
- (void)setupTableView{
    
    [self setupRefreshWithTableView:_tableView];
    [self.tableView registerNib:[UINib nibWithNibName:@"ApplyrRewardCell" bundle:nil] forCellReuseIdentifier:@"ApplyrRewardCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"ApplyrRewardMiddleCell" bundle:nil] forCellReuseIdentifier:@"ApplyrRewardMiddleCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"ApplyRewardTailCell" bundle:nil] forCellReuseIdentifier:@"ApplyRewardTailCell"];
}
- (void)setupNavi
{
    [self.navigationController setNavigationBarHidden:NO animated:NO];
    self.title = @"申请现金奖励";
    
    UIButton *customView = [UIButton buttonWithType:UIButtonTypeCustom];
    customView.frame = CGRectMake(0, 0, 44, 44);
    customView.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [customView setImage:[UIImage imageNamed:@"nav_back_normal"] forState:UIControlStateNormal];
    [customView addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:customView];
}

- (void)getRewardDetail
{
    [self.httpUtil requestDic4MethodNam:@"v2/accept/user/applyRewardDetail" parameters:@{@"limit":@(_limit),@"start":@(_start)} result:^(NSDictionary *dic, int status, NSString *msg) {
        
        NSLog(@"%@",dic);
        if (status == 0) {
            [MBProgressHUD showMessag:msg toView:self.view];
            
        }else{
            self.hideNoNetWork = YES;
            _customerDic = dic;
            [_customerArry addObject:dic];
            _customerAr = [dic objectForKey:@"list"];
            for (NSDictionary *item in _customerAr) {
                NSLog(@"%@--%@",[item objectForKey:@"investAmount"],[item objectForKey:@"username"]);
            }
        }
        [_tableView reloadData];
    }];
    
}

- (void)sureBtnClick:(UIButton *)sender
{
    NSLog(@"456456");
    [self.httpUtil requestDic4MethodNam:@"v2/accept/user/applyReward" parameters:nil result:^(NSDictionary *dic, int status, NSString *msg) {
        
        NSLog(@"%@",dic);
        if (status == 0) {
            [MBProgressHUD showMessag:msg toView:self.view];
            
        }else{
            self.hideNoNetWork = YES;
            [MBProgressHUD showMessag:msg toView:self.view];


        }
        [_tableView reloadData];
    }];
}

//几个区
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}
//一个区有几行
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 1;
    }else if (section == 2){
        return 1;
    }else
    return _customerAr.count;
}
//区头部距离上面的高度
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return 35;
    }
    return CGFLOAT_MIN;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return CGFLOAT_MIN;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.section == 0) {
        static NSString *cellID = @"ApplyrRewardCell";
        ApplyrRewardCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
        if (cell == nil) {
            cell = [[ApplyrRewardCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        return cell;
    }else if (indexPath.section == 1){
        static NSString *cellID = @"ApplyrRewardMiddleCell";
        ApplyrRewardMiddleCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
        if (cell == nil) {
            cell = [[ApplyrRewardMiddleCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        if (indexPath.row<_customerAr.count) {
            [cell setMyRmountDic:_customerAr[indexPath.row]];
        }
        return cell;
    }
    static NSString *cellID = @"ApplyRewardTailCell";
    
    ApplyRewardTailCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [[ApplyRewardTailCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (indexPath.row<_customerArry.count) {
        [cell setMyRmountDic:_customerArry[indexPath.row]];
    }
    return cell;

}
//设置cell的高
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{

    if (indexPath.section == 2) {
        return 88;
    }
    return 44;
}


- (void)headerRefreshloadData
{
    NSLog(@"%ld",_customerAr.count);
    NSLog(@"%ld",_limit);
    if (_customerAr.count<_limit) {
        [MBProgressHUD showMessag:@"没有更多数据了" toView:self.view];
        
        [_tableView.mj_header endRefreshing];
        return;
    }
    
    _start = _start +_limit;
    [self getRewardDetail];
    [_tableView.mj_header endRefreshing];
}

- (void)footerRefreshloadData
{
    
    
    NSLog(@"%ld",_customerAr.count);
    NSLog(@"%ld",_limit);
    if (_customerAr.count-_start<_limit) {
        
        [MBProgressHUD showMessag:@"没有更多数据了" toView:self.view];
        
        [_tableView.mj_footer endRefreshing];
        return;
    }
    
    _start = _start +_limit;
    [self getRewardDetail];
    [_tableView.mj_footer endRefreshing];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
