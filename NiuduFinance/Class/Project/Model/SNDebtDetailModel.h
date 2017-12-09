//
//  SNDebtDetailModel.h
//  NiuduFinance
//
//  Created by ponta on 2017/2/21.
//  Copyright © 2017年 liuyong. All rights reserved.
//

#import "VZHTTPModel.h"

@interface SNDebtDetailItem : VZListItem

@property (nonatomic, strong) NSString * amount;              //  待收本息,保留小数2位
@property (nonatomic, strong) NSString * remainamount;        //  剩余可买
@property (nonatomic, strong) NSString * process;             //  投资进度
@property (nonatomic, strong) NSString * owingnumber;         //  剩余期数
@property (nonatomic, strong) NSString * srrsy;               //  受让人收益率,保留小数2位
@property (nonatomic, strong) NSString * statusid;            //  1立即投资，10000自已债权，4交易结束，5交易结束
@property (nonatomic, strong) NSString * share;               //  每份多少钱,保留小数2位
@property (nonatomic, strong) NSString * projectId;           //  对应的投资项目编号
@property (nonatomic, strong) NSString * debtDealId;          //  债权项目编号
@property (nonatomic, strong) NSString * mincopies;           //  最低投资份数

@property (nonatomic, strong) NSString * title;               //  项目标题
@property (nonatomic, strong) NSString * periodtypeidName;    //  期数单位，天，个月，年
@property (nonatomic, strong) NSString * projectintroduce;    //  项目介绍
@property (nonatomic, strong) NSString * enterpriseintroduce; //  借款企业介绍
@property (nonatomic, strong) NSString * riskmanagement;      //  风控保障

@end


@interface SNDebtDetailModel : VZHTTPModel

@property (nonatomic, strong) NSString * debtDealID;

@property (nonatomic, strong) SNDebtDetailItem * detailItem;

@end
