//
//  HYNewActivtyViewController.m
//  NiuduFinance
//
//  Created by Apple on 2017/12/19.
//  Copyright © 2017年 liuyong. All rights reserved.
//

#import "HYNewActivtyViewController.h"
#import "HYNewActivtyCell.h"
#import "NoMsgView.h"
#import "HYHTTPTools.h"

@interface HYNewActivtyViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, weak) UITableView *mainTV;

@end

@implementation HYNewActivtyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"动态";
    [self setupMainTV];
    [self setupHeaderRefresh:self.mainTV];
    [self setupFooterRefresh:self.mainTV];
}

//数据请求
-(void)sendServerForRequest
{
    NSDictionary *dic = @[];
    [[HYHTTPTools shareHTTPS] postServerForAFNetWorkingURL:@"" parmer:dic success:^(id responeseObj) {
        
    } failed:^(NSError *error) {
        
    }];
}

#pragma mark - UITableView
- (void)setupHeaderRefresh:(UITableView *)tableView
{
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(headerRefreshloadData)];
    header.lastUpdatedTimeLabel.font = [UIFont systemFontOfSize:12];
    header.stateLabel.font = [UIFont systemFontOfSize:12];
    tableView.mj_header = header;
}

- (void)setupFooterRefresh:(UITableView *)tableView
{
    MJRefreshBackNormalFooter *footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(footerRefreshloadData)];
    footer.stateLabel.font = [UIFont systemFontOfSize:12];
    footer.arrowView.alpha = 0.0;
    tableView.mj_footer = footer;
}

-(void)headerRefreshloadData
{
    
}

-(void)footerRefreshloadData
{
    
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    HYNewActivtyCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HYNACell" forIndexPath:indexPath];
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 160;
}

-(void)setupMainTV
{
    UITableView *mainTV = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 64 - 49) style:UITableViewStylePlain];
    mainTV.delegate = self;
    mainTV.dataSource = self;
    mainTV.separatorStyle = UITableViewCellSeparatorStyleNone;
    mainTV.backgroundColor = qianhui244Color;
    [self.view addSubview:mainTV];
    self.mainTV = mainTV;
    
    [mainTV registerNib:[UINib nibWithNibName:@"HYNewActivtyCell" bundle:nil] forCellReuseIdentifier:@"HYNACell"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
