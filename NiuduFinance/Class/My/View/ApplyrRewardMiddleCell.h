//
//  ApplyrRewardMiddleCell.h
//  NiuduFinance
//
//  Created by 123 on 17/3/22.
//  Copyright © 2017年 liuyong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ApplyrRewardMiddleCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *amount;
@property (nonatomic,strong)NSDictionary * myRmountDic;
- (void)setMyRmountDic:(NSDictionary *)myRmountDic;
@end
