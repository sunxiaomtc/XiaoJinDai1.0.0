//
//  ApplyRewardTailCell.h
//  NiuduFinance
//
//  Created by 123 on 17/3/21.
//  Copyright © 2017年 liuyong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ApplyRewardTailCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *number;
@property (weak, nonatomic) IBOutlet UILabel *amount;
@property (nonatomic,strong)NSDictionary * myRmountDic;
- (void)setMyRmountDic:(NSDictionary *)myRmountDic;
@end
