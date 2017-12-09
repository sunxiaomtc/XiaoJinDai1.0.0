//
//  ZHHTTPSessionManager.m
//  ZHPartnerHome
//
//  Created by wyy on 2017/3/20.
//  Copyright © 2017年 争辉科技. All rights reserved.
//

#import "ZHHTTPSessionManager.h"

@implementation ZHHTTPSessionManager
+(AFHTTPSessionManager *)shareManager {
    static AFHTTPSessionManager *manager=nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [AFHTTPSessionManager manager];
        //        manager.requestSerializer = [AFJSONRequestSerializer serializer];
        //        manager.responseSerializer = [AFJSONResponseSerializer serializer];
    });
    
    return manager;
}
@end
