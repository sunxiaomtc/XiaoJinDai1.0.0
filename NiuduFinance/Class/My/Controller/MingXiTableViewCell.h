//
//  MingXiTableViewCell.h
//  NiuduFinance
//
//  Created by 123 on 17/8/4.
//  Copyright © 2017年 liuyong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MingXiTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *imageVie;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *moneyLabel;

@property (nonatomic,strong)NSDictionary *fundAccountDic;
- (void)setFundAccountDic:(NSDictionary *)fundAccountDic;
@end
