//
//  HYTZJLOneCell.h
//  NiuduFinance
//
//  Created by Apple on 2018/1/4.
//  Copyright © 2018年 liuyong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HYTZJLOneCell : UITableViewCell

+(instancetype)hyTZJLOneCellForTableView:(UITableView *)tableView;

@property (nonatomic, weak) UIImageView *pmImage;

@property (nonatomic, weak) UILabel *nameLabel;

@property (nonatomic, weak) UILabel *priceLabel;

@property (nonatomic, weak) UILabel *dateLabel;

@property (nonatomic, weak) UILabel *timeLabel;

@property (nonatomic, strong) NSDictionary *dic;

@property (nonatomic, strong) NSIndexPath *indexPath;

@end
