//
//  FundSortCollectionViewCell.m
//  NiuduFinance
//
//  Created by mac on 2017/9/27.
//  Copyright © 2017年 liuyong. All rights reserved.
//

#import "FundSortCollectionViewCell.h"

@implementation FundSortCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.selectedBackgroundView = [[UIView alloc] init];
    self.selectedBackgroundView.backgroundColor = UIcolors;
}

-(void)setSelected:(BOOL)selected
{
    [super setSelected:selected];
    if (selected) {
        self.titleLB.textColor =[UIColor colorWithHexString:@"ffffff"];
    }else{
        self.titleLB.textColor =[UIColor colorWithHexString:@"000000"];
    }
}

@end
