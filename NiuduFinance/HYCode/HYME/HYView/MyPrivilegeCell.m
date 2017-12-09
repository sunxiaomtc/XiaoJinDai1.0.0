//
//  MyPrivilegeCell.m
//  NiuduFinance
//
//  Created by 123 on 17/8/3.
//  Copyright © 2017年 liuyong. All rights reserved.
//

#import "MyPrivilegeCell.h"

@implementation MyPrivilegeCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (void)setMyPrivilegeDic:(NSDictionary *)myPrivilegeDic withStatus:(int)status
{
    _myPrivilegeDic = myPrivilegeDic;

    _status = status;
    if (_status == 0) {
        UIImage * image = [UIImage imageNamed:@"cju.png"];
        _bgImag.image = image;
        [_moneyNumLabe setTextColor:[UIColor colorWithHexString:@"#FFFFFF"]];
        [_moneyNumLabe setText:[NSString stringWithFormat:@"%@",[_myPrivilegeDic objectForKey:@"bounsvalue"]]];
        [_qtqxLabe setTextColor:[UIColor colorWithHexString:@"#FFFFFF"]];
        //券名
        NSLog(@"%@",[_myPrivilegeDic objectForKey:@"bounsname"]);
        [_qtqxLabe setText:[NSString stringWithFormat:@"%@",[_myPrivilegeDic objectForKey:@"bounsname"]]];
        [_lyLabe setTextColor:[UIColor colorWithHexString:@"#FFFFFF"]];
        [_lyLabe setText:[NSString stringWithFormat:@"来源：%@",[_myPrivilegeDic objectForKey:@"sourcename"]]];
        NSString * timeStampString = [NSString stringWithFormat:@"%@",[_myPrivilegeDic objectForKey:@"createdate"]];
        NSTimeInterval _interval=[timeStampString doubleValue] / 1000.0;
        NSDate *date = [NSDate dateWithTimeIntervalSince1970:_interval];
        NSDateFormatter *objDateformat = [[NSDateFormatter alloc] init];
        [objDateformat setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        NSLog(@"%@",  [objDateformat stringFromDate: date]);
        NSString * string = [objDateformat stringFromDate:date];
        NSString * str = [string substringWithRange:NSMakeRange(0, 10)];
        [_yxqLabe setTextColor:[UIColor colorWithHexString:@"#FFFFFF"]];
        [_yxqLabe setText:[NSString stringWithFormat:@"获得时间：%@",str]];
        [_syLabe setTextColor:[UIColor colorWithHexString:@"#FFFFFF"]];
        [_syLabe setText:@"可使用"];
    }else if(_status == 1)
    {
        UIImage * image = [UIImage imageNamed:@"bju.png"];
        _bgImag.image = image;
        [_moneyNumLabe setTextColor:[UIColor colorWithHexString:@"#9A9A9A"]];
        [_moneyNumLabe setText:[NSString stringWithFormat:@"%@",[_myPrivilegeDic objectForKey:@"bounsvalue"]]];
        [_qtqxLabe setTextColor:[UIColor colorWithHexString:@"#9A9A9A"]];
        [_qtqxLabe setText:[NSString stringWithFormat:@"%@",[_myPrivilegeDic objectForKey:@"bounsname"]]];
        [_lyLabe setTextColor:[UIColor colorWithHexString:@"#9A9A9A"]];
        [_lyLabe setText:[NSString stringWithFormat:@"来源：%@",[_myPrivilegeDic objectForKey:@"sourcename"]]];
        NSString * timeStampString = [NSString stringWithFormat:@"%@",[_myPrivilegeDic objectForKey:@"createdate"]];
        NSTimeInterval _interval=[timeStampString doubleValue] / 1000.0;
        NSDate *date = [NSDate dateWithTimeIntervalSince1970:_interval];
        NSDateFormatter *objDateformat = [[NSDateFormatter alloc] init];
        [objDateformat setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        NSLog(@"%@",  [objDateformat stringFromDate: date]);
        NSString * string = [objDateformat stringFromDate:date];
        NSString * str = [string substringWithRange:NSMakeRange(0, 10)];
        [_yxqLabe setTextColor:[UIColor colorWithHexString:@"#9A9A9A"]];
        [_yxqLabe setText:[NSString stringWithFormat:@"获得时间：%@",str]];
        [_syLabe setTextColor:[UIColor colorWithHexString:@"#9A9A9A"]];
        [_syLabe setText:@"已使用"];
    }else{
        UIImage * image = [UIImage imageNamed:@"bju.png"];
        _bgImag.image = image;
        [_moneyNumLabe setTextColor:[UIColor colorWithHexString:@"#9A9A9A"]];
        [_moneyNumLabe setText:[NSString stringWithFormat:@"%@",[_myPrivilegeDic objectForKey:@"bounsvalue"]]];
        [_qtqxLabe setTextColor:[UIColor colorWithHexString:@"#9A9A9A"]];
        [_qtqxLabe setText:[NSString stringWithFormat:@"%@",[_myPrivilegeDic objectForKey:@"bounsname"]]];
        [_lyLabe setTextColor:[UIColor colorWithHexString:@"#9A9A9A"]];
        [_lyLabe setText:[NSString stringWithFormat:@"来源：%@",[_myPrivilegeDic objectForKey:@"sourcename"]]];
        NSString * timeStampString = [NSString stringWithFormat:@"%@",[_myPrivilegeDic objectForKey:@"createdate"]];
        NSTimeInterval _interval=[timeStampString doubleValue] / 1000.0;
        NSDate *date = [NSDate dateWithTimeIntervalSince1970:_interval];
        NSDateFormatter *objDateformat = [[NSDateFormatter alloc] init];
        [objDateformat setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        NSLog(@"%@",  [objDateformat stringFromDate: date]);
        NSString * string = [objDateformat stringFromDate:date];
        NSString * str = [string substringWithRange:NSMakeRange(0, 10)];
        [_yxqLabe setTextColor:[UIColor colorWithHexString:@"#9A9A9A"]];
        [_yxqLabe setText:[NSString stringWithFormat:@"获得时间：%@",str]];
        [_syLabe setTextColor:[UIColor colorWithHexString:@"#9A9A9A"]];
        [_syLabe setText:@"已过期"];
    }

}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
