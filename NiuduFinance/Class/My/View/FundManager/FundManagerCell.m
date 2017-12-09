//
//  FundManagerCell.m
//  NiuduFinance
//
//  Created by zhoupushan on 16/3/4.
//  Copyright © 2016年 liuyong. All rights reserved.
//

#import "FundManagerCell.h"
@interface FundManagerCell()
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *detailLabel;
@property (weak, nonatomic) IBOutlet UIImageView *pointer;

@end
@implementation FundManagerCell

- (void)setupTitle:(NSString *)title detailText:(NSString *)detailText  pointer:(UIImage*)pointer valueStyle:(FundManagerCellValueStyle)valueStyle
{
    _titleLabel.text = title;
    _detailLabel.text = detailText;
    _pointer.image = pointer;
    
    UIColor *detailTextColor;
    switch (valueStyle)
    {
        case FundManagerCellValueStyleBule:
            detailTextColor = [UIColor colorWithHexString:@"#2aa0f2"];
            break;
        case FundManagerCellValueStyleBlack:
            detailTextColor = [UIColor blackColor];
            break;
        case FundManagerCellValueStyleGreen:
            detailTextColor = [UIColor colorWithHexString:@"82c369"];
            break;
    }
    _detailLabel.textColor = detailTextColor;
}

@end
