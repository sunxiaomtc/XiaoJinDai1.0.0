//
//  CWNumberKeyboard.h
//  CWNumberKeyboardDemo
//
//  Created by william on 16/3/19.
//  Copyright © 2016年 陈大威. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CWNumberKeyboard : UIView
typedef void(^numberKeyboardBlock)(NSString *priceString);
- (void)showNumKeyboardViewAnimateWithPrice:(NSString *)priceString andBlock:(numberKeyboardBlock)block;

@end
