//
//  MyTouZiViewController.m
//  NiuduFinance
//
//  Created by mac on 2017/9/30.
//  Copyright © 2017年 liuyong. All rights reserved.
//

#import "MyTouZiViewController.h"
#import "MyDispeController.h"
#import "XShareProjectController.h"
#import "MyCreditorViewController.h"
#import "MyZouZiTableViewCell.h"
#import "NetWorkingUtil.h"

@interface MyTouZiViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic , copy) NSString *str_one;
@property (nonatomic , copy) NSString *str_two;
@property (nonatomic , copy) NSString *str_three;
@end

@implementation MyTouZiViewController

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    NSDictionary *mine = [NSDictionary dictionaryWithObject:[UIColor blackColor] forKey:NSForegroundColorAttributeName];
    self.navigationController.navigationBar.titleTextAttributes = mine;
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    [self setupBarButtomItemWithImageName:@"黑色返回按钮" highLightImageName:@"nav_back_select.png" selectedImageName:nil target:self action:@selector(backClick) leftOrRight:YES];
    self.title = @"投资记录";
}

-(void)backClick
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.tableView.delegate =self;
    self.tableView.dataSource =self;
    [self.tableView registerNib:[UINib nibWithNibName:@"MyZouZiTableViewCell" bundle:nil] forCellReuseIdentifier:@"MyZouZiTableViewCell"];
//    [self.navigationController setNavigationBarHidden:YES animated:NO];
    [self backBarItem];
    [self getNetWorkData];
}

- (void)getNetWorkData
{
    NetWorkingUtil *util = [NetWorkingUtil netWorkingUtil];
    [util requestDic4MethodNam:@"v2/accept/account/getUserAssetInfo" parameters:nil result:^(NSDictionary *dic, int status, NSString *msg) {
        NSLog(@"%@",dic);
        if (status == 0) {
            [MBProgressHUD showMessag:msg toView:self.view];
        }else{
            _str_one = [NSString stringWithFormat:@"%.2f",[[dic objectForKey:@"receivableAmount"] floatValue]];
            _str_two = [NSString stringWithFormat:@"%.2f",[[dic objectForKey:@"fundReceivableInterest"] floatValue]];
            _str_three = [NSString stringWithFormat:@"%.2f",[[dic objectForKey:@"debtReceivable"] floatValue]];
        }
        [self.tableView reloadData];
    }];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 2;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MyZouZiTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MyZouZiTableViewCell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (indexPath.row ==0) {
        [cell.icon setImage:[UIImage imageNamed:@"jx.png"]];
        cell.title.text =@"精选标";
        cell.des.text =_str_one;
    }else if (indexPath.row ==1){
        [cell.icon setImage:[UIImage imageNamed:@"nq.png"]];
        cell.title.text =@"福利标";
        cell.des.text =_str_two;
    }else{
        [cell.icon setImage:[UIImage imageNamed:@"zq.png"]];
        cell.title.text = @"债权转让";
        cell.des.text = _str_three;
    }
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row ==0 ) {
        MyDispeController *VC = [MyDispeController new];
        [self.navigationController pushViewController:VC animated:YES];
    }else if (indexPath.row ==1){
        XShareProjectController * vc = [XShareProjectController new];
        [self.navigationController pushViewController:vc animated:YES];
    }else{
        MyCreditorViewController * creditorVC = [MyCreditorViewController new];
        [self.navigationController pushViewController:creditorVC animated:YES];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
