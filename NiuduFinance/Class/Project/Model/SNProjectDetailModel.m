//
//  SNProjectDetailModel.m
//  NiuduFinance
//
//  Created by ponta on 2017/2/18.
//  Copyright © 2017年 liuyong. All rights reserved.
//

#import "SNProjectDetailModel.h"

@implementation SNProjectDetailItem

- (void)autoKVCBinding:(NSDictionary *)dictionary
{
    [super autoKVCBinding:dictionary];
}

@end

@implementation SNProjectDetailModel

- (NSDictionary *)dataParams
{
    return @{@"projectId" : self.projectId ? : @""};
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
    return [__API_HEADER__ stringByAppendingString:@"v2/accept/project/find"];
}

- (BOOL)parseResponse:(id)JSON
{
    if (JSON && [JSON isKindOfClass:[NSDictionary class]]) {
        _detailItem = [SNProjectDetailItem new];
        [_detailItem autoKVCBinding:JSON];
    }
    
    return YES;
}

@end
