//
//  HYHTTPTools.m
//  NiuduFinance
//
//  Created by Apple on 2017/12/12.
//  Copyright © 2017年 liuyong. All rights reserved.
//

#import "HYHTTPTools.h"
#import <AFNetworking.h>

static HYHTTPTools *_instance = nil;

@implementation HYHTTPTools

+(instancetype)allocWithZone:(struct _NSZone *)zone
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [super allocWithZone:zone];
    });
    return _instance;
}

+(instancetype)shareHTTPS
{
    if(_instance == nil)
    {
        _instance = [[super alloc] init];
    }
    return _instance;
}

-(id)copyWithZone:(NSZone *)zone
{
    return _instance;
}

-(id)mutableCopyWithZone:(NSZone *)zone
{
    return _instance;
}

-(void)getServerForAFNetWorkingURL:(NSString *)url success:(void (^)(id))success failed:(void (^)(NSError *))faild
{
    AFHTTPSessionManager *session = [AFHTTPSessionManager manager];
    session.responseSerializer =  [AFHTTPResponseSerializer serializer];
    [session GET:url parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        //成功
        success(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        faild(error);
    }];
}

-(void)postServerForAFNetWorkingURL:(NSString *)url parmer:(NSDictionary *)parmer success:(void (^)(id))seccess failed:(void (^)(NSError *))faild
{
    AFHTTPSessionManager *session = [AFHTTPSessionManager manager];
    session.responseSerializer =  [AFHTTPResponseSerializer serializer];
    [session POST:url parameters:parmer progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        //成功
        seccess(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        faild(error);
        NSLog(@"接口:%@ 请求失败: %@",url,error);
    }];
}

@end
