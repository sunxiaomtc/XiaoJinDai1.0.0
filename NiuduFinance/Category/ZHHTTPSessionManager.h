//
//  ZHHTTPSessionManager.h
//  ZHPartnerHome
//
//  Created by wyy on 2017/3/20.
//  Copyright © 2017年 争辉科技. All rights reserved.
//

#import <AFNetworking/AFNetworking.h>

@interface ZHHTTPSessionManager : AFHTTPSessionManager
+(AFHTTPSessionManager *)shareManager;
@end
