//
//  HYPDTwoCell.m
//  NiuduFinance
//
//  Created by Apple on 2018/1/3.
//  Copyright © 2018年 liuyong. All rights reserved.
//

#import "HYPDTwoCell.h"

@implementation HYPDTwoCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.rightImage.hidden = YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    //[super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

-(void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated
{
    
}

@end
