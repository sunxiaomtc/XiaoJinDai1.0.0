//
//  SNProjectListModel.m
//  NiuduFinance
//
//  Created by BuJia on 17/2/15.
//  Copyright © 2017年 liuyong. All rights reserved.
//

#import "SNProjectListModel.h"

@implementation SNProjectListModel

- (NSDictionary *)dataParams
{
    /*
     start int 分页时记录读取索引,读取第一条start=0
     limit int 每页多少条记录
     isNewLender int 1新手标（新手共享区）,0为散标
     */
    if (self.isHome) {
        return @{@"start" : @"0",
                 @"limit" : @"5",
                 @"isNewLender" : self.isNewLender ? @(1) : @(0),
                 @"isAvailable":@(self.avative)
                 };
    } else {
        return @{@"start" : @(self.start ? : 0),
                 @"limit" : @"10",
                 @"isNewLender" : self.isNewLender ? @(1) : @(0),
                 @"isAvailable":@(self.avative)
                 };
    }
}

- (NSString *)methodName
{
    return [__API_HEADER__ stringByAppendingString:@"v2/open/project/list"];
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
        SNProjectListItem * item = [SNProjectListItem new];
        [item autoKVCBinding:dic];
        
        [list addObject:item];
    }
    
    return list;
}

@end
