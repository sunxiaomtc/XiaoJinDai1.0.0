//
//  VZListViewController.m
//  Vizzle
//
//  Created by Jayson Xu on 14-9-15.
//  Copyright (c) 2014年 VizLab. All rights reserved.
//

#import "VZListViewController.h"
#import "VZHTTPListModel.h"
#import "VizzleConfig.h"
#import "VZListDefaultTextItem.h"
#import "VZListViewDataSource.h"
#import "VZListViewDelegate.h"
#import "VZListCell.h"
#import "VZListItem.h"
#import "VZFooterViewFactory.h"
#import "MJRefresh.h"

@interface VZListViewController ()
{
    //state,bad
    NSInteger _loadMoreSection;
}

@end


@implementation VZListViewController

@synthesize dataSource = _dataSource;
@synthesize delegate   = _delegate;

///////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - setters

- (void)setDataSource:(VZListViewDataSource*)dataSource
{
    _dataSource = dataSource;
    _dataSource.controller = self;
    self.tableView.dataSource = dataSource;
}

- (void)setDelegate:(VZListViewDelegate*)delegate
{
    _delegate = delegate;
    _delegate.controller = self;
    self.tableView.delegate = delegate;
}


- (void)setKeyModel:(VZHTTPListModel *)keyModel
{
    NSAssert([keyModel isKindOfClass:[VZHTTPListModel class]],@"keyModel类型错误");
    _keyModel = keyModel;
    _loadMoreSection = keyModel.sectionNumber;
}

///////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - getters

- (UITableView*)tableView
{
    if (!_tableView)
    {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 0) style:UITableViewStylePlain];
        _tableView.opaque  = YES;
        _tableView.separatorStyle = NO;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        _tableView.dataSource = nil;
        _tableView.delegate = nil;
//        _tableView.separatorColor = [WKColors lineColor];
    }
    return _tableView;
}

- (VZListViewDataSource* )dataSource
{
    if(!_dataSource)
    {
        _dataSource = [[VZListViewDataSource alloc]init];
        _dataSource.controller = self;
    }
    
    return _dataSource;
}

- (VZListViewDelegate* )delegate
{
    if(!_delegate)
    {
        _delegate = [[VZListViewDelegate alloc]init];
        _delegate.controller = self;
    }
    
    return _delegate;
    
}

#pragma mark - life cycle

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self setUp];
    }
    return self;
}

- (id)init
{
    self = [super init];
    if (self) {
        [self setUp];
    }
    return self;
}

- (void)setUp
{
    _clearItemsWhenModelReload = YES;
    _loadmoreAutomatically = NO;
    _needPullRefresh      = NO;
    _needLoadMore         = NO;
}

- (void)loadView
{
    [super loadView];
    
    if ([self respondsToSelector:@selector(setEdgesForExtendedLayout:)])
        [self setEdgesForExtendedLayout:UIRectEdgeNone];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.view addSubview:self.tableView];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


////////////////////////////////////////////////////////////////////
#pragma mark - VZViewController

- (void)registerModel:(VZModel *)model
{
    NSAssert([model isKindOfClass:[VZHTTPListModel class]], @"model类型不正确");
    
    return [super registerModel:model];
}

- (void)load
{
    NSAssert(_keyModel != nil, @"至少需要指定一个keymodel");
    [super load];
}

- (void)loadMore
{
    if (self.needLoadMore) {
        
        NSAssert(_keyModel != nil, @"至少需要指定一个keymodel");
        
        if ([self.keyModel hasMore]) {
            
            if (self.loadmoreAutomatically) {
                [self.keyModel loadMore];
            } else
                [self showLoadMoreFooterView];
        } else {
            [self hiddenLoadMoreFooterView];
        }
    }
}

- (void)didLoadModel:(VZHTTPListModel *)model
{
    //VZMV* => 1.1 : 多个model注册同一个section，只有keymodel才能被加载
    NSInteger section = self.keyModel.sectionNumber;
    
    if (model.sectionNumber == section) {
        
        //只处理key model带回来的数据
        if (model == self.keyModel ) {
            [self.dataSource tableViewControllerDidLoadModel:model ForSection:model.sectionNumber];
        }

    } else
        [self.dataSource tableViewControllerDidLoadModel:model ForSection:model.sectionNumber];
    
    
}

- (BOOL)canShowModel:(VZHTTPListModel *)model
{
    if (![super canShowModel:model]) {
        return NO;
    }
    
    NSInteger numberOfRows = 0;
    NSInteger numberOfSections = 0;
    
    numberOfSections = [self.dataSource numberOfSectionsInTableView:self.tableView];
    
    if (!numberOfSections) {
        return NO;
    }
    
    numberOfRows = 0;
    
    for (int i=0; i<numberOfSections; i++) {
        numberOfRows =  [self.dataSource tableView:self.tableView numberOfRowsInSection:model.sectionNumber];
        if (numberOfRows > 0) {
            break;
        }
    }
    
    if (!numberOfRows) {
        return NO;
    }
    else
    {
        //VZMV* => 1.1 : 多个model注册同一个section，只有keymodel才能被show出来
        if (numberOfSections == 1) {
            
            if (model == _keyModel) {
                return YES;
            }
            else
                return NO;
        }
    }
    return YES;
}


- (void)showEmpty:(VZHTTPListModel *)model
{
    VZLog(@"[%@]-->showEmpty:{key:%@,section:%ld}",[self class],model.key,(long)model.sectionNumber);
    
    [super showEmpty:model];
    
    [self endRefreshing];
    [self showNoResult:model];
}

//默认loading 样式
- (void)showLoading:(VZHTTPListModel *)model
{
    VZLog(@"[%@]-->showLoading:{key:%@,section:%ld}",[self class],model.key,(long)model.sectionNumber);
    
    if (model == _keyModel) {
        
    } else {
        //VZMV* => 1.1:解决注册了同一个section的不同model的状态的问题
        if (model.sectionNumber != _keyModel.sectionNumber) {
            
            //show loading for seciton
            NSInteger section = model.sectionNumber;
            //创建一个loading item
            VZListItem* item = [VZListItem new];
            item.itemType = kItem_Loading;
            item.itemHeight = 44;
            [self.dataSource setItems:@[item] ForSection:section];
            [self reloadTableView];
        }
    }
}

- (void)showModel:(VZHTTPListModel *)model
{
    VZLog(@"[%@]-->showModel:{key:%@,section:%ld}",[self class],model.key,(long)model.sectionNumber);
    
    [super showModel:model];
    
    //VZMV* => 1.1:
    [self reloadTableView];
    
    [self.tableView.mj_footer endRefreshing];
  
    [self endRefreshing];
    
}

- (void)showError:(NSError *)error withModel:(VZHTTPListModel *)model
{
    VZLog(@"[%@]-->showError:{key:%@,section:%ld}",[self class], model.key,(long)model.sectionNumber);
    
    [self endRefreshing];
    
    if (model == _keyModel) {
        [self.tableView.mj_footer endRefreshing];
    } else {
        //VZMV => 1.1:解决注册了同一个section的不同model的状态的问题
        if (model.sectionNumber != _keyModel.sectionNumber) {
            //show loading for seciton
            NSInteger section = model.sectionNumber;
            //创建一个error item
            VZListDefaultTextItem* item = [VZListDefaultTextItem new];
            item.itemType = kItem_Error;
            item.text = error.localizedDescription;
            item.itemHeight = 44;
            [self.dataSource setItems:@[item] ForSection:section];
            [self reloadTableView];
        }
    }
}
////////////////////////////////////////////////////////////////////
#pragma mark - private

- (void)reloadTableView
{
    self.tableView.dataSource = self.dataSource;
    self.tableView.delegate   = self.delegate;
    [self.tableView reloadData];
}

////////////////////////////////////////////////////////////////////
#pragma mark - public

/**
 * 加载某个section的model
 */
- (void)loadModelForSection:(NSInteger)section
{
    //load model
    [_modelDictInternal enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        
        VZHTTPListModel* model = (VZHTTPListModel*)obj;
        
        if (section == model.sectionNumber) {
            [model load];
        }
    }];
}
/**
 *  根据model的key来加载model
 *
 *  VZMV* => 1.1
 *
 *  @param key
 */
- (void)loadModelByKey:(NSString* )targetKey
{
    [_modelDictInternal enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        
        VZHTTPListModel* model = (VZHTTPListModel*)obj;
        
        if ([key isEqualToString : targetKey]) {
            [model load];
        }
    }];
}
/**
 * 显示下拉刷新
 */
- (void)beginRefreshing
{
    [self.delegate beginRefreshing];
}
/**
 * 隐藏下拉刷新
 */
- (void)endRefreshing
{
    [self.delegate endRefreshing];
}
/**
 下拉刷新通知
 */
- (void)pullRefreshDidTrigger
{
    [self load];
}

@end

@implementation VZListViewController(Subclassing)

- (void)showNoResult:(VZHTTPListModel *)model
{
    NSLog(@"[%@]-->showNoResult:{key:%@,section:%ld}",[self class],model.key,(long)model.sectionNumber);
    
    [self endRefreshing];
    
    if (model == _keyModel) {
        self.tableView.tableFooterView = [VZFooterViewFactory normalFooterView:CGRectMake(0, 0, self.view.frame.size.width, 44) Text:@"没有结果"];
    } else {
        //VZ => 1.1:解决注册了同一个section的不同model的状态的问题
        if (model.sectionNumber != _keyModel.sectionNumber) {
            
            NSInteger section = model.sectionNumber;
            //创建一个customized item
            VZListDefaultTextItem* item = [VZListDefaultTextItem new];
            item.itemType = kItem_Customize;
            item.text = @"没有结果";
            item.itemHeight = 44;
            [self.dataSource setItems:@[item] ForSection:section];
            [self reloadTableView];
        }
    }
}

- (void)showComplete:(VZHTTPListModel *)model
{
    VZLog(@"[%@]-->showComplete:{section:%ld}",[self class],(long)model.sectionNumber);
    
    if (model == _keyModel) {
        [self.tableView.mj_footer endRefreshing];
    } else {
        //todo:
    }
}
- (void)showLoadMoreFooterView
{
    VZLog(@"[%@]-->showLoadMoreFooterView",self.class);
    
    if (!self.tableView.mj_footer)
        self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
            [self onLoadMoreClicked:nil];
        }];
}

- (void)hiddenLoadMoreFooterView
{
    VZLog(@"[%@]-->hiddenLoadMoreFooterView", self.class);
    
    if (self.tableView.mj_footer) {
        [self.tableView.mj_footer endRefreshing];
        self.tableView.mj_footer = nil;
    }
}

- (void)onLoadMoreClicked:(id)sender
{
    [self.keyModel loadMore];
}

@end

@implementation VZListViewController(UITableView)

/*
 * tableView的相关操作
 */
- (void)tableView:(UITableView*)tableView didSelectRowAtIndexPath:(NSIndexPath*)indexPath
{
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath component:(NSDictionary*)bundle
{
    
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPat
{
    
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    
}
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    
}

@end
