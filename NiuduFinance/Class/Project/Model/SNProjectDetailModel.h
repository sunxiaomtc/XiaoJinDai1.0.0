//
//  SNProjectDetailModel.h
//  NiuduFinance
//
//  Created by ponta on 2017/2/18.
//  Copyright © 2017年 liuyong. All rights reserved.
//

#import "VZHTTPModel.h"

@interface SNProjectDetailItem : VZListItem

@property (nonatomic, strong) NSString * title;
@property (nonatomic, strong) NSNumber * rate;
@property (nonatomic, strong) NSNumber * loanperiod;
@property (nonatomic, strong) NSString * periodtypeidName;   //  期限单位，天，个月，年
@property (nonatomic, strong) NSNumber * minbidamount;
@property (nonatomic, strong) NSNumber * remainamount;
@property (nonatomic, strong) NSNumber * amount;
@property (nonatomic, strong) NSNumber * process;
@property (nonatomic, strong) NSString * projectintroduce;    //  项目介绍
@property (nonatomic, strong) NSString * enterpriseintroduce; //  借款企业介绍
@property (nonatomic, strong) NSString * riskmanagement;      //  风控保障
@property (nonatomic, strong) NSNumber * statusid;  //  1进行中（立即投资）,2待审核,3还款中,4还款结束,-10000不是新手，-1未开始
@property (nonatomic, strong) NSNumber * collectDate;
@end

@interface SNProjectDetailModel : VZHTTPModel

@property (nonatomic, strong) NSString * projectId;

@property (nonatomic, strong) SNProjectDetailItem * detailItem;

@end
