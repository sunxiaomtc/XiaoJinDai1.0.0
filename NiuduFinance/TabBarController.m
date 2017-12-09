//
//  TabBarController.m
//  PublicFundraising
//
//  Created by Apple on 15/10/9.
//  Copyright © 2015年 Niuduz. All rights reserved.
//

#import "activityNViewController.h"
#import "TabBarController.h"
#import "BaseNavigationController.h"
#import "HomeViewController.h"
#import "ProjectViewController.h"
#import "XProjectViewController.h"
#import "MyViewController.h"
#import "InvestViewController.h"
#import "AppDelegate.h"
#import "LoginViewController.h"
#import "AppDelegate.h"


@interface TabBarController ()

@end

@implementation TabBarController

//- (void)loadView
//{
//    [super loadView];
    //修改高度
//    CGFloat width = [[UIScreen mainScreen] bounds].size.width;
//    CGFloat height = [[UIScreen mainScreen] bounds].size.height;
//    CGFloat tabBarHeight = 49;
//    self.tabBar.frame = CGRectMake(0, height-tabBarHeight, width, tabBarHeight);
//    self.tabBar.clipsToBounds = YES;
//    UIView *transitionView = [[self.view subviews] objectAtIndex:0];
//    transitionView.height = height-tabBarHeight;
//}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // set base navigationBar
    [self setAppearanceNaviBar];
    
    [self setupViewControllers];
}

- (void)setAppearanceNaviBar
{
    [[UINavigationBar appearance] setBarTintColor:NaviColor];
    [[UINavigationBar appearance] setBarStyle:UIBarStyleBlackOpaque];
    [[UINavigationBar appearance] setTranslucent:NO];
    [[UINavigationBar appearance] setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:18.0f],NSForegroundColorAttributeName:[UIColor colorWithHexString:@"#2B2B2B"]}];

    self.tabBar.translucent = NO;
    self.tabBar.backgroundColor = [UIColor redColor];
    self.tabBar.barTintColor = [UIColor whiteColor];
    
}

- (void)setupViewControllers
{
    UIColor *textColor = UIcolors;
    UITabBarItem *item1 = [[UITabBarItem alloc] init];
    item1.tag = 1;
    [item1 setTitle:@"首页"];
    [item1 setImage:[UIImage imageNamed:@"home"]];
    [item1 setSelectedImage:[[UIImage imageNamed:@"home-Click"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    [item1 setTitleTextAttributes:@{NSForegroundColorAttributeName: textColor}
                         forState:UIControlStateSelected];
    
    UITabBarItem *item2 = [[UITabBarItem alloc] init];
    item2.tag = 2;
    [item2 setTitle:@"投资"];
    [item2 setImage:[UIImage imageNamed:@"tab-project"]];
    [item2 setSelectedImage:[[UIImage imageNamed:@"tab-project-Click"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    [item2 setTitleTextAttributes:@{NSForegroundColorAttributeName: textColor}
                         forState:UIControlStateSelected];
    
    UITabBarItem *item3 = [[UITabBarItem alloc] init];
    item3.tag = 3;
    [item3 setTitle:@"活动"];
    [item3 setImage:[UIImage imageNamed:@"tab-activity"]];
    [item3 setSelectedImage:[[UIImage imageNamed:@"tab-activity-Click"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    [item3 setTitleTextAttributes:@{NSForegroundColorAttributeName: textColor}
                         forState:UIControlStateSelected];
    
//    UITabBarItem *item3 = [[UITabBarItem alloc]init];
//    item3.tag = 3;
//    [item3 setTitle:@"活动"];
//    [item3 setSelectedImage:[UIImage imageNamed:@"tab-activity"]];
//    [item3 setSelectedImage:[[UIImage imageNamed:@"tab-activity-Click"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
//    [item3 setTitleTextAttributes:@{NSForegroundColorAttributeName: textColor}
//                         forState:UIControlStateSelected];
//
    UITabBarItem *item4 = [[UITabBarItem alloc] init];
    item4.tag = 4;
    [item4 setTitle:@"我的"];
    [item4 setImage:[UIImage imageNamed:@"tab-my"]];
    [item4 setSelectedImage:[[UIImage imageNamed:@"tab-my-Click"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    [item4 setTitleTextAttributes:@{NSForegroundColorAttributeName: textColor}
                         forState:UIControlStateSelected];
    

    
    
    HomeViewController *homeController = [[HomeViewController alloc] init];
    BaseNavigationController *homeNavController = [[BaseNavigationController alloc] initWithRootViewController:homeController];
    homeNavController.tabBarItem = item1;
    
//    ProjectViewController *projectController = [[ProjectViewController alloc] init];
//    BaseNavigationController *projectNavController = [[BaseNavigationController alloc] initWithRootViewController:projectController];
//    projectNavController.tabBarItem = item2;

    XProjectViewController *projectController = [[XProjectViewController alloc] init];
    BaseNavigationController *projectNavController = [[BaseNavigationController alloc] initWithRootViewController:projectController];
    projectNavController.tabBarItem = item2;
    
//    InvestViewController *investController = [[InvestViewController alloc] init];
//    BaseNavigationController *messageNavController = [[BaseNavigationController alloc] initWithRootViewController:investController];
//    messageNavController.tabBarItem = item3;
    
    activityNViewController *activityVC = [[activityNViewController alloc]init];
    BaseNavigationController *activityNav = [[BaseNavigationController alloc] initWithRootViewController:activityVC];
    activityNav.tabBarItem = item3;
    
    
    MyViewController *myController = [[MyViewController alloc] init];
    BaseNavigationController *myNavController = [[BaseNavigationController alloc] initWithRootViewController:myController];
    myNavController.tabBarItem = item4;
    
    
    self.viewControllers = [NSArray arrayWithObjects:homeNavController,projectNavController,activityNav,myNavController,nil];
    self.delegate = self;
    self.selectedIndex = 0;
}

- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController{
    return YES;
}

- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController{
    NSLog(@"dasasdsadasdasd");
    /*
     AppDelegate *app = (AppDelegate *)[UIApplication sharedApplication].delegate;
     NSString *isHaveRun = [[NSUserDefaults standardUserDefaults] objectForKey:KHaveLogin];
     if (!isHaveRun || [isHaveRun isEqualToString:@"NO"]) {
     if (app.window.rootViewController.presentingViewController == nil) {
     //  跳转登录
     LoginViewController*loginVC = [[LoginViewController alloc] init];
     BaseNavigationController *baseNav = [[BaseNavigationController alloc] initWithRootViewController:loginVC];
     //            [baseNav.navigationBar setBackgroundImage:[UIImage imageNamed:@""] forBarPosition:UIBarPositionAny barMetrics:UIBarMetricsDefault];
     //            [baseNav.navigationBar setShadowImage:[UIImage new]];
     baseNav.navigationBar.barTintColor = [UIColor whiteColor];//Nav019BFF;
     baseNav.navigationBar.barStyle = UIBarStyleDefault;//UIBarStyleBlackOpaque;
     baseNav.navigationBar.shadowImage = [AppDelegate qqimageWithColor:[UIColor clearColor] sizeq:CGSizeMake(SCREEN_WIDTH, 1)];
     
     [app.window.rootViewController presentViewController:baseNav animated:YES completion:^{
     }];
     }
     return NO;
     }else{
     return YES;
     }
     */
    if (tabBarController.selectedIndex == 3) {
        AppDelegate *app = (AppDelegate *)[UIApplication sharedApplication].delegate;
        NSString *isHaveRun = [[NSUserDefaults standardUserDefaults] objectForKey:KHaveLogin];
        if (!isHaveRun || [isHaveRun isEqualToString:@"NO"]) {
            if (app.window.rootViewController.presentingViewController == nil) {
                //  跳转登录
                LoginViewController*loginVC = [[LoginViewController alloc] init];
                BaseNavigationController *baseNav = [[BaseNavigationController alloc] initWithRootViewController:loginVC];
                loginVC.typeStr = @"tabbarpush";
                //            [baseNav.navigationBar setBackgroundImage:[UIImage imageNamed:@""] forBarPosition:UIBarPositionAny barMetrics:UIBarMetricsDefault];
                //            [baseNav.navigationBar setShadowImage:[UIImage new]];
                baseNav.navigationBar.barTintColor = [UIColor whiteColor];//Nav019BFF;
                baseNav.navigationBar.barStyle = UIBarStyleDefault;//UIBarStyleBlackOpaque;
                baseNav.navigationBar.shadowImage = [self qqimageWithColor:[UIColor clearColor] sizeq:CGSizeMake(SCREEN_WIDTH, 1)];
                
                [app.window.rootViewController presentViewController:baseNav animated:YES completion:^{
                }];
                return;
            }
        }else{
            
        }
    }
}
 
-(UIImage *)qqimageWithColor:(UIColor *)color sizeq:(CGSize)size
{
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
