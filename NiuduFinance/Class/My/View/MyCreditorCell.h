//
//  MyCreditorCell.h
//  NiuduFinance
//
//  Created by zhoupushan on 16/3/10.
//  Copyright © 2016年 liuyong. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSInteger, CreditorState){
    CreditorStateCanTransfer,
    CreditorStateRefunding,
    CreditorStateHistory
};
@class MyCreditorCell;
@protocol MyCreditorCellDelegate <NSObject>

- (void)creditorInvestAction:(MyCreditorCell *)cell;

@end

@interface MyCreditorCell : UITableViewCell
@property (assign, nonatomic,readonly) CreditorState creditorState;
@property (weak, nonatomic) id<MyCreditorCellDelegate> delegate;
//剩余本息
@property (weak, nonatomic) IBOutlet UILabel *bottomLeftLabel;
//按钮
@property (weak, nonatomic) IBOutlet UIButton *creditorInvestButton;// 转让 撤回
- (void)creditorState:(CreditorState)state model:(NSDictionary *)modelDic;
@end
