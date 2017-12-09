//
//  CJTNaSearchView.m
//  CloneFactoryApp
//
//  Created by 小吊丝 on 16/6/13.
//  Copyright © 2016年 CSCHS. All rights reserved.
//

#import "UIScrollView+Refresh.h"
#import <MJRefresh/MJRefresh.h>

@implementation UIScrollView (Refresh)

//添加下拉刷新
- (void)MJ_addPullToRefreshWithHandler:(void (^)(void))handler {
    if (!self.mj_header) {
        MJRefreshNormalHeader *refreshHeader = [MJRefreshNormalHeader headerWithRefreshingBlock:handler];
        refreshHeader.lastUpdatedTimeLabel.hidden = YES;
        self.mj_header = refreshHeader;
    }
}

//开始刷新
- (void)MJ_beginTriggerPullToRefresh {
    [self.mj_header beginRefreshing];
    self.mj_footer.hidden = YES;
}

//结束下拉刷新
- (void)MJ_endPullToRefresh {
    [self.mj_header endRefreshing];
    [self.mj_footer resetNoMoreData];
    self.mj_footer.hidden = NO;
}

//添加上拉加载更多
- (void)MJ_addPagingRefreshWithHandler:(void (^)(void))handler {
    if (!self.mj_footer) {
        MJRefreshAutoNormalFooter *refreshFooter = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:handler];
        self.mj_footer = refreshFooter;
    }
}

//显示已经全部加载完毕
- (void)MJ_pagingRefreshNoMoreData {
    [self.mj_footer endRefreshingWithNoMoreData];
}

@end
