//
//  RewardRetailsCell.h
//  NiuduFinance
//
//  Created by 123 on 17/3/22.
//  Copyright © 2017年 liuyong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RewardRetailsCell : UITableViewCell
@property (nonatomic, strong)UIView * lineOne;
@property (nonatomic, strong)UIView * lineTwo;
@property (nonatomic, strong)UIView * lineThree;

@property (nonatomic, strong)UILabel * friendsLabel;
@property (nonatomic, strong)UILabel * typeLabel;
@property (nonatomic, strong)UILabel * rewardLabel;
@property (nonatomic, strong)UILabel * noteLabel;
@property (nonatomic, strong)NSDictionary * myRewardDic;
@property (nonatomic, strong)NSString * isAssign;

- (void)setMyRewardDic:(NSDictionary *)myRewardDic;
@end
