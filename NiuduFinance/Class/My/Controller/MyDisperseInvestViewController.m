//
//  MyDisperseInvestViewController.m
//  NiuduFinance
//
//  Created by zhoupushan on 16/3/11.
//  Copyright © 2016年 liuyong. All rights reserved.
//

#import "MyDisperseInvestViewController.h"
#import "MyDisperseInvestViewCell.h"
#import "ReturnDetailsViewController.h"
#import "WebPageVC.h"

#import "YZPullDownMenu.h"
#import "YZMenuButton.h"
#import "YZMoreMenuViewController.h"
#import "YZSortViewController.h"
#import "AppDelegate.h"
@interface MyDisperseInvestViewController ()<UITableViewDelegate ,UITableViewDataSource,MyDisperseInvestViewCellDelegate,YZPullDownMenuDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic,assign)NSInteger start;
@property (nonatomic,assign)NSInteger limit;
@property (nonatomic,strong) NSMutableArray *touArr;
@property (nonatomic,strong) NSMutableArray * first;
@property (nonatomic, strong) NSArray *titles;

@property (nonatomic, strong)UIImageView * imageView;
@property (nonatomic, strong)UILabel * twoLabel;
@end

@implementation MyDisperseInvestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.title = @"我的投资";
//    [self backBarItem];
    [self setupNavi];
    [self setupTableView];

    
    _start = 0;
    _limit = 200;
    _touArr = [NSMutableArray array];
    _first = [NSMutableArray array];


    
    YZPullDownMenu * menu = [YZPullDownMenu new];
    [self.view addSubview:menu];
    [menu mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH, 60));
    }];
    
    
    _twoLabel = [UILabel new];
    [_twoLabel setText:@"用户资金安全由汇付天下进行托管"];
    [_twoLabel setFont:[UIFont systemFontOfSize:13]];
    [_twoLabel setTextColor:[UIColor colorWithHexString:@"#019BFF"]];
    [self.view addSubview:_twoLabel];
    [_twoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(61);
        make.centerX.equalTo(self.view.mas_centerX).with.offset(0);
        make.height.mas_equalTo(13);
    }];

    _imageView = [UIImageView new];
    UIImage * image = [UIImage imageNamed:@"0.7.png"];
    _imageView.image = image;
    [self.view addSubview:_imageView];
    [_imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(61);
        make.right.equalTo(self.twoLabel.mas_left).with.offset(-10);
        make.size.mas_equalTo(CGSizeMake(13, 13));
    }];
    
    // 设置下拉菜单代理
    menu.dataSource = self;
    
    // 初始化标题
    _titles = @[@"理财项目",@"未结清"];
    
    // 添加子控制器
    [self setupAllChildViewController];


    [self getInBiData];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(test:) name:@"notifacation" object:nil];
    
    
}
- (void)test:(NSNotification*) notification
{
    _first = [notification object];

    [self.tableView reloadData];
}
- (void)setupNavi
{
    [self.navigationController setNavigationBarHidden:NO animated:NO];
    self.title = @"我的投资";
    
    UIButton *customView = [UIButton buttonWithType:UIButtonTypeCustom];
    customView.frame = CGRectMake(0, 0, 44, 44);
    customView.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [customView setImage:[UIImage imageNamed:@"nav_back_normal"] forState:UIControlStateNormal];
    [customView addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:customView];
}
- (void)backAction
{
    //返回（我的）
    [AppDelegate backToMe];
}
#pragma mark - 添加子控制器
- (void)setupAllChildViewController
{
    YZSortViewController *sort = [[YZSortViewController alloc] init];
    YZMoreMenuViewController *moreMenu = [[YZMoreMenuViewController alloc] init];
    [self addChildViewController:sort];
    [self addChildViewController:moreMenu];
}


#pragma mark - YZPullDownMenuDataSource
// 返回下拉菜单多少列
- (NSInteger)numberOfColsInMenu:(YZPullDownMenu *)pullDownMenu
{
    return 2;
}

// 返回下拉菜单每列按钮
- (UIButton *)pullDownMenu:(YZPullDownMenu *)pullDownMenu buttonForColAtIndex:(NSInteger)index
{
    YZMenuButton *button = [YZMenuButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:_titles[index] forState:UIControlStateNormal];
    button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [button setTitleColor:[UIColor colorWithRed:25 /255.0 green:143/255.0 blue:238/255.0 alpha:1] forState:UIControlStateSelected];
    [button setImage:[UIImage imageNamed:@"多边形.png"] forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:@"形.png"] forState:UIControlStateSelected];
    
    return button;
}


// 返回下拉菜单每列对应的控制器
- (UIViewController *)pullDownMenu:(YZPullDownMenu *)pullDownMenu viewControllerForColAtIndex:(NSInteger)index
{
    return self.childViewControllers[index];
}

// 返回下拉菜单每列对应的高度
- (CGFloat)pullDownMenu:(YZPullDownMenu *)pullDownMenu heightForColAtIndex:(NSInteger)index
{
    
    // 第1列 高度
    if (index == 0) {
        return 89;
    }
    
    
    // 第2列 高度
    return 133;
}


- (void)viewDidAppear:(BOOL)animated
{
    self.hideNaviBar = NO;
    //未结清
    
}

//新未结清
- (void)getInBiData
{
    [self.httpUtil requestDic4MethodNam:@"v2/accept/project/list" parameters:@{@"limit":@(_limit),@"type":@(0),@"start":@(_start)} result:^(id  dic, int status, NSString *msg) {
        NSLog(@"%@",dic);
        if (status == 0) {
            [MBProgressHUD showMessag:msg toView:self.view];
            if (_touArr.count == 0) {
                self.hideNoNetWork = NO;
                self.noNetWorkView.top = 53;
                self.noNetWorkView.height = SCREEN_HEIGHT - 53;
                self.noNetWorkView.width = SCREEN_WIDTH;
            }
            
        }else{
            
            self.hideNoNetWork = YES;
            NSLog(@"%@",dic);

            [_first addObjectsFromArray:dic];
            [_tableView.mj_footer resetNoMoreData];

            
        }
        [_tableView reloadData];
        
    }];
    
}

- (void)setupTableView
{
    _tableView.contentInset = UIEdgeInsetsMake(1.0,0.0,0.0,0.0);
    _tableView.tableFooterView  = [UIView new];
    [self setupRefreshWithTableView:_tableView];
    [_tableView registerNib:[UINib nibWithNibName:@"MyDisperseInvestViewCell" bundle:nil] forCellReuseIdentifier:@"MyDisperseInvestViewCell"];

}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 9;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.1;
}

#pragma mark - MyDispreseInvestCellDelegate

#pragma mark - UITableViewDelegate & UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

        return _first.count;

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITapGestureRecognizer *bottomLabelGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(gotoProtocol:)];
    MyDisperseInvestViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MyDisperseInvestViewCell"];
    cell.delegate = self;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    if (indexPath.row  < _first.count) {
        [cell.xieYiBtn addGestureRecognizer:bottomLabelGesture];
        [cell creditorStateModel:_first[indexPath.row]];
    }else{
        [cell creditorStateModel:nil];
    }
//    if (indexPath.row <_first.count) {
//        [cell creditorState:_disperseInvestStat model:_first[indexPath.row]];
//    }else{
//        [cell creditorState:_disperseInvestStat model:nil];
//    
//    }

    return cell;
}
//查看协议

- (void)gotoProtocol:(UITapGestureRecognizer *)gesture{
    
    
    CGPoint point = [gesture locationInView:self.tableView];
    NSIndexPath *indexPatch = [self.tableView indexPathForRowAtPoint:point];
    
    WebPageVC *vc = [[WebPageVC alloc] init];
    vc.title = @"协议";
    vc.name = @"agreement/bidproject";
    
    vc.dic = @{@"projectId":[_first[indexPatch.row] objectForKey:@"projectId"]};
    
    NSLog(@"%@",[_first[indexPatch.row] objectForKey:@"projectId"]);
    
    [self.navigationController pushViewController:vc animated:YES];
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{

    return 128;
}
//
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([[NSString stringWithFormat:@"%@",[_first[indexPath.row] objectForKey:@"statusid"]] isEqualToString:@"1"])
        return;
    {
    }
    if ([[NSString stringWithFormat:@"%@",[_first[indexPath.row] objectForKey:@"statusid"]] isEqualToString:@"2"])
    {
        return;
    }else
    {
        ReturnDetailsViewController *returnDetailsVC = [ReturnDetailsViewController new];
        returnDetailsVC.projectId = [[_first[indexPath.row] objectForKey:@"projectId"] intValue];
        [self.navigationController pushViewController:returnDetailsVC animated:YES];
        [tableView deselectRowAtIndexPath:indexPath animated:NO];
        
    }

}

- (void)headerRefreshloadData
{
    
    if (_touArr.count < _limit) {
        [_tableView.mj_header endRefreshing];
        return;
    }else{
        
    }
    
    [_tableView.mj_header endRefreshing];
}
- (void)footerRefreshloadData
{

    if (_touArr.count-_start < _limit) {
        [MBProgressHUD showMessag:@"没有更多数据了" toView:self.view];
        
        [_tableView.mj_footer endRefreshing];
        return;
    }

    [_tableView.mj_header endRefreshing];
    
}
-(void)dealloc{
    //第一种方法.这里可以移除该控制器下的所有通知
    // 移除当前所有通知
    NSLog(@"移除了所有的通知");
    //[[NSNotificationCenter defaultCenter] removeObserver:self];
    
    //第二种方法.这里可以移除该控制器下名称为tongzhi的通知
    //移除名称为tongzhi的那个通知
    //NSLog(@"移除了名称为notifacation的通知");
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"notifacation" object:nil];
}

@end
