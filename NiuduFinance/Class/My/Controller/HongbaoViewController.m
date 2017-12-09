//
//  HongbaoViewController.m
//  NiuduFinance
//
//  Created by andrewliu on 16/9/12.
//  Copyright © 2016年 liuyong. All rights reserved.
//

#import "HongbaoViewController.h"
#import "BenefitsCell.h"

@interface HongbaoViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *StateButtonsArray;

@property (weak, nonatomic) IBOutlet UITableView *tableview;
@property (strong, nonatomic) UIButton *hongbaoStateButton;

@property (assign, nonatomic) HongbaoState hongbaoState;

//测试用
@property (nonatomic,assign)NSInteger start;
@property (nonatomic,assign)NSInteger limit;
@property (nonatomic,strong) NSDictionary *hongBaoAllDic;
@property (nonatomic,strong) NSMutableArray *hongBaoArr;

@property (nonatomic,assign)NSInteger  status;



@end
@implementation HongbaoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"我的福利";
    [self backBarItem];
    [self loadTableView];
    [self loadCanHongBaoData];

    
    _hongBaoAllDic = [NSDictionary dictionary];
    _hongBaoArr = [NSMutableArray array];
    _start = 0;
    _limit = 5;
    
    _hongbaoState = HongbaoStateCanUser;
    _hongbaoStateButton = _StateButtonsArray[2];
    
    
    [_hongbaoStateButton setTitleColor:NaviColor forState:UIControlStateNormal];
    
}


- (void)loadTableView{

    [self setupRefreshWithTableView:_tableview];
    _tableview.delegate = self;
    _tableview.dataSource = self;
    
    _tableview.backgroundColor = [UIColor colorWithHexString:@"#F0EFF5"];
    _tableview.tableFooterView = [UIView new];
    
    [_tableview registerNib:[UINib nibWithNibName:@"BenefitsCell" bundle:nil] forCellReuseIdentifier:@"BenefitsCell"];

}

#pragma mark -- Action

- (IBAction)optionStateAction:(UIButton *)sender {
    
    _hongbaoStateButton.selected = !_hongbaoStateButton.selected;
    _hongBaoArr = [NSMutableArray array];
    //    _start = 0;
    //    _limit = 5;
    //    [_hongBaoArr removeAllObjects];
    if (sender == _hongbaoStateButton) {
        return;
    }else{
        
        _hongbaoStateButton.selected = NO;
        sender.selected = YES;
        [_hongbaoStateButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    }
    
    _hongbaoStateButton = sender;
    [_hongbaoStateButton setTitleColor:NaviColor forState:UIControlStateNormal];
    if (_hongbaoStateButton == _StateButtonsArray[2]) {
        
        self.hongbaoState = HongbaoStateCanUser;
        
        [self loadCanHongBaoData];
    }
    if (_hongbaoStateButton == _StateButtonsArray[1]) {
        
        self.hongbaoState = HongbaoStateUsed;
        [self loadUsedHongBaoData];
    }
    if (_hongbaoStateButton == _StateButtonsArray[0]) {
        
        self.hongbaoState = HongbaoStateAbandon;
        [self loadAbandonHongBaoData];
    }
}


- (void)setHongbaoState:(HongbaoState)hongbaoState
{
    _hongbaoState = hongbaoState;
    //    [_tableview reloadData];
}
//可用的红包
- (void)loadCanHongBaoData{
    
        [self.httpUtil requestDic4MethodNam:@"v2/accept/account/findAllCoupon" parameters:@{@"status":@(0)} result:^(id  dic, int status, NSString *msg) {
    
    
            if (status == 0) {
                [MBProgressHUD showMessag:msg toView:self.view];
               if (_hongBaoArr.count == 0) {
                self.hideNoNetWork = NO;
                self.noNetWorkView.top = 53;
                self.noNetWorkView.height = SCREEN_HEIGHT - 53;
                self.noNetWorkView.width = SCREEN_WIDTH;
               }
    
            }else{
    
                self.hideNoNetWork = YES;
                NSLog(@"%@",dic);
                if (_start == 0) {
                    _hongBaoArr = [NSMutableArray array];
                }
                [_hongBaoArr removeAllObjects];
                [_hongBaoArr addObjectsFromArray:dic];
                [_tableview.mj_footer resetNoMoreData];
    
                }
            [_tableview reloadData];
    
        }];
    
}
//已近使用的红包
- (void)loadUsedHongBaoData{
    
    
    
    [self.httpUtil requestDic4MethodNam:@"v2/accept/account/findAllCoupon" parameters:@{@"status":@(1)} result:^(id  dic, int status, NSString *msg) {
        
        
        if (status == 0) {
            [MBProgressHUD showMessag:msg toView:self.view];
            
            if (_hongBaoArr.count == 0) {
                self.hideNoNetWork = NO;
                self.noNetWorkView.top = 53;
                self.noNetWorkView.height = SCREEN_HEIGHT - 53;
                self.noNetWorkView.width = SCREEN_WIDTH;
            }
        }else{
            
            self.hideNoNetWork = YES;
            NSLog(@"%@",dic);
            if (_start == 0) {
                _hongBaoArr = [NSMutableArray array];
            }
            [_hongBaoArr removeAllObjects];
            [_hongBaoArr addObjectsFromArray:dic];
            [_tableview.mj_footer resetNoMoreData];
            
        }
        [_tableview reloadData];
        
    }];
}

//已近过期的红包
- (void)loadAbandonHongBaoData{
    
    
    [self.httpUtil requestDic4MethodNam:@"v2/accept/account/findAllCoupon" parameters:@{@"status":@(2)} result:^(id  dic, int status, NSString *msg) {
        
        
        if (status == 0) {
            [MBProgressHUD showMessag:msg toView:self.view];
            if (_hongBaoArr.count == 0) {
                self.hideNoNetWork = NO;
                self.noNetWorkView.top = 53;
                self.noNetWorkView.height = SCREEN_HEIGHT - 53;
                self.noNetWorkView.width = SCREEN_WIDTH;
            }
            
        }else{
            
            self.hideNoNetWork = YES;
            NSLog(@"%@",dic);
            [_hongBaoArr removeAllObjects];
            [_hongBaoArr addObjectsFromArray:dic];
            [_tableview.mj_footer resetNoMoreData];
            
        }
        [_tableview reloadData];
        
    }];
}
#pragma mark -- tableViewdelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 130;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return _hongBaoArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    BenefitsCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BenefitsCell"];
//    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (indexPath.row<_hongBaoArr.count) {
        [cell creditorState:_hongbaoState model:_hongBaoArr[indexPath.row]];
    }
    return cell;
}




- (void)headerRefreshloadData
{
    [_tableview.mj_header endRefreshing];
}

- (void)footerRefreshloadData
{
    [MBProgressHUD showMessag:@"没有更多数据了" toView:self.view];

    [_tableview.mj_footer endRefreshing];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
