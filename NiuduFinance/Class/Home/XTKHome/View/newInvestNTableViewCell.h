//
//  newInvestNTableViewCell.h
//  NiuduFinance
//
//  Created by 沈益南 on 2017/10/23.
//  Copyright © 2017年 liuyong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface newInvestNTableViewCell : UITableViewCell
@property (nonatomic, strong) UIImageView * titleImage;
@property (nonatomic, strong) UILabel *titleLab;
@property (nonatomic, strong) UILabel *percentLab;
@property (nonatomic, strong) UILabel *addPercentLab;
@property (nonatomic, strong) UILabel *investBtn;
@property (nonatomic, strong) UIView * backgroundNView;
@property (nonatomic, strong) UIView *titleBackGroundView;

@end
