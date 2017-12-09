//
//  NewsPopView.h
//  NiuduFinance
//
//  Created by 邢天阔 on 2017/9/28.
//  Copyright © 2017年 liuyong. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^NewsPopButtonTag)(NSInteger buttonTag);//订单明细ID

@interface NewsPopView : UIView

@property (nonatomic, copy) NewsPopButtonTag newsPopButtonTag;

+ (NewsPopView *)buttonTag:(NewsPopButtonTag)buttonTag;

- (void)closeAction;
@end
