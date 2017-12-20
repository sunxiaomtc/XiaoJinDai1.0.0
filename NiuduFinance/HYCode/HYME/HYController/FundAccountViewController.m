//
//  FundAccountViewController.m
//  NiuduFinance
//
//  Created by liuyong on 16/3/14.
//  Copyright © 2016年 liuyong. All rights reserved.
//

#import "FundAccountViewController.h"
#import "FundAccountTableViewCell.h"
#import "FundCollectionViewCell.h"
#import "NoMsgView.h"

static NSString *FundSortCollectionViewCellID = @"FundCollectionViewCell";

@interface FundAccountViewController ()<UITableViewDataSource,UITableViewDelegate,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property (weak, nonatomic) IBOutlet UITableView *fundAccountTableView;

@property (nonatomic,strong)NSMutableArray *fundAccountArr;


@property (nonatomic,assign)NSInteger start;
@property (nonatomic,assign)NSInteger limit;
//zk
@property (weak, nonatomic) IBOutlet UIView *bgView;
@property (strong, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *heightConst;
@property (nonatomic , assign) BOOL  isOpen;
@property (nonatomic , strong) NSMutableArray *sortData;
@property (nonatomic , assign) NSUInteger  sortIndex;
@end

@implementation FundAccountViewController
- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])
    {
        //显示底部tabBar
        self.hideBottomBar = NO;
    }
    return self;
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    //隐藏导航栏
    [self.navigationController setNavigationBarHidden:NO animated:NO];
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
    [self backBarItem];
    self.navigationItem.title = @"资金记录";
    _start = 0;
    _limit = 12;
    _sortIndex =0;
    
    _fundAccountArr = [NSMutableArray array];
    
    [self setTableViewInfo];
    
    [self getFundAccountData];
    
    [self setupBarButtomItemWithTitle:@"筛选" target:self action:@selector(rightAction) leftOrRight:NO];
    self.navigationItem.rightBarButtonItem.tintColor = [UIColor blackColor];//[UIColor colorWithHexString:@"ffffff"];
}

- (void)rightAction {
    NSLog(@"右边点击");
    //加载筛选数据，创建筛选页面
    if (!_isOpen) {
        //打开
        _sortData = [NSMutableArray arrayWithObjects:@"全部",@"福利金",@"充值",@"提现",@"投资",@"还款",@"优惠券",@"其他", nil];
        
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        _collectionView.collectionViewLayout = layout;
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        
        [_collectionView registerNib:[UINib nibWithNibName:@"FundCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"FundCollectionViewCell"];
        
        _collectionView.hidden = NO;
        _bgView.hidden = NO;
        self.navigationItem.rightBarButtonItem.title = @"取消";
        
        _heightConst.constant = 30+44*ceilf(_sortData.count/3.0) +ceilf(_sortData.count/3.0)*10;
        
        UITapGestureRecognizer *tap =[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap)];
        [_bgView addGestureRecognizer:tap];
        
        [_collectionView reloadData];
    }else {
        //关闭
        _collectionView.hidden =YES;
        _bgView.hidden =YES;
         self.navigationItem.rightBarButtonItem.title =self.sortData[_sortIndex];
    }
    _isOpen = !_isOpen;
}

- (void)tap {
    _bgView.hidden =YES;
    _collectionView.hidden =YES;
    self.navigationItem.rightBarButtonItem.title = self.sortData[_sortIndex];
    _isOpen = NO;
}

#pragma mark - collectionView
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    NSLog(@"数组%lu",(unsigned long)_sortData.count);
    return _sortData.count;
}
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    FundCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:FundSortCollectionViewCellID forIndexPath:indexPath];
    cell.fundLabel.text = _sortData[indexPath.row];
    [collectionView selectItemAtIndexPath:[NSIndexPath indexPathForRow:_sortIndex inSection:0] animated:NO scrollPosition:UICollectionViewScrollPositionNone];
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    _sortIndex = indexPath.row;
    _start =0;
    self.navigationItem.rightBarButtonItem.title = self.sortData[indexPath.row];
    [self tap];
    [_fundAccountArr removeAllObjects];
    [self getFundAccountData];
    [self.fundAccountTableView.mj_header beginRefreshing];
}


-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(15, 15, 15, 15);
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake((SCREEN_WIDTH-50)/3, 44);
}

-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 10;
}

-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 2.5;
}

- (void)getFundAccountData {
    WS
    [self.httpUtil requestDic4MethodNam:@"v2/accept/account/findAllFundSerials" parameters:@{@"type":@(_sortIndex),@"limit":@(_limit),@"start":@(_start)} result:^(id dic, int status, NSString *msg) {
        
        NSLog(@"%d",status);
        NSLog(@"%@",dic);
        if (_start == 0) {
            [_fundAccountArr removeAllObjects];
        }
        if (status == 0) {
            if (![dic isKindOfClass:[NSNull class]]) {
                [_fundAccountArr addObjectsFromArray:dic];
                if(_fundAccountArr.count == 0)
                {
                    [weakSelf.view addSubview:weakSelf.noMsgView];
                }else
                {
                    [weakSelf.noMsgView removeFromSuperview];
                }
            }
        }else {
            [_fundAccountArr addObjectsFromArray:dic];
            [_fundAccountTableView.mj_footer resetNoMoreData];
        }
        [_fundAccountTableView reloadData];
    }];
    
}

- (void)setTableViewInfo
{
    //底部刷新
    _fundAccountTableView.tableFooterView = [UIView new];
    [self setupRefreshWithTableView:_fundAccountTableView];
    [_fundAccountTableView registerNib:[UINib nibWithNibName:@"FundAccountTableViewCell" bundle:nil] forCellReuseIdentifier:@"FundAccountTableViewCell"];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _fundAccountArr.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 70;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID = @"FundAccountTableViewCell";
    FundAccountTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [[FundAccountTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    
    NSLog(@"%ld",indexPath.row);
    if (indexPath.row<_fundAccountArr.count) {
        [cell setFundAccountDic:_fundAccountArr[indexPath.row]];
    }

    return cell;
}

- (void)headerRefreshloadData
{
    NSLog(@"%ld",_fundAccountArr.count);
    NSLog(@"%ld",_limit);
    if (_fundAccountArr.count<_limit) {
//        [MBProgressHUD showMessag:@"没有更多数据了" toView:self.view];
         [self getFundAccountData];
        [_fundAccountTableView.mj_header endRefreshing];
        return;
    }

//    _start = _start +_limit;
    [self getFundAccountData];
    [_fundAccountTableView.mj_header endRefreshing];
}

- (void)footerRefreshloadData
{
    

    NSLog(@"%ld",_fundAccountArr.count);
    NSLog(@"%ld",_limit);
    if (_fundAccountArr.count-_start<_limit) {
        
        [MBProgressHUD showMessag:@"没有更多数据了" toView:self.view];

        [_fundAccountTableView.mj_footer endRefreshing];
        return;
    }
//    [_fundAccountArr removeAllObjects];

        _start = _start +_limit;
        [self getFundAccountData];
        [_fundAccountTableView.mj_footer endRefreshing];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
