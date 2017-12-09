//
//  AccountSafeCell.m
//  NiuduFinance
//
//  Created by 123 on 17/2/5.
//  Copyright © 2017年 liuyong. All rights reserved.
//

#import "AccountSafeCell.h"

@implementation AccountSafeCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setuptitle:(NSString *)title detailText:(NSString *)detail hideLine:(BOOL)hide jianTouImageView:(BOOL)jianTouImageView
{
    
    if (![title isKindOfClass:[NSNull class]]) {
    
      _titleLabel.text = title;
    }
    if (![detail isKindOfClass:[NSNull class]]) {
        
      _detailLabel.text = detail;
    }
   
    _lineView.hidden = hide;
    _jianTouImageView.hidden = jianTouImageView;
    
}
@end
