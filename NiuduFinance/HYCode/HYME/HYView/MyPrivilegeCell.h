//
//  MyPrivilegeCell.h
//  NiuduFinance
//
//  Created by 123 on 17/8/3.
//  Copyright © 2017年 liuyong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyPrivilegeCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *moneyNumLabe;
@property (weak, nonatomic) IBOutlet UIImageView *bgImag;
@property (weak, nonatomic) IBOutlet UILabel *qtqxLabe;
@property (weak, nonatomic) IBOutlet UILabel *lyLabe;
@property (weak, nonatomic) IBOutlet UILabel *yxqLabe;
@property (weak, nonatomic) IBOutlet UILabel *syLabe;
@property (nonatomic,strong)NSDictionary * myPrivilegeDic;
@property (nonatomic,assign)NSInteger  status;
- (void)setMyPrivilegeDic:(NSDictionary *)myPrivilegeDic withStatus:(int)status;
@end
