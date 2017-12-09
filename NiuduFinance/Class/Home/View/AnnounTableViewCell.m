//
//  AnnounTableViewCell.m
//  NiuduFinance
//
//  Created by 123 on 17/2/10.
//  Copyright © 2017年 liuyong. All rights reserved.
//

#import "AnnounTableViewCell.h"

@implementation AnnounTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setuptitle:(NSString *)titleName titleDate:(NSString *)titleDate{
    
    _titleName.text = titleName;
    _titleDate.text = titleDate;
    
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
