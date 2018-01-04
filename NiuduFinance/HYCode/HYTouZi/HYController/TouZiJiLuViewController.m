//
//  TouZiJiLuViewController.m
//  NiuduFinance
//
//  Created by Apple on 2018/1/4.
//  Copyright © 2018年 liuyong. All rights reserved.
//

#import "TouZiJiLuViewController.h"
#import "HYTZJLOneCell.h"
#import "SNProjectFindAllInvestorModel.h"
#import "HYTZJLTwoCell.h"

@interface TouZiJiLuViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *mainTV;

@property (nonatomic, strong) SNProjectFindAllInvestorModel * findAllModel;

@property (nonatomic, strong) NSMutableArray *dataArray;

@end

@implementation TouZiJiLuViewController

- (SNProjectFindAllInvestorModel *)findAllModel
{
    if (!_findAllModel) {
        _findAllModel = [SNProjectFindAllInvestorModel new];
        _findAllModel.key = @"__SNProjectFindAllInvestorModel__";
        _findAllModel.requestType = VZModelCustom;
    }
    return _findAllModel;
}

-(NSMutableArray *)dataArray
{
    if(_dataArray == nil)
    {
        _dataArray = [[NSMutableArray alloc] init];
    }
    return _dataArray;
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.navigationController.navigationBar setBackgroundImage:
     [UIImage imageNamed:@"dhl-bgImage"] forBarMetrics:UIBarMetricsDefault];
    
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName:[UIColor whiteColor],NSFontAttributeName:[UIFont boldSystemFontOfSize:17]};
    
    UIButton *customView = [UIButton buttonWithType:UIButtonTypeCustom];
    customView.frame = CGRectMake(0, 0, 44, 44);
    customView.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [customView setImage:[UIImage imageNamed:@"nav_back_normal"] forState:UIControlStateNormal];
    [customView addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:customView];
    
    self.title = @"投资记录";
    
    self.view.backgroundColor = qianhui244Color;
    
    [self sendServerForRequest];
}

-(void)viewWillDisappear:(BOOL)animated
{
//    [self.navigationController.navigationBar setBackgroundImage:
//     [UIImage new] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName:[UIColor blackColor],NSFontAttributeName:[UIFont boldSystemFontOfSize:17]};
}

-(void)backAction
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setHeaderUI];
    
    self.mainTV.rowHeight = 62;
    
    
}

-(void)setHeaderUI
{
    NSArray *title = @[@"当前排名",@"投资用户",@"投资金额",@"投资时间"];
    for(int i = 0; i < 4; i++)
    {
        UILabel *labels = [[UILabel alloc] init];
        labels.frame = CGRectMake(i * (SCREEN_WIDTH / 4.0f), 10, SCREEN_WIDTH / 4.0f, 40);
        labels.backgroundColor = [UIColor whiteColor];
        labels.textColor = qianhui(27, 27, 27);
        labels.font = [UIFont systemFontOfSize:15.0f];
        labels.textAlignment = NSTextAlignmentCenter;
        labels.text = title[i];
        [self.view addSubview:labels];
    }
}

//请求数据
-(void)sendServerForRequest
{
    WS
    self.findAllModel.projectId = [NSString stringWithFormat:@"%d",self.projectId];
    [self.findAllModel loadWithCompletion:^(VZModel *model, NSError *error) {
        if (!error) {
            weakSelf.dataArray = [weakSelf.findAllModel.listArray mutableCopy];
            NSLog(@"%@",weakSelf.dataArray);
            [weakSelf.mainTV reloadData];
        }
    }];
}

#pragma mark - UITableView
-(UITableView *)mainTV
{
    if(_mainTV == nil)
    {
        _mainTV = [[UITableView alloc] initWithFrame:CGRectMake(0, 50, SCREEN_WIDTH, SCREEN_HEIGHT - 50) style:UITableViewStylePlain];
        _mainTV.backgroundColor = [UIColor whiteColor];
        _mainTV.delegate = self;
        _mainTV.dataSource = self;
        _mainTV.separatorStyle = UITableViewCellSeparatorStyleNone;
        [self.view addSubview:_mainTV];
        
    }
    return _mainTV;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    //return 6;
    return self.dataArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.row < 3)
    {
        HYTZJLOneCell *cell = [HYTZJLOneCell hyTZJLOneCellForTableView:tableView];
        cell.dic = self.dataArray[indexPath.row];
        return cell;
    }else
    {
        HYTZJLTwoCell *cell = [HYTZJLTwoCell hyTZJLTwoCellForTableView:tableView];
        cell.dic = self.dataArray[indexPath.row];
        cell.pmLabel.text = [NSString stringWithFormat:@"第%ld名",indexPath.row];
        return cell;
    }
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.row < 3)
    {
        return 72;
    }else
    {
        return 62;
    }
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
