//
//  SNDebtDetailModel.m
//  NiuduFinance
//
//  Created by ponta on 2017/2/21.
//  Copyright © 2017年 liuyong. All rights reserved.
//

#import "SNDebtDetailModel.h"

@implementation SNDebtDetailItem

- (void)autoKVCBinding:(NSDictionary *)dictionary
{
    [super autoKVCBinding:dictionary];
    
    _amount = [NSString stringWithFormat:@"%.2f", [dictionary[@"amount"] floatValue]];   //  待收本息,保留小数2位
    _remainamount = [NSString stringWithFormat:@"%@", dictionary[@"remainamount"]];        //  剩余可买
    _process = [NSString stringWithFormat:@"%@", dictionary[@"process"]];           //  投资进度
    _owingnumber = [NSString stringWithFormat:@"%@", dictionary[@"owingnumber"]];        //  剩余期数
    _srrsy = [NSString stringWithFormat:@"%.2f", [dictionary[@"srrsy"] floatValue]]; //  受让人收益率,保留小数2位
    _statusid = [NSString stringWithFormat:@"%@", dictionary[@"statusid"]];        //  1立即投资，10000自已债权，4交易结束，5交易结束
    _share = [NSString stringWithFormat:@"%.2f", [dictionary[@"share"] floatValue]];   //  每份多少钱,保留小数2位
    _projectId = [NSString stringWithFormat:@"%@", dictionary[@"projectid"]];        //  对应的投资项目编号
    _debtDealId = [NSString stringWithFormat:@"%@", dictionary[@"debtdealid"]];;      //  债权项目编号
    _mincopies = [NSString stringWithFormat:@"%@", dictionary[@"mincopies"]];   //  最低投资份数
}

@end


@implementation SNDebtDetailModel

- (NSDictionary *)dataParams
{
    return @{@"debtDealId" : self.debtDealID ? : @""};
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
    return [__API_HEADER__ stringByAppendingString:@"v2/accept/debt/find"];
}

- (BOOL)parseResponse:(id)JSON
{
    if (JSON && [JSON isKindOfClass:[NSDictionary class]]) {
        _detailItem = [SNDebtDetailItem new];
        [_detailItem autoKVCBinding:JSON];
    }
    
    return YES;
}

@end
