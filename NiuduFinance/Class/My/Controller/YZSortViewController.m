//
//  YZSortViewController.m
//  PullDownMenu
//
//  Created by yz on 16/8/12.
//  Copyright © 2016年 yz. All rights reserved.
//

#import "YZSortViewController.h"
#import "YZSortCell.h"
#import "NetWorkingUtil.h"

extern NSString * const YZUpdateMenuTitleNote;
static NSString * const ID = @"cell";

@interface YZSortViewController ()
@property (nonatomic, copy) NSArray *titleArray;

@property (nonatomic,assign)NSInteger start;
@property (nonatomic,assign)NSInteger limit;
@property (nonatomic,strong) NSMutableArray *toArr1;
@property (nonatomic,strong) NSMutableArray *toArr2;
@property (nonatomic,assign) int status;
@end

@implementation YZSortViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    _selectedCo = 0;
    
    
    _start = 0;
    _limit = 200;
    _toArr1 = [NSMutableArray array];
    _toArr2 = [NSMutableArray array];
    _titleArray = @[@"我的优惠券",@"我的特权券"];
    
    [self.tableView registerClass:[YZSortCell class] forCellReuseIdentifier:ID];

}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    NSIndexPath *indexPath = [NSIndexPath indexPathForItem:_selectedCo inSection:0];
    [self.tableView selectRowAtIndexPath:indexPath animated:YES scrollPosition:UITableViewScrollPositionNone];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.titleArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    YZSortCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    cell.textLabel.textAlignment = NSTextAlignmentCenter;
    [cell.textLabel setFont:[UIFont systemFontOfSize:14]];
    cell.textLabel.text = _titleArray[indexPath.row];
    if (indexPath.row == 0) {
        [cell setSelected:YES animated:NO];
    }
    
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    _selectedCo = indexPath.row;
    
    NSLog(@"%ld",_selectedCo);
    // 选中当前
    YZSortCell *cell = [tableView cellForRowAtIndexPath:indexPath];

    // 更新菜单标题
    [[NSNotificationCenter defaultCenter] postNotificationName:YZUpdateMenuTitleNote object:self userInfo:@{@"title":cell.textLabel.text}];
    
    
    if (_selectedCo == 0) {
        //这里切换数据源
        [self getInBiData];
        [[NSUserDefaults standardUserDefaults]setValue:0 forKey:@"selectedCo"];
        [[NSUserDefaults standardUserDefaults]synchronize];
    }else{
        [self getBakLendData];
        [[NSUserDefaults standardUserDefaults]setValue:@"1" forKey:@"selectedCo"];
        [[NSUserDefaults standardUserDefaults]synchronize];
    }
    
    
}
//新未结清/可使用
- (void)getInBiData
{
    NetWorkingUtil *util = [NetWorkingUtil netWorkingUtil];
    [util requestDic4MethodNam:@"v2/accept/account/findAllCoupon" parameters:@{@"status":@(0)} result:^(id  dic, int status, NSString *msg) {
        NSLog(@"%@",dic);
        if (status == 0) {
            [MBProgressHUD showMessag:msg toView:self.view];
            if (_toArr1.count == 0) {
                
            }
        }else{
            
            if (_start == 0) {
                _toArr1 = [NSMutableArray array];
            }
            [_toArr1 addObjectsFromArray:dic];
            [[NSNotificationCenter defaultCenter] postNotificationName:@"notifacation"object:_toArr1];
            [[NSNotificationCenter defaultCenter] postNotificationName:@"chuanCan"object:@"0"];
            [[NSNotificationCenter defaultCenter] postNotificationName:@"tyQuan"object:@"5"];
        }
        
    }];
    
}
//新未结清/可使用/特权券
- (void)getBakLendData
{
    NetWorkingUtil *util = [NetWorkingUtil netWorkingUtil];
    [util requestDic4MethodNam:@"v2/accept/account/commonCouponList" parameters:@{@"statusid":@(0)} result:^(id  dic, int status, NSString *msg) {
        NSLog(@"%@",dic);
        if (status == 0) {
            [MBProgressHUD showMessag:msg toView:self.view];
            if (_toArr2.count == 0) {
            }
        }else{
            
            if (_start == 0) {
                _toArr2 = [NSMutableArray array];
            }
            [_toArr2 addObjectsFromArray:dic];
            [[NSNotificationCenter defaultCenter] postNotificationName:@"notifacation"object:_toArr2];
            [[NSNotificationCenter defaultCenter] postNotificationName:@"chuanCan"object:@"0"];
            [[NSNotificationCenter defaultCenter] postNotificationName:@"tyQuan"object:@"6"];
        }
        
    }];
}

@end
