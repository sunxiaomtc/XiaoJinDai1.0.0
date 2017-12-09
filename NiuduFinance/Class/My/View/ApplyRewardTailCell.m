//
//  ApplyRewardTailCell.m
//  NiuduFinance
//
//  Created by 123 on 17/3/21.
//  Copyright © 2017年 liuyong. All rights reserved.
//

#import "ApplyRewardTailCell.h"

@implementation ApplyRewardTailCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (void)setMyRmountDic:(NSDictionary *)myRmountDic
{
    _myRmountDic = myRmountDic;
    _number.text = [NSString stringWithFormat:@"%@人",[[_myRmountDic objectForKey:@"applyTotal"] objectForKey:@"totalUserNum"]];
    _amount.text = [NSString stringWithFormat:@"%@元",[[_myRmountDic objectForKey:@"applyTotal"] objectForKey:@"totalInvestAmount"]];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
