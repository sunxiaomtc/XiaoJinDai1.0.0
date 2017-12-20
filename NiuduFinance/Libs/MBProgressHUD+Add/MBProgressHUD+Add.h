//
//  MBProgressHUD+Add.h
//  视频客户端
//
//  Created by mj on 13-4-18.
//  Copyright (c) 2013年 itcast. All rights reserved.
//

#import "MBProgressHUD.h"

@interface MBProgressHUD (Add)
+ (void)showError:(NSString *)error toView:(UIView *)view;
+ (void)show:(NSString *)text andShowLabel:(NSString *)showLabel icon:(NSString *)icon view:(UIView *)view;
+ (void)showSuccess:(NSString *)success toView:(UIView *)view;

+ (void)showMessag:(NSString *)message toView:(UIView *)view;

+ (MB_INSTANCETYPE)showStatus:(NSString *)status toView:(UIView *)view;

+ (instancetype)mb_ProgressHUDStatusToView:(UIView*)view statusString:(NSString*)statusString;

+ (void)showMessag:(NSString *)message toView:(UIView *)view;

+ (BOOL)dismissHUDForView:(UIView *)view;

+ (BOOL)dismissHUDForView:(UIView *)view withError:(NSString *)error;

+ (BOOL)dismissHUDForView:(UIView *)view withsuccess:(NSString *)success;

+(void)showMessageForWindow:(NSString *)text;

- (void)dismissSuccessStatusString:(NSString *)statusString hideAfterDelay:(NSTimeInterval)delay;

- (void)dismissErrorStatusString:(NSString*)statusString hideAfterDelay:(NSTimeInterval)delay;

- (void)dismissMsgStatusString:(NSString *)statusString hideAfterDelay:(NSTimeInterval)delay;

@end
