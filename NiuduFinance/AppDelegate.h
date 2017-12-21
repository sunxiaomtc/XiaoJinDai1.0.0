//
//  AppDelegate.h
//  NiuduFinance
//
//  Created by liuyong on 16/2/24.
//  Copyright © 2016年 liuyong. All rights reserved.
//

#import <UIKit/UIKit.h>
// 引入JPush功能所需头文件
#import "JPUSHService.h"
// iOS10注册APNs所需头文件
#ifdef NSFoundationVersionNumber_iOS_9_x_Max
#import <UserNotifications/UserNotifications.h>
#endif
static NSString *appKey = @"2879ac4f902b03bb428ead0b";
static NSString *channel = @"APP Store";
static BOOL isProduction = true;

@interface AppDelegate : UIResponder <UIApplicationDelegate,JPUSHRegisterDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (nonatomic,assign)BOOL isLoginLock;

//调用登录
+ (BOOL)loginMain;

//检验是否登录
+ (BOOL)checkLogin;

//检查登录   不弹出登录页面
+ (BOOL)checkLoginNew;

// 检验锁屏后是否登录
+ (BOOL)checkLoginLock;

+ (BOOL)checkTabbarLogin;

+(BOOL)backToMe;

+(BOOL)backToTouZi;


@end

