//
//  SNProjectListItem.h
//  NiuduFinance
//
//  Created by BuJia on 17/2/15.
//  Copyright © 2017年 liuyong. All rights reserved.
//

#import "VZListItem.h"

@interface SNProjectListItem : VZListItem

@property (nonatomic, strong) NSString * title;         //  项目标题
@property (nonatomic, strong) NSNumber * rate;          //  年化率，保留小数点后2位
@property (nonatomic, strong) NSNumber * loanperiod;    //  投资期限
@property (nonatomic, strong) NSNumber * minbidamount;  //  起投金额
@property (nonatomic, strong) NSNumber * statusid;      //  1进行中（立即投资）,2待审核,3还款中,4还款结束，5.未开始
@property (nonatomic, strong) NSNumber * projectId;     //  项目编号
@property (nonatomic, strong) NSNumber * remainamount;  //  剩余可投金额
@property (nonatomic, strong) NSNumber * funding;       //  已投标金额
@property (nonatomic, strong) NSNumber * amount;        //  借款金额，标的金额
@property (nonatomic, strong) NSNumber * process;       //  投资进度，已投金额比例

@property (nonatomic, strong) NSNumber * activityid;
@property (nonatomic, strong) NSNumber * approvaladminuserid;
@property (nonatomic, strong) NSNumber * approvaldate;
@property (nonatomic, strong) NSNumber * collectDate; //募集期截止时间

@property (nonatomic, strong) NSString * auditdata;
@property (nonatomic, strong) NSNumber * bids;
@property (nonatomic, strong) NSNumber * bidstartdate;
@property (nonatomic, strong) NSNumber * borrowerid;
@property (nonatomic, strong) NSNumber * cooperationdescription;
@property (nonatomic, strong) NSNumber * creationdate;
@property (nonatomic, strong) NSString * description;
@property (nonatomic, strong) NSNumber * enterpriseintroduce;
@property (nonatomic, strong) NSNumber * iscooperationshow;
@property (nonatomic, strong) NSNumber * isdraw;
@property (nonatomic, strong) NSNumber * isnewlender;
@property (nonatomic, strong) NSNumber * isriskmanagement;
@property (nonatomic, strong) NSString * loansecurity;
@property (nonatomic, strong) NSNumber * loantypeid;
@property (nonatomic, strong) NSNumber * loanuseid;
@property (nonatomic, strong) NSNumber * maxbidamount;
@property (nonatomic, strong) NSNumber * paymentinstructions;
@property (nonatomic, strong) NSNumber * paymentsource;
@property (nonatomic, strong) NSNumber * periodtypeid;
@property (nonatomic, strong) NSString * periodtypeidName;
@property (nonatomic, strong) NSNumber * poundage;

@property (nonatomic, strong) NSNumber * projectamount;
@property (nonatomic, strong) NSNumber * projectcategoryid;
@property (nonatomic, strong) NSNumber * projectduration;
@property (nonatomic, strong) NSNumber * projectenddate;
@property (nonatomic, strong) NSNumber * projectintroduce;
@property (nonatomic, strong) NSNumber * releaseduserid;
@property (nonatomic, strong) NSNumber * repaymenttypeid;
@property (nonatomic, strong) NSString * riskmanagement;
@property (nonatomic, strong) NSNumber * securityguarantee;

@property (nonatomic, strong) NSNumber *addRate;
@end
