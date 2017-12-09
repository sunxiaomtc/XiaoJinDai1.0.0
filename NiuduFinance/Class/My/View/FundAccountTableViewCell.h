//
//  FundAccountTableViewCell.h
//  NiuduFinance
//
//  Created by liuyong on 16/3/14.
//  Copyright © 2016年 liuyong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FundAccountTableViewCell : UITableViewCell
//获取通道
@property (weak, nonatomic) IBOutlet UILabel *fundAccountLab;
//金额
@property (weak, nonatomic) IBOutlet UILabel *fundAmountLab;
//日期
@property (weak, nonatomic) IBOutlet UILabel *fundDataLab;
//
@property (weak, nonatomic) IBOutlet UIImageView *funImage;

@property (nonatomic,strong)NSDictionary *fundAccountDic;
- (void)setFundAccountDic:(NSDictionary *)fundAccountDic;
@end
