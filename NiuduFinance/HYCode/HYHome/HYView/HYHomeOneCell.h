//
//  HYHomeOneCell.h
//  NiuduFinance
//
//  Created by Apple on 2017/12/9.
//  Copyright © 2017年 liuyong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HYHomeOneCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *xszxLabel;
@property (weak, nonatomic) IBOutlet UIButton *buyBtn;
@property (weak, nonatomic) IBOutlet UIView *bgView;
@property (weak, nonatomic) IBOutlet UILabel *bfbLabel;

@property (nonatomic, copy) void(^buyBlock)();

@end
