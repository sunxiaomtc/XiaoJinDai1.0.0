//
//  HYPDHeaderView.h
//  NiuduFinance
//
//  Created by Apple on 2018/1/3.
//  Copyright © 2018年 liuyong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HYJDTCustomView.h"
#import "SNProjectListItem.h"
@interface HYPDHeaderView : UIView

@property (nonatomic, strong) HYJDTCustomView *customView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *titleTopLayout;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *btnTopLayout;
@property (weak, nonatomic) IBOutlet UILabel *bfbLabel;
@property (weak, nonatomic) IBOutlet UILabel *addLabel;
@property (weak, nonatomic) IBOutlet UILabel *allPriceLabel;
@property (weak, nonatomic) IBOutlet UILabel *dayLabel;
@property (weak, nonatomic) IBOutlet UILabel *syPriceLabel;

@property (nonatomic, strong) UIViewController *superViewController;

@property (nonatomic, strong) SNProjectListItem *models;


@end
