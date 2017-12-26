//
//  NewsViewController.m
//  NiuduFinance
//
//  Created by 邢天阔 on 2017/9/28.
//  Copyright © 2017年 liuyong. All rights reserved.
//

#import "NewsViewController.h"
#import "NewsTableViewCell.h"
#import "NewsPopView.h"
#import "NewsModel.h"
#import "MJExtension.h"
#import "RequestService.h"
#import "NewsDetailViewController.h"

static NSString *NewsTableViewCellID = @"NewsTableViewCell";
static NSString *newsType = @"";

@interface NewsViewController ()<UITableViewDelegate, UITableViewDataSource>
/**筛选按钮
 */
@property (nonatomic, strong) UIButton *rightBtn;
@property (nonatomic, strong) UITableView *newsTabelView;
@property (nonatomic, weak) NewsPopView *popView;
@property (nonatomic, assign) NSInteger page;//页数
@property(nonatomic, strong)NSMutableArray *dataArray;
@end

@implementation NewsViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    self.page = 1;
    newsType = @"0";
    self.navigationItem.title = @"消息";
    [self.view addSubview:self.newsTabelView];
    [self setupRefreshWithTableView:self.newsTabelView];//首页下拉刷新
    [self createBackButton];
    self.page = 1;
    self.dataArray = [NSMutableArray array];
    [self loadDataNewsList];//请求数据
}
#pragma mark - 创建返回按钮和右侧按钮
- (void)createBackButton {
    [self setupBarButtomItemWithImageName:@"黑色返回按钮" highLightImageName:@"黑色返回按钮" selectedImageName:nil target:self action:@selector(backClick) leftOrRight:YES];
    
    UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 0.5f)];
    lineView.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:lineView];
    
    UIButton *rightBtn = [[UIButton alloc] initWithFrame:(CGRect){10, 10, 44, 44}];
    [rightBtn setTitle:@"筛选" forState:UIControlStateNormal];
    [rightBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    rightBtn.titleLabel.font = [UIFont systemFontOfSize:13.f];
    [rightBtn addTarget:self action:@selector(editBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    self.rightBtn = rightBtn;
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
}
- (void)editBtnClick:(UIButton *)sender {
    WS
    sender.selected = !sender.selected;
    if (sender.selected) {
        NSLog(@"下拉框显示");
        NewsPopView *popView = [NewsPopView buttonTag:^(NSInteger buttonTag) {
            weakSelf.page = 1;
            if (buttonTag == 100) {
                NSLog(@"点击了全部");
                newsType = @"0";
                [weakSelf loadDataNewsList];//请求全部的数据
            }
            else if (buttonTag == 101) {
                newsType = @"1";
                [weakSelf loadDataNewsList];//请求系统消息的数据
            }
            else if (buttonTag == 102){
                newsType = @"2";
                [weakSelf loadDataNewsList];//请求用户消息的数据
            }
            [weakSelf.rightBtn setTitle:@"筛选" forState:UIControlStateNormal];
            sender.selected = !sender.selected;
        }];
        [weakSelf.view addSubview:popView];
        weakSelf.popView = popView;
    }else {
        NSLog(@"下拉框隐藏");
        [weakSelf.popView closeAction];
    }
    [self.rightBtn setTitle:sender.selected ? @"取消":@"筛选" forState:UIControlStateNormal];
}

#pragma marlk - 请求消息数据
- (void)loadDataNewsList {
    //NSString *pageStr = [NSString stringWithFormat:@"%ld",(long)self.page];
    NSString *url = [__API_HEADER__ stringByAppendingString:@"v2/accept/msg/findALL"];
    
    NSDictionary *dic = @{
                          @"id":newsType,
                          @"start":[NSString stringWithFormat:@"%ld", (self.page-1)*10],
                          @"limit":@"10"
                          };
    [NSObject POST:url parameters:dic progress:^(NSProgress *downloadProgress) {
        
    } completionHandler:^(id responseObject, NSError *error) {
        if (error) {
            
        }else {
            [NewsModel mj_setupReplacedKeyFromPropertyName:^NSDictionary *{
                
                return @{@"typeId":@"typeid"};
            }];
            if (self.page == 1) {
                self.dataArray = [NSMutableArray arrayWithArray:[NewsModel mj_objectArrayWithKeyValuesArray:[responseObject objectForKey:@"data"]]];
            }else {
                NSMutableArray *tempArray = [NSMutableArray arrayWithArray:[NewsModel mj_objectArrayWithKeyValuesArray:[responseObject objectForKey:@"data"]]];
                [self.dataArray addObjectsFromArray:tempArray];
            }
            if (self.dataArray.count == 0) {
                [self.view addSubview:self.noMsgView];
            }else {
                [self.noMsgView removeFromSuperview];
            }
            [self.newsTabelView reloadData];
        }
        [self.newsTabelView reloadData];
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NewsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NewsTableViewCellID];
    if (!cell) {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"NewsTableViewCell" owner:self options:nil]lastObject];
    }
    cell.layoutMargins = UIEdgeInsetsZero;
    cell.separatorInset = UIEdgeInsetsZero;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.model = self.dataArray[indexPath.row];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NewsDetailViewController *vc = [[NewsDetailViewController alloc]init];
    vc.newsModel = self.dataArray[indexPath.row];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 70;
}


- (UITableView *)newsTabelView {
    if (!_newsTabelView) {
        if(isIPhoneX)
        {
            _newsTabelView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - WDTopHeight + 34) style:UITableViewStylePlain];
        }else
        {
            _newsTabelView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 64) style:UITableViewStylePlain];
        }
        
        _newsTabelView.delegate = self;
        _newsTabelView.dataSource = self;
        _newsTabelView.showsVerticalScrollIndicator = NO;
        _newsTabelView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
//        _newsTabelView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _newsTabelView;
}

#pragma mark - 返回上一个页面
- (void)backClick {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)headerRefreshloadData {
    [self.newsTabelView.mj_header endRefreshing];
    self.page = 1;
    [self loadDataNewsList];//请求数据
}
- (void)footerRefreshloadData {
    [self.newsTabelView.mj_footer endRefreshing];
    self.page ++;
    [self loadDataNewsList];//请求数据
}
- (void)naButtonAction {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
