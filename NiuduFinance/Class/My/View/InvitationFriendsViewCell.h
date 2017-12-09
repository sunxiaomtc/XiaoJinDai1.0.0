//
//  InvitationFriendsViewCell.h
//  NiuduFinance
//
//  Created by 123 on 17/3/20.
//  Copyright © 2017年 liuyong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface InvitationFriendsViewCell : UITableViewCell
@property (nonatomic,strong)UILabel * phone;
@property (nonatomic,strong)UILabel * time;
@property (nonatomic,strong)UILabel * amount;
@property (nonatomic,strong)UILabel * reward;
@property (nonatomic,strong)NSDictionary * myRewardDic;
- (void)setMyRewardDic:(NSDictionary *)myRewardDic;

@end
