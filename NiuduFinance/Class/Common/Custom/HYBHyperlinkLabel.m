//
//  HYBHyperlinkLabel.m
//  NiuduFinance
//
//  Created by andrewliu on 16/9/18.
//  Copyright © 2016年 liuyong. All rights reserved.
//

#import "HYBHyperlinkLabel.h"

#define kFontWithSize(size) [UIFont systemFontOfSize:size]
@interface HYBHyperlinkLabel ()

@property (nonatomic, strong) UILabel *textLabel;      // 文本内容
@property (nonatomic, strong) UILabel *underlineLabel; // 下划线，默认高度为1px
@property (nonatomic, weak)   id      target;
@property (nonatomic, assign) SEL     action;

@end

@implementation HYBHyperlinkLabel

- (id)initWithFrame:(CGRect)frame text:(NSString *)text {
    return [self initWithFrame:frame text:text font:kFontWithSize(13)];
}

- (id)initWithFrame:(CGRect)frame text:(NSString *)text font:(UIFont *)font {
    return [self initWithFrame:frame
                          text:text
                     textColor:[UIColor blueColor]
                underlineColor:[UIColor blueColor]
                          font:font];
}

//
- (id)initWithFrame:(CGRect)frame text:(NSString *)text textColor:(UIColor *)textColor {
    return [self initWithFrame:frame text:text textColor:textColor font:kFontWithSize(13)];
}

- (id)initWithFrame:(CGRect)frame text:(NSString *)text textColor:(UIColor *)textColor font:(UIFont *)font {
    return [self initWithFrame:frame
                          text:text
                     textColor:textColor
                underlineColor:[UIColor blueColor]
                          font:font];
}

//
- (id)initWithFrame:(CGRect)frame
               text:(NSString *)text
          textColor:(UIColor *)textColor
     underlineColor:(UIColor *)underlineColor
               font:(UIFont *)font {
    // 以文字高度作为视图的高度
    CGSize size = [text sizeWithFont:font];
    frame.size.height = size.height;
    frame.size.width = size.width;
    
    if (self = [super initWithFrame:frame]) {
        self.textColor = textColor;
        self.underlineColor = underlineColor;
        
        CGRect rect = CGRectMake(0, 0, frame.size.width, frame.size.height);
//        self.textLabel = [HYBUIMaker labelWithFrame:rect
//                                               text:text
//                                          textColor:textColor
//                                               font:font];
        [self addSubview:self.textLabel];
        
        CGFloat originX = (self.textLabel.width - size.width) / 2;
//        self.underlineLabel = [HYBUIMaker labelWithFrame:CGRectMake(originX, self.textLabel.bottomY,
//                                                                    size.width, 0.8)];
        self.underlineLabel.backgroundColor = self.underlineColor;
        [self addSubview:self.underlineLabel];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame
               text:(NSString *)text
          textColor:(UIColor *)textColor
     underlineColor:(UIColor *)underlineColor {
    return [self initWithFrame:frame
                          text:text
                     textColor:textColor
                underlineColor:underlineColor
                          font:kFontWithSize(13)];
}

- (void)addTarget:(id)target action:(SEL)action {
    self.target = target;
    self.action = action;
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:target action:action];
    [self addGestureRecognizer:tap];
    return;
}

@end
