//
//  SNProjectFindAllInvestorModel.h
//  NiuduFinance
//
//  Created by ponta on 2017/2/20.
//  Copyright © 2017年 liuyong. All rights reserved.
//

#import "VZHTTPModel.h"

@interface SNProjectFindAllInvestorModel : VZHTTPModel

@property (nonatomic, strong) NSString * projectId;
@property (nonatomic, strong) NSString * debtDealId;

@property (nonatomic, strong) NSArray * listArray;

@end
