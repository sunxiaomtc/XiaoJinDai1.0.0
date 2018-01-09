//
//  HYJDTCustomView.m
//  NiuduFinance
//
//  Created by Apple on 2017/12/28.
//  Copyright © 2017年 liuyong. All rights reserved.
//

#import "HYJDTCustomView.h"

@implementation HYJDTCustomView

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(self)
    {
        //self.backgroundColor = qianhui(247, 126, 2);
        
        UILabel *bgView = [[UILabel alloc] init];
        bgView.backgroundColor = qianhui(255, 178, 86);
        bgView.frame = CGRectMake(25, 15, SCREEN_WIDTH - 50, 5);
        bgView.layer.cornerRadius = 2.0f;
        bgView.layer.masksToBounds = YES;
        self.bgLabel = bgView;
        [self addSubview:bgView];
        
        UILabel *showLabel = [[UILabel alloc] init];
        showLabel.frame = CGRectMake(0, 0, 0, 5);
        showLabel.backgroundColor = qianhui(255, 178, 87);
        self.showLabel = showLabel;
        //[self.showLabel addObserver:self forKeyPath:@"frame" options:NSKeyValueObservingOptionOld|NSKeyValueObservingOptionNew context:nil];
        [bgView addSubview:showLabel];
        
        UILabel *pointLabel = [[UILabel alloc] init];
        pointLabel.frame = CGRectMake(0, 12, 12, 12);
        pointLabel.backgroundColor = [UIColor whiteColor];
        pointLabel.layer.borderWidth = 1.0f;
        pointLabel.layer.borderColor = [qianhui220Color CGColor];
        pointLabel.layer.cornerRadius = 6.0f;
        pointLabel.layer.masksToBounds = YES;
        self.pointLabel = pointLabel;
        [self addSubview:pointLabel];
        
        UICountingLabel *numLabel = [[UICountingLabel alloc] initWithFrame:CGRectMake(pointLabel.frame.origin.x + 25 - 20 + 6, 28, 40, 15)];
        //numLabel.frame = CGRectMake(pointLabel.frame.origin.x + 25 - 20, 25, 40, 15);
        numLabel.textColor = [UIColor whiteColor];
        numLabel.text = @"0%";
        numLabel.font = [UIFont systemFontOfSize:15.0f];
        numLabel.textAlignment = NSTextAlignmentCenter;
        numLabel.format = @"%.0f%%";
        self.numLabel = numLabel;
        [self addSubview:numLabel];
        
    }
    return self;
}

-(void)setBfbStr:(NSString *)bfbStr
{
    _bfbStr = bfbStr;
    
//    [UIView animateWithDuration:1.5 animations:^{
//
//        float bfb = [bfbStr floatValue];
//        CGFloat labelX = (SCREEN_WIDTH - 50) * bfb;
//        self.showLabel.frame = CGRectMake(0, 0, labelX, 5);
//        self.pointLabel.frame = CGRectMake(labelX + 25, 12, 12, 12);
//        self.numLabel.frame = CGRectMake(labelX + 25 - 20, 25, 40, 15);
//        self.numLabel.text = [NSString stringWithFormat:@"%.0f%%",self.showLabel.frame.size.width];
//        CAGradientLayer *gradientLayer = [CAGradientLayer layer];
//        gradientLayer.colors = @[(__bridge id)qianhui(255, 178, 87).CGColor, (__bridge id)[UIColor whiteColor].CGColor];
//        gradientLayer.startPoint = CGPointMake(0, 0);
//        gradientLayer.endPoint = CGPointMake(1.0, 0);
//        gradientLayer.frame = CGRectMake(0, 0, labelX, 5);
//        [self.showLabel.layer addSublayer:gradientLayer];
//    } completion:^(BOOL finished) {
//
//    }];
    
    float bfb = [bfbStr floatValue];
    CGFloat labelX = (SCREEN_WIDTH - 50) * bfb;
    self.showLabel.frame = CGRectMake(0, 0, labelX, 5);
    self.pointLabel.frame = CGRectMake(labelX + 25, 12, 12, 12);
    self.numLabel.frame = CGRectMake(labelX + 25 - 20 + 6, 28, 40, 15);
    self.numLabel.text = [NSString stringWithFormat:@"%@%%",[self formatFloat:[bfbStr floatValue] * 100]];
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.colors = @[(__bridge id)qianhui(255, 178, 87).CGColor, (__bridge id)[UIColor whiteColor].CGColor];
    gradientLayer.startPoint = CGPointMake(0, 0);
    gradientLayer.endPoint = CGPointMake(1.0, 0);
    gradientLayer.frame = CGRectMake(0, 0, labelX, 5);
    [self.showLabel.layer addSublayer:gradientLayer];
    
//    [UIView animateKeyframesWithDuration:2.0 delay:0 options:UIViewKeyframeAnimationOptionCalculationModeLinear animations:^{
//        float bfb = [bfbStr floatValue];
//        CGFloat labelX = (SCREEN_WIDTH - 50) * bfb;
//        self.showLabel.frame = CGRectMake(0, 0, labelX, 5);
//        self.pointLabel.frame = CGRectMake(labelX + 25, 12, 12, 12);
//        self.numLabel.frame = CGRectMake(labelX + 25 - 20 + 6, 28, 40, 15);
//        CAGradientLayer *gradientLayer = [CAGradientLayer layer];
//        gradientLayer.colors = @[(__bridge id)qianhui(255, 178, 87).CGColor, (__bridge id)[UIColor whiteColor].CGColor];
//        gradientLayer.startPoint = CGPointMake(0, 0);
//        gradientLayer.endPoint = CGPointMake(1.0, 0);
//        gradientLayer.frame = CGRectMake(0, 0, labelX, 5);
//        [self.showLabel.layer addSublayer:gradientLayer];
//        [self.numLabel countFrom:0 to:[bfbStr floatValue] * 100 withDuration:2];
//    } completion:^(BOOL finished) {
//    }];
}

- (NSString *)formatFloat:(float)f
{
    if (fmodf(f, 1)==0) {//如果有一位小数点
        return [NSString stringWithFormat:@"%.0f",f];
    } else if (fmodf(f*10, 1)==0) {//如果有两位小数点
        return [NSString stringWithFormat:@"%.1f",f];
    } else {
        return [NSString stringWithFormat:@"%.1f",f];
    }
}

//-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context
//{
//    if([keyPath isEqualToString:@"frame"] && object == self.showLabel)
//    {
//        NSLog(@"%@",[change valueForKey:@"new"]);
//    }
//}

-(void)dealloc
{
    //[self removeObserver:self forKeyPath:@"frame" context:nil];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
