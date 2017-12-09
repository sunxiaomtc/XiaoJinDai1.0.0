//
//  MyNewModel.h
//  NiuduFinance
//
//  Created by 小吊丝 on 2017/9/29.
//  Copyright © 2017年 liuyong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MyNewDataModel.h"

@interface MyNewModel : NSObject

@property(nonatomic, copy)NSString *expireFundAmount;
@property(nonatomic, copy)NSString *fundIncome;
@property(nonatomic, copy)NSString *incomedInterest;
@property(nonatomic, copy)NSString *fundInvest;
@property(nonatomic, copy)NSString *fundInvestTotal;
@property(nonatomic, copy)NSString *cooperationReward;
@property(nonatomic, copy)NSString *welfareFund;
@property(nonatomic, copy)NSString *isNewer;
@property(nonatomic, copy)NSString *frozen;
@property(nonatomic, copy)NSString *bounsAmount;
@property(nonatomic, copy)NSString *balance;
@property(nonatomic, copy)NSString *debtReceivable;
@property(nonatomic, copy)NSString *receivableAmount;
@property(nonatomic, copy)NSString *fundReceivableInterest;
@property(nonatomic, copy)NSString *receivablePrincipal;
@property(nonatomic, copy)NSString *income;
@property(nonatomic, copy)NSString *mayUseBalance;
@property(nonatomic, copy)NSString *receivableInterest;

@property(nonatomic, strong)MyNewDataModel *user;
@property(nonatomic, strong)MyNewDataModel *receivableItem;
@property(nonatomic, strong)MyNewDataModel *userDetail;





@end
