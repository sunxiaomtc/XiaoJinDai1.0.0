//
//  SNProjectInvestModel.m
//  NiuduFinance
//
//  Created by ponta on 2017/2/18.
//  Copyright © 2017年 liuyong. All rights reserved.
//

#import "SNProjectInvestModel.h"

@implementation SNProjectInvestModel

- (NSDictionary *)dataParams
{
    if (self.projectId) {
        return @{@"projectId" : self.projectId ? : @"",
                 @"amount" : self.amount ? : @"",
                 @"sendId" : self.sendId ? : @""};
    } else {
        return @{@"debtDealId" : self.debtDealId ? : @"",
                 @"quantity" : self.quantity ? @(self.quantity) : @""};
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
        return [__API_HEADER__ stringByAppendingString:@"v2/accept/project/invest"];
    } else {
        return [__API_HEADER__ stringByAppendingString:@"v2/accept/debt/invest"];
    }
}

- (BOOL)parseResponse:(id)JSON
{
    if (JSON && [JSON isKindOfClass:[NSString class]]) {
        _form = JSON;
    }
    
    return YES;
}

@end
