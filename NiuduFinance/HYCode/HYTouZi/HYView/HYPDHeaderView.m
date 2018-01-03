//
//  HYPDHeaderView.m
//  NiuduFinance
//
//  Created by Apple on 2018/1/3.
//  Copyright © 2018年 liuyong. All rights reserved.
//

#import "HYPDHeaderView.h"


@implementation HYPDHeaderView

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    self = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:nil options:nil] lastObject];
    if(self)
    {
        self.frame = frame;
        [self setUI];
    }
    return self;
}

-(void)setUI
{
    if(isIPhoneX)
    {
        self.titleTopLayout.constant = 0 + WDStatusBarHeight;
        self.btnTopLayout.constant = 0 + WDStatusBarHeight;
    }
    
    self.customView = [[HYJDTCustomView alloc] initWithFrame:CGRectMake(0, 180 + WDStatusBarHeight, SCREEN_WIDTH, 50)];
    self.customView.bfbStr = @"0";
    [self addSubview:self.customView];
    
}

-(void)setModels:(SNProjectListItem *)models
{
    _models = models;
    NSString *str = [self formatFloat:([models.rate floatValue]-([models.addRate floatValue]))];
    self.bfbLabel.text = str;
    if([models.addRate floatValue] > 0)
    {
        self.addLabel.text = [NSString stringWithFormat:@"+%@%%",models.addRate];
    }else
    {
        self.addLabel.text = @"";
    }
    self.allPriceLabel.text = [NSString stringWithFormat:@"%@元", models.amount];
    if ([models.periodtypeid integerValue] == 1) {
        self.dayLabel.text = [NSString stringWithFormat:@"%@天", models.loanperiod];
    } else if ([models.periodtypeid integerValue] == 2) {
        self.dayLabel.text = [NSString stringWithFormat:@"%@个月", models.loanperiod];
    } else if ([models.periodtypeid integerValue] == 3) {
        self.dayLabel.text = [NSString stringWithFormat:@"%@年", models.loanperiod];
    }
    self.syPriceLabel.text = [NSString stringWithFormat:@"%@元",models.remainamount];
    self.customView.bfbStr = [NSString stringWithFormat:@"%.2f",[models.process floatValue] / 100.0];
}

//小数点问题
- (NSString *)formatFloat:(float)f
{
    if (fmodf(f, 1)==0) {//如果有一位小数点
        return [NSString stringWithFormat:@"%.0f",f];
    } else if (fmodf(f*10, 1)==0) {//如果有两位小数点
        return [NSString stringWithFormat:@"%.1f",f];
    } else {
        return [NSString stringWithFormat:@"%.2f",f];
    }
}

- (IBAction)backClick:(UIButton *)sender {
    [self.superViewController.navigationController popViewControllerAnimated:YES];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
