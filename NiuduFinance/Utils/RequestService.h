//
//  CJTNaSearchView.h
//  CloneFactoryApp
//
//  Created by 小吊丝 on 16/6/13.
//  Copyright © 2016年 CSCHS. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RequestService : NSObject

+(instancetype)defaultRequstService;

-(void)asyncGetDataWithURL:(NSString *)requestURL
                  paramDic:(NSMutableDictionary *)paramDic
          responseDicBlock:(void (^)(BOOL success ,NSString *code , NSString *hint , NSDictionary *list,NSDictionary *resultDic))responseDic
                errorBlock:(void(^)(NSError *errorMessage))errorMessage;

-(void)asyncPostDataWithURL:(NSString *)requestURL
                   paramDic:(NSMutableDictionary *)paramDic
           responseDicBlock:(void(^)(BOOL success ,NSString *code , NSString *hint , NSDictionary *list,NSDictionary *resultDic))responseDic
                 errorBlock:(void(^)(NSError *errorMessage))errorMessage;


@end
