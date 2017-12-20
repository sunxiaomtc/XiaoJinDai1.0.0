//
//  YZMoreMenuViewController.m
//  PullDownMenu
//
//  Created by yz on 16/8/12.
//  Copyright © 2016年 yz. All rights reserved.
//

#import "YZMoreMenuViewController.h"
#import "YZMoreMenuCell.h"
#import "NetWorkingUtil.h"
#import "YZSortViewController.h"
extern NSString * const YZUpdateMenuTitleNote;
static NSString * const ID = @"cell";

@interface YZMoreMenuViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, copy) NSArray *titleArray;
// 记录选中的cell
@property (nonatomic, assign) NSInteger selectedCol;
@property (nonatomic, assign) id selected;
@property (nonatomic,assign)NSInteger start;
@property (nonatomic,assign)NSInteger limit;

@property (nonatomic,strong) NSMutableArray *toArr1;
@property (nonatomic,strong) NSMutableArray *toArr2;
@property (nonatomic,strong) NSMutableArray *toArr3;
@property (nonatomic,assign) int status;

@end

@implementation YZMoreMenuViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    // Do any additional setup after loading the view from its nib.
    
    _start = 0;
    _limit = 200;
    _toArr1 = [NSMutableArray array];
    _toArr2 = [NSMutableArray array];
    _toArr3 = [NSMutableArray array];
    _titleArray = @[@"可使用",@"已使用",@"已过期"];
    
    
    
    [self.tableView registerClass:[YZMoreMenuCell class] forCellReuseIdentifier:ID];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    NSIndexPath *indexPath = [NSIndexPath indexPathForItem:_selectedCol inSection:0];
    [self.tableView selectRowAtIndexPath:indexPath animated:YES scrollPosition:UITableViewScrollPositionNone];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _titleArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    YZMoreMenuCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    cell.textLabel.textAlignment = NSTextAlignmentCenter;
    [cell.textLabel setFont:[UIFont systemFontOfSize:14]];
    cell.textLabel.text = _titleArray[indexPath.row];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
   
    _selectedCol = indexPath.row;
    YZMoreMenuCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:YZUpdateMenuTitleNote object:self userInfo:@{@"title":cell.textLabel.text}];
    
    self.selected = [[NSUserDefaults standardUserDefaults]objectForKey:@"selectedCo"];
    NSLog(@"%@",_selected);
    NSInteger C  = [_selected integerValue];
    NSLog(@"%ld",C);

    if (C == 0) {

        if (_selectedCol == 0)
        {
            [self getInBiData];
            
        }else if (_selectedCol == 1)
        {
            [self getBakLendData];
        }else
        {
            [self getAllBdData];
        }
    }else{
        if (_selectedCol == 0)
        {
            [self getInBiData1];
            
        }else if (_selectedCol == 1)
        {
            [self getBakLendData1];
        }else
        {
            [self getAllBdData1];
        }
    }
}

//新未结清/可使用
- (void)getInBiData
{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"YHQLoading"object:0];
    NetWorkingUtil *util = [NetWorkingUtil netWorkingUtil];
    [util requestDic4MethodNam:@"v2/accept/account/findAllCoupon" parameters:@{@"status":@(0)} result:^(id  dic, int status, NSString *msg) {
        NSLog(@"%@",dic);
        [[NSNotificationCenter defaultCenter] postNotificationName:@"HIDEHUD"object:0];
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
            [[NSNotificationCenter defaultCenter] postNotificationName:@"chuanCan"object:0];
        }
        [_tableView reloadData];

    }];

}

//新已结清/已使用
- (void)getBakLendData
{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"YHQLoading"object:0];
    NetWorkingUtil *util = [NetWorkingUtil netWorkingUtil];
    [util requestDic4MethodNam:@"v2/accept/account/findAllCoupon" parameters:@{@"status":@(1)} result:^(id  dic, int status, NSString *msg) {
        NSLog(@"%@",dic);
        [[NSNotificationCenter defaultCenter] postNotificationName:@"HIDEHUD"object:0];
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
            [[NSNotificationCenter defaultCenter] postNotificationName:@"chuanCan"object:@"1"];

        }
        [_tableView reloadData];

    }];

}

//新全部/已过期
- (void)getAllBdData
{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"YHQLoading"object:0];
    NetWorkingUtil *util = [NetWorkingUtil netWorkingUtil];
    [util requestDic4MethodNam:@"v2/accept/account/findAllCoupon" parameters:@{@"status":@(2)} result:^(id  dic, int status, NSString *msg) {
        NSLog(@"%@",dic);
        [[NSNotificationCenter defaultCenter] postNotificationName:@"HIDEHUD"object:0];
        if (status == 0) {
            [MBProgressHUD showMessag:msg toView:self.view];
            if (_toArr3.count == 0) {

            }
            
        }else{
            if (_start == 0) {
                _toArr3 = [NSMutableArray array];
            }
            [_toArr3 addObjectsFromArray:dic];
            [[NSNotificationCenter defaultCenter] postNotificationName:@"notifacation"object:_toArr3];
            [[NSNotificationCenter defaultCenter] postNotificationName:@"chuanCan"object:@"2"];

        }
        [_tableView reloadData];

    }];

}

//新未结清
- (void)getInBiData1
{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"YHQLoading"object:0];
    NetWorkingUtil *util = [NetWorkingUtil netWorkingUtil];
    [util requestDic4MethodNam:@"v2/accept/account/commonCouponList" parameters:@{@"statusid":@(0)} result:^(id  dic, int status, NSString *msg) {
        NSLog(@"%@",dic);
        [[NSNotificationCenter defaultCenter] postNotificationName:@"HIDEHUD"object:0];
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

        }
        [_tableView reloadData];
        
    }];
    
}

//新已结清
- (void)getBakLendData1
{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"YHQLoading"object:0];
    NetWorkingUtil *util = [NetWorkingUtil netWorkingUtil];
    [util requestDic4MethodNam:@"v2/accept/account/commonCouponList" parameters:@{@"statusid":@(1)} result:^(id  dic, int status, NSString *msg) {
        NSLog(@"%@",dic);
        [[NSNotificationCenter defaultCenter] postNotificationName:@"HIDEHUD"object:0];
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
            [[NSNotificationCenter defaultCenter] postNotificationName:@"chuanCan"object:@"1"];

            
        }
        [_tableView reloadData];
        
    }];
    
}

//新全部
- (void)getAllBdData1
{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"YHQLoading"object:0];
    NetWorkingUtil *util = [NetWorkingUtil netWorkingUtil];
    [util requestDic4MethodNam:@"v2/accept/account/commonCouponList" parameters:@{@"statusid":@(2)} result:^(id  dic, int status, NSString *msg) {
        NSLog(@"%@",dic);
        [[NSNotificationCenter defaultCenter] postNotificationName:@"HIDEHUD"object:0];
        if (status == 0) {
            [MBProgressHUD showMessag:msg toView:self.view];
            if (_toArr3.count == 0) {
                
            }
            
        }else{
            if (_start == 0) {
                _toArr3 = [NSMutableArray array];
            }
            [_toArr3 addObjectsFromArray:dic];
            [[NSNotificationCenter defaultCenter] postNotificationName:@"notifacation"object:_toArr3];
            [[NSNotificationCenter defaultCenter] postNotificationName:@"chuanCan"object:@"2"];

        }
        [_tableView reloadData];
        
    }];
    
}

@end
