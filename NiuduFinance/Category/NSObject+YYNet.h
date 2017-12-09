//
//  NSObject+YYNet.h
//  pugongying
//
//  Created by wyy on 16/5/23.
//  Copyright © 2016年 WYY. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZHHTTPSessionManager.h"


@interface NSObject (YYNet)
/**
 *  get请求
 */
+ (id)GET:(NSString *)urlStr parameters:(NSDictionary *)parameters progress:(void(^)(NSProgress * downloadProgress)) downLoadProgress completionHandler:(void(^)(id responseObject, NSError *error)) completionHandler;
/**
 *  post请求
 */
+ (id)POST:(NSString *)urlStr parameters:(NSDictionary *)parameters progress:(void(^)(NSProgress * downloadProgress)) upLoadProgress completionHandler:(void(^)(id responseObject, NSError *error)) completionHandler;

+ (void)uploadImage:(UIImage *)image progress:(void (^)(CGFloat downloadProgress))downLoadProgress completionHandler:(void (^)(NSString *imagePath, NSError *error))completionHandler;

@end
