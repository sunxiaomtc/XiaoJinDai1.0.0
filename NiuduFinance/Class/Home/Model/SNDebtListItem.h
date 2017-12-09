//
//  SNDebtListItem.h
//  NiuduFinance
//
//  Created by BuJia on 17/2/17.
//  Copyright © 2017年 liuyong. All rights reserved.
//

#import "VZListItem.h"

@interface SNDebtListItem : VZListItem

@property (nonatomic, strong) NSString * title;             //  项目标题
@property (nonatomic, strong) NSNumber * owingnumber;       //  剩余期数
@property (nonatomic, strong) NSNumber * priceforsale;      //  购买价格
@property (nonatomic, strong) NSNumber * receivableamount;  //  未收本息
@property (nonatomic, strong) NSNumber * remainCount;       //  剩余可投份数
@property (nonatomic, strong) NSNumber * debtdealid;        //  项目编号
@property (nonatomic, strong) NSNumber * statusid;          //  1马上投资,其他“交易结束”
@property (nonatomic, strong) NSNumber * srrsy;             //  受让人收益率，保留小数2位
@property (nonatomic, strong) NSNumber * projectid;         //  项目编号

@property (nonatomic, strong) NSNumber * selleruserid;

@end
