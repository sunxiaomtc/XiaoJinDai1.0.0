//
//  SNDebtListModel.m
//  NiuduFinance
//
//  Created by BuJia on 17/2/17.
//  Copyright © 2017年 liuyong. All rights reserved.
//

#import "SNDebtListModel.h"

@implementation SNDebtListModel

- (NSDictionary *)dataParams
{
    /*
     start int 分页时记录读取索引,读取第一条start=0
     limit int 每页多少条记录
     */
    if (self.isHome) {
        return @{@"start" : @"0",
                 @"limit" : @"1"};
    } else {
        return @{@"start" : @(self.start ? : 0),
                 @"limit" : @"10"};
    }
}

- (NSString *)methodName
{
    return [__API_HEADER__ stringByAppendingString:@"v2/open/debt/list"];
}

- (BOOL)isPost
{
    return NO;
}

- (NSString *)customRequestClassName
{
    return @"WKHTTPRequest";
}

- (NSMutableArray *)responseObjects:(id)JSON
{
    if (!JSON || JSON == [NSNull null])
        return nil;
    
    NSMutableArray * list = [[NSMutableArray alloc] initWithCapacity:5];
    for (NSDictionary * dic in JSON) {
        SNDebtListItem * item = [SNDebtListItem new];
        [item autoKVCBinding:dic];
        
        [list addObject:item];
    }
    
    return list;
}

@end
