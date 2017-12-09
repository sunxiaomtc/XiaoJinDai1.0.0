//
//  CJTNaSearchView.h
//  CloneFactoryApp
//
//  Created by 小吊丝 on 16/6/13.
//  Copyright © 2016年 CSCHS. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIScrollView (Refresh)

/**
 *  添加下拉刷新
 */
- (void)MJ_addPullToRefreshWithHandler:(void (^)(void))handler;
/**
 *  开始刷新
 */
- (void)MJ_beginTriggerPullToRefresh;
/**
 *  结束下拉刷新
 */
- (void)MJ_endPullToRefresh;
/**
 *  添加上拉加载更多
 */
- (void)MJ_addPagingRefreshWithHandler:(void (^)(void))handler;
/**
 *  显示已经全部加载完毕
 */
- (void)MJ_pagingRefreshNoMoreData;

@end
