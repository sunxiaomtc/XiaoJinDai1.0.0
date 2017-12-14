//
//  XReturnDetailsController.m
//  NiuduFinance
//
//  Created by 123 on 17/7/27.
//  Copyright © 2017年 liuyong. All rights reserved.
//

#import "XReturnDetailsController.h"
#import "ShareReturnDetailsCell.h"
@interface XReturnDetailsController ()<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *returnDetailsTableView;
@property (nonatomic,strong)NSMutableArray *returnDetailsArr;

@end

@implementation XReturnDetailsController

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
    [_returnDetailsTableView registerNib:[UINib nibWithNibName:@"ShareReturnDetailsCell" bundle:nil] forCellReuseIdentifier:@"ShareReturnDetailsCell"];
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
    static NSString *cellID = @"ShareReturnDetailsCell";
    ShareReturnDetailsCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [[ShareReturnDetailsCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
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


@end
