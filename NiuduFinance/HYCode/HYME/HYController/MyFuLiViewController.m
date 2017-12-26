//
//  MyFuLiViewController.m
//  NiuduFinance
//
//  Created by 123 on 17/8/2.
//  Copyright © 2017年 liuyong. All rights reserved.
//

#import "MyFuLiViewController.h"
#import "MyDisperseInvestViewCell.h"
#import "ReturnDetailsViewController.h"
#import "WebPageVC.h"

#import "YZPullDownMenu.h"
#import "YZMenuButton.h"
#import "YZMoreMenuViewController.h"
#import "YZSortViewController.h"
#import "AppDelegate.h"
#import "MyFuLiableViewCell.h"
#import "MyPrivilegeCell.h"
#import "HYXiaLaView.h"
#import <objc/runtime.h>

@interface MyFuLiViewController ()<UITableViewDelegate ,UITableViewDataSource,MyDisperseInvestViewCellDelegate,YZPullDownMenuDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomFLLayout;
@property (nonatomic,assign)NSInteger start;
@property (nonatomic,assign)NSInteger limit;
@property (nonatomic,strong) NSMutableArray *touArr;
@property (nonatomic,strong) NSMutableArray * firstAry;
@property (nonatomic, strong) NSArray *titles;
@property (nonatomic,strong) NSString * statusStr;
@property (nonatomic,strong) NSDictionary * statusDic;
//判断我的优惠券/我的特权券
@property (nonatomic,strong) NSString * tYStr;

@end


@implementation MyFuLiViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];
    self.navigationItem.title = @"优惠券";
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor blackColor],NSFontAttributeName:[UIFont systemFontOfSize:17]}];
    NSDictionary *mine = [NSDictionary dictionaryWithObject:[UIColor blackColor] forKey:NSForegroundColorAttributeName];
    self.navigationController.navigationBar.titleTextAttributes = mine;
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    [self setupBarButtomItemWithImageName:@"黑色返回按钮" highLightImageName:@"nav_back_select.png" selectedImageName:nil target:self action:@selector(backClick) leftOrRight:YES];
}

-(void)backClick
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupTableView];
    
    _start = 0;
    _limit = 200;
    _touArr = [NSMutableArray array];
    _firstAry = [NSMutableArray array];
    _statusDic = [NSDictionary alloc];
    
    YZPullDownMenu * menu = [YZPullDownMenu new];
    [self.view addSubview:menu];
    [menu mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(1);
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH, 60));
    }];
    // 设置下拉菜单代理
    menu.dataSource = self;
    // 初始化标题
    _titles = @[@"我的优惠券",@"可使用"];
    // 添加子控制器
    [self setupAllChildViewController];
    _tYStr = @"5";
    _statusStr = @"0";
//    [self getInBiData];
    [self loadCanHongBaoData];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(test:) name:@"notifacation" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(testChuanCan:) name:@"chuanCan" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(testTy:) name:@"tyQuan" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(yhqLoading:) name:@"YHQLoading" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(hideHUDS:) name:@"HIDEHUD" object:nil];
    
//    HYXiaLaView *HY = [[HYXiaLaView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 64)];
//    HY.titleArr = @[@"我的优惠券",@"使用"];
//    NSArray *arr1 = @[@"test",@"test2",@"test3",@"test4",@"test5",@"test6"];
//    NSArray *arr2 = @[@"ssss",@"ssss2",@"ssss3",@"ssss4"];
//    NSDictionary *dic1 = @{@"num":@(4),@"high":@(45),@"data":arr1};
//    NSDictionary *dic2 = @{@"num":@(3),@"high":@(60),@"data":arr2};
//    NSArray *arr3 = @[dic1,dic2];
//    HY.dataArr = arr3;
//    [self.view addSubview:HY];
    
    if(isIPhoneX)
    {
        //self.fundAccountTableView.frame = CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT - WDTopHeight - 64);
        self.bottomFLLayout.constant = -34;
    }
    
}

//+(BOOL)resolveInstanceMethod:(SEL)sel
//{
//    class_addMethod([self class], sel, (IMP)dymemmeIMP, "v@:");
//    return [super resolveInstanceMethod:sel];
//}
//
//void dymemmeIMP(id self,SEL _cmd)
//{
//
//}

- (void)test:(NSNotification*)notification {
    [_firstAry removeAllObjects];
    _firstAry = [notification object];
    if(_firstAry.count == 0)
    {
        self.noMsgView.frame = CGRectMake(0, 0, SCREEN_WIDTH , SCREEN_HEIGHT - WDTopHeight - 64);
        [self.tableView addSubview:self.noMsgView];
    }else
    {
        [self.noMsgView removeFromSuperview];
    }
    [self.tableView reloadData];
    [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
    
}

- (void)testChuanCan:(NSNotification*)chuanCan {
    _statusStr = [NSString stringWithFormat:@"%@",chuanCan.object];
    [self.tableView reloadData];
    [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
    
}

- (void)testTy:(NSNotification*)testTy {
    _tYStr = [NSString stringWithFormat:@"%@",testTy.object];
    [self.tableView reloadData];
    [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
}

-(void)yhqLoading:(NSNotification *)yhqLoading
{
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
}

-(void)hideHUDS:(NSNotification *)hide
{
    [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
}

- (void)backAction {
    //返回（我的）
    //[AppDelegate backToMe];
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - 添加子控制器
- (void)setupAllChildViewController {
    YZSortViewController *sort = [[YZSortViewController alloc] init];
    YZMoreMenuViewController *moreMenu  = [[YZMoreMenuViewController alloc] init];
    [self addChildViewController:sort];
    [self addChildViewController:moreMenu];
}

#pragma mark - YZPullDownMenuDataSource
// 返回下拉菜单多少列
- (NSInteger)numberOfColsInMenu:(YZPullDownMenu *)pullDownMenu {
    return 2;
}

// 返回下拉菜单每列按钮
- (UIButton *)pullDownMenu:(YZPullDownMenu *)pullDownMenu buttonForColAtIndex:(NSInteger)index {
    YZMenuButton *button = [YZMenuButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:_titles[index] forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:14];
    button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [button setTitleColor:UIcolors forState:UIControlStateSelected];
    [button setImage:[UIImage imageNamed:@"多边形.png"] forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:@"形.png"] forState:UIControlStateSelected];
    return button;
}



// 返回下拉菜单每列对应的控制器
- (UIViewController *)pullDownMenu:(YZPullDownMenu *)pullDownMenu viewControllerForColAtIndex:(NSInteger)index {
    return self.childViewControllers[index];
}

// 返回下拉菜单每列对应的高度
- (CGFloat)pullDownMenu:(YZPullDownMenu *)pullDownMenu heightForColAtIndex:(NSInteger)index {
    // 第1列 高度
    if (index == 0) {
        return 89;
    }
    // 第2列 高度
    return 133;
}


- (void)viewDidAppear:(BOOL)animated {
    self.hideNaviBar = NO;
}

- (void)loadCanHongBaoData {
    [self.noMsgView removeFromSuperview];
    __weak __typeof(self) weakSelf = self;
    [self.httpUtil requestDic4MethodNam:@"v2/accept/account/findAllCoupon" parameters:@{@"status":@(0)} result:^(id  dic, int status, NSString *msg) {
        NSLog(@"%@\n%@",msg,dic);
        if (status == 0) {
//            [MBProgressHUD showMessag:msg toView:self.view];
            if (_firstAry.count == 0) {
//                self.hideNoNetWork = NO;
//                self.noNetWorkView.top = 53;
//                self.noNetWorkView.height = SCREEN_HEIGHT - 53;
//                self.noNetWorkView.width = SCREEN_WIDTH;
            }
        }else {
            self.hideNoNetWork = YES;
            NSLog(@"%@",dic);
            if (_start == 0) {
                _firstAry = [NSMutableArray array];
            }
            [_firstAry removeAllObjects];
            [_firstAry addObjectsFromArray:dic];
            
            [_tableView.mj_footer resetNoMoreData];
        }
        if(_firstAry.count == 0)
        {
            weakSelf.noMsgView.frame = CGRectMake(0, 0, SCREEN_WIDTH , SCREEN_HEIGHT - WDTopHeight - 64);
            [weakSelf.tableView addSubview:weakSelf.noMsgView];
        }
        [_tableView reloadData];
        [_tableView.mj_header endRefreshing];
    }];
}

//筛选加载
-(void)sendServerForRequest:(NSInteger )sort URL:(BOOL)isLeft
{
    [self.noMsgView removeFromSuperview];
    NSString *url = @"";
    if(isLeft)
    {
        url = @"v2/accept/account/findAllCoupon";
    }else
    {
        url = @"v2/accept/account/commonCouponList";
    }
    WS
    NSDictionary *dicse = @{@"status":@(sort)};
    [self.httpUtil requestDic4MethodNam:url parameters:dicse result:^(id  dic, int status, NSString *msg) {
        NSLog(@"%@\n%@",msg,dic);
        if (status == 0) {
            //            [MBProgressHUD showMessag:msg toView:self.view];
            if (_firstAry.count == 0) {
                //                self.hideNoNetWork = NO;
                //                self.noNetWorkView.top = 53;
                //                self.noNetWorkView.height = SCREEN_HEIGHT - 53;
                //                self.noNetWorkView.width = SCREEN_WIDTH;
            }
        }else {
            weakSelf.hideNoNetWork = YES;
            NSLog(@"%@",dic);
            if (_start == 0) {
                _firstAry = [NSMutableArray array];
            }
            [_firstAry removeAllObjects];
            [_firstAry addObjectsFromArray:dic];
            [_tableView.mj_footer resetNoMoreData];
            
        }
        if(_firstAry.count == 0)
        {
            weakSelf.noMsgView.frame = CGRectMake(0, 0, SCREEN_WIDTH , SCREEN_HEIGHT - WDTopHeight - 64);
            [weakSelf.tableView addSubview:weakSelf.noMsgView];
        }
        [_tableView reloadData];
        [_tableView.mj_header endRefreshing];
    }];
    
}

- (void)setupTableView {
    _tableView.contentInset = UIEdgeInsetsMake(1.0,0.0,0.0,0.0);
    _tableView.tableFooterView  = [UIView new];
    [self setupRefreshWithTableView:_tableView];

    [_tableView registerNib:[UINib nibWithNibName:@"MyFuLiableViewCell" bundle:nil] forCellReuseIdentifier:@"MyFuLiableViewCell"];
    [_tableView registerNib:[UINib nibWithNibName:@"MyPrivilegeCell" bundle:nil] forCellReuseIdentifier:@"MyPrivilegeCell"];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 9;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 10;
}

#pragma mark - UITableViewDelegate & UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _firstAry.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([_tYStr integerValue]==5) {
        static NSString *CellIdentifier = @"MyFuLiableViewCell";
        MyFuLiableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil) {
            cell = [[MyFuLiableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        }
        self.tableView.showsVerticalScrollIndicator = NO;
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        int stat = [_statusStr intValue];
        [cell setMyFuLiDic:_firstAry[indexPath.row] withStatus:stat];
        return cell;
    }else {
        static NSString *CellId = @"MyPrivilegeCell";
        MyPrivilegeCell *cell = [tableView dequeueReusableCellWithIdentifier:CellId];
        if (cell == nil) {
            cell = [[MyPrivilegeCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellId];
        }
        self.tableView.showsVerticalScrollIndicator = NO;
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        int stat = [_statusStr intValue];
        [cell setMyPrivilegeDic:_firstAry[indexPath.row] withStatus:stat];
        return cell;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 136;
}

- (void)headerRefreshloadData {
    if (_touArr.count < _limit) {
        //[self loadCanHongBaoData];
        //return;
    }else {
        //[self loadCanHongBaoData];
    }
//    id selected = [[NSUserDefaults standardUserDefaults]objectForKey:@"selectedCo"];
//    NSInteger C  = [selected integerValue];
    if ([_tYStr integerValue] == 5) {
        [self sendServerForRequest:[_statusStr integerValue] URL:YES];
    }else
    {
        [self sendServerForRequest:[_statusStr integerValue] URL:NO];
    }
    
    //[_tableView.mj_header endRefreshing];
}

- (void)footerRefreshloadData {
    if (_touArr.count-_start < _limit) {
        [MBProgressHUD showMessag:@"没有更多数据了" toView:self.view];
        [_tableView.mj_footer endRefreshing];
        return;
    }
    [_tableView.mj_header endRefreshing];
}

- (void)dealloc {
    //第一种方法.这里可以移除该控制器下的所有通知
    // 移除当前所有通知
    NSLog(@"移除了所有的通知");
    //[[NSNotificationCenter defaultCenter] removeObserver:self];
    //第二种方法.这里可以移除该控制器下名称为tongzhi的通知
    //移除名称为tongzhi的那个通知
    //NSLog(@"移除了名称为notifacation的通知");
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"notifacation" object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"chuanCan" object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"tyQuan" object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"YHQLoading" object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"HIDEHUD" object:nil];
    
}

@end
