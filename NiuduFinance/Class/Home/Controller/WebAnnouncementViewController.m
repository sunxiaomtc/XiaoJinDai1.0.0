//
//  WebAnnouncementViewController.m
//  NiuduFinance
//
//  Created by 123 on 17/2/7.
//  Copyright © 2017年 liuyong. All rights reserved.
//

#import "WebAnnouncementViewController.h"
#import "AnnounTableViewCell.h"
#import "MoreWebViewController.h"
@interface WebAnnouncementViewController ()<UITableViewDelegate,UITableViewDataSource>


@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic ,strong)NSMutableArray * data;
@property (nonatomic, strong)NSDictionary * dic;

@property (nonatomic, strong)NSString * titleNamee;
@property (nonatomic, strong)NSString * titleDate;

@property (nonatomic, assign)NSInteger start;
@property (nonatomic, assign)NSInteger limit;

@end

@implementation WebAnnouncementViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _start = 0;
    _limit = 5;
    _tableView.backgroundColor = [UIColor colorWithHexString:@"#F0EFF5"];
    _data = [NSMutableArray new];
    [_tableView setTableFooterView:[[UIView alloc] initWithFrame:CGRectZero]];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
     [self setupRefreshWithTableView:_tableView];
    [self getTitle];

}


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:NO];
    [self setupNavi];
}
- (void)setupNavi
{
    [self.navigationController setNavigationBarHidden:NO animated:NO];
    self.title = @"网站公告";
    
    UIButton *customView = [UIButton buttonWithType:UIButtonTypeCustom];
    customView.frame = CGRectMake(0, 0, 44, 44);
    customView.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [customView setImage:[UIImage imageNamed:@"nav_back_normal"] forState:UIControlStateNormal];
    [customView addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:customView];
}
- (void)getTitle{
    
    [self.httpUtil requestDic4MethodNam:@"v2/open/affiche/findAll" parameters:@{@"limit":@(_limit),@"start":@(_start)} result:^(id dic, int status, NSString *msg) {
        
        if (status ==0) {
            [MBProgressHUD showMessag:msg toView:self.view];
        }else{
            NSLog(@"%@",dic);
            [_data addObjectsFromArray:dic];
            [_tableView.mj_footer resetNoMoreData];
            [self.tableView reloadData];

        }
        
    }];
}
//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    return 75*SINGLE_LINE_WIDTH;
//}
//section头部显示的内容
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *header;
    if (section==0) {
        header = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 10*SINGLE_LINE_WIDTH)];
        header.backgroundColor = [UIColor whiteColor];
    }else{
        header = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 18*SINGLE_LINE_WIDTH)];
        header.backgroundColor = [UIColor whiteColor];
        UILabel *line = [[UILabel alloc] initWithFrame:CGRectMake(0, 8*SINGLE_LINE_WIDTH, SCREEN_WIDTH, 18*SINGLE_LINE_WIDTH)];
        line.backgroundColor = RGB(250, 250, 250);
        [header addSubview:line];
    }
    
    
    return header;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section;
{
    if (section==0) {
        return 10;
    }
    return 18;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    return self.data.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifierStr = @"AnnounTableViewCell";
    AnnounTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifierStr];
    if (cell == nil){
        cell = [[[NSBundle mainBundle] loadNibNamed:@"AnnounTableViewCell" owner:self options:nil] lastObject];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    NSDictionary *dataDic = self.data[indexPath.section];
    
    NSLog(@"------>%@",[NSString stringWithFormat:@"%@",[dataDic objectForKey:@"showdate"]]);
    NSString * timeStampString = [NSString stringWithFormat:@"%@",[dataDic objectForKey:@"showdate"]];
    NSTimeInterval _interval=[timeStampString doubleValue] / 1000.0;
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:_interval];
    NSDateFormatter *objDateformat = [[NSDateFormatter alloc] init];
    [objDateformat setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSLog(@"%@", [objDateformat stringFromDate: date]);
    
    [cell setuptitle:[NSString stringWithFormat:@"%@",[dataDic objectForKey:@"title"]] titleDate:[NSString stringWithFormat:@"%@",[objDateformat stringFromDate: date]]];
    

    
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *string = [[NSString alloc] initWithFormat:@"%ld",[[_data [indexPath.section]objectForKey:@"newsinformationid"] integerValue]];
    NSLog(@"%@",string);
    NSString * srtt = [[[NSMutableString stringWithString:@""]stringByAppendingString:@"v2/open/appAfficheDetail.jsp?id=" ]stringByAppendingString:string];
    NSLog(@"%@",srtt);
    
    MoreWebViewController * moreWebVC = [MoreWebViewController new];
    moreWebVC.titleStr = [_data[indexPath.row]objectForKey:@"title"];
    moreWebVC.webStr = srtt;
    NSLog(@"%@",moreWebVC.webStr);
    [self.navigationController pushViewController:moreWebVC animated:YES];
}

- (void)headerRefreshloadData
{

    if (_data.count-_start <_limit) {
//        [MBProgressHUD showMessag:@"没有更多数据了" toView:self.view];
        [_tableView.mj_header endRefreshing];
        return;
    }
    _start = _start + _limit;
    [self getTitle];
    [_tableView.mj_header endRefreshing];
}

- (void)footerRefreshloadData
{
    NSLog(@"%ld",_data.count);
    if (_data.count-_start <_limit) {
        [MBProgressHUD showMessag:@"没有更多数据了" toView:self.view];
        [_tableView.mj_footer endRefreshing];
        return;
    }
    _start = _start + _limit;
    [self getTitle];
    [_tableView.mj_footer endRefreshing];
    
}

@end
