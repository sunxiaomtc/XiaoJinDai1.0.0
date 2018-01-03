//
//  HYPDTwoCell.h
//  NiuduFinance
//
//  Created by Apple on 2018/1/3.
//  Copyright © 2018年 liuyong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SNProjectListItem.h"

@interface HYPDTwoCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *rightImage;
@property (weak, nonatomic) IBOutlet UILabel *detailsLabel;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@property (nonatomic, strong) SNProjectListItem *models;

@end
