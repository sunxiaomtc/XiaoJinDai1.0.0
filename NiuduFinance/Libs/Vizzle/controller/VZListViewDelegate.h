//
//  VZListViewDelegate.h
//  Vizzle
//
//  Created by Jayson Xu on 14-9-15.
//  Copyright (c) 2014年 VizLab. All rights reserved.
//

#import <UIKit/UIKit.h>

@class VZListViewController;
@protocol VZListViewDelegate <UITableViewDelegate>
@end

@interface VZListViewDelegate : NSObject<VZListViewDelegate>

/**
 * a weak reference to view controller
 */
@property (nonatomic, weak) VZListViewController* controller;

/**
 begin & end pull refresh
 */
- (void)beginRefreshing;
- (void)endRefreshing;

@end
