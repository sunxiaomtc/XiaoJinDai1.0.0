//
//  CJTNaSearchView.m
//  CloneFactoryApp
//
//  Created by 小吊丝 on 16/6/13.
//  Copyright © 2016年 CSCHS. All rights reserved.
//

#import "RequestService.h"
#import <AFNetworking/AFNetworking.h>
#define TimeOut 60

@implementation RequestService

+(instancetype)defaultRequstService {
    static RequestService *_instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[RequestService alloc] init];
    });
    return _instance;
}

//异步get请求
-(void)asyncGetDataWithURL:(NSString *)requestURL
                  paramDic:(NSMutableDictionary *)paramDic
          responseDicBlock:(void (^)(BOOL success ,NSString *code , NSString *hint , NSDictionary *list,NSDictionary *resultDic))responseDic
                errorBlock:(void(^)(NSError *errorMessage))errorMessage{
    NSString *currentRequestURL;
    currentRequestURL = [__API_HEADER__ stringByAppendingString:requestURL];
//    currentRequestURL = [@"" stringByAppendingString:requestURL];
    if (!paramDic) {
        paramDic = [NSMutableDictionary dictionary];
    }
    if (paramDic && [[paramDic allKeys] count]>0) {
        currentRequestURL = [currentRequestURL stringByAppendingString:@"?"];
        /*遍历出要传的字段*/
        for (int i =0; i<[paramDic allKeys].count; i++) {
            NSString *currentKey = [[paramDic allKeys] objectAtIndex:i];
            NSString *currentValue = [paramDic objectForKey:currentKey];
            NSString *currentKeyAndValue = @"";
            if (i<[paramDic allKeys].count-1) {
                currentKeyAndValue = [currentKey stringByAppendingString:[NSString stringWithFormat:@"=%@&",currentValue]];
            }else{
                currentKeyAndValue = [currentKey stringByAppendingString:[NSString stringWithFormat:@"=%@",currentValue]];
            }
            currentRequestURL =[currentRequestURL stringByAppendingString:currentKeyAndValue];
        }
    }/*for 循环遍历结束 拼接最终的URL字符串结束*/
    currentRequestURL = [currentRequestURL stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];/*对URL进行编码*/
    NSLog(@"当前传入URL数据:%@",currentRequestURL);
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer.timeoutInterval = TimeOut;
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager.requestSerializer setValue:@"application/json;charset=utf-8" forHTTPHeaderField:@"Content-Type"];
//    [manager.requestSerializer setValue:kAPPDELEGATE.token forHTTPHeaderField:@"token"];
    
    [manager GET:currentRequestURL parameters:paramDic progress:^(NSProgress * _Nonnull downloadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSMutableDictionary *resultDic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil];
        NSString *codeStr = [resultDic objectForKey:@"code"];
        
        BOOL succeed = false;
        if (codeStr.integerValue == 40000) {
            succeed = YES;
        }
        NSString *msgStr = [resultDic objectForKey:@"hint"];
        NSDictionary *listDic = [resultDic objectForKey:@"list"];
        NSLog(@"get请求结果code:%@\n hint:%@",codeStr,msgStr);
        responseDic(succeed,codeStr,msgStr,listDic,resultDic);
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        errorMessage(error);
//        ShowMsg(@"加载失败,请检查网络后重试");
    }];
}

//异步post请求
-(void)asyncPostDataWithURL:(NSString *)requestURL
                   paramDic:(NSMutableDictionary *)paramDic
           responseDicBlock:(void(^)(BOOL success ,NSString *code , NSString *hint , NSDictionary *list,NSDictionary *resultDic))responseDic
                 errorBlock:(void(^)(NSError *errorMessage))errorMessage{
    NSString * currentRequestURL;
    currentRequestURL = [__API_HEADER__ stringByAppendingString:requestURL];
    //currentRequestURL = [@"" stringByAppendingString:requestURL];
    if (!paramDic) {
        paramDic = [NSMutableDictionary dictionary];
    }
    
    NSLog(@"当前传入URL数据:%@/%@",currentRequestURL,paramDic);
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
//    manager.requestSerializer = [AFJSONRequestSerializer serializer];
//    [manager.requestSerializer setValue:@"application/json;charset=utf-8" forHTTPHeaderField:@"Content-Type"];
////    [manager.requestSerializer setValue:kAPPDELEGATE.token forHTTPHeaderField:@"token"];
//    NSMutableArray *currentSet = [[manager.responseSerializer.acceptableContentTypes allObjects] mutableCopy];
//    [currentSet addObject:@"text/html"];
//    manager.responseSerializer.acceptableContentTypes = [NSSet setWithArray:currentSet];
    
    
    
    [manager POST:currentRequestURL parameters:paramDic progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"responseObject=====%@", responseObject);
        
        //NSMutableDictionary *resultDic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil];
        
        NSLog(@"成功");
        
        /*
        NSString *codeStr = [resultDic objectForKey:@"code"];
        BOOL succeed = false;
        if (codeStr.integerValue == 40000) {
            succeed = YES;
        }
        NSString *msgStr = [resultDic objectForKey:@"hint"];
        NSDictionary *listDic = [resultDic objectForKey:@"list"];
        NSLog(@"post请求结果code:%@\n hint:%@",codeStr,msgStr);
        responseDic(succeed,codeStr,msgStr,listDic,resultDic);
        */
        NSData *data=[NSJSONSerialization dataWithJSONObject:responseObject options:NSJSONWritingPrettyPrinted error:nil];
        NSString *jsonStr=[[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
        NSLog(@"jsonStr==%@",jsonStr);
        
        responseDic(@"",jsonStr,@"",responseObject,responseObject);
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        errorMessage(error);
        
        NSLog(@"请求接口失败");
        
    }];
}



@end
