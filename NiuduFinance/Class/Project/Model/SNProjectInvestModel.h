//
//  SNProjectInvestModel.h
//  NiuduFinance
//
//  Created by ponta on 2017/2/18.
//  Copyright © 2017年 liuyong. All rights reserved.
//

#import "VZHTTPModel.h"

@interface SNProjectInvestModel : VZHTTPModel

@property (nonatomic, strong) NSNumber * projectId;
@property (nonatomic, strong) NSString * amount;
@property (nonatomic, strong) NSString * sendId;


@property (nonatomic, strong) NSNumber * debtDealId;
@property (nonatomic, assign) NSInteger quantity;    //  购买数量


//  返回的数据
@property (nonatomic, strong) NSString * form;

@end
