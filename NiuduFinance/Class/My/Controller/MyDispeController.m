//
//  MyDispeController.m
//  NiuduFinance
//
//  Created by 123 on 17/7/25.
//  Copyright © 2017年 liuyong. All rights reserved.
//

#import "MyDispeController.h"
#import "MyDisperCell.h"
#import "ReturnDetailsViewController.h"
#import "WebPageVC.h"
@interface MyDispeController ()<UITableViewDelegate ,UITableViewDataSource,MyDisperCellDelegate>
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *myDisperseInvestStateButtons;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) UIButton *optionedStateButton;
@property (weak, nonatomic) IBOutlet UIView *tableHeardView;

@property (assign, nonatomic) MyDisperseInvestStat disperseInvestStat;


@property (nonatomic,assign)NSInteger start;
@property (nonatomic,assign)NSInteger limit;
@property (nonatomic,strong) NSMutableArray *touArr;
@end

@implementation MyDispeController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我的投资";
    [self backBarItem];
    [self setupTableView];
    _disperseInvestStat = MyDisperseInvestStatRufunding;
    _optionedStateButton = _myDisperseInvestStateButtons[0];    
    _start = 0;
    _limit = 10;
    _touArr = [NSMutableArray array];
    [self getInBiData];
}

- (void)viewDidAppear:(BOOL)animated {
    self.hideNaviBar = NO;
}

//新未结清
- (void)getInBiData {
    [self.httpUtil requestDic4MethodNam:@"v2/accept/project/list" parameters:@{@"limit":@(_limit),@"type":@(0),@"start":@(_start)} result:^(id  dic, int status, NSString *msg) {
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
- (void)getBakLendData {
    [self.httpUtil requestDic4MethodNam:@"v2/accept/project/list" parameters:@{@"limit":@(_limit),@"type":@(1),@"start":@(_start)} result:^(id  dic, int status, NSString *msg) {
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
- (void)getAllBdData {
    [self.httpUtil requestDic4MethodNam:@"v2/accept/project/list" parameters:@{@"limit":@(_limit),@"type":@(2),@"start":@(_start)} result:^(id  dic, int status, NSString *msg) {
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
            [_touArr addObjectsFromArray:dic];
            [_tableView.mj_footer resetNoMoreData];
        }
        [_tableView reloadData];
    }];
}

- (void)setupTableView {
    _tableView.contentInset = UIEdgeInsetsMake(1.0,0.0,0.0,0.0);
    _tableView.tableFooterView  = [UIView new];
    [self setupRefreshWithTableView:_tableView];
    [_tableView registerNib:[UINib nibWithNibName:@"MyDisperCell" bundle:nil] forCellReuseIdentifier:@"MyDisperCell"];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 9;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 10;
}

#pragma mark -  Action
- (IBAction)optionStateAction:(UIButton *)sender {
    _optionedStateButton.selected = !_optionedStateButton.selected;
    _start = 0;
    _limit = 10;
    [_touArr removeAllObjects];
    
    if (sender == _optionedStateButton) {
        return;
    }else {
        _optionedStateButton.selected = NO;
        sender.selected = YES;
    }
    _optionedStateButton = sender;
    if (_optionedStateButton ==_myDisperseInvestStateButtons[0]) {
        self.disperseInvestState = MyDisperseInvestStatRufunding;
        [self getInBiData];
    }
    else if (_optionedStateButton ==_myDisperseInvestStateButtons[1]) {
        self.disperseInvestState = MyDisperseInvestStatBidding;
        [self getBakLendData];
    }
    else if (_optionedStateButton ==_myDisperseInvestStateButtons[2]) {
        self.disperseInvestState = MyDisperseInvestStatHistory;
        [self getAllBdData];
    }
}

#pragma mark - Setter
- (void)setDisperseInvestState:(MyDisperseInvestStat)disperseInvestStat {
    _disperseInvestStat = disperseInvestStat;
}

#pragma mark - UITableViewDelegate & UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _touArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITapGestureRecognizer *bottomLabelGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(gotoProtocol:)];
    MyDisperCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MyDisperCell"];
    cell.delegate = self;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    if (indexPath.row <_touArr.count) {
        [cell.xieYiBtn addGestureRecognizer:bottomLabelGesture];
        [cell creditorState:_disperseInvestStat model:_touArr[indexPath.row]];
    }else {
        [cell creditorState:_disperseInvestStat model:nil];
    }
    return cell;
}

//查看协议
- (void)gotoProtocol:(UITapGestureRecognizer *)gesture {
    CGPoint point = [gesture locationInView:self.tableView];
    NSIndexPath *indexPatch = [self.tableView indexPathForRowAtPoint:point];
    
    WebPageVC *vc = [[WebPageVC alloc] init];
    vc.title = @"协议";
    vc.name = @"agreement/bidproject";
    vc.dic = @{@"projectId":[_touArr[indexPatch.row] objectForKey:@"projectId"]};
    NSLog(@"%@",[_touArr[indexPatch.row] objectForKey:@"projectId"]);
    [self.navigationController pushViewController:vc animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 170;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([[NSString stringWithFormat:@"%@",[_touArr[indexPath.row] objectForKey:@"statusid"]] isEqualToString:@"1"])
        return; {
    }
    if ([[NSString stringWithFormat:@"%@",[_touArr[indexPath.row] objectForKey:@"statusid"]] isEqualToString:@"2"]) {
        return;
    }else {
        ReturnDetailsViewController *returnDetailsVC = [ReturnDetailsViewController new];
        returnDetailsVC.projectId = [[_touArr[indexPath.row] objectForKey:@"projectId"] intValue];
        [self.navigationController pushViewController:returnDetailsVC animated:YES];
        [tableView deselectRowAtIndexPath:indexPath animated:NO];
    }
}

- (void)headerRefreshloadData {
    if (_touArr.count < _limit) {
        [_tableView.mj_header endRefreshing];
        return;
    }
    if (_optionedStateButton == _myDisperseInvestStateButtons[1]) {
        self.disperseInvestStat = MyDisperseInvestStatBidding;
        [self getBakLendData];
    }
    if (_optionedStateButton == _myDisperseInvestStateButtons[0]) {
        self.disperseInvestStat = MyDisperseInvestStatRufunding;
        [self getInBiData];
    }
    if (_optionedStateButton == _myDisperseInvestStateButtons[2]) {
        self.disperseInvestStat = MyDisperseInvestStatHistory;
        [self getAllBdData];
    }
    [_tableView.mj_header endRefreshing];
}

- (void)footerRefreshloadData {
    
    if (_touArr.count-_start < _limit) {
        [MBProgressHUD showMessag:@"没有更多数据了" toView:self.view];
        
        [_tableView.mj_footer endRefreshing];
        return;
    }
    _start = _start + _limit;
    
    if (_optionedStateButton == _myDisperseInvestStateButtons[1]) {
        self.disperseInvestStat = MyDisperseInvestStatBidding;
        [self getBakLendData];
    }
    if (_optionedStateButton == _myDisperseInvestStateButtons[0]){
        self.disperseInvestStat = MyDisperseInvestStatRufunding;
        [self getInBiData];
    }
    if (_optionedStateButton == _myDisperseInvestStateButtons[2]){
        self.disperseInvestStat = MyDisperseInvestStatHistory;
        [self getAllBdData];
    }
    [_tableView.mj_header endRefreshing];
}


@end
