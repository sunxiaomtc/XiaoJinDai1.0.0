//
//  VZListViewDelegate.m
//  Vizzle
//
//  Created by Jayson Xu on 14-9-15.
//  Copyright (c) 2014年 VizLab. All rights reserved.
//

#import "VZListViewDelegate.h"
#import "VZListViewDataSource.h"
#import "VZListCell.h"
#import "VZListItem.h"
#import "VZHTTPListModel.h"
#import "VZListViewController.h"
#import "MJRefresh.h"

@implementation VZListViewDelegate

@synthesize controller = _controller;

#pragma mark - setters

- (void)setController:(VZListViewController *)controller
{
    _controller = controller;
    
    if (self.controller.needPullRefresh) {
        WS
        controller.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            [weakSelf.controller performSelector:@selector(pullRefreshDidTrigger) withObject:nil afterDelay:0.5f];
        }];
    }
}

#pragma mark - life cycle

- (void)dealloc
{
    NSLog(@"[%@]-->dealloc",self.class);
    
    _controller = nil;
}

#pragma mark - public

- (void)beginRefreshing
{
    if (self.controller.needPullRefresh)
        [self.controller.tableView.mj_header beginRefreshing];
}

- (void)endRefreshing
{
    if (self.controller.needPullRefresh)
        [self.controller.tableView.mj_header endRefreshing];
}

#pragma mark - uitableView delegate

// Variable height support

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    Class cls;
    
    if ([tableView.dataSource isKindOfClass:[VZListViewDataSource class]]) {
        
        VZListViewDataSource* dataSource = (VZListViewDataSource*)tableView.dataSource;
        
        VZListItem* item = [dataSource itemForCellAtIndexPath:indexPath];
        
        if (item.itemHeight > 0)
            return item.itemHeight;
        else {
            cls = [dataSource cellClassForItem:item AtIndex:indexPath];
            
            if ([cls isSubclassOfClass:[VZListCell class]]) {
                
                return [cls tableView:tableView variantRowHeightForItem:item AtIndex:indexPath];
            } else
                return 44;
        }
    } else
        return 44;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger numberOfSections = [self.controller.dataSource numberOfSectionsInTableView:tableView];
    if ( indexPath.section == numberOfSections - 1)
    {
        VZListViewDataSource* dataSource = (VZListViewDataSource*)tableView.dataSource;
        NSArray* items = dataSource.itemsForSection[@(indexPath.section)];
        if (indexPath.row  == items.count - 1 )
            [self.controller loadMore];
    }
}


- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0;
}
- (UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    return nil;
}
- (UIView*)tableView:(UITableView*)tableView viewForFooterInSection:(NSInteger)section
{
    return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.controller tableView:tableView didSelectRowAtIndexPath:indexPath];
}

- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return @"";
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    VZListViewController* controller = (VZListViewController*)self.controller;
    
    if (controller.editing == NO || !indexPath)
        return UITableViewCellEditingStyleNone;
    else
		return UITableViewCellEditingStyleDelete;
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - scrollview's delegate

- (void)scrollViewDidEndDragging:(UIScrollView*)scrollView willDecelerate:(BOOL)decelerate
{
    [self.controller scrollViewDidEndDragging:scrollView willDecelerate:decelerate];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView*)scrollView
{
    [self.controller scrollViewDidEndDecelerating:scrollView];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [self.controller scrollViewDidScroll:scrollView];
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    
    [self.controller scrollViewWillBeginDragging:scrollView];
}


/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - tableview delegate

- (void)onCellComponentClickedAtIndex:(NSIndexPath *)indexPath Bundle:(NSDictionary *)extra
{
    if(extra == nil)
        return [self.controller tableView:self.controller.tableView didSelectRowAtIndexPath:indexPath];
    else
        return [self.controller tableView:self.controller.tableView didSelectRowAtIndexPath:indexPath component:extra];
}

@end
