// VZViewController.m 
// iCoupon 
//created by Jayson Xu on 2014-09-15 15:35:19 +0800. 
// Copyright (c) @VizLab. All rights reserved.
// 

#import "VZViewController.h"
#import "VizzleConfig.h"
#import <libkern/OSAtomic.h>

@interface VZViewController ()
{

    //VZMV* => 1.4 Internal states of viewcontroller
    NSMutableDictionary* _states; //<key:model's key, value>
    
    //lock here
    OSSpinLock _lock;
}

@end

@implementation VZViewController


////////////////////////////////////////////////////////////////////////////////////
#pragma mark - setters



////////////////////////////////////////////////////////////////////////////////////
#pragma mark - getters

- (NSDictionary*)modelDictionary
{
    return [_modelDictInternal copy];
}

////////////////////////////////////////////////////////////////////////////////////
#pragma mark - life cycle


- (id)initWithCoder:(NSCoder *)aDecoder
{
    return [super initWithCoder:aDecoder];

}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    return [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
}

- (id)init {
    if (self = [super init]) {
        _modelDictInternal = [NSMutableDictionary new];
        _states = [NSMutableDictionary new];
        _lock = OS_SPINLOCK_INIT;
        _uuid = [[NSUUID UUID] UUIDString];
        
    }
    return self;
}

- (void)loadView
{
    [super loadView];
    
    self.view.backgroundColor = HEX_COLOR(@"f1f5f8");
    
    if ([self respondsToSelector:@selector(setEdgesForExtendedLayout:)])
        [self setEdgesForExtendedLayout:UIRectEdgeNone];
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = HEX_COLOR(@"f1f5f8");
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
}

- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
    
}

-(void)dealloc {
    
    VZLog(@"[%@]-->dealloc",self.class);
    
    OSSpinLockLock(&_lock);
    [_modelDictInternal removeAllObjects];
    [_states removeAllObjects];
    OSSpinLockUnlock(&_lock);
    
    //release viewmodel
    if (self.viewModel) {
        [self.viewModel endObserving];
    }
    
    //release template
    if (self.viewTemplate) {
        [self.viewTemplate endBinding];
    }

}

////////////////////////////////////////////////////////////////////////////////////
#pragma mark - public

- (void)registerModel:(VZModel *)model{
    
    model.delegate = self;
    
    NSAssert(model.key != nil, @"model must have a key");
    
    OSSpinLockLock(&_lock);
    [_modelDictInternal setObject:model forKey:model.key];
    [_states setObject:@"ready" forKey:model.key];
    OSSpinLockUnlock(&_lock);
}

- (void)unRegisterModel:(VZModel *)model{
    
     NSAssert(model.key != nil, @"model must have a key");
    
    OSSpinLockLock(&_lock);
    [_modelDictInternal removeObjectForKey:model.key];
    [_states removeObjectForKey:model.key];
    OSSpinLockUnlock(&_lock);
}

/*
 *  注册Template
 *
 *  @param clz 数据Template
 */
//- (void)registerViewTemplate:(VZTemplate* )viewTemplate
//{
//    if (viewTemplate) {
//      
//        _viewTemplate = viewTemplate;
//        _viewTemplate.identifier = self.uuid;
//        [_viewTemplate beginBinding];
//    }
//
//}
- (void)registerViewTemplateClass:(Class )clz
{
    NSAssert([clz isSubclassOfClass:[VZTemplate class]],@"Template's Class must be the subclass of VZTemplate");
    
    _viewTemplate = [[clz alloc]initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.bounds), CGRectGetHeight(self.view.bounds)) Identifier:[self uuid]];

    [self.view addSubview:_viewTemplate.contentView];
    [_viewTemplate beginBinding];
    
}

- (void)registerViewModelClass:(Class)clz
{
     NSAssert([clz isSubclassOfClass:[VZViewModel class]],@"ViewModel's Class must be the subclass of VZTemplate");
    
    _viewModel = [[clz alloc]initWithIdentifier:[self uuid]];
    [_viewModel beginObserving];
    
    
}
/*
 *  注册ViewModel
 *
 *  @param clz 数据ViewModel
 */
//- (void)registerViewModel:(VZViewModel* )viewModel
//{
//    NSAssert(viewModel != nil, @"ViewModel cannot be nil!");
//    _viewModel = viewModel;
//    _viewModel.identifier     = self.uuid;
//    _viewModel.viewController = self;
//    [_viewModel beginObserving];
//}

- (void)load {
    
    //解决遍历dictionary的时候，调用方调用unregister方法
    [_modelDictInternal  enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        VZHTTPModel *model = (VZHTTPModel*)obj;
        
        //to the next runloop
        dispatch_async(dispatch_get_main_queue(), ^{
            [model load];
        });
    }];
}

////////////////////////////////////////////////////////////////////////
#pragma mark - model callback

- (void)modelDidStart:(VZModel *)model {
    
    [self showLoading:model];
    [self updateState:@"loading" withKey:model.key];
}

- (void)modelDidFinish:(VZModel *)model {
    
    [self didLoadModel:model];
    
    //VZMV* 1.1 => 修改了showEmpty逻辑
    if ([self canShowModel:model])
    {
        [self showModel:model];
        [self updateState:@"finished" withKey:model.key];
    }
    else
    {
        
        [self showEmpty:model];
        [self updateState:@"empty" withKey:model.key];
    }
}

- (void)modelDidFail:(VZModel *)model withError:(NSError *)error {
    
    [self showError:error withModel:model];
    [self updateState:@"error" withKey:model.key];
}

////////////////////////////////////////////////////////////////////////
#pragma mark - logic action callback

- (void)onControllerShouldPerformAction:(int)type args:(NSDictionary* )dict
{
    
}

////////////////////////////////////////////////////////////////////////
#pragma mark - private 

- (void)updateState:(id) status withKey:(NSString* )key
{
    if (status && key) {
        
        OSSpinLockLock(&_lock);
        
        _states[key] = status;
        VZLog(@"[%@]-->status:%@",self.class,_states);
        
        OSSpinLockUnlock(&_lock);
    }
}

@end 


////////////////////////////////////////////////////////////////////////
@implementation VZViewController(Subclassing)

- (void)didLoadModel:(VZModel*)model{
}

- (BOOL)canShowModel:(VZModel*)model
{
    if ([_modelDictInternal.allKeys containsObject:model.key]) {
        return YES;
    }
    else
        return NO;
    
}

- (void)showModel:(VZModel *)model
{
    //todo:
}

- (void)showEmpty:(VZModel *)model
{
    //todo:
}


- (void)showLoading:(VZModel*)model
{
    //todo:
}

- (void)showError:(NSError *)error withModel:(VZModel*)model
{
    //todo:
}

@end

@implementation VZViewController(MemoryWarning)

- (BOOL)shouldHandleMemoryWarning
{
    return YES;
}

@end
