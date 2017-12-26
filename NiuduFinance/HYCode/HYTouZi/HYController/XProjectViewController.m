//
//  XProjectViewController.m
//  NiuduFinance
//
//  Created by 123 on 17/7/17.
//  Copyright © 2017年 liuyong. All rights reserved.
//

#import "XProjectViewController.h"
#import "ProjectDetailsViewController.h"
#import "SNProjectListModel.h"
#import "SNProjectListItem.h"
#import "XSNHomeProjecCell.h"
#import "AppDelegate.h"
#import "XProjectDetailsController.h"
#import "TouZiShouQingListViewController.h"
#import "MoreWebViewController.h"

@interface XProjectViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
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

@implementation XProjectViewController

- (SNProjectListModel *)newLenderProjectModel
{
    if (!_newLenderProjectModel) {
        _newLenderProjectModel = [SNProjectListModel new];
        _newLenderProjectModel.key = @"__SNProjectListModel__";
        _newLenderProjectModel.requestType = VZModelCustom;
        _newLenderProjectModel.isHome = YES;
        _newLenderProjectModel.isNewLender = YES;
        _newLenderProjectModel.avative =1;
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
        _projectModel.avative =1;
    }
    return _projectModel;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.title = @"投资";
    [self setupTableView];
    [self getXSZX];
    [self getIsNewData];
    //隐藏导航栏
//    [self.navigationController setNavigationBarHidden:YES animated:NO];
//    NSDictionary *mine = [NSDictionary dictionaryWithObject:[UIColor blackColor] forKey:NSForegroundColorAttributeName];
//    self.navigationController.navigationBar.titleTextAttributes = mine;
//    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
}

- (void)setupTableView
{
    //首页下拉刷新
    //[self setupRefreshWithTableView:_tableView];
    
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(headerRefreshloadData)];
    header.lastUpdatedTimeLabel.font = [UIFont systemFontOfSize:12];
    header.stateLabel.font = [UIFont systemFontOfSize:12];
    [header setTitle:@"松开立即刷新财运" forState:MJRefreshStatePulling];
    [header setTitle:@"松开立即刷新财运" forState:MJRefreshStateIdle];
    
    self.tableView.mj_header = header;
    
    MJRefreshBackNormalFooter *footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(footerRefreshloadData)];
    footer.stateLabel.font = [UIFont systemFontOfSize:12];
    footer.arrowView.alpha = 0.0;
    [footer setTitle:@"松开立即刷新财运" forState:MJRefreshStatePulling];
    [footer setTitle:@"松开立即刷新财运" forState:MJRefreshStateIdle];
    self.tableView.mj_footer = footer;
    
}

- (void)getNewAccment
{
    [self.httpUtil requestDic4MethodNam:@"v2/open/affiche/findAll" parameters:@{@"start":@(0),@"limit":@(1)} result:^(id dic, int status, NSString *msg) {
        
        if (status == 0) {
//            [MBProgressHUD showMessag:msg toView:self.view];
            
        }else{
            [_data addObjectsFromArray:dic];
            
            if (_data != nil && [_data count]>0) {
                NSLog(@"%@",_data[0]);
                
                NSString * title = [_data [0]objectForKey:@"title"];
                NSLog(@"%@",title);
                //                [_titleBtn setTitle:title forState:UIControlStateNormal];
                [_textLabel setText:title];
                NSLog(@"%@",_textLabel);
                
                NSInteger k = [[_data [0]objectForKey:@"newsinformationid"] integerValue];
                _textLabel.tag = k;
                
                NSLog(@"%@",[_data [0]objectForKey:@"newsinformationid"]);
                NSLog(@"%ld",_textLabel.tag);
            }
        }
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _noNewPageIndex = 1;
    _noNewPageSize = 10;
    _noNewCount = 0;
    _dataArr = [NSMutableArray array];
    _recProductAr = [NSMutableArray array];
    _noNewMutableArr = [NSMutableArray array];
    _data = [NSMutableArray array];
    self.tableView.showsVerticalScrollIndicator = NO;

    WS
    [self.newLenderProjectModel loadWithCompletion:^(VZModel *model, NSError *error) {
        if (!error && weakSelf.newLenderProjectModel.objects.count) {
            NSLog(@"投资首页-================%ld",weakSelf.newLenderProjectModel.objects.count);
            if (weakSelf.newLenderProjectModel.objects.count == 1)
            {
                [weakSelf.recProductAr addObject:weakSelf.newLenderProjectModel.objects[0]];
            }else{
                [weakSelf.recProductAr  addObjectsFromArray:[weakSelf.newLenderProjectModel.objects subarrayWithRange:NSMakeRange(0, 1)]];
            }

            [weakSelf.tableView reloadData];
        }
    }];
    [self.newLenderProjectModel loadWithCompletion:nil];
    
//    _firstView = [UIView new];
//    _firstView.height =45;
//    [_firstView setBackgroundColor:[UIColor colorWithHexString:@"#ffffff"]];
//    _tableView.tableHeaderView = _firstView;
//    [_firstView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.mas_equalTo(0);
//        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH, 45));
//    }];
//    
//    _imageView1 = [UIImageView new];
//    UIImage * image1 = [UIImage imageNamed:@"newad_icon"];
//    _imageView1.image = image1;
//    [_firstView addSubview:_imageView1];
//    [_imageView1 mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.mas_equalTo(15);
//        make.size.mas_equalTo(CGSizeMake(20, 25));
//        make.centerY.mas_equalTo(0);
//    }];
//    
//    UIImageView *arrow =[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"newad_arrow"]];
//    [_firstView addSubview:arrow];
//    [arrow mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.right.mas_equalTo(-15);
//        make.centerY.mas_equalTo(0);
//        make.size.mas_equalTo(CGSizeMake(8, 15));
//    }];
//    
//    UILabel *des = [[UILabel alloc] init];
//    [_firstView addSubview:des];
//    [des mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.right.mas_equalTo(arrow.mas_left).offset(-5);
//        make.centerY.mas_equalTo(0);
//    }];
//    [des setText:@"查看更多"];
//    des.textColor = kLineColor;
//    des.font = [UIFont systemFontOfSize:14];
//    
//    
//    _textLabel = [UILabel new];
//    [_firstView addSubview:_textLabel];
//    [_textLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.centerY.mas_equalTo(0);
//        make.left.equalTo(_imageView1.mas_right).with.offset(15);
//        make.right.equalTo(_firstView).with.offset(-100);
//    }];
//    [_textLabel setFont:[UIFont systemFontOfSize:14]];
//    UITapGestureRecognizer * textLabelNew=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(textLabelNew)];
//    _textLabel.userInteractionEnabled = NO;
//    [_firstView addGestureRecognizer:textLabelNew];
    
    
    [self getNewAccment];
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
    moreWebVC.hidesBottomBarWhenPushed =YES;
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
            [weakSelf.recProductAr  addObjectsFromArray:[weakSelf.newLenderProjectModel.objects subarrayWithRange:NSMakeRange(0, 5)]];
        }
    } else {
       
        [self.newLenderProjectModel loadWithCompletion:^(VZModel *model, NSError *error) {
            if (!error && weakSelf.newLenderProjectModel.objects.count) {
                if (weakSelf.newLenderProjectModel.objects.count == 1)
                {
                    [weakSelf.recProductAr addObject:weakSelf.newLenderProjectModel.objects[0]];
                }else{
                    [weakSelf.recProductAr  addObjectsFromArray:[weakSelf.newLenderProjectModel.objects subarrayWithRange:NSMakeRange(0, 5)]];
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
        [self.noNetWorkView removeFromSuperview];
        
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
                
//                self.noMsgView.width = SCREEN_WIDTH;
//                [_tableView addSubview:self.noMsgView];
            }else{
                [self.noMsgView removeFromSuperview];
            }
            if (pageIndex > 2 && !weakSelf.noNewCount) {
                [MBProgressHUD showMessag:@"没有更多数据了" toView:self.view];
            }
        } else {
            if (![[error localizedDescription] isEqual:@"尝试除以零。"]) {
                [MBProgressHUD showError:[error localizedDescription] toView:self.view];
            }
            
            self.noNetWorkView.width = SCREEN_WIDTH;
            [_tableView addSubview:self.noNetWorkView];
        }
        [_tableView reloadData];
    }];
    
    
    
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    NSLog(@"%ld",_noNewMutableArr.count);
    if (_noNewMutableArr.count ==0||!_noNewMutableArr) {
        return 1;
    }
    return _noNewMutableArr.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (!_noNewMutableArr||_noNewMutableArr.count ==0) {
        return 0;
    }
    return 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 150;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (!_noNewMutableArr||_noNewMutableArr.count ==0) {
        return 50;
    }
    if (section == _noNewMutableArr.count-1) {
        return 50;
    }else{
        return 0.1;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (!_noNewMutableArr||_noNewMutableArr.count ==0) {
        return 10;
    }
   
    return 10;
}
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if (!_noNewMutableArr||_noNewMutableArr.count ==0) {
        return @"";
    }
    if (section == 0) {
        return @"";
    }
    return @"";
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
        cell.type =_projectModel.avative;
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    @try {
        cell.item = _noNewMutableArr[indexPath.section];
        cell.type =_projectModel.avative;
//        cell.addRate = []
    } @catch (NSException *exception) {
        if (_noNewMutableArr.count-1 <= indexPath.section ) {
            NSLog(@"滑动太快啦吧");
        }
    } @finally {
        
    }
    
    return cell;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    if (!_noNewMutableArr||_noNewMutableArr.count ==0) {
        UIView *bgView =[[UIView alloc] init];
        
        UIView *aView = [[UIView alloc] init];
        aView.backgroundColor = [UIColor whiteColor];
        [bgView addSubview:aView];
        [aView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(5);
            make.left.mas_equalTo(0);
            make.right.mas_equalTo(0);
            make.bottom.mas_equalTo(-5);
        }];
        
        UIButton *button = [[UIButton alloc] init];
        [aView addSubview:button];
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(0);
            make.right.mas_equalTo(0);
            make.top.mas_equalTo(0);
            make.bottom.mas_equalTo(0);
        }];
        [button addTarget:self action:@selector(footerButtonAction) forControlEvents:(UIControlEventTouchUpInside)];
        button.backgroundColor = [UIColor whiteColor];
        UILabel *title = [[UILabel alloc] init];
        [aView addSubview:title];
        [title mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(15);
            make.centerY.mas_equalTo(aView.centerY);
        }];
        title.text =@"查看已售磬标的";
        title.textColor =[UIColor colorWithHexString:@"000000"];
        title.font = [UIFont systemFontOfSize:14];
        
        UIImageView *arrow = [[UIImageView alloc] init];
        arrow.image = [UIImage imageNamed:@"newad_arrow"];
        [aView addSubview:arrow];
        
        [arrow mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(-15);
            make.centerY.mas_equalTo(aView.centerY);
            make.size.mas_equalTo(CGSizeMake(10, 15));
        }];
        
        return bgView;
    }
    if (section == _noNewMutableArr.count-1) {
        UIView *bgView =[[UIView alloc] init];
        
        UIView *aView = [[UIView alloc] init];
        aView.backgroundColor = [UIColor whiteColor];
        [bgView addSubview:aView];
        [aView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(5);
            make.left.mas_equalTo(0);
            make.right.mas_equalTo(0);
            make.bottom.mas_equalTo(-5);
        }];
        
        UIButton *button = [[UIButton alloc] init];
        [aView addSubview:button];
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(0);
            make.right.mas_equalTo(0);
            make.top.mas_equalTo(0);
            make.bottom.mas_equalTo(0);
        }];
        [button addTarget:self action:@selector(footerButtonAction) forControlEvents:(UIControlEventTouchUpInside)];
        button.backgroundColor = [UIColor whiteColor];
        UILabel *title = [[UILabel alloc] init];
        [aView addSubview:title];
        [title mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(15);
            make.centerY.mas_equalTo(aView.centerY);
        }];
        title.text =@"查看已售磬标的";
        title.textColor =[UIColor colorWithHexString:@"000000"];
        title.font = [UIFont systemFontOfSize:14];
        
        UIImageView *arrow = [[UIImageView alloc] init];
        arrow.image = [UIImage imageNamed:@"newad_arrow"];
        [aView addSubview:arrow];
        
        [arrow mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(-15);
            make.centerY.mas_equalTo(aView.centerY);
            make.size.mas_equalTo(CGSizeMake(10, 15));
        }];
        
        return bgView;
    }else{
        return nil;
    }
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
    XProjectDetailsController *projectDetailsVC = [XProjectDetailsController new];
    //    ProjectDetailsViewController * projectDetailsVC = [ProjectDetailsViewController new];
    SNProjectListItem * projectItem = _noNewMutableArr[indexPath.section];
    projectDetailsVC.projectId = projectItem.projectId.intValue;
    projectDetailsVC.projectItem = projectItem;
//    projectDetailsVC.addrate = [cell.item.addRate floatValue];
    projectDetailsVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:projectDetailsVC animated:YES];
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
//修改状态栏为黑色
//- (UIStatusBarStyle)preferredStatusBarStyle
//{
//    return UIStatusBarStyleDefault;
//}

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
