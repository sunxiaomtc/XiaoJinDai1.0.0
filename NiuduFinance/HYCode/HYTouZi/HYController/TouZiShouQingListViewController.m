//
//  TouZiShouQingListViewController.m
//  NiuduFinance
//
//  Created by 小吊丝 on 2017/9/26.
//  Copyright © 2017年 liuyong. All rights reserved.
//

#import "TouZiShouQingListViewController.h"

#import "ProjectDetailsViewController.h"
#import "SNProjectListModel.h"
#import "SNProjectListItem.h"
#import "XSNHomeProjecCell.h"
#import "AppDelegate.h"
#import "XProjectDetailsController.h"
#import "MoreWebViewController.h"
#import "TouZiJiLuViewController.h"
#import "HYProjectDetailsViewController.h"


@interface TouZiShouQingListViewController ()<UITableViewDelegate, UITableViewDataSource>

@property(nonatomic, strong)UITableView *tableView;

@property (nonatomic, strong) UIScrollView * xsScroll;
@property (nonatomic, strong) UIView * xszxView;
@property (nonatomic, strong) UIPageControl * pageControl;
@property (nonatomic, strong)NSMutableArray * dataArr;
@property (nonatomic, strong)NSMutableArray * recProductAr;

@property (nonatomic, strong) SNProjectListModel * newLenderProjectModel;
@property (nonatomic, strong) SNProjectListModel * projectModel;
@property (nonatomic, strong) NSMutableArray     * noNewMutableArr;
@property (nonatomic, assign)int noNewPageIndex;
@property (nonatomic, assign)NSInteger noNewPageSize;
@property (nonatomic, assign)NSInteger noNewCount;
@property (nonatomic, assign)int page;

//zk
@property (nonatomic, strong) UIView * firstView;
@property (nonatomic, strong) UIImageView * imageView1;
@property (nonatomic, strong) UILabel * textLabel;
@property (nonatomic,strong)NSMutableArray * data;

@end

@implementation TouZiShouQingListViewController

- (SNProjectListModel *)newLenderProjectModel
{
    if (!_newLenderProjectModel) {
        _newLenderProjectModel = [SNProjectListModel new];
        _newLenderProjectModel.key = @"__SNProjectListModel__";
        _newLenderProjectModel.requestType = VZModelCustom;
        _newLenderProjectModel.isHome = YES;
        _newLenderProjectModel.isNewLender = YES;
        _newLenderProjectModel.avative =2;
    }
    return _newLenderProjectModel;
}
- (SNProjectListModel *)projectModel
{
    if (!_projectModel) {
        _projectModel = [SNProjectListModel new];
        _projectModel.key = @"__SNProjectListModel__";
        _projectModel.requestType = VZModelCustom;
        _projectModel.isNewLender = NO;
        _projectModel.avative = 2;
    }
    return _projectModel;
}


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.hidesBottomBarWhenPushed=NO;
    [self getXSZX];
    [self getIsNewData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _noNewPageIndex = 1;
    _noNewPageSize = 10;
    _noNewCount = 0;
    _dataArr = [NSMutableArray array];
    _recProductAr = [NSMutableArray array];
    _noNewMutableArr = [NSMutableArray array];
    _data = [NSMutableArray array];
    self.tableView.showsVerticalScrollIndicator = NO;
    
    
    [self setupBarButtomItemWithImageName:@"黑色返回按钮" highLightImageName:@"黑色返回按钮" selectedImageName:nil target:self action:@selector(backClick) leftOrRight:YES];
    self.title = @"售罄列表";
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-64) style:(UITableViewStyleGrouped)];
    [self.view addSubview:self.tableView];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    //首页下拉刷新
    [self setupRefreshWithTableView:_tableView];
    self.tableView.backgroundColor = [UIColor colorWithHexString:@"F0F0F4"];
    
    WS
    [self.newLenderProjectModel loadWithCompletion:^(VZModel *model, NSError *error) {
        if (!error && weakSelf.newLenderProjectModel.objects.count) {
            NSLog(@"投资首页-================%ld",weakSelf.newLenderProjectModel.objects.count);
            if (weakSelf.newLenderProjectModel.objects.count == 1)
            {
                [weakSelf.recProductAr addObject:weakSelf.newLenderProjectModel.objects[0]];
            }else{
//                [weakSelf.recProductAr  addObjectsFromArray:[weakSelf.newLenderProjectModel.objects subarrayWithRange:NSMakeRange(0, 5)]];
                [weakSelf.recProductAr addObjectsFromArray:weakSelf.newLenderProjectModel.objects];
            }
            
            [weakSelf.tableView reloadData];
        }
    }];
    [self.newLenderProjectModel loadWithCompletion:nil];
}

-(void)backClick
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)textLabelNew
{
    NSString *string = [[NSString alloc] initWithFormat:@"%ld",_textLabel.tag];
    NSLog(@"%@",string);
    NSString * srtt = [[[NSMutableString stringWithString:@""]stringByAppendingString:@"v2/open/appAfficheDetail.jsp?id=" ]stringByAppendingString:string];
    
    NSLog(@"%@",srtt);
    MoreWebViewController * moreWebVC = [MoreWebViewController new];
    moreWebVC.titleStr = @"最新公告";
    moreWebVC.webStr = srtt;
    NSLog(@"%@",moreWebVC.webStr);
    [self.navigationController pushViewController:moreWebVC animated:YES];
}

-(void)createScrollView{
    
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    _page = scrollView.contentOffset.x / scrollView.frame.size.width;
    //    NSLog(@"%d", page);
    
    // 设置页码
    _pageControl.currentPage = _page;
    //    NSLog(@"%d",_page);
    //
    //    if (_page == 0) {
    //        [self getXSZX];
    //    }else if (_page == 1)
    //    {
    //        [self getXSZX];
    //    }
}

- (void)getXSZX
{
    [self.httpUtil requestArr4MethodNam:@"v2/open/project/list" parameters:@{@"isAvailable":@(1),@"limit":@(6),@"isNewLender":@(1),@"start":@(0)} result:^(NSArray *arr, int status, NSString *msg) {
        NSLog(@"%@",arr);
        if (status == 0) {
            
        }else{
            [_dataArr removeAllObjects];
            [_dataArr addObjectsFromArray:arr];
            if (_dataArr.count == 0) {
                return ;
            }
            [self addData];
            
            [_tableView.mj_footer resetNoMoreData];
        }
    } convertClassName:nil key:nil];
    
}

-(void)addData{
    
    for (int i=0; i<_dataArr.count; i++) {
        UILabel *nhLabelN=[self.view viewWithTag:500+i];
        UILabel *qxLabelN=[self.view viewWithTag:600+i];
        UILabel *ktLabelN=[self.view viewWithTag:700+i];
        
        NSString * sss = [NSString stringWithFormat:@"%@",[_dataArr[i] objectForKey:@"rate"]];
        nhLabelN.text = [[NSString stringWithFormat:@"%.2f",[sss floatValue]] stringByAppendingString:@"%"];
        NSString * ssp = [NSString stringWithFormat:@"%@",[_dataArr[i] objectForKey:@"periodtypeid"]];
        NSString * ssb;
        if ([ssp isEqualToString:@"1"]) {
            ssb = @"天";
        }else if ([ssp isEqualToString:@"2"])
        {
            ssb = @"个月";
        }else if ([ssp isEqualToString:@"3"])
        {
            ssb = @"年";
        }
        qxLabelN.text = [NSString stringWithFormat:@"%@%@",[_dataArr[i] objectForKey:@"loanperiod"],ssb];
        ktLabelN.text = [NSString stringWithFormat:@"%@元",[_dataArr[i] objectForKey:@"remainamount"]];
        
    }
    [_tableView reloadData];
    
    
}

//点击进去新手专享
- (void)btnClick:(UIButton *)btn
{
    if (![AppDelegate checkLogin]) return;
    NSLog(@"12346");
    WS
    if (_newLenderProjectModel.objects.count) {
        //        [weakSelf.recProductAr  addObjectsFromArray:[weakSelf.newLenderProjectModel.objects subarrayWithRange:NSMakeRange(0, 5)]];
        if (weakSelf.newLenderProjectModel.objects.count == 1)
        {
            [weakSelf.recProductAr addObject:weakSelf.newLenderProjectModel.objects[0]];
        }else{
//            [weakSelf.recProductAr  addObjectsFromArray:[weakSelf.newLenderProjectModel.objects subarrayWithRange:NSMakeRange(0, 5)]];
            [weakSelf.recProductAr addObjectsFromArray:weakSelf.newLenderProjectModel.objects];
        }
    } else {
        
        [self.newLenderProjectModel loadWithCompletion:^(VZModel *model, NSError *error) {
            if (!error && weakSelf.newLenderProjectModel.objects.count) {
                if (weakSelf.newLenderProjectModel.objects.count == 1)
                {
                    [weakSelf.recProductAr addObject:weakSelf.newLenderProjectModel.objects[0]];
                }else{
//                    [weakSelf.recProductAr  addObjectsFromArray:[weakSelf.newLenderProjectModel.objects subarrayWithRange:NSMakeRange(0, 5)]];
                    [weakSelf.recProductAr addObjectsFromArray:weakSelf.newLenderProjectModel.objects];
                }
                [weakSelf.tableView reloadData];
            } else {
                
            }
        }];
    }
    SNProjectListItem * projectItem = _recProductAr[btn.tag-800];
    self.hidesBottomBarWhenPushed=YES;
    XProjectDetailsController * projectDetailsVC = [XProjectDetailsController new];
    projectDetailsVC.projectId = projectItem.projectId.intValue;
    projectDetailsVC.projectItem = projectItem;
    [self.navigationController pushViewController:projectDetailsVC animated:YES];
    self.hidesBottomBarWhenPushed=NO;
}

#pragma mark 散标data
- (void)getIsNewData
{
    __block NSInteger pageIndex;
    NSInteger pageSize;
    self.projectModel.start = 0;
    
    pageIndex = _noNewPageIndex;
    pageSize = _noNewPageSize;
    
    if (pageIndex > 1)
        self.projectModel.start = _noNewMutableArr.count;
    
    WS
    [self.projectModel loadWithCompletion:^(VZModel *model, NSError *error) {
        [weakSelf.noNetWorkView removeFromSuperview];
        
        if (!error) {
            if (_noNewPageIndex == 1) {
                [_noNewMutableArr removeAllObjects];
            }
            
            [_tableView.mj_header endRefreshing];
            [_tableView.mj_footer endRefreshing];
            
            _noNewCount = weakSelf.projectModel.objects.count;
            [_noNewMutableArr addObjectsFromArray:weakSelf.projectModel.objects];
            
            [weakSelf.projectModel.objects removeAllObjects];
            
            if (_noNewMutableArr.count == 0) {
                
                weakSelf.noMsgView.width = SCREEN_WIDTH;
                [_tableView addSubview:weakSelf.noMsgView];
            }else{
                [weakSelf.noMsgView removeFromSuperview];
            }
            
            if (pageIndex > 1 && !weakSelf.noNewCount) {
                [MBProgressHUD showMessag:@"没有更多数据了" toView:weakSelf.view];
            }
        } else {
            if (![[error localizedDescription] isEqual:@"尝试除以零。"]) {
                NSLog(@"%@",error.localizedDescription);
                [MBProgressHUD showError:[error localizedDescription] toView:weakSelf.view];
            }
            
            weakSelf.noNetWorkView.width = SCREEN_WIDTH;
            [_tableView addSubview:weakSelf.noNetWorkView];
        }
        [_tableView reloadData];
    }];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    NSLog(@"%ld",_noNewMutableArr.count);
    return _noNewMutableArr.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 150;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (section == _noNewMutableArr.count-1) {
        return 0.1;
    }else{
        return 0.1;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return 40;
    }
    return 10.0;
}
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return @"散标投资";
    }
    return @"";
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    return nil;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //    static NSString *CellIdentifier = @"Cell";
    //    UITableViewCell *cell = (UITableViewCell*)[tableView  dequeueReusableCellWithIdentifier:CellIdentifier];
    //    if (cell == nil) {
    //        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    //    }
    static NSString *cellID = @"XSNHomeProjecCell";
    XSNHomeProjecCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [[XSNHomeProjecCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    @try {
        cell.item = _noNewMutableArr[indexPath.section];
        cell.type =_projectModel.avative;
    } @catch (NSException *exception) {
        if (_noNewMutableArr.count-1 <= indexPath.section ) {
            NSLog(@"滑动太快啦吧");
        }
    } @finally{
    }
    return cell;
}

-(void)footerButtonAction
{
    self.hidesBottomBarWhenPushed=YES;
    TouZiShouQingListViewController *VC = [[TouZiShouQingListViewController alloc] init];
    [self.navigationController pushViewController:VC animated:YES];
    self.hidesBottomBarWhenPushed=NO;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (![AppDelegate checkLogin]) return;
//    self.hidesBottomBarWhenPushed=YES;
//    XProjectDetailsController *projectDetailsVC = [XProjectDetailsController new];
//    //    ProjectDetailsViewController * projectDetailsVC = [ProjectDetailsViewController new];
//    SNProjectListItem * projectItem = _noNewMutableArr[indexPath.section];
//    projectDetailsVC.projectId = projectItem.projectId.intValue;
//    projectDetailsVC.projectItem = projectItem;
//    [self.navigationController pushViewController:projectDetailsVC animated:YES];
//    self.hidesBottomBarWhenPushed=NO;
    
    HYProjectDetailsViewController *pro = [HYProjectDetailsViewController new];
    SNProjectListItem * projectItem = _noNewMutableArr[indexPath.section];
    pro.projectId = projectItem.projectId.intValue;
    pro.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:pro animated:YES];
    
}

- (void)headerRefreshloadData
{
    _noNewPageIndex = 1;
    _noNewPageSize = 10;
    [self getIsNewData];
    [_tableView.mj_header endRefreshing];
}

- (void)footerRefreshloadData
{
    _noNewPageIndex ++;
    
    [self getIsNewData];
    
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
