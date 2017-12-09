//
//  ApplyrRewardMiddleCell.m
//  NiuduFinance
//
//  Created by 123 on 17/3/22.
//  Copyright © 2017年 liuyong. All rights reserved.
//

#import "ApplyrRewardMiddleCell.h"

@implementation ApplyrRewardMiddleCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setMyRmountDic:(NSDictionary *)myRmountDic
{
    _myRmountDic = myRmountDic;
    _name.text = [NSString stringWithFormat:@"%@",[_myRmountDic objectForKey:@"username"]];
    _amount.text = [NSString stringWithFormat:@"%@元",[_myRmountDic  objectForKey:@"investAmount"]];

}



- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
