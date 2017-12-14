//
//  HomeViewController.m
//  NiuduFinance
//
//  Created by liuyong on 16/2/24.
//  Copyright © 2016年 liuyong. All rights reserved.
//

#import "HomeViewController.h"
#import "HomeHeaderView.h"
#import "HomeNewExclusiveCell.h"
#import "homeBullSharingCell.h"
#import "HomeFooterView.h"
#import "PageWebViewController.h"
#import "MoreWebViewController.h"
#import "AppDelegate.h"
#import "IntegralViewController.h"
#import "InvitationFriendsController.h"
#import "WelfareViewController.h"
#import "XProjectDetailsController.h"
#import "SNProjectListItem.h"
#import "SNProjectListModel.h"
#import "AnnouncementViewController.h"
#import "newInvestNTableViewCell.h"
#import "welfareNTableViewCell.h"
#import "AboutNViewController.h"
#import "HYHomeOneCell.h"
#import "HYHomeTwoCell.h"
#import "HYWebViewController.h"

static NSString *HomeNewExclusiveCellID = @"HomeNewExclusiveCell";
static NSString *homeBullSharingCellID = @"homeBullSharingCell";

@interface HomeViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *homeTableView;
@property (nonatomic, weak) HomeHeaderView *headerView;
@property (nonatomic, copy) NSString *rateStr;//预期年化
@property (nonatomic, copy) NSString *fljStr;//福利金
@property (nonatomic, copy) NSDictionary *experienceDic;//牛气分享标
@property (nonatomic, strong) NSMutableArray *recProductArr;
@property (nonatomic, strong) SNProjectListModel *newLenderProjectModel;
@property (nonatomic,copy) NSString *addRate;

@property (nonatomic, copy) NSString *str;

@property (nonatomic, copy) NSString *mutabStr;
@end

@implementation HomeViewController

- (SNProjectListModel *)newLenderProjectModel
{
    if (!_newLenderProjectModel) {
        _newLenderProjectModel = [SNProjectListModel new];
        _newLenderProjectModel.key = @"__SNProjectListModel__";
        _newLenderProjectModel.requestType = VZModelCustom;
        _newLenderProjectModel.isHome = YES;
        _newLenderProjectModel.isNewLender = YES;
//        _newLenderProjectModel.avative = 1;
    }
    return _newLenderProjectModel;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:animated];
    _recProductArr = [NSMutableArray array];
    if (_newLenderProjectModel.objects.count) {
        [self.recProductArr addObject:self.newLenderProjectModel.objects[0]];
    }else {
        WS
        [self.newLenderProjectModel loadWithCompletion:^(VZModel *model, NSError *error) {
            if (!error && weakSelf.newLenderProjectModel.objects.count) {
                [weakSelf.recProductArr addObject:weakSelf.newLenderProjectModel.objects[0]];
                [weakSelf.homeTableView reloadData];
            }else {
            }
        }];
    }
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    self.hideNaviBar = NO;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.homeTableView];
    [self setupRefreshWithTableView:_homeTableView];//首页下拉刷新
    [self.homeTableView reloadData];
    [self createHeaderAndFooter];
    [self loadDataScrollView];
    [self loadDataHomeList];
    [self shareAppVersionAlert];
    
    self.str = @"1";
    NSLog(@"1___%@",self.str);
    self.mutabStr = @"2";
    self.str = self.mutabStr;
    NSLog(@"%p___%p",self.str,self.mutabStr);
    NSLog(@"2___%@",self.str);
    self.mutabStr = @"3";
    NSLog(@"3___%@ ___%@  ___%p___%p",self.str,self.mutabStr,self.str,self.mutabStr);
    
}

#pragma mark - 请求轮播图数据以及广播文字的数组
- (void)loadDataScrollView {
    NSString *url = [__API_HEADER__ stringByAppendingString:@"v2/open/ad/findAll"];
    [NSObject POST:url parameters:nil progress:^(NSProgress *downloadProgress) {
        
    } completionHandler:^(id responseObject, NSError *error) {
        if (error) {
        }else {
            NSArray *array = responseObject[@"data"];
            self.headerView.bannerArray = array;
        }
    }];
//    文字轮播数据
    NSString *titleUrl = [__API_HEADER__ stringByAppendingString:@"v2/open/affiche/findAll"];
    NSDictionary *dic = @{
                          @"start":@(0),
                          @"limit":@(1)
                          };
    [NSObject POST:titleUrl parameters:dic progress:^(NSProgress *downloadProgress) {
        
    } completionHandler:^(id responseObject, NSError *error) {
        if (error) {
        }else {
            NSArray *array = responseObject[@"data"];
            self.headerView.titleArray = array;
        }
    }];
}

#pragma mark - 请求首页新手标的数据
- (void)loadDataHomeList{
    NSString *url = [__API_HEADER__ stringByAppendingString:@"v2/open/project/list"];
    NSDictionary *xsDic = @{
                            @"start":@(0),
                            @"limit":@(1),
                            @"isNewLender":@(1)
                            };
    __weak __typeof(self) weakSelf = self;
    [NSObject POST:url parameters:xsDic progress:^(NSProgress *downloadProgress) {
        
    } completionHandler:^(id responseObject, NSError *error) {
        if (error) {
            [MBProgressHUD showError:error.userInfo[ZHHTTPErrorMessage] toView:self.view];
        }else {
            NSArray *array = responseObject[@"data"];
            if (array.count != 0) {
                NSDictionary *dic = array[0];
               NSString *str = [self formatFloat:([dic[@"rate"]floatValue]-([dic[@"addRate"]floatValue]))];
//                self.rateStr = [NSString stringWithFormat:@"%.2f",([dic[@"rate"]floatValue]-([dic[@"addRate"]floatValue]))];
                weakSelf.rateStr = str;
                weakSelf.addRate = [NSString stringWithFormat:@"%@",dic[@"addRate"]];
            }
        }
        [weakSelf.homeTableView reloadData];
    }];
//    牛气分享标
    NSString *nqUrl = [__API_HEADER__ stringByAppendingString:@"v2/open/project/welfareFind"];
    [NSObject POST:nqUrl parameters:nil progress:^(NSProgress *downloadProgress) {
        
    } completionHandler:^(id responseObject, NSError *error) {
        if (error) {
            
        }else {
            self.experienceDic = responseObject[@"data"];
        }
        [self.homeTableView reloadData];
    }];
    self.fljStr = [NSString stringWithFormat:@"我的福利金0元"];
    
//    福利金
    NetWorkingUtil *util = [NetWorkingUtil netWorkingUtil];
    [util requestDic4MethodNam:@"v2/accept/account/getUserAssetInfo" parameters:nil result:^(NSDictionary *dic, int status, NSString *msg) {
        if (status == 0) {
//            [MBProgressHUD showMessag:msg toView:self.view];
        }else {
            self.fljStr = [NSString stringWithFormat:@"我的福利金%@元",[dic objectForKey:@"welfareFund"]];
        }
        [self.homeTableView reloadData];
    }];
}

//小数点问题
- (NSString *)formatFloat:(float)f
{
    if (fmodf(f, 1)==0) {//如果有一位小数点
        return [NSString stringWithFormat:@"%.0f",f];
    } else if (fmodf(f*10, 1)==0) {//如果有两位小数点
        return [NSString stringWithFormat:@"%.1f",f];
    } else {
        return [NSString stringWithFormat:@"%.2f",f];
    }
}



#pragma mark - 创建头部和尾部试图
- (void)createHeaderAndFooter {
    
    __weak __typeof(self) weakSelf = self;
    HomeHeaderView *headerView = [[HomeHeaderView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, [HomeHeaderView homeHeaderHight])];
//    首页的三个按钮的点击事件
    [headerView setHomeButtonBlock:^(NSInteger buttonTag){
        if (buttonTag == 0) {//积分签到
            if (![AppDelegate checkLogin]) {
//                [MBProgressHUD showMessag:@"未登录" toView:self.view];
                return;
            }else {
                IntegralViewController * integralVC = [IntegralViewController new];
                weakSelf.hidesBottomBarWhenPushed = YES;
                [weakSelf.navigationController pushViewController:integralVC animated:YES];
                weakSelf.hidesBottomBarWhenPushed = NO;
            }
        }
        else if (buttonTag == 1) {//邀请有奖
            if (![AppDelegate checkLogin]) {
                [MBProgressHUD showMessag:@"未登录" toView:self.view];
                return;
            }else {
                InvitationFriendsController * invitationVC = [InvitationFriendsController new];
                weakSelf.hidesBottomBarWhenPushed = YES;
                [weakSelf.navigationController pushViewController:invitationVC animated:YES];
                weakSelf.hidesBottomBarWhenPushed = NO;
            }
        }
        else if (buttonTag == 2) {
//            PageWebViewController *pageWebVC = [PageWebViewController new];
//            pageWebVC.urlStr = [__API_HEADER__ stringByAppendingString:@"v2/open/activity.jsp"] ;
//            pageWebVC.title = @"最新活动";
//            self.hidesBottomBarWhenPushed = YES;
//            [self.navigationController pushViewController:pageWebVC animated:YES];
//            self.hidesBottomBarWhenPushed = NO;
            AboutNViewController *aboutVC = [AboutNViewController new];
            weakSelf.hidesBottomBarWhenPushed = YES;
            [weakSelf.navigationController pushViewController:aboutVC animated:YES];
            weakSelf.hidesBottomBarWhenPushed = NO;
            
            
            
        }
    }];
    //轮播图的点击事件
    [headerView setHomeScrollViewBlock:^(NSString *bannerID){
        if (![bannerID isEqualToString:@""]) {//如果为空则不进行跳转
            PageWebViewController *pageWebVC = [PageWebViewController new];
            //pageWebVC.urlStr = [NSString stringWithFormat:@"%@%@",__API_HEADER__,bannerID];
            pageWebVC.urlStr = bannerID;
            pageWebVC.title = @"小金袋";
            weakSelf.hidesBottomBarWhenPushed = YES;
            [weakSelf.navigationController pushViewController:pageWebVC animated:YES];
            weakSelf.hidesBottomBarWhenPushed = NO;
        }
    }];
    headerView.btnClickBlock = ^(NSInteger tags) {
        if(tags == 0)
        {
            HYWebViewController *web = [[HYWebViewController alloc] init];
            //web.urlStr = @"http://plus.xiaojindai888.com/newdebt.php";
            web.urlStr = @"http://192.168.8.109:8080/banner1fu.jsp";
            web.hidesBottomBarWhenPushed = YES;
            web.title = @"注册福利";
            [weakSelf.navigationController pushViewController:web animated:YES];
        }else
        {
            HYWebViewController *web = [[HYWebViewController alloc] init];
            web.urlStr = @"http://plus.xiaojindai888.com/reginv.php";
            web.hidesBottomBarWhenPushed = YES;
            web.title = @"邀请有奖";
            [weakSelf.navigationController pushViewController:web animated:YES];
        }
    };
    
//    文字轮播点击
    [headerView setHomeTitleBlock:^(NSString *titleID){
        PageWebViewController *pageWebVC = [PageWebViewController new];
        pageWebVC.urlStr = [NSString stringWithFormat:@"%@v2/open/appAfficheDetail.jsp?id=%@",__API_HEADER__,titleID];
        pageWebVC.title = @"最新公告";
        weakSelf.hidesBottomBarWhenPushed = YES;
        [weakSelf.navigationController pushViewController:pageWebVC animated:YES];
        weakSelf.hidesBottomBarWhenPushed = NO;
    }];
    [self.homeTableView setTableHeaderView:headerView];
    self.headerView = headerView;
//    更多按钮的点击事件
    [headerView setHomeMachButtonBlock:^{
        AnnouncementViewController *vc = [[AnnouncementViewController alloc]init];
        vc.hidesBottomBarWhenPushed = YES;
        [weakSelf.navigationController pushViewController:vc animated:YES];
    }];
    
    /*********************************** 下面代码不需要 *********************************/
//    123下面的三个按钮的点击事件
    HomeFooterView *footerView = [[HomeFooterView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_WIDTH/375 *74)];
    [footerView setHomeFooterButtonBlock:^(NSInteger buttonTag){
        if (buttonTag == 100) {
            MoreWebViewController * moreWebVC = [MoreWebViewController new];
            moreWebVC.titleStr = @"新手指引";
            moreWebVC.webStr =@"v2/accept/new1";
            NSLog(@"%@",moreWebVC.webStr);
            self.navigationController.navigationBar.titleTextAttributes = @{UITextAttributeTextColor: [UIColor blackColor], UITextAttributeFont:[UIFont boldSystemFontOfSize:18]};
            [self.navigationController.navigationBar setBarTintColor:[UIColor whiteColor]];
            self.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:moreWebVC animated:YES];
            self.hidesBottomBarWhenPushed = NO;
        }
        else if (buttonTag == 101) {
            MoreWebViewController * moreWebVC = [MoreWebViewController new];
            moreWebVC.titleStr = @"公司背景";
            moreWebVC.webStr =@"v2/accept/new3";
            NSLog(@"%@",moreWebVC.webStr);
            self.navigationController.navigationBar.titleTextAttributes = @{UITextAttributeTextColor: [UIColor blackColor], UITextAttributeFont:[UIFont boldSystemFontOfSize:18]};
            [self.navigationController.navigationBar setBarTintColor:[UIColor whiteColor]];
            self.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:moreWebVC animated:YES];
            self.hidesBottomBarWhenPushed = NO;
        }
        else if (buttonTag == 102) {
            MoreWebViewController * moreWebVC = [MoreWebViewController new];
            moreWebVC.titleStr = @"安全保障";
            moreWebVC.webStr =@"v2/accept/new2";
            NSLog(@"%@",moreWebVC.webStr);
            self.navigationController.navigationBar.titleTextAttributes = @{UITextAttributeTextColor: [UIColor blackColor], UITextAttributeFont:[UIFont boldSystemFontOfSize:18]};
            [self.navigationController.navigationBar setBarTintColor:[UIColor whiteColor]];
            self.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:moreWebVC animated:YES];
            self.hidesBottomBarWhenPushed = NO;
         }
    }];
//    [self.homeTableView setTableFooterView:footerView];
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
//         static NSString *newInvest = @"newInvest";
//        newInvestNTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:
//                                 newInvest];
//        if (cell == nil) {
//            cell = [[newInvestNTableViewCell alloc]initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:newInvest];
//            cell.selectionStyle = UITableViewCellSelectionStyleNone;
//        }
//        cell.backgroundColor = [UIColor colorWithHexString:@"#f2f2f2"];
//        [cell backgroundNView];
//        [cell titleBackGroundView];
//        [cell investBtn];
//        cell.titleImage.image = [UIImage imageNamed:@"index_xinshou"];
//        cell.titleLab.text = @"预期年化";
//        cell.percentLab.text = [[NSString stringWithFormat:@"%@",self.rateStr] stringByAppendingString:@"%"];
//        cell.addPercentLab.text = [[NSString stringWithFormat:@"+%@",self.addRate] stringByAppendingString:@"%"];
//        
//        return cell;
        HYHomeOneCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HYHomeOneCell" forIndexPath:indexPath];
        cell.bfbStr = self.rateStr;
        cell.addBFBStr = self.addRate;
        __weak __typeof(self) weakSelf = self;
        cell.buyBlock = ^{
            [weakSelf xinshoubiao:indexPath];
        };
        return cell;
 //------------------------------
//        HomeNewExclusiveCell *cell = [tableView dequeueReusableCellWithIdentifier:HomeNewExclusiveCellID];
//        if (!cell) {
//            cell = [[[NSBundle mainBundle]loadNibNamed:HomeNewExclusiveCellID owner:self options:nil]lastObject];
//        }
//        cell.selectionStyle = UITableViewCellSelectionStyleNone;
//        cell.percentLabel.text = [[NSString stringWithFormat:@"%@",self.rateStr] stringByAppendingString:@"%"];
//        cell.addLab.text = [[NSString stringWithFormat:@"+%@",self.addRate] stringByAppendingString:@"%"];
//        return cell;
      
    }
    
//    static NSString *welfare = @"welfare";
//    welfareNTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:
//                                     welfare];
//    if (cell == nil) {
//        cell = [[welfareNTableViewCell alloc]initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:welfare];
//        cell.selectionStyle = UITableViewCellSelectionStyleNone;
//    }
//    cell.backgroundColor = [UIColor colorWithHexString:@"#f2f2f2"];
//    [cell backgroundNView];
//    [cell titleBackGroundView];
//    [cell layer];
//    cell.titleImage.image = [UIImage imageNamed:@"index_fulibiao"];
//    cell.titleLab.text = @"标题";
//
//    cell.percentLab.text = [[NSString stringWithFormat:@"%@",self.experienceDic[@"rate"] ? nil : @"0"] stringByAppendingString:@"%"];
//    cell.startInvestingLab.text = [[NSString stringWithFormat:@"%@",self.experienceDic[@"minbidamount"] ? nil : @"0"] stringByAppendingString:@"元"];
//    cell.cycleLab.text = [[NSString stringWithFormat:@"%@",self.experienceDic[@"loanperiod"] ? nil : @"0"] stringByAppendingString:@"天"];
//    [cell investBtn];
//
//
//    return cell;
    HYHomeTwoCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HYHomeTwoCell" forIndexPath:indexPath];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {//123点击新手标
        if (![AppDelegate checkLogin]) {
            [MBProgressHUD showMessag:@"未登录" toView:self.view];
            return;
        }
        [self xinshoubiao:indexPath];
    }
    else if (indexPath.section == 1) {//点击牛气分享标
//        if (![AppDelegate checkLogin]) {
//            //[MBProgressHUD showMessag:@"未登录" toView:self.view];
//            return;
//        }
//        WelfareViewController *vc = [WelfareViewController new];
//        self.hidesBottomBarWhenPushed = YES;
//        [self.navigationController pushViewController:vc animated:YES];
//        self.hidesBottomBarWhenPushed = NO;
    }
}

-(void)xinshoubiao:(NSIndexPath *)indexPath
{
    self.hidesBottomBarWhenPushed = YES;
    XProjectDetailsController * projectDetailsVC = [XProjectDetailsController new];
    projectDetailsVC.addrate = self.addRate;
    if (_recProductArr.count > 0) {
        SNProjectListItem * projectItem = _recProductArr[indexPath.section];
        projectDetailsVC.projectId = [projectItem.projectId intValue];
        projectDetailsVC.projectItem = projectItem;
        projectDetailsVC.resultsRate = [self.rateStr floatValue];
    }
    [self.navigationController pushViewController:projectDetailsVC animated:YES];
    self.hidesBottomBarWhenPushed = NO;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (section == 1) {
        UIView *sharingView = [[UIView alloc]init];
//        UIImageView *imageView = [[UIImageView alloc]init];
//        [sharingView addSubview:imageView];
//        [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.centerY.mas_equalTo(sharingView).mas_offset(0);
//            make.left.mas_equalTo(sharingView).mas_offset(15);
//        }];
//        [imageView setImage:[UIImage imageNamed:@"share_Money"]];
//
//
//
        UILabel *sharLabel = [[UILabel alloc]init];
        [sharingView addSubview:sharLabel];
        [sharLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.top.mas_equalTo(0);
                    make.left.mas_equalTo(0);
                    make.right.mas_equalTo(0);
                    make.bottom.mas_equalTo(0);
        }];
//        sharLabel.text = @"福利标";
//        sharLabel.textColor = [UIColor blackColor];
//        sharLabel.font = [UIFont systemFontOfSize:12];
        return sharingView;
    }
    return nil;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    if (section == 1) {
        //UIView *sharingView = [[UIView alloc]init];
//        UIImageView *imageView = [[UIImageView alloc]init];
//        [sharingView addSubview:imageView];
//        [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.centerY.mas_equalTo(sharingView).mas_offset(0);
//            make.left.mas_equalTo(sharingView).mas_offset(15);
//        }];
//        [imageView setImage:[UIImage imageNamed:@"platform"]];
        
//        UILabel *sharLabel = [[UILabel alloc]init];
//        [sharingView addSubview:sharLabel];
//        [sharLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.top.mas_equalTo(0);
//            make.left.mas_equalTo(0);
//            make.right.mas_equalTo(0);
//            make.bottom.mas_equalTo(0);
//        }];
//        sharLabel.text = @"账户资金由汇付天下保障";
//        sharLabel.textColor = [UIColor lightGrayColor];
//        sharLabel.textAlignment = NSTextAlignmentCenter;
//        sharLabel.font = [UIFont systemFontOfSize:12];
//        return sharingView;
    }
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return 172;
    }
    return 90;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 15;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    if (section == 1) {
        return 0.001;
    }
    return 0.00001;
}

- (UITableView *)homeTableView {
    if (!_homeTableView) {
        _homeTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, -20, SCREEN_WIDTH, SCREEN_HEIGHT - 49+20) style:UITableViewStyleGrouped];
        _homeTableView.delegate = self;
        _homeTableView.dataSource = self;
        _homeTableView.showsVerticalScrollIndicator = NO;
        _homeTableView.backgroundColor = [UIColor colorWithHexString:@"f2f2f2"];
        _homeTableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
        _homeTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        
        [_homeTableView registerNib:[UINib nibWithNibName:@"HYHomeOneCell" bundle:nil] forCellReuseIdentifier:@"HYHomeOneCell"];
        [_homeTableView registerNib:[UINib nibWithNibName:@"HYHomeTwoCell" bundle:nil] forCellReuseIdentifier:@"HYHomeTwoCell"];
    }
    return _homeTableView;
}

- (void)headerRefreshloadData {
    [_homeTableView.mj_header endRefreshing];
    [self loadDataHomeList];
}

- (void)footerRefreshloadData {
    [_homeTableView.mj_footer endRefreshing];
    [self loadDataHomeList];
}

- (void)shareAppVersionAlert {
    if(![self judgeNeedVersionUpdate]) return ;
    //App内info.plist文件里面版本号
    NSDictionary *infoDict = [[NSBundle mainBundle] infoDictionary];
    NSString *appVersion = infoDict[@"CFBundleShortVersionString"];
//    NSString *bundleId = infoDict[@"CFBundleIdentifier"];
    NSString *urlString = [NSString stringWithFormat:@"https://itunes.apple.com/cn/lookup?id=%@",@"1311305726"];
    //两种请求appStore最新版本app信息 通过bundleId与appleId判断1241612025
//    [NSString stringWithFormat:@"https://itunes.apple.com/cn/lookup?bundleid=%@", bundleId]
    //[NSString stringWithFormat:@"https://itunes.apple.com/cn/lookup?id=%@", appleid]
    NSURL *urlStr = [NSURL URLWithString:urlString];
    //创建请求体
    NSURLRequest *urlRequest = [NSURLRequest requestWithURL:urlStr];
    [NSURLConnection sendAsynchronousRequest:urlRequest queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse * _Nullable response, NSData * _Nullable data, NSError * _Nullable connectionError) {
        if (connectionError) {
            return ;
        }
        NSError *error;
        NSDictionary *resultsDict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
        if (error) {
            return;
        }
        NSArray *sourceArray = resultsDict[@"results"];
        
        if (sourceArray.count >= 1) {
            //AppStore内最新App的版本号
            NSDictionary *sourceDict = sourceArray[0];
            NSString *newVersion = sourceDict[@"version"];
            if ([self judgeNewVersion:newVersion withOldVersion:appVersion]){
                UIAlertController *alertVc = [UIAlertController alertControllerWithTitle:@"提示:\n本产品发布了最新版本，是否更新" message:@"" preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"以后更新" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                    //                    [alertVc dismissViewControllerAnimated:YES completion:nil];
                }];
                [alertVc addAction:action1];
                UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"立即更新" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
                    //跳转到AppStore，该App下载界面
                    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:sourceDict[@"trackViewUrl"]]];
                }];
                [alertVc addAction:action2];
                [[UIApplication sharedApplication].delegate.window.rootViewController presentViewController:alertVc animated:YES completion:nil];
            }
        }
    }];
}

//每天进行一次版本判断
- (BOOL)judgeNeedVersionUpdate {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    //获取年-月-日
    NSString *dateString = [formatter stringFromDate:[NSDate date]];
    NSString *currentDate = [[NSUserDefaults standardUserDefaults] objectForKey:@"currentDate"];
    if ([currentDate isEqualToString:dateString]) {
        return NO;
    }
    [[NSUserDefaults standardUserDefaults] setObject:dateString forKey:@"currentDate"];
    return YES;
}

//判断当前app版本和AppStore最新app版本大小
- (BOOL)judgeNewVersion:(NSString *)newVersion withOldVersion:(NSString *)oldVersion {
    NSArray *newArray = [newVersion componentsSeparatedByCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"."]];
    NSArray *oldArray = [oldVersion componentsSeparatedByCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"."]];
    for (NSInteger i = 0; i < newArray.count; i ++) {
        if ([newArray[i] integerValue] > [oldArray[i] integerValue]) {
            return YES;
        }
    }
    return NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
@end
