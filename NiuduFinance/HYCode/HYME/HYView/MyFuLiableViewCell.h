//
//  MyFuLiableViewCell.h
//  NiuduFinance
//
//  Created by 123 on 17/8/3.
//  Copyright © 2017年 liuyong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyFuLiableViewCell : UITableViewCell



@property (weak, nonatomic) IBOutlet UILabel *moneyNumLabel;
@property (weak, nonatomic) IBOutlet UIImageView *bgImage;
@property (weak, nonatomic) IBOutlet UILabel *qtqxLabel;
@property (weak, nonatomic) IBOutlet UILabel *qtjeLabel;
@property (weak, nonatomic) IBOutlet UILabel *lyLabel;
@property (weak, nonatomic) IBOutlet UILabel *yxqLabel;
@property (weak, nonatomic) IBOutlet UILabel *syLabel;
@property (weak, nonatomic) IBOutlet UILabel *jxqLabel;
@property (weak, nonatomic) IBOutlet UILabel *bfhLabel;


@property (nonatomic,strong)NSDictionary * myFuLiDic;
@property (nonatomic,assign)NSInteger  status;
- (void)setMyFuLiDic:(NSDictionary *)myFuLiDic withStatus:(int)status;
@end
