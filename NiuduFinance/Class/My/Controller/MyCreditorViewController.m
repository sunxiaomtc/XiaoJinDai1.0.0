//
//  MyCreditorViewController.m
//  NiuduFinance
//
//  Created by zhoupushan on 16/3/10.
//  Copyright © 2016年 liuyong. All rights reserved.
//

#import "MyCreditorViewController.h"

#import "MyCreditorActionViewController.h"
#import "MyCreditorActionViewControllerBackViewController.h"
#import "WebPageVC.h"
#import "MyCreditoNewCell.h"
#import "MyDisperseInvestViewCell.h"
#import "ReturnDetailsViewController.h"
#import "MyNewCreditorViewController.h"


@interface MyCreditorViewController ()<UITableViewDelegate ,UITableViewDataSource,MyCreditorNewCellDelegate>
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *CreditorStateButtons;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) UIButton *optionedStateButton;


@property (assign, nonatomic) CreditorStat creditorState;

@property (nonatomic,assign)NSInteger start;
@property (nonatomic,assign)NSInteger limit;
@property (nonatomic,strong) NSMutableArray *touArr;
@property (nonatomic,strong)NSMutableArray *transferringArr;
@property (nonatomic,strong)NSMutableArray *buyRecordArr;

@property (nonatomic,strong)NSString * debtDealId;
@property (nonatomic,assign)int  debtDeal;

@end

//static NSString * const cellIdentifier = @"MyCreditorCell";
static NSString * const cellIdentifier = @"MyCreditoNewCell";
@implementation MyCreditorViewController

- (void)viewDidLoad {
    [super viewDidLoad];
     self.title = @"债权交易";
    [self backBarItem];
    
    _start = 0;
    _limit = 10;
    _touArr = [NSMutableArray array];
    _transferringArr = [NSMutableArray array];
    _buyRecordArr = [NSMutableArray array];

    
    _creditorState = CreditorStateCanTransfe;
    _optionedStateButton = _CreditorStateButtons[0];
    [self setupTableView];
    [self getNeotiableData];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    if (_creditorState == CreditorStateCanTransfe) {
        [_touArr removeAllObjects];
        [self getNeotiableData];
    }else if (_creditorState == CreditorStateRefundin){
        [_transferringArr removeAllObjects];
        [self geTransferringData];

    }
}




- (void)viewDidAppear:(BOOL)animated
{
    self.hideNaviBar = NO;
}

//新可转让
- (void)getNeotiableData
{
    [self.httpUtil requestDic4MethodNam:@"v2/accept/debt/mayTransgerList" parameters:@{@"limit":@(_limit),@"start":@(_start)} result:^(id  dic, int status, NSString *msg) {
        NSLog(@"%@",dic);
        if (status == 0) {
            [MBProgressHUD showMessag:msg toView:self.view];
            if (_touArr.count == 0) {
                self.hideNoNetWork = NO;
                self.noNetWorkView.top = 53;
                self.noNetWorkView.height = SCREEN_HEIGHT - 53;
                self.noNetWorkView.width = SCREEN_WIDTH;
            }
            
        }else{
            self.hideNoNetWork = YES;
            NSLog(@"%@",dic);
            if (_start == 0) {
                _touArr = [NSMutableArray array];
            }
            
            [_touArr removeAllObjects];
            [_touArr addObjectsFromArray:dic];
            [_tableView.mj_footer resetNoMoreData];
            
        }
        [_tableView reloadData];
        
    }];
    
}

//新转让中
- (void)geTransferringData
{
    [self.httpUtil requestDic4MethodNam:@"v2/accept/debt/transgerinfList" parameters:@{@"limit":@(_limit),@"start":@(_start)} result:^(id  dic, int status, NSString *msg) {
        NSLog(@"%@",dic);
        if (status == 0) {
            [MBProgressHUD showMessag:msg toView:self.view];
            if (_transferringArr.count == 0) {
                self.hideNoNetWork = NO;
                self.noNetWorkView.top = 53;
                self.noNetWorkView.height = SCREEN_HEIGHT - 53;
                self.noNetWorkView.width = SCREEN_WIDTH;
            }
            
        }else{
            self.hideNoNetWork = YES;
            [_transferringArr removeAllObjects];
            [_transferringArr addObjectsFromArray:dic];
            [_tableView.mj_footer resetNoMoreData];
            
        }
        [_tableView reloadData];
        
    }];
    
}

//新已购买
- (void)geBuyRecordData
{
    [self.httpUtil requestDic4MethodNam:@"v2/accept/debt/buyTransgerinfList" parameters:@{@"limit":@(_limit),@"start":@(_start)} result:^(id  dic, int status, NSString *msg) {
        NSLog(@"%@",dic);
        if (status == 0) {
            [MBProgressHUD showMessag:msg toView:self.view];
            if (_buyRecordArr.count == 0) {
                self.hideNoNetWork = NO;
                self.noNetWorkView.top = 53;
                self.noNetWorkView.height = SCREEN_HEIGHT - 53;
                self.noNetWorkView.width = SCREEN_WIDTH;
            }
            
        }else{
            self.hideNoNetWork = YES;
            NSLog(@"%@",dic);
            [_buyRecordArr removeAllObjects];
            [_buyRecordArr addObjectsFromArray:dic];
            [_tableView.mj_footer resetNoMoreData];
            
        }
        [_tableView reloadData];
        
    }];
    
}





- (void)setupTableView
{
//    _tableView.contentInset = UIEdgeInsetsMake(9.0,0.0,0.0,0.0);
    _tableView.tableFooterView  = [UIView new];
    [_tableView registerNib:[UINib nibWithNibName:cellIdentifier bundle:nil] forCellReuseIdentifier:cellIdentifier];

    [self setupRefreshWithTableView:_tableView];
}

#pragma mark -  Action
- (IBAction)optionCreditorAction:(UIButton *)sender
{
    
    _optionedStateButton.selected = !_optionedStateButton.selected;
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
    if (_optionedStateButton ==_CreditorStateButtons[0])
    {
        self.creditorState = CreditorStateCanTransfe;

        [self getNeotiableData];
    }
    else if (_optionedStateButton ==_CreditorStateButtons[1])
    {
        self.creditorState = CreditorStateRefundin;
        [self geTransferringData];
    }
    else if (_optionedStateButton ==_CreditorStateButtons[2])
    {
        self.creditorState = CreditorStateHistor;
        [self geBuyRecordData];
    }
}



#pragma mark - Setter
- (void)setCreditorState:(CreditorStat)CreditorStat
{
    _creditorState = CreditorStat;
//    [_tableView reloadData];
}

#pragma mark - MyCreditorCellDelegate
- (void)creditorInvestAction:(MyCreditoNewCell *)cell
{
   
//    if (_creditorState == CreditorStateCanTransfe)
//    {
//        // 转让
//        MyCreditorActionViewController *vc = [[MyCreditorActionViewController alloc] init];
//        vc.transferInvest = YES;
//        vc.projectId = [_touArr[cell.creditorInvestLabel.tag] objectForKey:@"projectid"];
////        vc.myCreditorDic = _negotiableArr[cell.creditorInvestButton.tag];
//        [self.navigationController pushViewController:vc animated:YES];
//    }
//    
//    else if (_creditorState == CreditorStateRefundin)
//    {
//        // 撤回
//        MyCreditorActionViewControllerBackViewController *vc = [[MyCreditorActionViewControllerBackViewController alloc] init];
//        vc.transferInvest = NO;
//        vc.myCreditorDic = _transferringArr[cell.creditorInvestLabel.tag];
//        [self.navigationController pushViewController:vc animated:YES];
//    }
    
}

#pragma mark - UITableViewDelegate & UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    if (_creditorState == CreditorStateCanTransfe) {
        return _touArr.count;
    }else if (_creditorState == CreditorStateRefundin){
        return _transferringArr.count;
    }else if (_creditorState == CreditorStateHistor){
        return _buyRecordArr.count;
    }
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{


    return 1;
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"%ld",_buyRecordArr.count);
    UITapGestureRecognizer *bottomLabelGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(gotoProtocol:)];
    MyCreditoNewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    cell.delegate = self;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (_creditorState == CreditorStateCanTransfe) {
        if (_touArr.count > 0) {
            [cell creditorState:_creditorState model:_touArr[indexPath.section]];
            cell.creditorInvestLabel.tag = indexPath.row;
        }else{
            [cell creditorState:_creditorState model:nil];
        }
    }else if (_creditorState == CreditorStateRefundin){
        if (_transferringArr.count > 0) {
            [cell creditorState:_creditorState model:_transferringArr[indexPath.section]];
            cell.creditorInvestLabel.tag = indexPath.row;
        }else{
            [cell creditorState:_creditorState model:nil];
        }
    }else if (_creditorState == CreditorStateHistor){

        if (_buyRecordArr.count > 0) {
            cell.agreementLabel.userInteractionEnabled = YES;
            [cell.agreementLabel addGestureRecognizer:bottomLabelGesture];
            [cell creditorState:_creditorState model:_buyRecordArr[indexPath.section]];
        }else{
            [cell creditorState:_creditorState model:nil];
        }
    }
    return cell;
}

- (void)gotoProtocol:(UITapGestureRecognizer *)gesture{
    
    
    CGPoint point = [gesture locationInView:self.tableView];
    NSIndexPath *indexPatch = [self.tableView indexPathForRowAtPoint:point];
    
    WebPageVC *vc = [[WebPageVC alloc] init];
    vc.title = @"协议";
    vc.name = @"agreement/debtdeal";
    NSLog(@"%@",_buyRecordArr);
    if (_buyRecordArr == nil) {
        return;
    }
    NSLog(@"%@",[_buyRecordArr[indexPatch.row] objectForKey:@"debtdealbidid"]);
    vc.dic = @{@"debtdealbidid":[_buyRecordArr[indexPatch.row] objectForKey:@"debtdealbidid"]};
    
    [self.navigationController pushViewController:vc animated:YES];
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 118;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    if (_optionedStateButton == _CreditorStateButtons[0]) {

        MyNewCreditorViewController * vc = [MyNewCreditorViewController new];
        vc.projectId = [[_touArr[indexPath.row] objectForKey:@"projectId"] intValue];
        [self.navigationController pushViewController:vc animated:YES];
        [tableView deselectRowAtIndexPath:indexPath animated:NO];
    }
    if(_optionedStateButton == _CreditorStateButtons[1]){
        _debtDealId = [_transferringArr[indexPath.row]objectForKey:@"debtdealid"];
        
        _debtDeal = [_debtDealId intValue];
        
        NSString * auditstatusid = [_transferringArr[indexPath.row]objectForKey:@"auditstatusid"];
        
        int audit = [auditstatusid intValue];
        
        //1撤回
        if (audit == 1) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"确定要撤回!" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:@"取消", nil];
            [alert show];

        }
        
    }
    
    if (_optionedStateButton == _CreditorStateButtons[2]) {
        
        ReturnDetailsViewController *returnDetailsVC = [ReturnDetailsViewController new];
        returnDetailsVC.projectbidid = [[_buyRecordArr[indexPath.row] objectForKey:@"projectbidid"] intValue];
        [self.navigationController pushViewController:returnDetailsVC animated:YES];
        [tableView deselectRowAtIndexPath:indexPath animated:NO];
        
    }
    
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{

    if (buttonIndex == 1) {
        return;
    }else{
        [self.httpUtil requestArr4MethodNam:@"v2/accept/debt/canceltransger" parameters:@{@"debtDealId":@(_debtDeal)} result:^(NSArray *arr, int status, NSString *msg) {
            if (status == 0) {
                 [MBProgressHUD showError:msg toView:self.view];
                
            }else{
//                [_transferringArr addObjectsFromArray:arr];
                
                if (_transferringArr.count == 0) {
                    self.hideNoMsg = NO;
                }else{
                    self.hideNoMsg = YES;
                }
            }
            [self geTransferringData];
            [_tableView reloadData];
        } convertClassName:nil key:nil];
    }
}


- (void)headerRefreshloadData
{
    
    if (_touArr.count < _limit) {
        [_tableView.mj_header endRefreshing];
        return;
    }else if (_transferringArr.count<_limit){
        [_tableView.mj_header endRefreshing];

    }else{
        [_tableView.mj_header endRefreshing];
    }
    
    if (_optionedStateButton == _CreditorStateButtons[0]) {
        self.creditorState = MyDisperseInvestStatBidding;
        [self getNeotiableData];
    }
    if (_optionedStateButton == _CreditorStateButtons[1]){
        self.creditorState = MyDisperseInvestStatRufunding;
        [self geTransferringData];
    }
    if (_optionedStateButton == _CreditorStateButtons[2]){
        self.creditorState = MyDisperseInvestStatHistory;
        [self geBuyRecordData];
    }
    
    [_tableView.mj_header endRefreshing];
}

- (void)footerRefreshloadData
{
    
    if (_touArr.count-_start < _limit) {
        [MBProgressHUD showMessag:@"没有更多数据了" toView:self.view];
        
        [_tableView.mj_footer endRefreshing];
        return;
    }else if (_transferringArr.count-_start < _limit){
        [MBProgressHUD showMessag:@"没有更多数据了" toView:self.view];
        
        [_tableView.mj_footer endRefreshing];
        return;
    }else{
        [MBProgressHUD showMessag:@"没有更多数据了" toView:self.view];
        
        [_tableView.mj_footer endRefreshing];
        return;
    }
     _start = _start + _limit;
    
    if (_optionedStateButton == _CreditorStateButtons[0]) {
        self.creditorState = MyDisperseInvestStatBidding;
        [self getNeotiableData];
    }
    if (_optionedStateButton == _CreditorStateButtons[1]){
        self.creditorState = MyDisperseInvestStatRufunding;
        [self geTransferringData];
    }
    if (_optionedStateButton == _CreditorStateButtons[2]){
        self.creditorState = MyDisperseInvestStatHistory;
        [self geBuyRecordData];
    }
    
    [_tableView.mj_header endRefreshing];
    
}


@end
