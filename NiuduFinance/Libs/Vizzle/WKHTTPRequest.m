//
//  WKHTTPRequest.m
//  BX
//
//  Created by moxin on 15/3/30.
//  Copyright (c) 2015年 VizLab. All rights reserved.
//

#import "WKHTTPRequest.h"

@implementation WKHTTPRequest

- (void)requestDidFinish:(id)JSON
{
    NSNumber * code = JSON[@"msgType"];  //  0表示正常,1表示未登陆，2表示服务器处理逻辑异常
   
    if ((code.integerValue == 0 || code.integerValue == 1) && [JSON[@"success"] boolValue]) {
        
        id result = JSON[@"data"];
        
        if ([self.delegate respondsToSelector:@selector(requestDidFinish:)]) {
            [self.delegate requestDidFinish:result];
        }
    } else {
        NSError * error = [NSError errorWithDomain:@"WKHTTPError" code:[code integerValue] userInfo:@{NSLocalizedDescriptionKey : JSON[@"data"] ? : @"无结果"}];
        
        if ([self.delegate respondsToSelector:@selector(requestDidFailWithError:)]) {
            [self.delegate requestDidFailWithError:error];
        }
    }
}

@end
