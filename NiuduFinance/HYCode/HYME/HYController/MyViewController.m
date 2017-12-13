//
//  MyViewController.m
//  NiuduFinance
//
//  Created by liuyong on 16/2/24.
//  Copyright © 2016年 liuyong. All rights reserved.
//

#import "MyViewController.h"
#import "MyNewHeaderView.h"
#import "MyCollectionViewCell1.h"
#import "MyCollectionViewCell2.h"
#import "MyCollectionViewCell3.h"
#import "XHChatQQ.h"
#import "WebPageVC.h"
#import "BankNewTopUpViewController.h"
#import "MyAccountController.h"
#import "MoreWebViewController.h"
#import "MyDispeController.h"
#import "RequestService.h"
#import "MyNewModel.h"
#import "NewsViewController.h"
#import "FundAccountViewController.h"
#import "IntegralViewController.h"
#import "MyFuLiViewController.h"
#import "InvitationFriendsController.h"
#import "UIScrollView+Refresh.h"
#import "MJExtension.h"
#import "CCPScrollView.h"
#import "PageWebViewController.h"
#import "MyWelfareController.h"
#import "MyTouZiViewController.h"
#import "AppDelegate.h"
#import "LoginViewController.h"
#import "HYWebViewController.h"

@interface MyViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,MyCollectionViewCell3Delegate,MyNewHeaderViewDelegate,UIAlertViewDelegate>

@property(nonatomic, strong)UICollectionView *collectionView;
@property(nonatomic, strong)MyNewHeaderView *headerView;
@property(nonatomic, strong)MyNewModel *myNewModel;
@property(nonatomic, strong)CCPScrollView *ccpView;
@property(nonatomic, strong)NSMutableArray *titleArray;
@property(nonatomic, strong)NSMutableArray *idArray;

@end

@implementation MyViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    [self.collectionView reloadData];
    //    if (![AppDelegate checkLoginNew]) {
    //    }else{
    //        [self getOpen];
    //    }
    [self.collectionView MJ_addPullToRefreshWithHandler:^{
        [self loadDataNewsList];
    }];
    [self.collectionView MJ_beginTriggerPullToRefresh];
}


- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    self.navigationController.navigationBar.shadowImage = [self qqimageWithColor:[UIColor colorWithHexString:@"cccccc"] sizeq:CGSizeMake(SCREEN_WIDTH, 0.5)];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self createCollectionView];
}

-(void)createCollectionView
{
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.minimumLineSpacing = 1;
    flowLayout.minimumInteritemSpacing = 1;
    flowLayout.sectionInset = UIEdgeInsetsMake(10, 0, 0, 0);
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, -20, SCREEN_WIDTH, SCREEN_HEIGHT-46+20) collectionViewLayout:flowLayout];
    [self.view addSubview:self.collectionView];
    self.collectionView.backgroundColor = [UIColor colorWithHexString:@"#f2f2f2"];
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    self.collectionView.contentInset = UIEdgeInsetsMake(250, 0, 0, 0);
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
    [self.collectionView registerClass:[MyCollectionViewCell1 class] forCellWithReuseIdentifier:@"cell1"];
    [self.collectionView registerClass:[MyCollectionViewCell2 class] forCellWithReuseIdentifier:@"cell2"];
    [self.collectionView registerClass:[MyCollectionViewCell3 class] forCellWithReuseIdentifier:@"cell3"];
    
    /**  头部页面设置 */
    self.headerView = [[MyNewHeaderView alloc] initWithFrame:CGRectMake(0, -250, SCREEN_WIDTH, 250)];
    self.headerView.myNewHeaderViewDelegate = self;
    [self.collectionView addSubview:self.headerView];
    self.headerView.backgroundColor = [UIColor whiteColor];
    
}

- (void)loadDataNewsList
{
    NetWorkingUtil *util = [NetWorkingUtil netWorkingUtil];
    __weak __typeof(self) weakSelf = self;
    [util requestDic4MethodNam:@"v2/accept/user/getAssetMultipleInfo" parameters:nil result:^(NSDictionary *dic, int status, NSString *msg) {
        NSLog(@"_____%@",dic);
        
        if (status == 0) {
            [MBProgressHUD showMessag:msg toView:self.view];
            [self.collectionView MJ_endPullToRefresh];
//            LoginViewController *login = [LoginViewController new];
//            [weakSelf presentViewController:login animated:YES completion:nil];
        }else{
            
            self.myNewModel = [MyNewModel mj_objectWithKeyValues:dic];
            
            self.headerView.model = self.myNewModel;
            
            [self.collectionView MJ_endPullToRefresh];
        }
    }];

    self.idArray = [NSMutableArray array];
    self.titleArray = [NSMutableArray array];
    NSString *titleUrl = [__API_HEADER__ stringByAppendingString:@"v2/open/affiche/findAll"];
    NSDictionary *dic = @{
                          @"start":@(0),
                          @"limit":@(1)
                          };
    [NSObject POST:titleUrl parameters:dic progress:^(NSProgress *downloadProgress) {
        
    } completionHandler:^(id responseObject, NSError *error) {
        if (error) {
            [self.collectionView MJ_endPullToRefresh];
        }else {
            NSArray *array = responseObject[@"data"];
            for (NSDictionary *dic in array) {
                
                [self.titleArray addObject:dic[@"title"]];
                [self.idArray addObject:dic[@"newsinformationid"]];
            }
            [self.collectionView reloadData];
            [self.collectionView MJ_endPullToRefresh];
        }
    }];
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 3;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (section == 0) {
        return 1;
    }
    if (section == 1) {
        return 4;
    }
//    if (section == 2) {
//        return 2;
//    }
//    if (section == 3) {
//        return 2;
//    }
    if (section == 2) {
        return 1;
    }
    return 0;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        
        UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
        cell.backgroundColor = [UIColor whiteColor];
        
            UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bugle"]];
            [cell addSubview:imageView];
            [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(15);
                make.centerY.mas_equalTo(0);
            }];
        
            [cell addSubview:self.ccpView];
        if (self.titleArray.count >= 1) {
            self.ccpView.titleArray = self.titleArray;
        }
            [self.ccpView clickTitleLabel:^(NSInteger index,NSString *titleString) {
                PageWebViewController *pageWebVC = [PageWebViewController new];
                pageWebVC.urlStr = [NSString stringWithFormat:@"%@v2/open/appAfficheDetail.jsp?id=%@",__API_HEADER__,self.idArray[index]];
                pageWebVC.title = @"最新公告";
                self.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:pageWebVC animated:YES];
                self.hidesBottomBarWhenPushed = NO;
            }];
        
        return cell;
    }
    if (indexPath.section == 1) {
        MyCollectionViewCell1 *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell1" forIndexPath:indexPath];
        cell.indexPath = indexPath;
        return cell;
    }
//    if (indexPath.section == 2) {
//        MyCollectionViewCell2 *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell2" forIndexPath:indexPath];
//        cell.indexPath = indexPath;
//        return cell;
//    }
//    if (indexPath.section == 3) {
//        MyCollectionViewCell2 *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell2" forIndexPath:indexPath];
//        cell.indexPath = indexPath;
//        return cell;
//    }
    if (indexPath.section == 2) {
        MyCollectionViewCell3 *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell3" forIndexPath:indexPath];
        cell.myCollectionViewCell3Delegate = self;
        return cell;
    }
    
    return nil;
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return CGSizeMake(SCREEN_WIDTH, 43);
    }
    if (indexPath.section == 1) {
        return CGSizeMake((SCREEN_WIDTH-1)/2, 70);
    }
//    if (indexPath.section == 2) {
//        return CGSizeMake(SCREEN_WIDTH, 43);
//    }
//    if (indexPath.section == 3) {
//        return CGSizeMake(SCREEN_WIDTH, 43);
//    }
    if (indexPath.section == 2) {
        return CGSizeMake(SCREEN_WIDTH, 200+30);
    }
    return CGSizeZero;
}

-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    if (section == 0) {
        return UIEdgeInsetsMake(9, 0, 0, 0);
    }
    if (section == 1) {
        return UIEdgeInsetsMake(8, 0, 0, 0);
    }
//    if (section == 2) {
//        return UIEdgeInsetsMake(8, 0, 0, 0);
//    }
//    if (section == 3) {
//        return UIEdgeInsetsMake(8, 0, 0, 0);
//    }
    if (section == 2) {
        return UIEdgeInsetsMake(8, 0, 0, 0);
    }
    return UIEdgeInsetsZero;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"========cell");
    if (indexPath.section == 0) {
        
    }
    if (indexPath.section == 1) {
        if (indexPath.row == 0) {//投资记录
            MyTouZiViewController *VC = [[MyTouZiViewController alloc] init];
            VC.hidesBottomBarWhenPushed =YES;
            [self.navigationController pushViewController:VC animated:YES];
        }
        if (indexPath.row == 1) {//资金明细
            FundAccountViewController *fundAccountVC = [FundAccountViewController new];
            fundAccountVC.hidesBottomBarWhenPushed =YES;
            [self.navigationController pushViewController:fundAccountVC animated:YES]; 
        }
        if (indexPath.row == 2) {//优惠券
            MyFuLiViewController *hongBaoVC = [MyFuLiViewController new];
            hongBaoVC.hidesBottomBarWhenPushed =YES;
            [self.navigationController pushViewController:hongBaoVC animated:YES];
//            HYWebViewController *web = [[HYWebViewController alloc] init];
//            web.urlStr = @"http://plus.xiaojindai888.com/mapi/index.php?act=myecv";
//            web.hidesBottomBarWhenPushed = YES;
//            web.title = @"优惠券";
//            [self.navigationController pushViewController:web animated:YES];
        }
        if (indexPath.row == 3) {//福利金
            MyWelfareController *welfareVC = [MyWelfareController new];
            welfareVC.hidesBottomBarWhenPushed =YES;
            [self.navigationController pushViewController:welfareVC animated:YES];
        }
    }
//    if (indexPath.section == 2) {
//        if (indexPath.row == 0) {//投资记录
//            FundAccountViewController *fundAccountVC = [FundAccountViewController new];
//            [self.navigationController pushViewController:fundAccountVC animated:YES];
//            
//        }
//        if (indexPath.row == 1) {//资金明细
//            
//        }
//    }
//    if (indexPath.section == 3) {
//        if (indexPath.row == 0) {//邀请中心
//            InvitationFriendsController * invitationVC = [InvitationFriendsController new];
//            [self.navigationController pushViewController:invitationVC animated:YES];
//        }
//        if (indexPath.row == 1) {//客服管家
//            
//        }
//    }
}

#pragma mark -- qq  拨打电话
-(void)myCollectionViewCell3pCilckType:(NSString *)cilckType
{
    if ([cilckType isEqualToString:@"qq"]) {
        if([XHChatQQ haveQQ])//是否有安装QQ客户端
        {
            //2.此处传入的QQ号,需开通QQ推广功能,不然"陌生人"无法向此QQ号发送临时消,(发送时会直接失败).
            //开通QQ推广方法:1.打开QQ推广网址http://shang.qq.com并用QQ登录  2.点击顶部导航栏:推广工具  3.在弹出菜单中点击'立即免费开通' 即可
            
            //        [XHChatQQ chatWithQQ:@"2035689023"];//发起QQ临时会话
            int rNumber = rand() % 2;
            
            switch (rNumber) {
                case 0:
                    [XHChatQQ chatWithQQ:@"2852365842"];//发起QQ临时会话
                    break;
                case 1:
                    [XHChatQQ chatWithQQ:@"2852365842"];//发起QQ临时会话
                    break;
                default:
                    break;
            }
            
        }
        else
        {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"您的设备尚未安装QQ客户端,不能进行QQ临时会话" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alert show];
        }
    }
        if ([cilckType isEqualToString:@"电话"]) {
            //提示框
            UIAlertController *alertC = [UIAlertController alertControllerWithTitle:@"拨打电话" message: @"4006790008" preferredStyle:UIAlertControllerStyleAlert];
            
            //创建提示框按钮
            UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction*action) {
                
                //系统打电话
                NSString *num = [[NSString alloc]initWithFormat:@"tel:%ld",4006790008];
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:num]]; //拨号
                
            }];
            
            //将按钮放在提示框上
            [alertC addAction:action];
            
            UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction*action) {
                
                NSLog(@"点击的是取消按钮");
            }];
            [alertC addAction:action1];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                [self presentViewController:alertC animated:YES completion:^{
                    
                }];
            });
            
        }
}

-(void)myNewHeaderViewButtonAction:(NSInteger)index
{
    if (index == 1) {//头像
        //    AccountSafeController *vc = [[AccountSafeController alloc] init];
        //    vc.hidesBottomBarWhenPushed = YES;
        //    [self.navigationController pushViewController:vc animated:YES];
        
            MyAccountController *vc = [[MyAccountController alloc] init];
            vc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:vc animated:YES];
        //    vc.hidesBottomBarWhenPushed = NO;
    }
    if (index == 2) {//消息

        NewsViewController *vc = [[NewsViewController alloc]init];
        self.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
        self.hidesBottomBarWhenPushed = NO;
    }
    if (index == 3) {//充值
        [self getOpenWithType:0];
    }
    if (index == 4) {//提现
        [self getOpenWithType:1];
    }
}

- (CCPScrollView *)ccpView
{
    if (!_ccpView) {
        _ccpView = [[CCPScrollView alloc]initWithFrame:CGRectMake(30+15, 0, SCREEN_WIDTH-30, 43)];
        _ccpView.titleFont = 12;
        _ccpView.titleColor = [UIColor blackColor];
    }
    return _ccpView;
}

- (void)getOpenWithType:(BOOL)type{
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    NetWorkingUtil *util = [NetWorkingUtil netWorkingUtil];
    __weak __typeof(self) weakSelf = self;
    [util requestDic4MethodNam:@"v2/accept/user/openHuifuStatus" parameters:nil result:^(NSDictionary *dic, int status, NSString *msg) {
        [MBProgressHUD hideHUDForView:weakSelf.view animated:YES];
        if (status != 0) {
            NSLog(@"%@",dic);
            Boolean open = [[dic objectForKey:@"status"] boolValue];
            NSLog(@"%hhu",open);
            if (!open) {
                //安全退出
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"请先开通汇付" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"马上开通", nil];
                [alert show];
            }else {
                if (type == 0) {
                    [self.httpUtil requestDic4MethodNam:@"v2/accept/user/findExpressBankCard" parameters:nil result:^(id dic, int status, NSString *msg) {
                        
                        if (status == 0) {
                            WebPageVC *vc = [[WebPageVC alloc] init];
                            vc.title = @"充值";
                            vc.name = @"recharge";
                            self.navigationController.navigationBar.titleTextAttributes = @{UITextAttributeTextColor: [UIColor blackColor], UITextAttributeFont:[UIFont boldSystemFontOfSize:18]};
                            [self.navigationController.navigationBar setBarTintColor:[UIColor whiteColor]];
                            [self.navigationController pushViewController:vc animated:YES];
                        }else {
                            BankNewTopUpViewController * bankVC = [BankNewTopUpViewController new];
                            [self.navigationController pushViewController:bankVC animated:YES];
                        }
                    }];
                }else {
                    MoreWebViewController * moreWebVC = [MoreWebViewController new];
                    moreWebVC.titleStr = @"提现";
                    moreWebVC.webStr =@"v2/accept/account/appcash.jsp";
                    NSLog(@"%@",moreWebVC.webStr);
                    [self.navigationController pushViewController:moreWebVC animated:YES];
                    //  withdrawalViewController * VC = [withdrawalViewController new];
                    //  [self.navigationController pushViewController:VC animated:YES];
                }
            }
        }
    }];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 1) {
        WebPageVC *vc = [[WebPageVC alloc] init];
        vc.title = @"开通汇付账户";
        vc.name = @"huifu/openaccount";
        [self.navigationController pushViewController:vc animated:YES];
    }else {
        //安全退出改成取消
        //        NetWorkingUtil *util = [NetWorkingUtil netWorkingUtil];
        //        [util requestDic4MethodNam:@"v2/open/user/appExit" parameters:nil result:^(NSDictionary *dic, int status, NSString *msg) {
        //
        //            if (status == 0) {
        //                [MBProgressHUD showMessag:msg toView:self.view];
        //            }else{
        //
        //            }
        //            [[User shareUser] saveExit];
        //            [[User shareUser] removeUser];
        //            [User shareUser].userId = 0;
        ////            LoginViewController*loginVC = [[LoginViewController alloc] init];
        ////            loginVC.typeStr = @"exit";
        ////            [self presentViewController:loginVC animated:YES completion:^{
        ////
        ////            }];
        ////            [self.navigationController pushViewController:loginVC animated:YES];
        //
        //
        //            //  跳转登录
        //            AppDelegate *app = (AppDelegate *)[UIApplication sharedApplication].delegate;
        //            LoginViewController *loginVC = [[LoginViewController alloc] init];
        //            loginVC.typeStr = @"tabbar";
        //            BaseNavigationController *baseNav = [[BaseNavigationController alloc] initWithRootViewController:loginVC];
        //            //            [baseNav.navigationBar setBackgroundImage:[UIImage imageNamed:@""] forBarPosition:UIBarPositionAny barMetrics:UIBarMetricsDefault];
        //            //            [baseNav.navigationBar setShadowImage:[UIImage new]];
        //            baseNav.navigationBar.barTintColor = [UIColor whiteColor];//Nav019BFF;
        //            baseNav.navigationBar.barStyle = UIBarStyleDefault;//UIBarStyleBlackOpaque;
        //            baseNav.navigationBar.shadowImage = [self qqimageWithColor:[UIColor clearColor] sizeq:CGSizeMake(SCREEN_WIDTH, 1)];
        //            [app.window.rootViewController presentViewController:baseNav animated:YES completion:^{
        //            }];
        //            
        //        }];
    }
}

-(UIImage *)qqimageWithColor:(UIColor *)color sizeq:(CGSize)size {
    CGRect rect = CGRectMake(0, 0, size.width, size.height);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

@end
