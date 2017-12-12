//
//  WKDelegateController.h
//  NiuduFinance
//
//  Created by Apple on 2017/12/11.
//  Copyright © 2017年 liuyong. All rights reserved.
//

#import <UIKit/UIKit.h>

#import <WebKit/WebKit.h>
@protocol WKDelegate <NSObject>

- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message;

@end

@interface WKDelegateController : UIViewController<WKScriptMessageHandler>

@property (weak , nonatomic) id<WKDelegate> delegate;

@end
