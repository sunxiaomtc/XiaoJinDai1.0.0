//
//  AnnounTableViewCell.h
//  NiuduFinance
//
//  Created by 123 on 17/2/10.
//  Copyright © 2017年 liuyong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AnnounTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *titleName;
@property (weak, nonatomic) IBOutlet UILabel *titleDate;

- (void)setuptitle:(NSString *)titleName titleDate:(NSString *)titleDate;

@end
