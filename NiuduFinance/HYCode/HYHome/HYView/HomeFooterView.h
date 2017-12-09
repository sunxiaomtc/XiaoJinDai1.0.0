//
//  HomeFooterView.h
//  NiuduFinance
//
//  Created by 邢天阔 on 2017/9/28.
//  Copyright © 2017年 liuyong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HomeFooterView : UIView

@property (nonatomic, copy) void (^homeFooterButtonBlock)(NSInteger buttonTag);
@end
