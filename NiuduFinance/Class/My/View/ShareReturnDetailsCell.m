//
//  ShareReturnDetailsCell.m
//  NiuduFinance
//
//  Created by 123 on 17/7/27.
//  Copyright © 2017年 liuyong. All rights reserved.
//

#import "ShareReturnDetailsCell.h"

@implementation ShareReturnDetailsCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (void)setReturnDetailsDic:(NSDictionary *)returnDetailsDic
{
    _returnDetailsDic = returnDetailsDic;
    
//    NSInteger C  = [[[NSUserDefaults standardUserDefaults]objectForKey:@"selectedCo"] integerValue];
//    
//    NSLog(@"%ld",C);
//    if (C == 1) {
//        _principalLab.hidden = YES;
//    }else{
//        _principalLab.hidden = NO;
//        _principalLab.text = [NSString stringWithFormat:@"当期本金:%.2f元",[[_returnDetailsDic objectForKey:@"principal"] floatValue]];
//    }
    
    _interestLab.text = [NSString stringWithFormat:@"当期利息:%.2f元",[[_returnDetailsDic objectForKey:@"interest"] floatValue]];
    NSLog(@"%@",[_returnDetailsDic objectForKey:@"statusid"]);
    int  status = [[_returnDetailsDic objectForKey:@"statusid"] intValue];
    if (status == 1) {
        
        [_dataStateLab setText:@"已还"];
    }else{
        [_dataStateLab setTextColor:NaviColor];
        [_dataStateLab setText:@"未还"];
    }
    
    NSString * timeStampString = [NSString stringWithFormat:@"%@",[returnDetailsDic objectForKey:@"duedate"]];
    NSTimeInterval _interval=[timeStampString doubleValue] / 1000.0;
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:_interval];
    NSDateFormatter *objDateformat = [[NSDateFormatter alloc] init];
    [objDateformat setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSLog(@"%@",  [objDateformat stringFromDate: date]);
    NSString * string = [objDateformat stringFromDate:date];
    NSString * str = [string substringWithRange:NSMakeRange(0, 10)];
    _dateLabel.text = [NSString stringWithFormat:@"还款日期:%@",str];
    //期数
    _periodLab.text = [NSString stringWithFormat:@"%@/%@期",[_returnDetailsDic objectForKey:@"orderid"],[_returnDetailsDic objectForKey:@"loanperiod"]];
    
    
    
    [self.contentView addSubview:_shadowView];
    [_shadowView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.height.mas_equalTo(10);
    }];
    [self.contentView addSubview:_periodLab];
    [_periodLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_shadowView.mas_bottom).with.offset(18);
        make.left.mas_equalTo(15);
        make.height.mas_equalTo(15);
    }];
    [self.contentView addSubview:_lineView];
    [_lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_periodLab.mas_bottom).with.offset(12);
        make.left.mas_equalTo(15);
        make.right.mas_equalTo(0);
        make.height.mas_equalTo(2);
    }];
    
    [self.contentView addSubview:_interestLab];
    [_interestLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_lineView.mas_bottom).with.offset(16);
        make.left.mas_equalTo(22);
        make.height.mas_equalTo(14);
    }];
    
//    [self.contentView addSubview:_principalLab];
//    [_principalLab mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(_interestLab.mas_bottom).with.offset(9);
//        make.left.mas_equalTo(22);
//        make.height.mas_equalTo(14);
//    }];
    
    [self.contentView addSubview:_dataStatLab];
    [_dataStatLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_interestLab.mas_top).with.offset(0);
        make.height.mas_equalTo(14);
        make.right.mas_equalTo(0);
        make.centerX.mas_equalTo(89);
    }];
    
    [self.contentView addSubview:_dataStateLab];
    [_dataStateLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_interestLab.mas_top).with.offset(0);
        make.left.equalTo(_dataStatLab.mas_left).with.offset(65);
        make.height.mas_equalTo(14);
        make.right.mas_equalTo(0);
    }];
    
    [self.contentView addSubview:_dateLabel];
    [_dateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_dataStateLab.mas_bottom).with.offset(5);
        make.top.equalTo(_interestLab.mas_bottom).with.offset(9);
        make.left.mas_equalTo(22);
        make.height.mas_equalTo(14);
        
        
    }];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
