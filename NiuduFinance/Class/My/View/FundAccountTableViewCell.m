//
//  FundAccountTableViewCell.m
//  NiuduFinance
//
//  Created by liuyong on 16/3/14.
//  Copyright © 2016年 liuyong. All rights reserved.
//

#import "FundAccountTableViewCell.h"

@implementation FundAccountTableViewCell

- (void)awakeFromNib {
    // Initialization code
    [super awakeFromNib];
}

- (void)setFundAccountDic:(NSDictionary *)fundAccountDic
{
    _fundAccountDic = fundAccountDic;
    
    _fundAccountLab.text = [NSString stringWithFormat:@"%@",[_fundAccountDic objectForKey:@"desc"]];
//    _fundAmountLab.text = [NSString stringWithFormat:@"%@",[_fundAccountDic objectForKey:@"amount"]];

    if ([[_fundAccountDic objectForKey:@"serialsType"] integerValue] == 1 ) {
        _fundAmountLab.text = [NSString stringWithFormat:@"+%.2f",[[_fundAccountDic objectForKey:@"amount"] floatValue]];
    }else{
    
        _fundAmountLab.text = [NSString stringWithFormat:@"-%.2f",[[_fundAccountDic objectForKey:@"amount"] floatValue]];
    }
    
    
    if ([[_fundAccountDic objectForKey:@"serialsType"] integerValue] == 2) {
        
        [_funImage setImage:[UIImage imageNamed:@"dong.png"]];
    }else if([[_fundAccountDic objectForKey:@"serialsType"] integerValue] == 1){
        [_funImage setImage:[UIImage imageNamed:@"shou.png"]];
    }else if([[_fundAccountDic objectForKey:@"serialsType"] integerValue] == 0){
        [_funImage setImage:[UIImage imageNamed:@"zhi.png"]];

    }

    NSString * timeStampString = [NSString stringWithFormat:@"%@",[_fundAccountDic objectForKey:@"creationdate"]];
    NSTimeInterval _interval=[timeStampString doubleValue] / 1000.0;
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:_interval];
    NSDateFormatter *objDateformat = [[NSDateFormatter alloc] init];
    [objDateformat setDateFormat:@"HH:mm MM-dd"];
    NSLog(@"%@", [objDateformat stringFromDate: date]);
    
    NSString * string = [objDateformat stringFromDate:date];
//    NSString * str = [string substringWithRange:NSMakeRange(0, 8)];
    _fundDataLab.text = string;
    _fundDataLab.numberOfLines = 0;
    NSLog(@"++++++--------%@",_fundDataLab.text);

    
   
    [self.contentView addSubview:_fundDataLab];
    [_fundDataLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(12);
        make.right.mas_equalTo(-16);
        make.size.mas_equalTo(CGSizeMake(50, 50));
    }];
    [self.contentView addSubview:_funImage];
    [_funImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(17);
        make.left.mas_equalTo(16);
        make.size.mas_equalTo(CGSizeMake(38, 38));
    }];
    
    [self.contentView addSubview:_fundAmountLab];
    [_fundAmountLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(13+2.5);
        make.left.equalTo(_funImage.mas_right).with.offset(10);
        make.height.mas_equalTo(15);
    }];
    
    self.fundAccountLab.numberOfLines = 1;
    [self.contentView addSubview:_fundAccountLab];
    [_fundAccountLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_fundAmountLab.mas_bottom).with.offset(0);
        make.left.equalTo(_funImage.mas_right).with.offset(10);
        make.height.mas_equalTo(30);
        make.right.mas_equalTo(_fundDataLab.mas_left).offset(-10);

    }];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
