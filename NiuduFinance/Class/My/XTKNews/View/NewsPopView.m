//
//  NewsPopView.m
//  NiuduFinance
//
//  Created by 邢天阔 on 2017/9/28.
//  Copyright © 2017年 liuyong. All rights reserved.
//

#import "NewsPopView.h"

@interface NewsPopView ()

/**按钮的文字数组*/
@property (nonatomic, copy) NSArray *selectItems;
@property (nonatomic, strong) UIView *alertView;//弹框视图

@end

@implementation NewsPopView

- (NSArray *)selectItems {
    if (!_selectItems) {
        _selectItems = @[@"全部",@"系统消息",@"用户消息"];
    }
    return _selectItems;
}
- (UIView *)alertView {// 弹出窗
    if (!_alertView) {
        _alertView = [[UIView alloc] init];
        _alertView.backgroundColor = [UIColor whiteColor];
        _alertView.layer.cornerRadius = 0;
        _alertView.layer.masksToBounds = YES;
    }
    return _alertView;
}


+ (NewsPopView *)buttonTag:(NewsPopButtonTag)buttonTag {
    NewsPopView *popView = [[NewsPopView alloc]initWithButtonTag:buttonTag];
    return popView;
}

- (instancetype)initWithButtonTag:(NewsPopButtonTag)buttonTag {
    if (self = [super init]) {
        self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:.4];
        self.newsPopButtonTag = [buttonTag copy];
        [self addSubview:self.alertView];//弹窗窗
        
        [self createUIView];
        [self showAlertView];
    }
    return self;
}
#pragma mark - 显示弹窗
- (void)showAlertView {
    self.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
    [[UIApplication sharedApplication].keyWindow addSubview:self];
    self.alertView.alpha = 0;
    [UIView animateWithDuration:0.1 animations:^{
        self.alertView.alpha = 1;
    }];
}
#pragma mark - 创建UI
- (void)createUIView {
    self.alertView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_WIDTH/375 * 74);
    
    CGFloat Button_Width = (SCREEN_WIDTH/self.selectItems.count) - SCREEN_WIDTH/375*20;
    CGFloat Start_X = SCREEN_WIDTH/375 *15;
    CGFloat Width_Space = SCREEN_WIDTH/375*15;
    
    for (int i = 0; i < self.selectItems.count; i++) {
        NSInteger index = i % 3;
        UIButton *platformButton = [[UIButton alloc]initWithFrame:CGRectMake(index * (Button_Width + Width_Space) + Start_X, (SCREEN_WIDTH/375 *74 - SCREEN_WIDTH/375*40)/2, Button_Width, SCREEN_WIDTH/375*40)];
        [platformButton setTitle:self.selectItems[i] forState:UIControlStateNormal];
        [platformButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        platformButton.titleLabel.font = [UIFont systemFontOfSize:13];
        platformButton.tag = i + 100;
        platformButton.layer.cornerRadius = 2.0f;
        platformButton.layer.borderColor = [UIColor blackColor].CGColor;
        platformButton.layer.borderWidth = 0.5f;
        [platformButton addTarget:self action:@selector(platformButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.alertView addSubview:platformButton];
    }
}

- (void)platformButtonClick:(UIButton *)sender {
    if (_newsPopButtonTag) {
        _newsPopButtonTag(sender.tag);
    }
    [self closeAction];
}
#pragma mark - 弹窗消失
- (void)closeAction {
    [UIView animateWithDuration:0.3 animations:^{
        self.alpha = 0;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    CGPoint pt = [touch locationInView:self];
    if (!CGRectContainsPoint([self.alertView frame], pt)) {
        [self closeAction];
    }
    if (_newsPopButtonTag) {
        _newsPopButtonTag(@105);
    }
}
@end
