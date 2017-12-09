//
//  XSNHomeProjecCell.h
//  NiuduFinance
//
//  Created by 123 on 17/7/14.
//  Copyright © 2017年 liuyong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SNProjectListItem.h"

@interface XSNHomeProjecCell : UITableViewCell
@property (nonatomic, strong) UIButton * statusButton;
@property (nonatomic, strong) UIButton * bottomButton;
@property (nonatomic, copy) NSString *addRate;
@property (nonatomic, strong) SNProjectListItem * item;

@property (nonatomic , assign) NSUInteger  type;
@end
