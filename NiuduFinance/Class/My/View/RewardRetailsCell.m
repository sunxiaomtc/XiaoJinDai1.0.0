//
//  RewardRetailsCell.m
//  NiuduFinance
//
//  Created by 123 on 17/3/22.
//  Copyright © 2017年 liuyong. All rights reserved.
//

#import "RewardRetailsCell.h"
@implementation RewardRetailsCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setMyRewardDic:(NSDictionary *)myRewardDic
{
    _myRewardDic = myRewardDic;
    if (!(_lineOne)) {
        _lineOne = [UILabel new];
    }
    if (!(_lineTwo)) {
        _lineTwo = [UILabel new];
    }
    if (!(_lineThree)) {
        _lineThree = [UILabel new];
    }
    if (!(_friendsLabel)) {
        _friendsLabel = [UILabel new];
    }
    if (!(_typeLabel)) {
        _typeLabel = [UILabel new];
    }
    if (!(_rewardLabel)) {
        _rewardLabel = [UILabel new];
    }
    if (!(_noteLabel)) {
        _noteLabel = [UILabel new];
    }
    
    [_lineOne setBackgroundColor:[UIColor blackColor]];
    [self.contentView addSubview:_lineOne];
    [_lineOne mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.bottom.mas_equalTo(0);
        make.size.mas_equalTo(CGSizeMake(1, self.contentView.height));
        make.centerX.equalTo(self.contentView.mas_left).with.offset(SCREEN_WIDTH/4);
    }];
    
    [_lineTwo setBackgroundColor:[UIColor blackColor]];
    [self.contentView addSubview:_lineTwo];
    [_lineTwo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.bottom.mas_equalTo(0);
        make.size.mas_equalTo(CGSizeMake(1, self.contentView.height));
        make.centerX.mas_equalTo(0);
    }];
    
    [_lineThree setBackgroundColor:[UIColor blackColor]];
    [self.contentView addSubview:_lineThree];
    [_lineThree mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.bottom.mas_equalTo(0);
        make.size.mas_equalTo(CGSizeMake(1, self.contentView.height));
        make.centerX.equalTo(self.contentView.mas_left).with.offset(SCREEN_WIDTH/4*3);
    }];
    
//    [_friendsLabel setText:@"好友"];
    [_friendsLabel setFont:[UIFont systemFontOfSize:13]];
    _friendsLabel.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:_friendsLabel];
    [_friendsLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.left.mas_equalTo(0);
        make.bottom.mas_equalTo(0);
        make.right.equalTo(_lineOne.mas_left);
    }];
    
//    [_typeLabel setText:@"类型"];
    [_typeLabel setFont:[UIFont systemFontOfSize:13]];
    _typeLabel.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:_typeLabel];
    [_typeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.left.equalTo(_lineOne.mas_right);
        make.bottom.mas_equalTo(0);
        make.right.equalTo(_lineTwo.mas_left);
    }];
    
//    [_rewardLabel setText:@"我的奖励"];
    [_rewardLabel setFont:[UIFont systemFontOfSize:13]];
    _rewardLabel.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:_rewardLabel];
    [_rewardLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.left.equalTo(_lineTwo.mas_right);
        make.bottom.mas_equalTo(0);
        make.right.equalTo(_lineThree.mas_left);
    }];
    
//    [_noteLabel setText:@"备注"];
    _noteLabel.numberOfLines = 0;
    [_noteLabel setFont:[UIFont systemFontOfSize:12]];
    _noteLabel.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:_noteLabel];
    [_noteLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.left.equalTo(_lineThree.mas_right);
        make.bottom.mas_equalTo(0);
        make.right.mas_equalTo(0);
    }];

    _friendsLabel.text = [NSString stringWithFormat:@"%@",[_myRewardDic objectForKey:@"username"]];
    NSLog(@"%@",_friendsLabel.text);
    _typeLabel.text = [NSString stringWithFormat:@"%@",[_myRewardDic objectForKey:@"typeName"]];
    NSLog(@"%@",_typeLabel.text);

    _rewardLabel.text = [NSString stringWithFormat:@"%@",[_myRewardDic objectForKey:@"reward"]];
    NSLog(@"%@",_rewardLabel.text);
    _noteLabel.text = [NSString stringWithFormat:@"%@",[_myRewardDic objectForKey:@"remark"]];
    NSLog(@"%@",_noteLabel.text);

    _isAssign = [NSString stringWithFormat:@"%@",[_myRewardDic objectForKey:@"isAssign"]];
    NSLog(@"%@",_isAssign);
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
