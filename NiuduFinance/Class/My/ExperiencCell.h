//
//  ExperiencCell.h
//  NiuduFinance
//
//  Created by 123 on 17/3/29.
//  Copyright © 2017年 liuyong. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface ExperiencCell : UITableViewCell

- (void)setuptitle:(NSString *)title tulabel:(NSString *)tulabel imgeView:(BOOL)imgeView castLabel:(NSString *)castLabel lineView:(BOOL)lineView annual:(NSString *)annual annualNum:(NSString *)annualNum percent:(NSString *)percent timeLimit:(NSString *)timeLimit timeLimitNum:(NSString *)timeLimitNum timeLabel:(NSString *)timeLabel touLabl:(NSString *)touLabl remain:(NSString *)remain progressLabel:(NSString *)progressLabel;
@end
