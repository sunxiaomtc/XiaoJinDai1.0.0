//
//  homeBullSharingCell.h
//  NiuduFinance
//
//  Created by 邢天阔 on 2017/9/28.
//  Copyright © 2017年 liuyong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface homeBullSharingCell : UITableViewCell
/**标的名称
 */
@property (weak, nonatomic) IBOutlet UILabel *scaleNameLabel;

@property (nonatomic, copy) NSDictionary *experienceDic;
@end
