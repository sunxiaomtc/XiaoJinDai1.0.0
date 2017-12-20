//
//  MyWelfareController.m
//  NiuduFinance
//
//  Created by 123 on 17/8/1.
//  Copyright © 2017年 liuyong. All rights reserved.
//

#import "MyWelfareController.h"
#import "WelfareViewController.h"
#import "DetailViewController.h"
@interface MyWelfareController ()<UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) UIView * dhView;
@property (nonatomic, strong) UILabel * dhTitleLabe;
@property (nonatomic, strong) UIImageView * imageVie;
@property (nonatomic, strong) UIButton * mxBtn;

@property (nonatomic, strong) UIView * firstView;
@property (nonatomic, strong) UIImageView * imageView;
//可用福利金余额
@property (nonatomic, strong) UILabel * kyyeLabel;
@property (nonatomic, strong) UILabel * kyyeNum;
@property (nonatomic, strong) UIView * lineView1;
@property (nonatomic, strong) UIView * lineView2;
//已使用
@property (nonatomic, strong) UILabel * ysyLabel;
@property (nonatomic, strong) UILabel * ysyNum;
//已过期
@property (nonatomic, strong) UILabel * ygqLabel;
@property (nonatomic, strong) UILabel * ygqNum;

@property (nonatomic, strong) UIView * twoView;
@property (nonatomic, strong) UILabel * whyLabel;
@property (nonatomic, strong) UILabel * detailLabel;
@property (nonatomic, strong) UIView * lineView3;
@property (nonatomic, strong) UIImageView * imageView1;
@property (nonatomic, strong) UIButton * nowBtn;
@property (nonatomic, strong) UIImageView * imageView2;

@end

@implementation MyWelfareController
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    [self getWelfarePayments];
    //隐藏导航栏
    [self.navigationController setNavigationBarHidden:YES animated:NO];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    _dhView = [UIView new];
    [_dhView setBackgroundColor:[UIColor whiteColor]];
    [self.tableView addSubview:_dhView];
    [_dhView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(-20);
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH, 64));
    }];
    
    _dhTitleLabe = [UILabel new];
    [_dhTitleLabe setText:@"我的福利金"];
    [_dhTitleLabe setFont:[UIFont systemFontOfSize:17]];
    [self.dhView addSubview:_dhTitleLabe];
    [_dhTitleLabe mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(0);
        make.top.mas_equalTo(34);
        make.height.mas_equalTo(16);
    }];
    
    _imageVie = [UIImageView new];
    UIImage * image = [UIImage imageNamed:@"黑色返回按钮"];
    _imageVie.image = image;
    [self.dhView addSubview:_imageVie];
    [_imageVie mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(34);
        make.left.mas_equalTo(15);
//        make.size.mas_equalTo(CGSizeMake(18, 18));
    }];
    UIView *backView = [[UIView alloc] init];
    [self.dhView addSubview:backView];
    [backView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.mas_equalTo(_imageVie.mas_left).offset(-15);
        make.right.mas_equalTo(_imageVie.mas_right).offset(15);
        make.top.mas_equalTo(_imageVie.mas_top).offset(-15);
        make.bottom.mas_equalTo(_imageVie.mas_bottom).offset(15);
    }];
    
    UITapGestureRecognizer *labelTapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(labelClick)];
    [backView addGestureRecognizer:labelTapGestureRecognizer];
    _imageVie.userInteractionEnabled = YES;
    
    _mxBtn = [UIButton new];
    [_mxBtn setTitle:@"明细" forState:UIControlStateNormal];
//    [_mxBtn setTitleColor:[UIColor colorWithHexString:@"#0096FF"] forState:UIControlStateNormal];
    [_mxBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    _mxBtn.titleLabel.font = [UIFont systemFontOfSize:13];
    [_mxBtn addTarget:self action:@selector(mxBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.dhView addSubview:_mxBtn];
    [_mxBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_dhTitleLabe.mas_centerY);
        make.right.mas_equalTo(-8);
        make.size.mas_equalTo(CGSizeMake(50, 20));
    }];
    
    _firstView = [UIView new];
    [_firstView setBackgroundColor:[UIColor redColor]];
    [self.tableView addSubview:_firstView];
    [_firstView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_dhView.mas_bottom).with.offset(0);
        make.centerX.mas_equalTo(0);
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH, 164));
    }];
    
    _imageView = [UIImageView new];
    UIImage * image1 = [UIImage imageNamed:@"矩形-11"];
    _imageView.image = image1;
    [self.firstView addSubview:_imageView];
    [_imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.centerX.mas_equalTo(0);
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH, 164));
    }];
    
    _kyyeLabel = [UILabel new];
    [_kyyeLabel setText:@"可用福利金余额 (元)"];
    [_kyyeLabel setFont:[UIFont systemFontOfSize:12]];
    [_kyyeLabel setTextColor:[UIColor whiteColor]];
    [self.firstView addSubview:_kyyeLabel];
    [_kyyeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(15);
        make.left.mas_equalTo(15);
        make.height.mas_equalTo(12);
    }];
    
    _kyyeLabel = [UILabel new];
    [_kyyeLabel setText:@"0.00"];
    [_kyyeLabel setFont:[UIFont systemFontOfSize:19]];
    [_kyyeLabel setTextColor:[UIColor whiteColor]];
    [self.firstView addSubview:_kyyeLabel];
    [_kyyeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(67);
        make.centerX.mas_equalTo(0);
        make.height.mas_equalTo(15);
    }];
    
    _lineView1 = [UIView new];
    [_lineView1 setBackgroundColor:[UIColor whiteColor]];
    [self.firstView addSubview:_lineView1];
    [_lineView1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(-44);
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH, 1));
    }];
    
    _lineView2 = [UIView new];
    [_lineView2 setBackgroundColor:[UIColor whiteColor]];
    [self.firstView addSubview:_lineView2];
    [_lineView2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(0);
        make.centerX.mas_equalTo(0);
        make.size.mas_equalTo(CGSizeMake(1, 44));
    }];
    
    _ysyLabel = [UILabel new];
    [_ysyLabel setText:@"已使用"];
    [_ysyLabel setFont:[UIFont systemFontOfSize:12]];
    [_ysyLabel setTextColor:[UIColor whiteColor]];
    [self.firstView addSubview:_ysyLabel];
    [_ysyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.bottom.mas_equalTo(-17);
        make.height.mas_equalTo(12);
    }];
    
    _ysyNum = [UILabel new];
    [_ysyNum setText:@"0.00"];
    [_ysyNum setFont:[UIFont systemFontOfSize:12]];
    [_ysyNum setTextColor:[UIColor whiteColor]];
    [self.firstView addSubview:_ysyNum];
    [_ysyNum mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_ysyLabel.mas_centerY);
        make.right.equalTo(_lineView2.mas_left).with.offset(-16);
        make.height.mas_equalTo(10);
    }];
    
    _ygqLabel = [UILabel new];
    [_ygqLabel setText:@"已过期"];
    [_ygqLabel setFont:[UIFont systemFontOfSize:12]];
    [_ygqLabel setTextColor:[UIColor whiteColor]];
    [self.firstView addSubview:_ygqLabel];
    [_ygqLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_lineView2.mas_right).with.offset(15);
        make.centerY.equalTo(_ysyLabel.mas_centerY);
        make.height.mas_equalTo(12);
    }];
    
    _ygqNum = [UILabel new];
    [_ygqNum setText:@"0.00"];
    [_ygqNum setFont:[UIFont systemFontOfSize:12]];
    [_ygqNum setTextColor:[UIColor whiteColor]];
    [self.firstView addSubview:_ygqNum];
    [_ygqNum mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_ysyLabel.mas_centerY);
        make.right.mas_equalTo(-16);
        make.height.mas_equalTo(10);
    }];
    
    _twoView = [UIView new];
    [_twoView setBackgroundColor:[UIColor whiteColor]];
    [self.tableView addSubview:_twoView];
    [_twoView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_firstView.mas_bottom).with.offset(10);
        make.centerX.mas_equalTo(0);
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH, 379));
    }];
    
    _whyLabel = [UILabel new];
    [_whyLabel setText:@"什么是福利金？"];
    [_whyLabel setFont:[UIFont systemFontOfSize:13]];
    [self.twoView addSubview:_whyLabel];
    [_whyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(30);
        make.centerX.mas_equalTo(0);
        make.height.mas_equalTo(13);
    }];
    //你有你的铜枝铁干，像刀、像剑也像戟；我有我红硕的花朵像沉重的叹息，又像英勇的火炬。我们分担寒潮、风雷、霹雳；我们共享雾霭、流岚、虹霓。仿佛永远分离，却又终身相依。这才是伟大的爱情，坚贞就在这里：不仅爱你伟岸的身躯，也爱你坚持的位置，脚下的土地。
    _detailLabel = [UILabel new];
    _detailLabel.numberOfLines = 0;
    [_detailLabel setText:@"福利金是指通过邀请好友或其他活动获得的虚拟资金，仅可用于投资 福利标。用户获得福利金后，需在15个工作日内进行“福利 标”的投资操作，项目到期后，该笔福利金收回，相应投资收益归用 户所有。超过15个工作日未进行福利金的投资操作，视为放弃福利金 收益，系统将自动回收作清零处理。"];
    [_detailLabel setFont:[UIFont systemFontOfSize:12]];
    [self.twoView addSubview:_detailLabel];
    [_detailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.right.mas_equalTo(-16);
        make.centerX.mas_equalTo(0);
        make.top.equalTo(_whyLabel.mas_bottom).with.offset(29);
    }];
    
    _lineView3 = [UIView new];
    [_lineView3 setBackgroundColor:[UIColor colorWithHexString:@"#EEEEEE"]];
    [self.twoView addSubview:_lineView3];
    [_lineView3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_detailLabel.mas_bottom).with.offset(40);
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH, 1));
    }];
    
//    _nowBtn = [UIButton new];
//    [_nowBtn setTitle:@"马上去投福利标>>" forState:UIControlStateNormal];
//    [_nowBtn setTitleColor:[UIColor colorWithHexString:@"#0096FF"] forState:UIControlStateNormal];
//    _nowBtn.titleLabel.font = [UIFont systemFontOfSize:10];
//    [_nowBtn addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
//    [self.twoView addSubview:_nowBtn];
//    [_nowBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.centerX.mas_equalTo(0);
//        make.bottom.mas_equalTo(-88);
//        make.height.mas_equalTo(10);
//    }];
//
//    _imageView2 = [UIImageView new];
//    UIImage * image2 = [UIImage imageNamed:@"nhi.png"];
//    _imageView2.image = image2;
//    [self.twoView addSubview:_imageView2];
//    [_imageView2 mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.centerY.equalTo(_nowBtn.mas_centerY);
//        make.right.equalTo(_nowBtn.mas_left).with.offset(-4);
//        make.size.mas_equalTo(CGSizeMake(10, 13));
//    }];
}

- (void)btnClick
{
    self.hidesBottomBarWhenPushed=YES;
    WelfareViewController * vc = [WelfareViewController new];
    [self.navigationController pushViewController:vc animated:YES];
    self.hidesBottomBarWhenPushed=NO;
}
- (void)mxBtnClick
{
    NSLog(@"123");
    DetailViewController * vc = [DetailViewController new];
    [self.navigationController pushViewController:vc animated:YES];
}

//我的福利金
- (void)getWelfarePayments
{
    
    NetWorkingUtil *util = [NetWorkingUtil netWorkingUtil];
    [util requestDic4MethodNam:@"v2/accept/account/getUserAssetInfo" parameters:nil result:^(NSDictionary *dic, int status, NSString *msg) {
        NSLog(@"%@",dic);
        
        if (status == 0) {
            [MBProgressHUD showMessag:msg toView:self.view];
        }else{
            _kyyeLabel.text = [NSString stringWithFormat:@"%.2f",[[dic objectForKey:@"welfareFund"] floatValue]];
            _ysyNum.text = [NSString stringWithFormat:@"%.2f",[[dic objectForKey:@"fundInvestTotal"] floatValue]];
            _ygqNum.text = [NSString stringWithFormat:@"%.2f",[[dic objectForKey:@" expireFundAmount"] floatValue]];

        }
        [self.tableView reloadData];
    }];
}

- (void)labelClick
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 50+164+379;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = (UITableViewCell*)[tableView  dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    self.tableView.showsVerticalScrollIndicator = NO;
    return cell;
}

//修改状态栏为黑色
- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleDefault;
}
@end
