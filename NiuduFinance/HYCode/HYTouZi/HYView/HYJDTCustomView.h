//
//  HYJDTCustomView.h
//  NiuduFinance
//
//  Created by Apple on 2017/12/28.
//  Copyright © 2017年 liuyong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UICountingLabel.h"

@interface HYJDTCustomView : UIView

@property (nonatomic, weak) UILabel *bgLabel;

@property (nonatomic, weak) UILabel *showLabel;

@property (nonatomic, weak) UICountingLabel *numLabel;

@property (nonatomic, weak) UILabel *pointLabel;

@property (nonatomic, strong) NSString *bfbStr;

@end
