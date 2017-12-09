//
//  ReturnDetailsViewController.m
//  NiuduFinance
//
//  Created by liuyong on 16/3/16.
//  Copyright © 2016年 liuyong. All rights reserved.
//

#import "ReturnDetailsViewController.h"
#import "ReturnDetailsTableViewCell.h"

@interface ReturnDetailsViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *returnDetailsTableView;

@property (nonatomic,strong)NSMutableArray *returnDetailsArr;
@end

@implementation ReturnDetailsViewController
- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])
    {
        self.title = @"回款详情";
    }
    return self;
}

- (void)setProjectId:(int)projectId
{
    _projectId = projectId;
    
    [self getReturnDetailsData];
    [self getReturnDetailsDat];
}

- (void)setProjectbidid:(int)projectbidid
{
    _projectbidid = projectbidid;
    
    [self getReturnDetailsDat];
}



- (void)viewDidLoad {
    [super viewDidLoad];
    [self backBarItem];
    
    _returnDetailsArr = [NSMutableArray array];
    
    [self setTableViewInfo];
}

- (void)getReturnDetailsData
{
    [self.httpUtil requestArr4MethodNam:@"v2/accept/project/repaymentdetail" parameters:@{@"projectId":@(_projectId),@"projectbidid":@(_projectbidid),@"projectType":@(1)} result:^(NSArray *arr, int status, NSString *msg) {
        if (status == 0) {
        }else{
            [_returnDetailsArr addObjectsFromArray:arr];
            if (_returnDetailsArr.count == 0) {
                self.hideNoMsg = NO;
            }else{
                self.hideNoMsg = YES;
            }
        }
        [_returnDetailsTableView reloadData];
    } convertClassName:nil key:nil];

}

- (void)getReturnDetailsDat
{
    
    [self.httpUtil requestArr4MethodNam:@"v2/accept/project/repaymentdetail" parameters:@{@"projectId":@(_projectId),@"projectbidid":@(_projectbidid),@"projectType":@(0)} result:^(NSArray *arr, int status, NSString *msg) {
        if (status == 0) {
        }else{
            [_returnDetailsArr addObjectsFromArray:arr];
            
            if (_returnDetailsArr.count == 0) {
                self.hideNoMsg = NO;
            }else{
                self.hideNoMsg = YES;
            }
        }
        [_returnDetailsTableView reloadData];
    } convertClassName:nil key:nil];
}

- (void)setTableViewInfo
{
    _returnDetailsTableView.tableFooterView = [UIView new];
    [_returnDetailsTableView registerNib:[UINib nibWithNibName:@"ReturnDetailsTableViewCell" bundle:nil] forCellReuseIdentifier:@"ReturnDetailsTableViewCell"];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _returnDetailsArr.count;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 127;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID = @"ReturnDetailsTableViewCell";
    ReturnDetailsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [[ReturnDetailsTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.returnDetailsDic = _returnDetailsArr[indexPath.row];
    return cell;
}

- (void)headerRefreshloadData
{
    
    [_returnDetailsTableView.mj_header endRefreshing];
}

- (void)footerRefreshloadData
{
    [_returnDetailsTableView.mj_footer endRefreshing];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
