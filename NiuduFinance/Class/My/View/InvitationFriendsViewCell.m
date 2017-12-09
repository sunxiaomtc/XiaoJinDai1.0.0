//
//  InvitationFriendsViewCell.m
//  NiuduFinance
//
//  Created by 123 on 17/3/20.
//  Copyright © 2017年 liuyong. All rights reserved.
//

#import "InvitationFriendsViewCell.h"

@implementation InvitationFriendsViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}


- (void)setMyRewardDic:(NSDictionary *)myRewardDic;
{
    _myRewardDic = myRewardDic;
    if (!(_phone)) {
        _phone = [UILabel new];
    }
    if (!(_time)) {
        _time = [UILabel new];
    }
    if (!(_amount)) {
        _amount = [UILabel new];
    }
    if (!(_reward)) {
        _reward = [UILabel new];
    }
    
    NSString * send = [NSString stringWithFormat:@"%@",[_myRewardDic objectForKey:@"sendStatus"]];
    
    if ([send isEqual:@"1"]||[send isEqual:@"2"]) {
        [_phone setTextColor:[UIColor colorWithHexString:@"#b0afaf"]];
        [_time setTextColor:[UIColor colorWithHexString:@"#b0afaf"]];
        [_amount setTextColor:[UIColor colorWithHexString:@"#b0afaf"]];
    }else{
        [_phone setTextColor:[UIColor blackColor]];
        [_time setTextColor:[UIColor blackColor]];
        [_amount setTextColor:[UIColor blackColor]];
    }
    
    _phone.text = [NSString stringWithFormat:@"%@",[_myRewardDic objectForKey:@"mobile"]];
    [_phone setFont:[UIFont systemFontOfSize:12]];
    _phone.textAlignment = NSTextAlignmentCenter;

    [self.contentView addSubview:_phone];
    [_phone mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.bottom.mas_equalTo(0);
        make.size.mas_equalTo(CGSizeMake(85, 9));
        make.centerX.equalTo(self.contentView.mas_left).with.offset(SCREEN_WIDTH/7);

    }];
    
    NSString * timeStampString = [NSString stringWithFormat:@"%@",[_myRewardDic objectForKey:@"creationdate"]];
    NSTimeInterval _interval=[timeStampString doubleValue] / 1000.0;
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:_interval];
    NSDateFormatter *objDateformat = [[NSDateFormatter alloc] init];
    [objDateformat setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSLog(@"%@",  [objDateformat stringFromDate: date]);
    NSString * string = [objDateformat stringFromDate:date];
    NSString * str = [string substringWithRange:NSMakeRange(0, 10)];
    _time.text = str;
    [_time setFont:[UIFont systemFontOfSize:12]];
    _time.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:_time];
    [_time mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.bottom.mas_equalTo(0);
        make.size.mas_equalTo(CGSizeMake(85, 9));
        make.centerX.equalTo(self.contentView.mas_left).with.offset(SCREEN_WIDTH/7*3);
    }];
    
    _amount.text = [NSString stringWithFormat:@"%@元",[_myRewardDic objectForKey:@"investAmount"]];
    _amount.textAlignment = NSTextAlignmentCenter;
    [_amount setFont:[UIFont systemFontOfSize:12]];
    _amount.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:_amount];
    [_amount mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.bottom.mas_equalTo(0);
        make.size.mas_equalTo(CGSizeMake(85, 9));
        make.centerX.equalTo(self.contentView.mas_left).with.offset(SCREEN_WIDTH/6*4);

    }];
    
    [_reward setText:@"详情"];
    [_reward setFont:[UIFont systemFontOfSize:12]];
    _reward.textAlignment = NSTextAlignmentCenter;
    [_reward setTextColor:[UIColor colorWithHexString:@"#019BFF"]];
    [self.contentView addSubview:_reward];
    [_reward mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.bottom.mas_equalTo(0);
        make.size.mas_equalTo(CGSizeMake(85, 9));
        make.centerX.equalTo(self.contentView.mas_left).with.offset(SCREEN_WIDTH/7*6);
    }];
}



- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
