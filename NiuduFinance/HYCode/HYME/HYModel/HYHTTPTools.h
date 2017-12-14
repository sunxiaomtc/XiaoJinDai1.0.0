//
//  HYHTTPTools.h
//  NiuduFinance
//
//  Created by Apple on 2017/12/12.
//  Copyright © 2017年 liuyong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HYHTTPTools : NSObject<NSCopying,NSMutableCopying>

+(instancetype)shareHTTPS;

-(void)getServerForAFNetWorkingURL:(NSString *)url success:(void(^)(id responeseObj))success failed:(void(^)(NSError *error))faild;

-(void)postServerForAFNetWorkingURL:(NSString *)url parmer:(NSDictionary *)parmer success:(void(^)(id responeseObj))seccess failed:(void(^)(NSError *error))faild;

@end
