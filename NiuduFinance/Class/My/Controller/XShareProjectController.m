//
//  XShareProjectController.m
//  NiuduFinance
//
//  Created by 123 on 17/7/27.
//  Copyright © 2017年 liuyong. All rights reserved.
//

#import "XShareProjectController.h"
#import "XReturnDetailsController.h"
#import "WebPageVC.h"
#import "ShareProjectCell.h"
@interface XShareProjectController ()<UITableViewDelegate ,UITableViewDataSource,ShareProjectCellDelegate>
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray * shareProjectStateButtons;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) UIButton *optionedStateButton;
@property (weak, nonatomic) IBOutlet UIView *tableHeardView;

@property (assign, nonatomic) ShareProjectStat shareProjectStat;


@property (nonatomic,assign)NSInteger start;
@property (nonatomic,assign)NSInteger limit;
@property (nonatomic,strong) NSMutableArray *touArr;

@end

@implementation XShareProjectController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"体验金";
    [self backBarItem];
    [self setupTableView];
    _shareProjectStat = ShareProjectStatRufunding;
    _optionedStateButton = _shareProjectStateButtons[0];
    
    _start = 0;
    _limit = 10;
    _touArr = [NSMutableArray array];
    //    _tableHeardView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 68);
    //    [_tableView addSubview:_tableHeardView];
    [self getInBiData];
}

- (void)viewDidAppear:(BOOL)animated {
    self.hideNaviBar = NO;
}

//新未结清
- (void)getInBiData
{
    [self.httpUtil requestDic4MethodNam:@"v2/accept/project/welfareList" parameters:@{@"limit":@(_limit),@"type":@(0),@"start":@(_start)} result:^(id  dic, int status, NSString *msg) {
        NSLog(@"%@",dic);
        if (status == 0) {
//            [MBProgressHUD showMessag:msg toView:self.view];
            if (_touArr.count == 0) {
//                self.hideNoNetWork = NO;
//                self.noNetWorkView.top = 53;
//                self.noNetWorkView.height = SCREEN_HEIGHT - 53;
//                self.noNetWorkView.width = SCREEN_WIDTH;
            }
        }else {
            self.hideNoNetWork = YES;
            NSLog(@"%@",dic);
            if (_start == 0) {
                _touArr = [NSMutableArray array];
            }
            [_touArr addObjectsFromArray:dic];
            [_tableView.mj_footer resetNoMoreData];
        }
        [_tableView reloadData];
    }];
}

//新已结清
- (void)getBakLendData
{
    [self.httpUtil requestDic4MethodNam:@"v2/accept/project/welfareList" parameters:@{@"limit":@(_limit),@"type":@(1),@"start":@(_start)} result:^(id  dic, int status, NSString *msg) {
        NSLog(@"%@",dic);
        if (status == 0) {
//            [MBProgressHUD showMessag:msg toView:self.view];
            if (_touArr.count == 0) {
//                self.hideNoNetWork = NO;
//                self.noNetWorkView.top = 53;
//                self.noNetWorkView.height = SCREEN_HEIGHT - 53;
//                self.noNetWorkView.width = SCREEN_WIDTH;
            }
            
        }else{
            
            self.hideNoNetWork = YES;
            NSLog(@"%@",dic);
            if (_start == 0) {
                _touArr = [NSMutableArray array];
            }
            [_touArr addObjectsFromArray:dic];
            [_tableView.mj_footer resetNoMoreData];
            
        }
        [_tableView reloadData];
        
    }];
    
}

//新全部
- (void)getAllBdData
{
    [self.httpUtil requestDic4MethodNam:@"v2/accept/project/welfareList" parameters:@{@"limit":@(_limit),@"type":@(2),@"start":@(_start)} result:^(id  dic, int status, NSString *msg) {
        NSLog(@"%@",dic);
        if (status == 0) {
//            [MBProgressHUD showMessag:msg toView:self.view];
            if (_touArr.count == 0) {
//                self.hideNoNetWork = NO;
//                self.noNetWorkView.top = 53;
//                self.noNetWorkView.height = SCREEN_HEIGHT - 53;
//                self.noNetWorkView.width = SCREEN_WIDTH;
            }
            
        }else{
            
            self.hideNoNetWork = YES;
            NSLog(@"%@",dic);
            
            [_touArr addObjectsFromArray:dic];
            [_tableView.mj_footer resetNoMoreData];
            
        }
        [_tableView reloadData];
        
    }];
    
}

- (void)setupTableView
{
    _tableView.contentInset = UIEdgeInsetsMake(1.0,0.0,0.0,0.0);
    _tableView.tableFooterView  = [UIView new];
    [self setupRefreshWithTableView:_tableView];
    [_tableView registerNib:[UINib nibWithNibName:@"ShareProjectCell" bundle:nil] forCellReuseIdentifier:@"ShareProjectCell"];
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 9;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.1;
}

#pragma mark -  Action
- (IBAction)optionStateAction:(UIButton *)sender
{
    _optionedStateButton.selected = !_optionedStateButton.selected;
    [_optionedStateButton setTintColor:UIcolors];
    _start = 0;
    _limit = 10;
    [_touArr removeAllObjects];
    
    if (sender == _optionedStateButton)
    {
        return;
    }
    else
    {
        _optionedStateButton.selected = NO;
        sender.selected = YES;
    }
    _optionedStateButton = sender;
    if (_optionedStateButton ==_shareProjectStateButtons[0])
    {
        self.shareProjectStat = ShareProjectStatRufunding;
        
        [self getInBiData];
        
    }
    else if (_optionedStateButton ==_shareProjectStateButtons[1])
    {
        self.shareProjectStat = ShareProjectStatBidding;
        [self getBakLendData];
    }
    else if (_optionedStateButton ==_shareProjectStateButtons[2])
    {
        self.shareProjectStat = ShareProjectStatHistory;
        [self getAllBdData];
    }
}

#pragma mark - Setter
- (void)setDisperseInvestState:(ShareProjectStat)shareProjectStat
{
    _shareProjectStat = shareProjectStat;
    //    [_tableView reloadData];
}

#pragma mark - MyDispreseInvestCellDelegate

#pragma mark - UITableViewDelegate & UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return _touArr.count;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITapGestureRecognizer *bottomLabelGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(gotoProtocol:)];
    ShareProjectCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ShareProjectCell"];
    cell.delegate = self;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    if (indexPath.row <_touArr.count) {
        [cell.xieYiBtn addGestureRecognizer:bottomLabelGesture];
        [cell creditorState:_shareProjectStat model:_touArr[indexPath.row]];
    }else{
        [cell creditorState:_shareProjectStat model:nil];
        
    }
    
    return cell;
}

//查看协议

- (void)gotoProtocol:(UITapGestureRecognizer *)gesture{
    
    
    CGPoint point = [gesture locationInView:self.tableView];
    NSIndexPath *indexPatch = [self.tableView indexPathForRowAtPoint:point];
    
    WebPageVC *vc = [[WebPageVC alloc] init];
    vc.title = @"协议";
    vc.name = @"agreement/bidproject";
    
    vc.dic = @{@"projectId":[_touArr[indexPatch.row] objectForKey:@"projectId"]};
    
    NSLog(@"%@",[_touArr[indexPatch.row] objectForKey:@"projectId"]);
    
    [self.navigationController pushViewController:vc animated:YES];
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return 169;
}
//
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([[NSString stringWithFormat:@"%@",[_touArr[indexPath.row] objectForKey:@"statusid"]] isEqualToString:@"1"])
        return;
    {
    }
    if ([[NSString stringWithFormat:@"%@",[_touArr[indexPath.row] objectForKey:@"statusid"]] isEqualToString:@"2"])
    {
        return;
    }else
    {
        XReturnDetailsController *returnDetailsVC = [XReturnDetailsController new];
        returnDetailsVC.projectId = [[_touArr[indexPath.row] objectForKey:@"projectId"] intValue];
        [self.navigationController pushViewController:returnDetailsVC animated:YES];
        [tableView deselectRowAtIndexPath:indexPath animated:NO];
        
    }
    
}

- (void)headerRefreshloadData
{
    
    if (_touArr.count < _limit) {
        [_tableView.mj_header endRefreshing];
        return;
    }
    
    if (_optionedStateButton == _shareProjectStateButtons[1]) {
        self.shareProjectStat = ShareProjectStatBidding;
        [self getBakLendData];
    }
    if (_optionedStateButton == _shareProjectStateButtons[0]){
        self.shareProjectStat = ShareProjectStatRufunding;
        [self getInBiData];
    }
    if (_optionedStateButton == _shareProjectStateButtons[2]){
        self.shareProjectStat = ShareProjectStatHistory;
        [self getAllBdData];
    }
    
    [_tableView.mj_header endRefreshing];
}
- (void)footerRefreshloadData
{
    
    if (_touArr.count-_start < _limit) {
        [MBProgressHUD showMessag:@"没有更多数据了" toView:self.view];
        
        [_tableView.mj_footer endRefreshing];
        return;
    }
    _start = _start + _limit;
    
    if (_optionedStateButton == _shareProjectStateButtons[1]) {
        self.shareProjectStat = ShareProjectStatBidding;
        [self getBakLendData];
    }
    if (_optionedStateButton == _shareProjectStateButtons[0]){
        self.shareProjectStat = ShareProjectStatRufunding;
        [self getInBiData];
    }
    if (_optionedStateButton == _shareProjectStateButtons[2]){
        self.shareProjectStat = ShareProjectStatHistory;
        [self getAllBdData];
    }
    
    [_tableView.mj_header endRefreshing];
    
}
@end
