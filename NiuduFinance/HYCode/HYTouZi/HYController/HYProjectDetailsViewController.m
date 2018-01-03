//
//  HYProjectDetailsViewController.m
//  NiuduFinance
//
//  Created by Apple on 2018/1/3.
//  Copyright © 2018年 liuyong. All rights reserved.
//

#import "HYProjectDetailsViewController.h"
#import "ColorButton.h"
#import "HYPDHeaderView.h"
#import "HYPDOneCell.h"
#import "HYPDTwoCell.h"
#import "SNProjectListItem.h"
#import "XProjectDetailsNewController.h"
#import "MoreWebViewController.h"
#import "XProjectConfirmController.h"
#import "WebPageVC.h"

@interface HYProjectDetailsViewController ()<UITableViewDelegate,UITableViewDataSource,UIAlertViewDelegate>

@property (nonatomic, strong) UITableView *mainTV;

@property (nonatomic, weak) ColorButton *buyBtn;

@property (nonatomic, strong) NSArray *titleArr;

@property (nonatomic, strong) SNProjectListItem *models;

@property (nonatomic, strong) HYPDHeaderView *headerView;


@end

@implementation HYProjectDetailsViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    [self sendServerForRequest];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //self.navigationController.navigationBar.hidden = YES;
    
    
    [self setupLJTZBtn];
    
    self.headerView = [[HYPDHeaderView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 230 + WDStatusBarHeight)];
    self.headerView.superViewController = self;
    self.mainTV.tableHeaderView = self.headerView;
}

//立即投资按钮
-(void)setupLJTZBtn
{
    NSMutableArray *colorArray1 = [@[qianhui(255, 130, 0),qianhui(255, 207, 0)] mutableCopy];
    ColorButton *btn1 = [[ColorButton alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT - 50, SCREEN_WIDTH, 50) FromColorArray:colorArray1 ByGradientType:leftToRight];
    if([[User shareUser] checkIsLogin])
    {
        [btn1 setTitle:@"立即投资" forState:UIControlStateNormal];
    }else
    {
        [btn1 setTitle:@"请登录" forState:UIControlStateNormal];
    }
    [btn1 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    btn1.titleLabel.font = [UIFont fontWithName:@"STHeitiSC-Medium" size:18.0f];
    btn1.adjustsImageWhenHighlighted = NO;
    self.buyBtn = btn1;
    [btn1 addTarget:self action:@selector(buyClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn1];
}

-(void)buyClick:(UIButton *)btn
{
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    NetWorkingUtil *util = [NetWorkingUtil netWorkingUtil];
    __weak __typeof(self) weakSelf = self;
    [util requestDic4MethodNam:@"v2/accept/user/openHuifuStatus" parameters:nil result:^(NSDictionary *dic, int status, NSString *msg) {
        [MBProgressHUD hideHUDForView:weakSelf.view animated:YES];
        if (status != 0) {
            NSLog(@"%@",dic);
            Boolean open = [[dic objectForKey:@"status"] boolValue];
            NSLog(@"%hhu",open);
            if (!open) {
                //安全退出
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"请先开通汇付" delegate:weakSelf cancelButtonTitle:@"取消" otherButtonTitles:@"马上开通", nil];
                alert.tag = 888;
                [alert show];
            }else {
                XProjectConfirmController * confirmVC =[XProjectConfirmController new];
                confirmVC.projectId = _projectId;
                confirmVC.hidesBottomBarWhenPushed = YES;
                [weakSelf.navigationController pushViewController:confirmVC animated:YES];
            }
        }
    }];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(alertView.tag == 888)
    {
        if (buttonIndex == 1) {
            WebPageVC *vc = [[WebPageVC alloc] init];
            vc.title = @"开通汇付账户";
            vc.name = @"huifu/openaccount";
            WS
            vc.isOpen = ^(BOOL isO) {
                [weakSelf buyClick:nil];
            };
            vc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:vc animated:YES];
        }
    }
}

#pragma mark - 请求数据
-(void)sendServerForRequest
{
    WS
    [self.httpUtil requestDic4MethodNam:@"v2/accept/project/find" parameters:@{@"projectId":@(self.projectId)} result:^(NSDictionary *dic, int status, NSString *msg) {
        NSLog(@"%@",dic);
        if (status == 0) {
        }else
        {
            weakSelf.models = [SNProjectListItem new];
            [weakSelf.models setValuesForKeysWithDictionary:dic];
            weakSelf.headerView.models = weakSelf.models;
            [weakSelf.mainTV reloadData];
            
            NSMutableArray *colorArray2 = [@[qianhui(255, 130, 0),qianhui(255, 207, 0)] mutableCopy];
            if ([weakSelf.models.statusid integerValue] == 1)
            {
                weakSelf.buyBtn.userInteractionEnabled = YES;
                [weakSelf.buyBtn setCustomColorArray:colorArray2 byType:leftToRight];
                [weakSelf.buyBtn setTitle:@"立即投资" forState:UIControlStateNormal];
            }else if ([weakSelf.models.statusid integerValue] == 2)
            {
                [weakSelf setBtnStatus];
                [weakSelf.buyBtn setTitle:@"待审核" forState:UIControlStateNormal];
            }else if ([weakSelf.models.statusid integerValue] == 3)
            {
                [weakSelf setBtnStatus];
                [weakSelf.buyBtn setTitle:@"还款中" forState:UIControlStateNormal];
            }else if ([weakSelf.models.statusid integerValue] == 4)
            {
                [weakSelf setBtnStatus];
                [weakSelf.buyBtn setTitle:@"还款结束" forState:UIControlStateNormal];
            }else if ([weakSelf.models.statusid isEqualToNumber:@(-10000)])
            {
                [weakSelf setBtnStatus];
                [weakSelf.buyBtn setTitle:@"不是新手" forState:UIControlStateNormal];
            }else if ([weakSelf.models.statusid isEqualToNumber:@(-1)])
            {
                [weakSelf setBtnStatus];
                [weakSelf.buyBtn setTitle:@"未开始" forState:UIControlStateNormal];
            }else if ([weakSelf.models.statusid isEqualToNumber:@(-2)])
            {
                [weakSelf setBtnStatus];
                [weakSelf.buyBtn setTitle:@"募集结束" forState:UIControlStateNormal];
            }
        }
    }];
}

-(void)setBtnStatus
{
    NSMutableArray *colorArray1 = [@[qianhui140Color,qianhui140Color] mutableCopy];
    self.buyBtn.userInteractionEnabled = NO;
    [self.buyBtn setCustomColorArray:colorArray1 byType:leftToRight];
}

#pragma mark - UITableView

-(UITableView *)mainTV
{
    if(_mainTV == nil)
    {
        _mainTV = [[UITableView alloc] initWithFrame:CGRectMake(0, -WDStatusBarHeight, SCREEN_WIDTH, SCREEN_HEIGHT - 50 + WDStatusBarHeight) style:UITableViewStyleGrouped];
        _mainTV.delegate = self;
        _mainTV.dataSource = self;
        _mainTV.separatorStyle = UITableViewCellSeparatorStyleNone;
        [self.view addSubview:_mainTV];
        
        [_mainTV registerNib:[UINib nibWithNibName:@"HYPDOneCell" bundle:nil] forCellReuseIdentifier:@"HYPDOneCells"];
        [_mainTV registerNib:[UINib nibWithNibName:@"HYPDTwoCell" bundle:nil] forCellReuseIdentifier:@"HYPDTwoCells"];
    }
    return _mainTV;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(section == 0)
    {
        return 1;
    }else if (section == 1)
    {
        return 4;
    }else
    {
        return 3;
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
     [tableView deselectRowAtIndexPath:indexPath animated:YES];
    self.titleArr = @[@"项目名称",@"募集周期",@"起投金额",@"回款方式",@"项目详情",@"安全保障",@"投资记录"];
    if(indexPath.section == 0)
    {
        HYPDOneCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HYPDOneCells" forIndexPath:indexPath];
        if(self.models)
        {
            cell.models = self.models;
        }
        return cell;
    }else if (indexPath.section == 1)
    {
        HYPDTwoCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HYPDTwoCells" forIndexPath:indexPath];
        cell.titleLabel.text = self.titleArr[indexPath.row];
        if(self.models)
        {
            if(indexPath.row == 0)
            {
                cell.detailsLabel.text = self.models.title;
            }else if (indexPath.row == 1)
            {
                cell.detailsLabel.text = [self compareTwoTime:[self.models.creationdate longLongValue] time2:[self.models.collectDate longLongValue]];
            }else if (indexPath.row == 2)
            {
                cell.detailsLabel.text = [NSString stringWithFormat:@"%@起投", self.models.minbidamount];
            }else
            {
                cell.detailsLabel.text = @"一次性还款";
            }
        }
        return cell;
    }else
    {
        HYPDTwoCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HYPDTwoCells" forIndexPath:indexPath];
        cell.titleLabel.text = self.titleArr[indexPath.row + 4];
        cell.rightImage.hidden = NO;
        return cell;
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.section == 2)
    {
        if (indexPath.row == 0)
        {
            XProjectDetailsNewController *projectDetailsVC = [XProjectDetailsNewController new];
            projectDetailsVC.projectId = self.models.projectId.intValue;
            projectDetailsVC.projectItem = self.models;
            self.hidesBottomBarWhenPushed=YES;
            [self.navigationController pushViewController:projectDetailsVC animated:YES];
        }else if (indexPath.row == 1)
        {
            MoreWebViewController * moreWebVC = [MoreWebViewController new];
            moreWebVC.titleStr = @"安全保障";
            moreWebVC.webStr =@"v2/accept/new2";
            self.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:moreWebVC animated:YES];
        }else
        {
        }
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.section == 0)
    {
        return 90;
    }
    return 45;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return [[UIView alloc] init];
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return [[UIView alloc] init];
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.01;
}

- (NSString*)compareTwoTime:(long long)time1 time2:(long long)time2
{
    NSTimeInterval balance = time2 / 1000 - time1 /1000;
    
    NSString *timeString = [[NSString alloc]init];
    
    timeString = [NSString stringWithFormat:@"%f",balance /60];
    
    timeString = [timeString substringToIndex:timeString.length-7];
    
    NSInteger timeInt = [timeString intValue];
    
    NSInteger hour = timeInt / 60;
    
    NSInteger mint = timeInt % 60;
    
    NSInteger day = hour / 24;
    
    if(day != 0)
    {
        timeString = [NSString stringWithFormat:@"%ld天",(long)day];
        return timeString;
    }
    if(hour ==0)
    {
        timeString = [NSString stringWithFormat:@"%ld分钟",(long)mint];
    }else
    {
        if(mint ==0)
        {
            timeString = [NSString stringWithFormat:@"%ld小时",(long)hour];
        }
        else
        {
            timeString = [NSString stringWithFormat:@"%ld小时%ld分钟",(long)hour,(long)mint];
        }
    }
    return timeString;
    
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
