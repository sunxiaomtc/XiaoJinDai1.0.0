//
//  MyAccountCell.m
//  NiuduFinance
//
//  Created by 123 on 17/8/2.
//  Copyright © 2017年 liuyong. All rights reserved.
//

#import "MyAccountCell.h"

@implementation MyAccountCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setMyAccountDic:(NSDictionary *)myAccountDic
{
    _myAccountDic = myAccountDic;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
