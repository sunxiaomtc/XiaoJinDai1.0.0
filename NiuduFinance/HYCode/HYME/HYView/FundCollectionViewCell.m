//
//  FundCollectionViewCell.m
//  NiuduFinance
//
//  Created by 邢天阔 on 2017/10/21.
//  Copyright © 2017年 liuyong. All rights reserved.
//

#import "FundCollectionViewCell.h"

@implementation FundCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.selectedBackgroundView = [[UIView alloc] init];
    self.selectedBackgroundView.backgroundColor = UIcolors;
}

-(void)setSelected:(BOOL)selected {
    [super setSelected:selected];
    if (selected) {
        self.fundLabel.textColor =[UIColor colorWithHexString:@"ffffff"];
    }else {
        self.fundLabel.textColor =[UIColor colorWithHexString:@"000000"];
    }
}
@end
