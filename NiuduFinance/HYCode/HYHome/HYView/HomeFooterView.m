//
//  HomeFooterView.m
//  NiuduFinance
//
//  Created by 邢天阔 on 2017/9/28.
//  Copyright © 2017年 liuyong. All rights reserved.
//

#import "HomeFooterView.h"

@interface HomeFooterView ()

@property (nonatomic, copy) NSArray *platformImageArray;
@end

@implementation HomeFooterView

- (NSArray *)platformImageArray {
    if (!_platformImageArray) {
        _platformImageArray = @[@"图层-26",@"图层-27",@"图层-28"];
    }
    return _platformImageArray;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor redColor];
        [self createFooterView];
    }
    return self;
}

- (void)createFooterView {
    UIView *footerView = [[UIView alloc]init];
    [self addSubview:footerView];
    [footerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH, SCREEN_WIDTH/375 *74));
        make.bottom.top.mas_equalTo(self).mas_offset(0);
    }];
    footerView.backgroundColor = [UIColor whiteColor];
    
    CGFloat Button_Width = (SCREEN_WIDTH/self.platformImageArray.count) - SCREEN_WIDTH/375*20;
    CGFloat Start_X = SCREEN_WIDTH/375 *15;
    CGFloat Width_Space = SCREEN_WIDTH/375*15;
    
    for (int i = 0; i < self.platformImageArray.count; i++) {
        NSInteger index = i % 3;
        UIButton *platformButton = [[UIButton alloc]initWithFrame:CGRectMake(index * (Button_Width + Width_Space) + Start_X, (SCREEN_WIDTH/375 *74 - SCREEN_WIDTH/375*40)/2, Button_Width, SCREEN_WIDTH/375*40)];
        [platformButton setImage:[UIImage imageNamed:self.platformImageArray[i]] forState:UIControlStateNormal];
        platformButton.tag = i + 100;
        [platformButton addTarget:self action:@selector(platformButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [footerView addSubview:platformButton];
    }
}

#pragma mark - 按钮的点击事件
- (void)platformButtonClick:(UIButton *)sender {
    if (_homeFooterButtonBlock) {
        _homeFooterButtonBlock(sender.tag);
    }
}

@end
