//
//  MyCreditoNewCell.h
//  NiuduFinance
//
//  Created by 123 on 17/2/18.
//  Copyright © 2017年 liuyong. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSInteger, CreditorStat){
    CreditorStateCanTransfe,
    CreditorStateRefundin,
    CreditorStateHistor
};
@class MyCreditoNewCell;
@protocol MyCreditorNewCellDelegate <NSObject>

- (void)creditorInvestAction:(MyCreditoNewCell *)cell;

@end

@interface MyCreditoNewCell : UITableViewCell
@property (assign, nonatomic,readonly) CreditorStat creditorStat;
@property (weak, nonatomic) id<MyCreditorNewCellDelegate> delegate;
//协议
@property (nonatomic,strong)UILabel * agreementLabel;
@property (nonatomic,strong) UILabel *creditorInvestLabel;

- (void)creditorState:(CreditorStat)state model:(NSDictionary *)modelDic;
@end
