//
//  ShareProjectCell.h
//  NiuduFinance
//
//  Created by 123 on 17/7/27.
//  Copyright © 2017年 liuyong. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSInteger,ShareProjectStat)
{
    ShareProjectStatRufunding,
    ShareProjectStatBidding,
    ShareProjectStatHistory
};
@class ShareProjectStatViewCell;
@protocol ShareProjectCellDelegate <NSObject>

@end
@interface ShareProjectCell : UITableViewCell
//协议
@property (weak, nonatomic) IBOutlet UIButton *xieYiBtn;
@property (weak, nonatomic) id<ShareProjectCellDelegate> delegate;
-(void)creditorState:(ShareProjectStat)state model:(NSDictionary *)modeIDic;
@end
