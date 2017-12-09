//
//  AnnouncementViewController.m
//  NiuduFinance
//
//  Created by 邢天阔 on 2017/10/19.
//  Copyright © 2017年 liuyong. All rights reserved.
//

#import "AnnouncementViewController.h"
#import "AnnouncementCell.h"
#import "PageWebViewController.h"

static NSString *AnnouncementCellID = @"AnnouncementCell";

@interface AnnouncementViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *announcementTabView;
@property (nonatomic, strong) NSMutableArray *dataArray;
@end

@implementation AnnouncementViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"网站公告";
    self.dataArray = [NSMutableArray array];
    [self createTabView];
    [self loadData];
}

- (void)createTabView {

    self.announcementTabView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) style:UITableViewStyleGrouped];
    self.announcementTabView.delegate = self;
    self.announcementTabView.dataSource = self;
    self.announcementTabView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.announcementTabView];
    
    [self setupBarButtomItemWithImageName:@"黑色返回按钮" highLightImageName:@"黑色返回按钮" selectedImageName:nil target:self action:@selector(backClick) leftOrRight:YES];
}
#pragma mark - 返回上一个页面
- (void)backClick {
    [self.navigationController popViewControllerAnimated:YES];
}


- (void)loadData {
    NSString *url = [NSString stringWithFormat:@"%@v2/open/affiche/findAll",__API_HEADER__];
    NSDictionary *dic = @{
                          @"start" : @"0",
                          @"limit" : @"12",
                          };
    [NSObject POST:url parameters:dic progress:^(NSProgress *downloadProgress) {
        
    } completionHandler:^(id responseObject, NSError *error) {
        if (error) {
            
        }else {
            self.dataArray = responseObject[@"data"];
        }
        [self.announcementTabView reloadData];
    }];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.dataArray.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    AnnouncementCell *cell = [tableView dequeueReusableCellWithIdentifier:AnnouncementCellID];
    if (!cell) {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"AnnouncementCell" owner:self options:nil]lastObject];
    }
    cell.announcementTitleLabel.text = [self.dataArray[indexPath.section] objectForKey:@"title"];
    //时间戳转成时间
    NSString *dataStr = [NSString stringWithFormat:@"%@",[self.dataArray[indexPath.section] objectForKey:@"showdate"]];
    NSString *currentStr = [dataStr substringWithRange:NSMakeRange(0,10)];
    
    NSDateFormatter *stampFormatter = [[NSDateFormatter alloc] init];
    [stampFormatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
    NSDate *stampDate = [NSDate dateWithTimeIntervalSince1970:[currentStr integerValue]];
    cell.announcementTimeLabel.text = [NSString stringWithFormat:@"%@",[stampFormatter stringFromDate:stampDate]];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    PageWebViewController *pageWebVC = [PageWebViewController new];
    pageWebVC.urlStr = [NSString stringWithFormat:@"%@v2/open/appAfficheDetail.jsp?id=%@",__API_HEADER__,[self.dataArray[indexPath.section] objectForKey:@"newsinformationid"]];;
    pageWebVC.title = @"最新公告";
    self.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:pageWebVC animated:YES];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 5;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 5;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
