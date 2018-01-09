//
//  AppDelegate.m
//  NiuduFinance
//
//  Created by liuyong on 16/2/24.
//  Copyright © 2016年 liuyong. All rights reserved.
//

#define isFirstRun           @"isFirstRun"

#import "AppDelegate.h"
#import <IQKeyboardManager.h>
#import "TabBarController.h"
#import "LoginViewController.h"
#import "BaseNavigationController.h"
#import "User.h"
#import "PCCircleViewConst.h"
#import "GestureViewController.h"
#import "WelcomeViewController.h"
#import "YinDaoViewController.h"
#import <UMMobClick/MobClick.h>
//友盟
#import <UMSocialCore/UMSocialCore.h>
@interface AppDelegate ()
{
    NSDate *date;
}
@property (nonatomic,strong) UIWebView *webView;
@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    
    [NSThread sleepForTimeInterval:3];
    
    _isLoginLock = NO;
    
//    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    //IQKeyboardManager
    
    [IQKeyboardManager sharedManager].shouldResignOnTouchOutside = YES;
    [IQKeyboardManager sharedManager].shouldToolbarUsesTextFieldTintColor = YES;
    [IQKeyboardManager sharedManager].enableAutoToolbar = NO;

//    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"引导页"];
//    NSString *str = [[NSUserDefaults standardUserDefaults] objectForKey:@"引导页"];
//    if (![str isEqualToString:@"1"]) {
//        YinDaoViewController *VC = [[YinDaoViewController alloc] init];
//        self.window.rootViewController = VC;
//    }else{
        NSString *isHaveRun = [[NSUserDefaults standardUserDefaults] objectForKey:KHaveLogin];
        if (isHaveRun&&[isHaveRun isEqualToString:@"YES"]) {//自动登录
            [self autoLogin];
       }else{
            //未登录状态
            TabBarController *tabbarController = [[TabBarController alloc] init];
            self.window.rootViewController = tabbarController;
        }
//    }
    
    //友盟
    /* 打开调试日志 */
    //    [[UMSocialManager defaultManager] openLog:YES];
    /* 设置友盟appkey */
    //    [[UMSocialManager defaultManager] setUmSocialAppkey:@"58f70be475ca356e0a00213a"];
    [MobClick setLogEnabled:YES];
    UMConfigInstance.appKey = @"5a0964678f4a9d2f2c000062";
    UMConfigInstance.channelId = @"App Store";//一般是这样写，用于友盟后台的渠道统计，当然苹果也不会有其他渠道，写死就好
    UMConfigInstance.ePolicy = SEND_INTERVAL; //上传模式，这种为最小间隔发送90S，也可按照要求选择其他上传模式。也可不设置，在友盟后台修改。
    [MobClick startWithConfigure:UMConfigInstance];//开启SDK
    NSString *version = [[[NSBundle mainBundle] infoDictionary]objectForKey:@"CFBundleShortVersionString"];
    [MobClick setAppVersion:version];
    [self configUSharePlatforms];
    
    /************************* 极光 ***************************/
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 10.0) {
#ifdef NSFoundationVersionNumber_iOS_9_x_Max
        JPUSHRegisterEntity * entity = [[JPUSHRegisterEntity alloc] init];
        entity.types = UNAuthorizationOptionAlert|UNAuthorizationOptionBadge|UNAuthorizationOptionSound;
        [JPUSHService registerForRemoteNotificationConfig:entity delegate:self];
#endif
    } else if ([[UIDevice currentDevice].systemVersion floatValue] >= 8.0) {
        //可以添加自定义categories
        [JPUSHService registerForRemoteNotificationTypes:(UIUserNotificationTypeBadge |
                                                          UIUserNotificationTypeSound |
                                                          UIUserNotificationTypeAlert)
                                              categories:nil];
    }
    
    [JPUSHService setupWithOption:launchOptions appKey:appKey
                          channel:@"APP Store"
                 apsForProduction:isProduction
            advertisingIdentifier:nil];
    
    [JPUSHService registrationIDCompletionHandler:^(int resCode, NSString *registrationID) {
        if(resCode == 0){
            NSLog(@"registrationID获取成功：%@",registrationID);
        }
        else{
            NSLog(@"registrationID获取失败，code：%d",resCode);
        }
    }];
    
    
    return YES;
}

//友盟
- (void)configUSharePlatforms
{
    //微信
//    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_WechatSession appKey:@"wxcc225603ac13a8f7" appSecret:@"bbf3649b596d904f97407fd6ed34258d" redirectURL:@"http://mobile.umeng.com/social"];
}
    
- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url
{
    BOOL result = [[UMSocialManager defaultManager] handleOpenURL:url];
    if (!result) {
        // 其他如支付等SDK的回调
    }
    return result;
}

//自动登录
- (void)autoLogin
{
    User *user = [User userFromFile];
    NSLog(@"======%@----%@====%ld",user.userName,user.password,(long)user.userId);
    
    if (user.password == nil || user.userName == nil) {
        [user saveExit];
        [user removeUser];
        [AppDelegate loginMain];
    }else{
        // 手势密码本地判断
        if ([[PCCircleViewConst getGestureWithKey:gestureFinalSaveKey] length]) {
            /*
             requestObj4MethodName:@"user/login" parameters:@{@"UserName":_accountTextField.text,@"Password"
             */
            NetWorkingUtil *util = [NetWorkingUtil netWorkingUtil];
            [util requestObj4MethodName:@"user/login" parameters:@{@"UserName":user.userName,@"Password":user.password} result:^(id obj, int status, NSString *msg) {
                
                if (status != 1) {
                    [user saveExit];
                    [user removeUser];
                    [MBProgressHUD showError:@"网络错误" toView:self.window];
                    [self performSelector:@selector(delayMethod) withObject:nil afterDelay:0.5f];
                }
            } convertClassName:nil key:nil];
            
            GestureViewController *gestureVc = [[GestureViewController alloc] init];
            [gestureVc setType:GestureViewControllerTypeLogin];
            self.window.rootViewController = gestureVc;
            
            
        }else{
            
//            UIViewController *vc = [UIViewController new];
//            self.window.rootViewController = vc;
            TabBarController *tabbarController = [[TabBarController alloc] init];
            self.window.rootViewController = tabbarController;
            
            NetWorkingUtil *util = [NetWorkingUtil netWorkingUtil];
            [util requestObj4MethodName:@"user/login" parameters:@{@"UserName":user.userName,@"Password":user.password} result:^(id obj, int status, NSString *msg) {
                if (status != 1) {
                    [user saveExit];
                    [user removeUser];
                    [self performSelector:@selector(delayMethod) withObject:nil afterDelay:0.5f];
                }else{
                    [AppDelegate loginMain];
                }
            } convertClassName:nil key:nil];
        }
    }
}

- (void)delayMethod
{
    [AppDelegate loginMain];
}
//检查登录 不做登录页面跳转  返回NO未登录    YES已登录
+ (BOOL)checkLoginNew
{
    NSString *isHaveRun = [[NSUserDefaults standardUserDefaults] objectForKey:KHaveLogin];
    if (!isHaveRun || [isHaveRun isEqualToString:@"NO"]) {
        return NO;
    }else{
        return YES;
    }
}
//检查登录 做登录页面跳转
+ (BOOL)checkLogin
{
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
}

+(UIImage *)qqimageWithColor:(UIColor *)color sizeq:(CGSize)size
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
//手势锁
+ (BOOL)checkLoginLock
{
    AppDelegate *app = (AppDelegate *)[UIApplication sharedApplication].delegate;
    NSString *isHaveRun = [[NSUserDefaults standardUserDefaults] objectForKey:KHaveLogin];
    if (!isHaveRun || [isHaveRun isEqualToString:@"NO"]) {
        if (app.window.rootViewController.presentingViewController == nil) {
            //  跳转首页
            [AppDelegate loginMain];
        }
        return NO;
    }else{
        
        return YES;
    }

}

+ (BOOL)loginMain
{
    AppDelegate *app = (AppDelegate *)[UIApplication sharedApplication].delegate;
    TabBarController *tabbarController = [[TabBarController alloc] init];
    tabbarController.selectedIndex = 0;
    app.window.rootViewController = tabbarController;
    app.isLoginLock = YES;
    return YES;
}

+(BOOL)backToMe{
    
    AppDelegate *app = (AppDelegate *)[UIApplication sharedApplication].delegate;
    TabBarController *tabbarController = [[TabBarController alloc] init];
    tabbarController.selectedIndex = 3;
    app.window.rootViewController = tabbarController;
    return YES;
}


+(BOOL)backToTouZi
{
    AppDelegate *app = (AppDelegate *)[UIApplication sharedApplication].delegate;
    TabBarController *tabbarController = [[TabBarController alloc] init];
    tabbarController.selectedIndex = 1;
    app.window.rootViewController = tabbarController;
    return YES;
}

+ (BOOL)checkTabbarLogin
{
    AppDelegate *app = (AppDelegate *)[UIApplication sharedApplication].delegate;
    NSString *isHaveRun = [[NSUserDefaults standardUserDefaults] objectForKey:KHaveLogin];
    if (!isHaveRun || [isHaveRun isEqualToString:@"NO"]) {
        if (app.window.rootViewController.presentingViewController == nil) {
            //  跳转登录
//            LoginViewController*loginVC = [[LoginViewController alloc] init];
//            loginVC.typeStr = @"tabbar";
//            BaseNavigationController *baseNav = [[BaseNavigationController alloc] initWithRootViewController:loginVC];
//            baseNav.navigationBar.barTintColor = Nav019BFF;
//            baseNav.navigationBar.barStyle = UIBarStyleBlackOpaque;
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
}

#pragma mark JSPush
- (void)application:(UIApplication *)application
didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    
    /// Required - 注册 DeviceToken
    [JPUSHService registerDeviceToken:deviceToken];
}

- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
    //Optional
    NSLog(@"did Fail To Register For Remote Notifications With Error: %@", error);
}

// iOS 10 Support
#ifdef NSFoundationVersionNumber_iOS_9_x_Max
- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(NSInteger))completionHandler {
    // Required
    NSDictionary * userInfo = notification.request.content.userInfo;
    if([notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        [JPUSHService handleRemoteNotification:userInfo];
        NSLog(@"iOS10 收到远程通知:%@", [self logDic:userInfo]);
    }
    completionHandler(UNNotificationPresentationOptionBadge|UNNotificationPresentationOptionSound|UNNotificationPresentationOptionAlert); // 需要执行这个方法，选择是否提醒用户，有Badge、Sound、Alert三种类型可以选择设置
}

// iOS 10 Support
- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void (^)())completionHandler {
    // Required
    NSDictionary * userInfo = response.notification.request.content.userInfo;
    if([response.notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        [JPUSHService handleRemoteNotification:userInfo];
        NSLog(@"iOS10 收到远程通知:%@", [self logDic:userInfo]);
    }
    completionHandler();  // 系统要求执行这个方法
}
#endif

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler {
    
    // Required, iOS 7 Support
    [JPUSHService handleRemoteNotification:userInfo];
    NSLog(@"iOS7及以上系统，收到通知:%@", [self logDic:userInfo]);
    completionHandler(UIBackgroundFetchResultNewData);
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
    
    // Required,For systems with less than or equal to iOS6
    [JPUSHService handleRemoteNotification:userInfo];
}

- (NSString *)logDic:(NSDictionary *)dic {
    if (![dic count]) {
        return nil;
    }
    NSString *tempStr1 =
    [[dic description] stringByReplacingOccurrencesOfString:@"\\u"
                                                 withString:@"\\U"];
    NSString *tempStr2 =
    [tempStr1 stringByReplacingOccurrencesOfString:@"\"" withString:@"\\\""];
    NSString *tempStr3 =
    [[@"\"" stringByAppendingString:tempStr2] stringByAppendingString:@"\""];
    NSData *tempData = [tempStr3 dataUsingEncoding:NSUTF8StringEncoding];
    NSString *str = [NSPropertyListSerialization propertyListWithData:tempData options:NSPropertyListImmutable format:NULL error:NULL];
    //    [NSPropertyListSerialization propertyListFromData:tempData
    //                                     mutabilityOption:NSPropertyListImmutable
    //                                               format:NULL
    //                                     errorDescription:NULL];
    
    return str;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    
    

    date = [NSDate date];
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    [[UIApplication sharedApplication] setApplicationIconBadgeNumber:0];
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    
    [application setApplicationIconBadgeNumber:0];
    [application cancelAllLocalNotifications];
    NSTimeInterval secondsInterval= [[NSDate date] timeIntervalSinceDate:date];
    
    if (secondsInterval >= 180) {
        if ([[PCCircleViewConst getGestureWithKey:gestureFinalSaveKey] length] && _isLoginLock == YES){
            if ([AppDelegate checkLoginLock]) {
                AppDelegate *app = (AppDelegate *)[UIApplication sharedApplication].delegate;
                GestureViewController *gestureVc = [[GestureViewController alloc] init];
                [gestureVc setType:GestureViewControllerTypeLock];
                BaseNavigationController *baseNav = [[BaseNavigationController alloc] initWithRootViewController:gestureVc];
                baseNav.navigationBar.barTintColor = Nav019BFF;
                baseNav.navigationBar.barStyle = UIBarStyleBlackOpaque;
                [app.window.rootViewController presentViewController:baseNav animated:YES completion:^{
                    
                }];
            }
        }
    }
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
