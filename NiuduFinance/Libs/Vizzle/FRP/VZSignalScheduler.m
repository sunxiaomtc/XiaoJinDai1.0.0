//
//  VZSignalScheduler.m
//  VZAsyncTemplate
//
//  Created by moxin.xt on 15-2-3.
//  Copyright (c) 2015年 VizLab. All rights reserved.
//

#import "VZSignalScheduler.h"


@interface VZSignalImmediateScheduler:VZSignalScheduler

@end

@implementation VZSignalScheduler

- (VZSignalHandler *)schedule:(void (^)(void))block
{
    return nil;
}

@end

@implementation VZSignalImmediateScheduler


@end
