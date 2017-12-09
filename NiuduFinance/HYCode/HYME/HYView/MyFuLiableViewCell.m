//
//  MyFuLiableViewCell.m
//  NiuduFinance
//
//  Created by 123 on 17/8/3.
//  Copyright © 2017年 liuyong. All rights reserved.
//

#import "MyFuLiableViewCell.h"
@interface MyFuLiableViewCell ()



@end
@implementation MyFuLiableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setMyFuLiDic:(NSDictionary *)myFuLiDic withStatus:(int)status
{
    _myFuLiDic = myFuLiDic;
    _status = status;

    if (_status == 0) {
        if ([[_myFuLiDic objectForKey:@"type"] integerValue]==1) {
            _jxqLabel.hidden = YES;
            [_moneyNumLabel setTextColor:[UIColor colorWithHexString:@"#FFFFFF"]];
            [_moneyNumLabel setText:[NSString stringWithFormat:@"%@",[_myFuLiDic objectForKey:@"bounsvalue"]]];
            [_bfhLabel setText:@"元"];
        }else if([[_myFuLiDic objectForKey:@"type"] integerValue]==2){
            _jxqLabel.hidden = NO;
            [_jxqLabel setTextColor:[UIColor colorWithHexString:@"FFFFFF"]];
            [_moneyNumLabel setTextColor:[UIColor colorWithHexString:@"#FFFFFF"]];
            [_moneyNumLabel setText:[NSString stringWithFormat:@"%@",[_myFuLiDic objectForKey:@"bounsvalue"]]];
            [_bfhLabel setText:@"%"];
        }
        
        UIImage * image = [UIImage imageNamed:@"hju.png"];
        _bgImage.image = image;
        [_qtqxLabel setTextColor:[UIColor colorWithHexString:@"#FFFFFF"]];
        [_qtqxLabel setText:[NSString stringWithFormat:@"起投期限：%@月",[_myFuLiDic objectForKey:@"loanperiod"]]];
        [_qtjeLabel setTextColor:[UIColor colorWithHexString:@"#FFFFFF"]];
        [_qtjeLabel setText:[NSString stringWithFormat:@"起投金额：%@元",[_myFuLiDic objectForKey:@"bidamount"]]];
        [_lyLabel setTextColor:[UIColor colorWithHexString:@"#FFFFFF"]];
        [_lyLabel setText:[NSString stringWithFormat:@"来源：%@",[_myFuLiDic objectForKey:@"sourcename"]]];
        NSString * timeStampString = [NSString stringWithFormat:@"%@",[_myFuLiDic objectForKey:@"validate"]];
        NSTimeInterval _interval=[timeStampString doubleValue] / 1000.0;
        NSDate *date = [NSDate dateWithTimeIntervalSince1970:_interval];
        NSDateFormatter *objDateformat = [[NSDateFormatter alloc] init];
        [objDateformat setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        NSLog(@"%@",  [objDateformat stringFromDate: date]);
        NSString * string = [objDateformat stringFromDate:date];
        NSString * str = [string substringWithRange:NSMakeRange(0, 10)];
        [_yxqLabel setTextColor:[UIColor colorWithHexString:@"#FFFFFF"]];
        [_yxqLabel setText:[NSString stringWithFormat:@"有效期：%@",str]];
        [_syLabel setTextColor:[UIColor colorWithHexString:@"#FFFFFF"]];
        [_syLabel setText:@"可使用"];
    }else if(_status == 1)
    {
        if ([[_myFuLiDic objectForKey:@"type"] integerValue]==1) {
            _jxqLabel.hidden = YES;
            [_moneyNumLabel setTextColor:[UIColor colorWithHexString:@"#9A9A9A"]];
            [_moneyNumLabel setText:[NSString stringWithFormat:@"%@",[_myFuLiDic objectForKey:@"bounsvalue"]]];
            [_bfhLabel setText:@"元"];
        }else if([[_myFuLiDic objectForKey:@"type"] integerValue]==2){
            _jxqLabel.hidden = NO;
            [_jxqLabel setTextColor:[UIColor colorWithHexString:@"9A9A9A"]];
            [_moneyNumLabel setTextColor:[UIColor colorWithHexString:@"#9A9A9A"]];
            [_moneyNumLabel setText:[NSString stringWithFormat:@"%@",[_myFuLiDic objectForKey:@"bounsvalue"]]];
            [_bfhLabel setText:@"%"];
        }
        
        UIImage * image = [UIImage imageNamed:@"bju.png"];
        _bgImage.image = image;
        [_moneyNumLabel setTextColor:[UIColor colorWithHexString:@"#9A9A9A"]];
        [_moneyNumLabel setText:[NSString stringWithFormat:@"%@元",[_myFuLiDic objectForKey:@"bounsvalue"]]];
        [_qtqxLabel setTextColor:[UIColor colorWithHexString:@"#9A9A9A"]];
        [_qtqxLabel setText:[NSString stringWithFormat:@"起投期限：%@月",[_myFuLiDic objectForKey:@"loanperiod"]]];
        [_qtjeLabel setTextColor:[UIColor colorWithHexString:@"#9A9A9A"]];
        [_qtjeLabel setText:[NSString stringWithFormat:@"起投金额：%@元",[_myFuLiDic objectForKey:@"bidamount"]]];
        [_lyLabel setTextColor:[UIColor colorWithHexString:@"#9A9A9A"]];
        [_lyLabel setText:[NSString stringWithFormat:@"来源：%@",[_myFuLiDic objectForKey:@"sourcename"]]];
        NSString * timeStampString = [NSString stringWithFormat:@"%@",[_myFuLiDic objectForKey:@"validate"]];
        NSTimeInterval _interval=[timeStampString doubleValue] / 1000.0;
        NSDate *date = [NSDate dateWithTimeIntervalSince1970:_interval];
        NSDateFormatter *objDateformat = [[NSDateFormatter alloc] init];
        [objDateformat setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        NSLog(@"%@",  [objDateformat stringFromDate: date]);
        NSString * string = [objDateformat stringFromDate:date];
        NSString * str = [string substringWithRange:NSMakeRange(0, 10)];
        [_yxqLabel setTextColor:[UIColor colorWithHexString:@"#9A9A9A"]];
        [_yxqLabel setText:[NSString stringWithFormat:@"有效期：%@",str]];
        [_syLabel setTextColor:[UIColor colorWithHexString:@"#9A9A9A"]];
        [_syLabel setText:@"已使用"];
    }else{
        if ([[_myFuLiDic objectForKey:@"type"] integerValue]==1) {
            _jxqLabel.hidden = YES;
            [_moneyNumLabel setTextColor:[UIColor colorWithHexString:@"#9A9A9A"]];
            [_moneyNumLabel setText:[NSString stringWithFormat:@"%@",[_myFuLiDic objectForKey:@"bounsvalue"]]];
            [_bfhLabel setText:@"元"];
        }else if([[_myFuLiDic objectForKey:@"type"] integerValue]==2){
            _jxqLabel.hidden = NO;
            [_jxqLabel setTextColor:[UIColor colorWithHexString:@"9A9A9A"]];
            [_moneyNumLabel setTextColor:[UIColor colorWithHexString:@"#9A9A9A"]];
            [_moneyNumLabel setText:[NSString stringWithFormat:@"%@",[_myFuLiDic objectForKey:@"bounsvalue"]]];
            [_bfhLabel setText:@"%"];
        }
        UIImage * image = [UIImage imageNamed:@"bju.png"];
        _bgImage.image = image;
        [_moneyNumLabel setTextColor:[UIColor colorWithHexString:@"#9A9A9A"]];
        [_moneyNumLabel setText:[NSString stringWithFormat:@"%@元",[_myFuLiDic objectForKey:@"bounsvalue"]]];
        [_qtqxLabel setTextColor:[UIColor colorWithHexString:@"#9A9A9A"]];
        [_qtqxLabel setText:[NSString stringWithFormat:@"起投期限：%@月",[_myFuLiDic objectForKey:@"loanperiod"]]];
        [_qtjeLabel setTextColor:[UIColor colorWithHexString:@"#9A9A9A"]];
        [_qtjeLabel setText:[NSString stringWithFormat:@"起投金额：%@元",[_myFuLiDic objectForKey:@"bidamount"]]];
        [_lyLabel setTextColor:[UIColor colorWithHexString:@"#9A9A9A"]];
        [_lyLabel setText:[NSString stringWithFormat:@"来源：%@",[_myFuLiDic objectForKey:@"sourcename"]]];
        NSString * timeStampString = [NSString stringWithFormat:@"%@",[_myFuLiDic objectForKey:@"validate"]];
        NSTimeInterval _interval=[timeStampString doubleValue] / 1000.0;
        NSDate *date = [NSDate dateWithTimeIntervalSince1970:_interval];
        NSDateFormatter *objDateformat = [[NSDateFormatter alloc] init];
        [objDateformat setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        NSLog(@"%@",  [objDateformat stringFromDate: date]);
        NSString * string = [objDateformat stringFromDate:date];
        NSString * str = [string substringWithRange:NSMakeRange(0, 10)];
        [_yxqLabel setTextColor:[UIColor colorWithHexString:@"#9A9A9A"]];
        [_yxqLabel setText:[NSString stringWithFormat:@"有效期：%@",str]];
        [_syLabel setTextColor:[UIColor colorWithHexString:@"#9A9A9A"]];
        [_syLabel setText:@"已过期"];
    }
    


}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
