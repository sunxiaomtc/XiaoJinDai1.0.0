//
//  SNProjectImagesModel.m
//  NiuduFinance
//
//  Created by ponta on 2017/2/20.
//  Copyright © 2017年 liuyong. All rights reserved.
//

#import "SNProjectImagesModel.h"

@implementation SNProjectImagesModel

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
    return [__API_HEADER__ stringByAppendingString:@"v2/accept/project/getImages"];
}

- (BOOL)parseResponse:(id)JSON
{
    if (JSON && [JSON isKindOfClass:[NSArray class]]) {
        self.imagesArray = JSON;
    }
    
    return YES;
}

@end
