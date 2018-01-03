//
//  HYPDOneCell.h
//  NiuduFinance
//
//  Created by Apple on 2018/1/3.
//  Copyright © 2018年 liuyong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SNProjectListItem.h"

@interface HYPDOneCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *pointLabel1;
@property (weak, nonatomic) IBOutlet UILabel *pointLabel2;
@property (weak, nonatomic) IBOutlet UILabel *pointLabel3;
@property (weak, nonatomic) IBOutlet UILabel *lineLabel1;
@property (weak, nonatomic) IBOutlet UILabel *lineLabel2;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel1;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel2;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel3;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;

@property (nonatomic, strong) SNProjectListItem *models;

@end
