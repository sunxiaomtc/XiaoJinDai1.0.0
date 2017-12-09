//
//  SNHomeProjecCell.h
//  NiuduFinance
//
//  Created by BuJia on 17/2/15.
//  Copyright © 2017年 liuyong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SNProjectListItem.h"
#import "SNDebtListItem.h"

@interface SNHomeProjecCell : UITableViewCell

@property (nonatomic, strong) UIButton * statusButton;
@property (nonatomic, strong) UIButton * bottomButton;

@property (nonatomic, strong) SNProjectListItem * item;

@end
