//
//  NSObject+YYNet.m
//  pugongying
//
//  Created by wyy on 16/5/23.
//  Copyright © 2016年 WYY. All rights reserved.
//

#import "NSObject+YYNet.h"
#import "AFNetworking.h"
#import "JSONKit.h"

static AFHTTPSessionManager *manager;

static NSString *kappKey = kAppKey;
static NSString *accesstoken = @"";
static NSString *version = kVersion;
static NSString * os = kos ;

@implementation NSObject (YYNet)

+ (id)GET:(NSString *)urlStr parameters:(NSDictionary *)parameters progress:(void(^)(NSProgress * downloadProgress)) downLoadProgress completionHandler:(void(^)(id responseObject, NSError *error)) completionHandler{
    
    AFHTTPSessionManager *manager = [ZHHTTPSessionManager shareManager];
    
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html", @"application/json", @"text/json", @"text/javascript", @"text/plain", nil];
    //修改超时时间
    manager.requestSerializer.timeoutInterval = 30;
    
    return [manager GET:urlStr parameters:parameters progress:^(NSProgress * _Nonnull downloadProgress) {
        downLoadProgress(downloadProgress);
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        completionHandler(responseObject, nil);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        completionHandler(nil,error);
    }];
}

+ (id)POST:(NSString *)urlStr parameters:(NSDictionary *)parameters progress:(void(^)(NSProgress * downloadProgress)) upLoadProgress completionHandler:(void(^)(id responseObject, NSError *error)) completionHandler {
    
//    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
//    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
////
//    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
//    manager.requestSerializer.timeoutInterval = 30;
//    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html", @"application/json", @"text/json", @"text/javascript", @"text/plain", nil];
    
    AFHTTPSessionManager *manager = [ZHHTTPSessionManager shareManager];
    NSDictionary * parma = [self parameterDicWithDic:parameters];
    return [manager POST:urlStr parameters:parma progress:^(NSProgress * _Nonnull uploadProgress) {
        upLoadProgress(uploadProgress);
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSNumber *returnCode = responseObject[@"success"];
        if (returnCode.integerValue == 1) {

            completionHandler(responseObject, nil);
        }else {
            
            NSString *returnCode = responseObject[@"success"];
            NSString *returnMessage = responseObject[@"data"];
            NSMutableDictionary *userInfo = [NSMutableDictionary dictionary];
            if (returnMessage) {
                userInfo[ZHHTTPErrorMessage] = returnMessage;
            }
            NSError *error = [NSError errorWithDomain:@"0" code:returnCode.integerValue userInfo:userInfo];
            completionHandler(nil, error);
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        completionHandler(nil,error);
    }];
}

#pragma mark - private
- (NSDictionary *)parameterDicWithDic:(NSDictionary *)pamar {
    // 对传的参数进行处理
    NSMutableDictionary * dic = pamar?[NSMutableDictionary dictionaryWithDictionary:pamar]:[NSMutableDictionary dictionary];
    //     token
    if (accesstoken) {
        [dic setObject:accesstoken forKey:@"accesstoken"];
        NSLog(@"accesstoken-----%@",accesstoken);
    }
    // UserID
    NSInteger userId = [User shareUser].userId;
    if (userId) {
        [dic setObject:[NSString stringWithFormat:@"%ld",(long)userId] forKey:@"UserId"];
    }
    if (os) {
        [dic setObject:os forKey:@"os"];
    }
    if (version) {
        [dic setObject:version forKey:@"version"];
    }
    [dic setObject:@"2" forKey:@"Platform"];
    //     排序
    NSArray *keys = [self sortKeys:[dic allKeys]];
    // 生成加密参数
    NSMutableString *valueStr = [NSMutableString string];
    for (NSString *key in keys) {
        id obj = [dic objectForKey:key];
        NSString *str;
        if ([obj isKindOfClass:[NSString class]])// 字符串
        {
            str = (NSString *)obj;
        }
        else if ([obj isKindOfClass:[NSNumber class]]) // number
        {
            str = [obj stringValue];
        }
        else
        {
            str = [obj JSONString];
        }
        [valueStr appendFormat:@"%@|",str];
    }
    [valueStr appendString:kappKey];
    [dic setObject:[IOSmd5 md5:valueStr] forKey:@"Sign"];
    return dic;
}

- (NSArray *)sortKeys:(NSArray *)keys {
    keys = [keys sortedArrayUsingComparator:^NSComparisonResult(NSString*  _Nonnull obj1, NSString*  _Nonnull obj2)
            {
                NSComparisonResult result =  [obj1 compare:obj2 options:NSLiteralSearch];
                return result == NSOrderedDescending;
            }];
    return keys;
}
@end
