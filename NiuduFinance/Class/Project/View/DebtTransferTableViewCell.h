//
//  DebtTransferTableViewCell.h
//  NiuduFinance
//
//  Created by liuyong on 16/2/26.
//  Copyright © 2016年 liuyong. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CircleAnimationView;
@class DebtModel;
@interface DebtTransferTableViewCell : UITableViewCell

//中建标题
@property (weak, nonatomic) IBOutlet UILabel *debtTitleLab;
//受让人年收益率
@property (weak, nonatomic) IBOutlet UILabel *debtRateLab;
//受让人收益率
@property (strong, nonatomic) IBOutlet UILabel *rateTitleLab;
//剩余期数
@property (weak, nonatomic) IBOutlet UILabel *owingnumberLab;

//购买价格
@property (weak, nonatomic) IBOutlet UILabel *priceforsaleLab;

//末收本息
@property (weak, nonatomic) IBOutlet UILabel *receivableamountLab;

@property (strong, nonatomic) IBOutlet UIButton *debtProtocolBtn;
//立即购买
@property (weak, nonatomic) IBOutlet UIButton *debtStateBtn;

@property (nonatomic, strong)DebtModel *debtModel;

@end
