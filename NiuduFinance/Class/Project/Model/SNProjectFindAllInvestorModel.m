//
//  SNProjectFindAllInvestorModel.m
//  NiuduFinance
//
//  Created by ponta on 2017/2/20.
//  Copyright © 2017年 liuyong. All rights reserved.
//

#import "SNProjectFindAllInvestorModel.h"

@implementation SNProjectFindAllInvestorModel

- (NSDictionary *)dataParams
{
    if (self.projectId) {
        return @{@"projectId" : self.projectId ? : @""};
    } else {
        return @{@"debtDealId" : self.debtDealId ? @([self.debtDealId integerValue]) : @""};
    }
}

- (BOOL)isPost
{
    return YES;
}

- (NSString *)customRequestClassName
{
    return @"WKHTTPRequest";
}

- (NSString *)methodName
{
    if (self.projectId) {
        return [__API_HEADER__ stringByAppendingString:@"v2/accept/project/findAllInvestor"];
    } else {
        return [__API_HEADER__ stringByAppendingString:@"v2/accept/debt/findAllInvestor"];
    }
}

- (BOOL)parseResponse:(id)JSON
{
    if (JSON && [JSON isKindOfClass:[NSArray class]]) {
        self.listArray = JSON;
    }
    
    return YES;
}

@end
