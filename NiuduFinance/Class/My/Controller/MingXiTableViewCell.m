//
//  MingXiTableViewCell.m
//  NiuduFinance
//
//  Created by 123 on 17/8/4.
//  Copyright © 2017年 liuyong. All rights reserved.
//

#import "MingXiTableViewCell.h"

@implementation MingXiTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (void)setFundAccountDic:(NSDictionary *)fundAccountDic
{
    _fundAccountDic = fundAccountDic;
    
    NSString * typeStr = [NSString stringWithFormat:@"%@",[_fundAccountDic objectForKey:@"serialsType"]];
    NSInteger type = [typeStr integerValue];
    if (type == 0) {
        UIImage * image1 = [UIImage imageNamed:@"zhi.png"];
        _imageVie.image = image1;
        
        [_moneyLabel setTextColor:[UIColor colorWithHexString:@"#0096FF"]];
        _moneyLabel.text = [NSString stringWithFormat:@"-%@",[_fundAccountDic objectForKey:@"amount"]];
        
    }else
    {
        UIImage * image1 = [UIImage imageNamed:@"shou.png"];
        _imageVie.image = image1;
        [_moneyLabel setTextColor:[UIColor colorWithHexString:@"#FF0000"]];
        _moneyLabel.text = [NSString stringWithFormat:@"+%@",[_fundAccountDic objectForKey:@"amount"]];
    }
    NSString * list = [_fundAccountDic objectForKey:@"description"];
    NSArray * rageArr = [list componentsSeparatedByString:@"，"];
    NSString * raStr = [NSString stringWithFormat:@"%@",rageArr[0]];
    _titleLabel.text = raStr;
    NSLog(@"%@",raStr);
    NSString * timeStampString = [NSString stringWithFormat:@"%@",[_fundAccountDic objectForKey:@"creationdate"]];
    NSTimeInterval _interval=[timeStampString doubleValue] / 1000.0;
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:_interval];
    NSDateFormatter *objDateformat = [[NSDateFormatter alloc] init];
    [objDateformat setDateFormat:@"MM-dd HH:mm:ss"];
    NSLog(@"%@",  [objDateformat stringFromDate: date]);
    NSString * string = [objDateformat stringFromDate:date];
    NSString * str = [string substringWithRange:NSMakeRange(0, 14)];
    [_timeLabel setTextColor:[UIColor colorWithHexString:@"#999999"]];
    [_timeLabel setText:[NSString stringWithFormat:@"%@",str]];
    
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
