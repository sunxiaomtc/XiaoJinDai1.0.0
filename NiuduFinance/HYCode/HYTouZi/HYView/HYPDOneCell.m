//
//  HYPDOneCell.m
//  NiuduFinance
//
//  Created by Apple on 2018/1/3.
//  Copyright © 2018年 liuyong. All rights reserved.
//

#import "HYPDOneCell.h"

@implementation HYPDOneCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.pointLabel1.layer.cornerRadius = 6.5f;
    self.pointLabel1.layer.masksToBounds = YES;
    self.pointLabel2.layer.cornerRadius = 6.5f;
    self.pointLabel2.layer.masksToBounds = YES;
    self.pointLabel3.layer.cornerRadius = 6.5f;
    self.pointLabel3.layer.masksToBounds = YES;
}

-(void)setModels:(SNProjectListItem *)models
{
    _models = models;
    
    NSString * timeStampString = [NSString stringWithFormat:@"%@",models.collectDate];
    NSTimeInterval _interval=[timeStampString doubleValue] / 1000.0;
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:_interval];
    NSDateFormatter *objDateformat = [[NSDateFormatter alloc] init];
    [objDateformat setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSLog(@"%@",  [objDateformat stringFromDate: date]);
    NSString * string = [objDateformat stringFromDate:date];
    NSString * str = [string substringWithRange:NSMakeRange(0, 10)];
    self.dateLabel.text = [NSString stringWithFormat:@"募集期至%@",str];
    if ([models.statusid integerValue] == 1)
    {
        [self setDefault];
    }else if ([models.statusid integerValue] == 2)
    {
        [self setDefault];
    }else if ([models.statusid integerValue] == 3)
    {
        self.pointLabel1.backgroundColor = qianhui(252, 128, 2);
        self.pointLabel2.backgroundColor = qianhui(252, 128, 2);
        self.pointLabel3.backgroundColor = qianhui(255, 221, 159);
        self.lineLabel1.backgroundColor = qianhui(252, 128, 2);
        self.lineLabel2.backgroundColor = qianhui(255, 221, 159);
    }else if ([models.statusid integerValue] == 4)
    {
        self.pointLabel1.backgroundColor = qianhui(252, 128, 2);
        self.pointLabel2.backgroundColor = qianhui(252, 128, 2);
        self.pointLabel3.backgroundColor = qianhui(252, 128, 2);
        self.lineLabel1.backgroundColor = qianhui(252, 128, 2);
        self.lineLabel2.backgroundColor = qianhui(252, 128, 2);
    }else
    {
        [self setDefault];
    }
}

-(void)setDefault
{
    self.pointLabel1.backgroundColor = qianhui(252, 128, 2);
    self.pointLabel2.backgroundColor = qianhui(255, 221, 159);
    self.pointLabel3.backgroundColor = qianhui(255, 221, 159);
    self.lineLabel1.backgroundColor = qianhui(255, 221, 159);
    self.lineLabel2.backgroundColor = qianhui(255, 221, 159);
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    //[super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated
{
    
}

@end
