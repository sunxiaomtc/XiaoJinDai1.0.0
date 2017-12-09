//
//  ReflectUtil.m
//  AFNetworkingTest
//
//  Created by book on 14-9-2.
//  Copyright (c) 2014年 vi_chen. All rights reserved.
//

#import "ReflectUtil.h"
#import <objc/runtime.h>
@implementation ReflectUtil
+ (NSArray*)propertyKeysWithClassName:(Class)clazz

{
    
    unsigned int outCount, i;
    
    objc_property_t *properties = class_copyPropertyList(clazz, &outCount);
    
    NSMutableArray *keys = [[NSMutableArray alloc] initWithCapacity:outCount];
    
    for (i = 0; i < outCount; i++) {
        
        objc_property_t property = properties[i];
        
        NSString *propertyName = [[NSString alloc] initWithCString:property_getName(property) encoding:NSUTF8StringEncoding];
       
        [keys addObject:propertyName];
        
    }
    
    free(properties);
    return keys;
}


+ (id)reflectDataWithClassName:(NSString *) calssName otherObject:(NSObject*)dataSource {
   
    Class class = NSClassFromString(calssName);
    id obj = [[class alloc]init];
    BOOL ret = NO;
    
    for (NSString *key in [self propertyKeysWithClassName:class]) {
        
        NSString *conventStr = [NSString stringWithString:key];
        NSString *firstStr = [[key substringWithRange:NSMakeRange(0, 1)] uppercaseString];
        conventStr = [conventStr stringByReplacingCharactersInRange:NSMakeRange(0, 1) withString:firstStr];
        
        if ([dataSource isKindOfClass:[NSDictionary class]])
        {
            
            ret = ([dataSource valueForKey:conventStr]==nil)?NO:YES;
        }
        else
        {
            ret = [dataSource respondsToSelector:NSSelectorFromString(conventStr)];
        }
        
        if (ret)
        {
            id propertyValue = [dataSource valueForKey:conventStr];
           
            //该值不为NSNULL，并且也不为nil
            if (![propertyValue isKindOfClass:[NSNull class]] && propertyValue!=nil)
            {
                [obj setValue:propertyValue forKey:key];
            }
        }
    }
    //return ret;
    return obj;
    
}

+ (id)reflectDataWithClassName:(NSString *) calssName otherObject:(NSObject*)dataSource isList:(BOOL)isList{
    if(!isList)
        return [self reflectDataWithClassName:calssName otherObject:dataSource];
    NSMutableArray *arr = [[NSMutableArray alloc]init];
    NSArray *tempArr = (NSArray*)dataSource;
    for (NSObject *key in tempArr) {
        [arr addObject:[self reflectDataWithClassName:calssName otherObject:key]];
    }
    return arr;
}
@end
