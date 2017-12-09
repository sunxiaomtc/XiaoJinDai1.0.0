//
//  MyAccountCell.h
//  NiuduFinance
//
//  Created by 123 on 17/8/2.
//  Copyright © 2017年 liuyong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyAccountCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *titileLabel;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

@property (nonatomic,strong)NSDictionary * myAccountDic;
- (void)setMyAccountDic:(NSDictionary *)myAccountDic;
@end
