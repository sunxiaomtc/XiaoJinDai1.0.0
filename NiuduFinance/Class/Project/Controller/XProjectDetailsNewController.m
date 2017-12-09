//
//  XProjectDetailsNewController.m
//  NiuduFinance
//
//  Created by 小吊丝 on 2017/9/26.
//  Copyright © 2017年 liuyong. All rights reserved.
//

#import "XProjectDetailsNewController.h"
#import "QRG_MJRefreshAutoFooter.h"
#import "QRG_MJRefreshNormalHeader.h"
#import "SNProjectDetailIFooterView.h"
#import "SNProjectDetailModel.h"
#import "SNProjectImagesModel.h"
#import "SNProjectFindAllInvestorModel.h"
#import "XProjectConfirmController.h"
#import "XProjectDetailsNewController.h"

@interface XProjectDetailsNewController ()<UITableViewDelegate,UITableViewDataSource>
{
    float lastContentOffset;
    UITableView *OneTable;
    UITableView *TwoTable;
    SNProjectDetailIFooterView * footerView;
}

@property (nonatomic, strong) UIView * firstView;
@property (nonatomic, strong) UILabel * nhsylLabel;
@property (nonatomic, strong) UILabel * nhsylNumber;
@property (nonatomic, strong) UILabel * bfhLabel;

@property (nonatomic, strong) UIImageView * imageVie;
@property (nonatomic, strong) UILabel * xmqxLabel;
@property (nonatomic, strong) UILabel * qtjeLabel;
@property (nonatomic, strong) UILabel * mjzeLabel;
@property (nonatomic, strong) UILabel * xmqxNumber;
@property (nonatomic, strong) UILabel * qtjeNumber;
@property (nonatomic, strong) UILabel * mjzeNumber;

@property (nonatomic, strong) UIView * twoView;
@property (nonatomic, strong) UILabel * starLabel;
@property (nonatomic, strong) UILabel * zhongLabel;
@property (nonatomic, strong) UILabel * endLabel;
@property (nonatomic, strong) UIImageView * imageViewD;
@property (nonatomic, strong) UILabel * bjsLabel;
@property (nonatomic, strong) UILabel * timeLabel;

@property (nonatomic, strong) UIView * threeView;
@property (nonatomic, strong) UIView * lineView;
@property (nonatomic, strong) UILabel * nameLabel;
@property (nonatomic, strong) UILabel * wayLabel;

@property (nonatomic, strong) UIButton * invesBtn;
@property (nonatomic, strong) UIView * syktView;
@property (nonatomic, strong) UILabel * syktLabel;
@property (nonatomic, strong) UILabel * syktNum;
@property (nonatomic, strong) UILabel * syktNumber;


@property (nonatomic, strong) UILabel * huaLabel;
@property (nonatomic, strong) SNProjectDetailModel * projectDetailModel;
@property (nonatomic, strong) SNProjectImagesModel * projectImagesModel;
@property (nonatomic, strong) SNProjectFindAllInvestorModel * findAllModel;

@property (nonatomic, strong) UILabel * huaLabe;
@property (nonatomic, strong) NSMutableArray     * isNewMutableArr;

@end

@implementation XProjectDetailsNewController

- (SNProjectDetailModel *)projectDetailModel
{
    if (!_projectDetailModel) {
        _projectDetailModel = [SNProjectDetailModel new];
        _projectDetailModel.key = @"__SNProjectDetailModel__";
        _projectDetailModel.requestType = VZModelCustom;
    }
    return _projectDetailModel;
}

- (SNProjectImagesModel *)projectImagesModel
{
    if (!_projectImagesModel) {
        _projectImagesModel = [SNProjectImagesModel new];
        _projectImagesModel.key = @"__SNProjectImagesModel__";
        _projectImagesModel.requestType = VZModelCustom;
    }
    return _projectImagesModel;
}

- (SNProjectFindAllInvestorModel *)findAllModel
{
    if (!_findAllModel) {
        _findAllModel = [SNProjectFindAllInvestorModel new];
        _findAllModel.key = @"__SNProjectFindAllInvestorModel__";
        _findAllModel.requestType = VZModelCustom;
    }
    return _findAllModel;
}

- (void)setProjectId:(int)projectId
{
    _projectId = projectId;
    NSLog(@"====%d",_projectId);
}

- (void)setType:(NSString *)type
{
    _type = type;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self getDetail];
    self.view.backgroundColor = [UIColor colorWithHexString:@"#ededed"];
    //设置本也的bar隐藏
    //    self.tabBarController.tabBar.hidden=YES;
    self.navigationItem.title = @"详情页";
//    self.navigationController.navigationBar.barTintColor = [UIColor colorWithHexString:@"#0C366F"];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor blackColor],NSFontAttributeName:[UIFont systemFontOfSize:17]}];
    UIButton *customView = [UIButton buttonWithType:UIButtonTypeCustom];
    customView.frame = CGRectMake(0, 0, 44, 44);
    customView.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [customView setImage:[UIImage imageNamed:@"黑色返回按钮"] forState:UIControlStateNormal];
    [customView addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:customView];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    /** 底层view*/
    UIScrollView * mainScrollView = [[UIScrollView alloc] init];
    mainScrollView.scrollEnabled = NO;
    mainScrollView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
    mainScrollView.contentSize = CGSizeMake(SCREEN_WIDTH, SCREEN_HEIGHT * 2);
    mainScrollView.backgroundColor = [UIColor colorWithHexString:@"#ededed"];
    mainScrollView.pagingEnabled = YES;
    mainScrollView.bounces = YES;
    [self.view addSubview:mainScrollView];
    
    /** 第一页面 table*/
    OneTable = [[UITableView alloc] init];
    OneTable.frame = CGRectMake(0,0, SCREEN_WIDTH, SCREEN_HEIGHT);
    OneTable.backgroundColor = [UIColor colorWithHexString:@"#ededed"];
    OneTable.delegate = self;
    OneTable.dataSource = self;
    OneTable.separatorStyle = NO;
    [mainScrollView addSubview:OneTable];
    
    
    /** 第二页面 scrollView*/
    UIScrollView *TwoScrollView = [[UIScrollView alloc] init];
    TwoScrollView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT );
    TwoScrollView.contentSize = CGSizeMake(SCREEN_WIDTH, SCREEN_HEIGHT );
    TwoScrollView.backgroundColor = [UIColor colorWithHexString:@"#ededed"];
    TwoScrollView.pagingEnabled = YES;
    TwoScrollView.bounces = NO;
    [mainScrollView addSubview:TwoScrollView];
    
    
    /** 第二页面 table*/
    
    TwoTable = [[UITableView alloc] init];
    TwoTable.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT );
    TwoTable.backgroundColor = [UIColor colorWithHexString:@"#ededed"];
    TwoTable.delegate = self;
    TwoTable.dataSource = self;
    TwoTable.separatorStyle = NO;
    [TwoScrollView addSubview:TwoTable];
    
    
    footerView = [[SNProjectDetailIFooterView alloc] init];
    footerView.tableView = TwoTable;
    footerView.frame = CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, footerView.height);
    [TwoTable addSubview:footerView];
    
    
    
    //设置UITableView 上拉加载
//    OneTable.mj_footer = [QRG_MJRefreshAutoFooter footerWithRefreshingBlock:^{
//        //上拉，执行对应的操作---改变底层滚动视图的滚动到对应位置
//        //设置动画效果
//        [UIView animateWithDuration:0.5 delay:0.0 options:UIViewAnimationOptionLayoutSubviews animations:^{
//            //            self.scrollV.contentOffset = CGPointMake(0, IPHONE_H);
//            [mainScrollView setContentOffset:CGPointMake(0, SCREEN_HEIGHT)];
//            
//        } completion:^(BOOL finished) {
//            //结束加载
//            [OneTable.mj_footer endRefreshing];
//        }];
//        
//        
//    }];
//    
//    //设置TwoTable 有下拉操作
//    TwoTable.mj_header = [QRG_MJRefreshNormalHeader headerWithRefreshingBlock:^{
//        //下拉执行对应的操作
//        //        self.scrollV.contentOffset = CGPointMake(0,0);
//        
//        [UIView animateWithDuration:1 animations:^{
//            [mainScrollView setContentOffset:CGPointMake(0,0)];
//            
//        }];
//        //结束加载
//        [TwoTable.mj_header endRefreshing];
//    }];
    
    
    _isNewMutableArr = [NSMutableArray array];
    
    UIView *bottomView = [[UIView alloc]init];
    [self.view addSubview:bottomView];
    [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(0);
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH, 70));
        make.centerX.mas_equalTo(0);
    }];
    bottomView.backgroundColor = [UIColor whiteColor];
    
    _invesBtn = [UIButton new];
    [_invesBtn setTitle:@"立即投资" forState:UIControlStateNormal];
    _invesBtn.layer.cornerRadius = 20;
    _invesBtn.layer.masksToBounds = YES;
    [_invesBtn setBackgroundColor:UIcolors];
    [_invesBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_invesBtn];
    [_invesBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(-15);
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH-50, 40));
        make.centerX.mas_equalTo(0);
    }];
    
    _syktView = [UIView new];
    [_syktView setBackgroundColor:[UIColor whiteColor]];
    [self.view addSubview:_syktView];
    [_syktView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(_invesBtn.mas_top);
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH, 50));
    }];
    _syktLabel = [UILabel new];
    [_syktLabel setText:@"剩余可投"];
    [_syktLabel setTextColor:[UIColor colorWithHexString:@"#9A9A9A"]];
    _syktLabel.textAlignment = NSTextAlignmentCenter;
    [_syktLabel setBackgroundColor:[UIColor whiteColor]];
    [_syktLabel setFont:[UIFont systemFontOfSize:13]];
    [_syktView addSubview:_syktLabel];
    [_syktLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(_syktView.mas_left).with.offset(SCREEN_WIDTH/6*2);
        make.centerY.mas_equalTo(0);
        make.height.mas_equalTo(13);
    }];
    _syktNum = [UILabel new];
    [_syktNum setText:@"0.00"];
    [_syktNum setTextColor:[UIColor colorWithHexString:@"#FF0000"]];
    _syktNum.textAlignment = NSTextAlignmentCenter;
    [_syktNum setBackgroundColor:[UIColor whiteColor]];
    [_syktNum setFont:[UIFont systemFontOfSize:13]];
    [_syktView addSubview:_syktNum];
    [_syktNum mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_syktLabel.mas_right).with.offset(10);
        make.centerY.mas_equalTo(0);
        make.height.mas_equalTo(13);
    }];
    _syktNumber = [UILabel new];
    [_syktNumber setText:@"0.00"];
    [_syktNumber setTextColor:[UIColor colorWithHexString:@"#0096FF"]];
    _syktNumber.textAlignment = NSTextAlignmentCenter;
    [_syktNumber setBackgroundColor:[UIColor whiteColor]];
    [_syktNumber setFont:[UIFont systemFontOfSize:13]];
    [_syktView addSubview:_syktNumber];
    [_syktNumber mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_syktNum.mas_right);
        make.centerY.mas_equalTo(0);
        make.height.mas_equalTo(13);
    }];
    
    
    _firstView = [UIView new];
    [_firstView setBackgroundColor:[UIColor colorWithHexString:@"#ededed"]];
    [OneTable setTableHeaderView:_firstView];
    [OneTable addSubview:_firstView];
    [_firstView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH, 212));
    }];
    
    _nhsylLabel = [UILabel new];
    [_nhsylLabel setText:@"年化收益率"];
    [_nhsylLabel setTextColor:[UIColor whiteColor]];
    [_nhsylLabel setFont:[UIFont systemFontOfSize:14]];
    [_firstView addSubview:_nhsylLabel];
    [_nhsylLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(50);
        make.centerX.mas_equalTo(0);
        make.height.mas_equalTo(14);
    }];
    
    _nhsylNumber = [UILabel new];
    [_nhsylNumber setText:@"0.00%"];
    [_nhsylNumber setTextColor:[UIColor whiteColor]];
    [_nhsylNumber setFont:[UIFont systemFontOfSize:32]];
    [_firstView addSubview:_nhsylNumber];
    [_nhsylNumber mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_nhsylLabel.mas_bottom).with.offset(16);
        make.centerX.mas_equalTo(0);
        make.height.mas_equalTo(24);
    }];
    
    _bfhLabel = [UILabel new];
    [_bfhLabel setText:@"%"];
    [_bfhLabel setTextColor:[UIColor whiteColor]];
    [_bfhLabel setFont:[UIFont systemFontOfSize:15]];
    [_firstView addSubview:_bfhLabel];
    [_bfhLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(_nhsylNumber.mas_bottom);
        make.size.mas_equalTo(CGSizeMake(15, 12));
        make.left.equalTo(_nhsylNumber.mas_right).with.offset(5);
    }];
    
    _imageVie = [UIImageView new];
    UIImage * image = [UIImage imageNamed:@"dxian.png"];
    _imageVie.image = image;
    [_firstView addSubview:_imageVie];
    [_imageVie mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo (_nhsylNumber.mas_bottom).with.offset(20);
        make.left.mas_equalTo(15);
        make.right.mas_equalTo(-15);
        make.height.mas_equalTo(0.5);
    }];
    
    _xmqxLabel = [UILabel new];
    [_xmqxLabel setText:@"项目期限"];
    [_xmqxLabel setFont:[UIFont systemFontOfSize:14]];
    [_xmqxLabel setTextColor:[UIColor colorWithHexString:@"#949EB4"]];
    [_firstView addSubview:_xmqxLabel];
    [_xmqxLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_imageVie.mas_bottom).with.offset(23);
        make.left.mas_equalTo(35);
        make.height.mas_equalTo(13);
    }];
    
    _xmqxNumber = [UILabel new];
    [_xmqxNumber setText:@"0"];
    [_xmqxNumber setFont:[UIFont systemFontOfSize:14]];
    [_xmqxNumber setTextColor:[UIColor whiteColor]];
    [_firstView addSubview:_xmqxNumber];
    [_xmqxNumber mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_xmqxLabel.mas_bottom).with.offset(15);
        make.height.mas_equalTo(13);
        make.centerX.equalTo(_xmqxLabel.mas_centerX);
    }];
    
    
    _qtjeLabel = [UILabel new];
    [_qtjeLabel setText:@"起投金额"];
    [_qtjeLabel setFont:[UIFont systemFontOfSize:14]];
    [_qtjeLabel setTextColor:[UIColor colorWithHexString:@"#949EB4"]];
    [_firstView addSubview:_qtjeLabel];
    [_qtjeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_imageVie.mas_bottom).with.offset(23);
        make.centerX.mas_equalTo(0);
        make.height.mas_equalTo(13);
    }];
    
    _qtjeNumber = [UILabel new];
    [_qtjeNumber setText:@"0.00元"];
    [_qtjeNumber setFont:[UIFont systemFontOfSize:14]];
    [_qtjeNumber setTextColor:[UIColor whiteColor]];
    [_firstView addSubview:_qtjeNumber];
    [_qtjeNumber mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_qtjeLabel.mas_bottom).with.offset(15);
        make.centerX.equalTo(_qtjeLabel.mas_centerX);
        make.height.mas_equalTo(13);
    }];
    
    
    _mjzeLabel = [UILabel new];
    [_mjzeLabel setText:@"募集总额"];
    [_mjzeLabel setFont:[UIFont systemFontOfSize:14]];
    [_mjzeLabel setTextColor:[UIColor colorWithHexString:@"#949EB4"]];
    [_firstView addSubview:_mjzeLabel];
    [_mjzeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_imageVie.mas_bottom).with.offset(23);
        make.right.mas_equalTo(-36);
        make.height.mas_equalTo(13);
    }];
    
    _mjzeNumber = [UILabel new];
    [_mjzeNumber setText:@"0.00元"];
    [_mjzeNumber setFont:[UIFont systemFontOfSize:14]];
    [_mjzeNumber setTextColor:[UIColor whiteColor]];
    [_firstView addSubview:_mjzeNumber];
    [_mjzeNumber mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_mjzeLabel.mas_bottom).with.offset(15);
        make.centerX.equalTo(_mjzeLabel.mas_centerX);
        make.height.mas_equalTo(13);
    }];
    
    _twoView = [UIView new];
    [_twoView setBackgroundColor:[UIColor whiteColor]];
    [OneTable addSubview:_twoView];
    [_twoView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_firstView.mas_bottom);
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH, 131));
    }];
    
    _starLabel = [UILabel new];
    [_starLabel setText:@"开始投资"];
    [_starLabel setFont:[UIFont systemFontOfSize:12]];
    [_starLabel setTextColor:[UIColor colorWithHexString:@"#0096FF"]];
    [_twoView addSubview:_starLabel];
    [_starLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(30);
        make.left.mas_equalTo(39);
        make.height.mas_equalTo(12);
    }];
    
    _zhongLabel = [UILabel new];
    [_zhongLabel setText:@"满标计息"];
    [_zhongLabel setFont:[UIFont systemFontOfSize:12]];
    [_zhongLabel setTextColor:[UIColor colorWithHexString:@"#FF8320"]];
    [_twoView addSubview:_zhongLabel];
    [_zhongLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(30);
        make.centerX.mas_equalTo(0);
        make.height.mas_equalTo(12);
    }];
    
    _endLabel = [UILabel new];
    [_endLabel setText:@"到期回款"];
    [_endLabel setFont:[UIFont systemFontOfSize:12]];
    [_endLabel setTextColor:[UIColor colorWithHexString:@"#FF0000"]];
    [_twoView addSubview:_endLabel];
    [_endLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(30);
        make.right.mas_equalTo(-39);
        make.height.mas_equalTo(12);
    }];
    
    _imageViewD = [UIImageView new];
    [_twoView addSubview:_imageViewD];
    [_imageViewD mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo (_starLabel.mas_bottom).with.offset(19);
        make.centerX.mas_equalTo(0);
        make.height.mas_equalTo(13);
    }];
    
    _bjsLabel = [UILabel new];
    [_bjsLabel setText:@"募集期不计算收益"];
    [_bjsLabel setFont:[UIFont systemFontOfSize:11]];
    [_bjsLabel setTextColor:[UIColor colorWithHexString:@"#9A9A9A"]];
    [_twoView addSubview:_bjsLabel];
    [_bjsLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(-29);
        make.left.mas_equalTo(15);
        make.height.mas_equalTo(11);
    }];
    
    _timeLabel = [UILabel new];
    [_timeLabel setText:@"募集期至0000.00.00"];
    [_timeLabel setFont:[UIFont systemFontOfSize:11]];
    [_timeLabel setTextColor:[UIColor colorWithHexString:@"#9A9A9A"]];
    [_twoView addSubview:_timeLabel];
    [_timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(-29);
        make.right.mas_equalTo(-15);
        make.height.mas_equalTo(11);
    }];
    
    
    _threeView = [UIView new];
    [_threeView setBackgroundColor:[UIColor whiteColor]];
    [OneTable addSubview:_threeView];
    [_threeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_twoView.mas_bottom).with.offset(5);
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH, 83));
    }];
    
    _lineView = [UIView new];
    [_lineView setBackgroundColor:[UIColor colorWithHexString:@"#EEEEEE"]];
    [_threeView addSubview:_lineView];
    [_lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(0);
        make.left.mas_equalTo(15);
        make.right.mas_equalTo(0);
        make.height.mas_equalTo(1);
    }];
    
    _nameLabel = [UILabel new];
    [_nameLabel setText:@"项目名称：发斯蒂芬违法热个梵蒂冈地方"];
    [_nameLabel setFont:[UIFont systemFontOfSize:12]];
    [_nameLabel setTextColor:[UIColor colorWithHexString:@"#666565"]];
    [_threeView addSubview:_nameLabel];
    [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(15);
        make.left.mas_equalTo(15);
        make.height.mas_equalTo(12);
    }];
    
    _wayLabel = [UILabel new];
    [_wayLabel setText:@"回款方式：一次性还本付息"];
    [_wayLabel setFont:[UIFont systemFontOfSize:12]];
    [_wayLabel setTextColor:[UIColor colorWithHexString:@"#666565"]];
    [_threeView addSubview:_wayLabel];
    [_wayLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(-15);
        make.left.mas_equalTo(15);
        make.height.mas_equalTo(12);
    }];
    _wayLabel.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(wayLabelAction)];
    [_wayLabel addGestureRecognizer:tap];
    
    _huaLabel = [UILabel new];
    [_huaLabel setText:@"向上滑 查看更多"];
    _huaLabel.textAlignment = NSTextAlignmentCenter;
    [_huaLabel setFont:[UIFont systemFontOfSize:12]];
    [_huaLabel setTextColor:[UIColor colorWithHexString:@"#9A9A9A"]];
    [OneTable addSubview:_huaLabel];
    [_huaLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_threeView.mas_bottom).with.offset(0);
        make.centerX.mas_equalTo(0);
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH, 72));
    }];
    
    UITapGestureRecognizer *labelTapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(labelClick:)];
    [_huaLabel addGestureRecognizer:labelTapGestureRecognizer];
    _huaLabel.userInteractionEnabled = YES;
    
    
    //    _huaLabe = [UILabel new];
    //    [_huaLabe setText:@"向下滑 回到简介"];
    //    _huaLabe.textAlignment = NSTextAlignmentCenter;
    //    [_huaLabe setFont:[UIFont systemFontOfSize:12]];
    //    [_huaLabe setTextColor:[UIColor blueColor]];
    //    [footerView addSubview:_huaLabe];
    //    [_huaLabe mas_makeConstraints:^(MASConstraintMaker *make) {
    //        make.top.equalTo(footerView.mas_bottom).with.offset(0);
    //        make.centerX.mas_equalTo(0);
    //        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH, 72));
    //    }];
    
}

-(void)wayLabelAction
{
    XProjectDetailsNewController *VC = [[XProjectDetailsNewController alloc] init];
    [self.navigationController pushViewController:VC animated:YES];
}

- (void)labelClick:(UIGestureRecognizer *)gest
{
    //    NSLog(@"12345679");
    //    SNProjectDetailIFooterView * footerView = [[SNProjectDetailIFooterView alloc] init];
    //    NSLog(@"%f",footerView.height);
    //    [self.tableView setContentOffset:CGPointMake(0, 212+131+83+50) animated:YES];
    
}
- (void)btnClick:(UIButton *)btn
{
    self.hidesBottomBarWhenPushed=YES;
    XProjectConfirmController * confirmVC =[XProjectConfirmController new];
    confirmVC.projectId = _projectId;
    [self.navigationController pushViewController:confirmVC animated:YES];
    
}

- (void)backClick
{
    [self.navigationController popViewControllerAnimated:YES];
    
}

- (void)getDetail
{
    
    [self.httpUtil requestDic4MethodNam:@"v2/accept/project/find" parameters:@{@"projectId":@(_projectId)} result:^(NSDictionary *dic, int status, NSString *msg) {
        NSLog(@"%@",dic);
        if (status == 0) {
        }else{
            NSString * statusStr = [NSString stringWithFormat:@"%@",[dic objectForKey:@"statusid"]];
            NSLog(@"%@",statusStr);
            if ([statusStr integerValue] == 1) {
                UIImage * imageD = [UIImage imageNamed:@"jd1.png"];
                _imageViewD.image = imageD;
                _invesBtn.backgroundColor = UIcolors;
                [_invesBtn setTitle:@"立即投资" forState:UIControlStateNormal];
            } else if ([statusStr integerValue] == 2)  {
                UIImage * imageD = [UIImage imageNamed:@"jd1.png"];
                _imageViewD.image = imageD;
                _invesBtn.userInteractionEnabled = NO;
                _invesBtn.backgroundColor = BlackCCCCCC;
                [_invesBtn setTitle:@"待审核" forState:UIControlStateNormal];
            } else if ([statusStr integerValue] == 3) {
                UIImage * imageD = [UIImage imageNamed:@"jd2.png"];
                _imageViewD.image = imageD;
                _invesBtn.userInteractionEnabled = NO;
                _invesBtn.backgroundColor = BlackCCCCCC;
                [_invesBtn setTitle:@"还款中" forState:UIControlStateNormal];
            } else if ([statusStr integerValue] == 4) {
                UIImage * imageD = [UIImage imageNamed:@"jd3.png"];
                _imageViewD.image = imageD;
                _invesBtn.userInteractionEnabled = NO;
                _invesBtn.backgroundColor = BlackCCCCCC;
                [_invesBtn setTitle:@"还款结束" forState:UIControlStateNormal];
            } else if ([statusStr isEqualToString:@"-10000"]) {
                UIImage * imageD = [UIImage imageNamed:@"jd1.png"];
                _imageViewD.image = imageD;
                _invesBtn.userInteractionEnabled = NO;
                _invesBtn.backgroundColor = BlackCCCCCC;
                [_invesBtn setTitle:@"不是新手" forState:UIControlStateNormal];
            } else if ([statusStr isEqualToString:@"-1"]) {
                UIImage * imageD = [UIImage imageNamed:@"jd1.png"];
                _imageViewD.image = imageD;
                _invesBtn.userInteractionEnabled = NO;
                _invesBtn.backgroundColor = BlackCCCCCC;
                [_invesBtn setTitle:@"未开始" forState:UIControlStateNormal];
            }else if ([statusStr isEqualToString:@"-2"]) {
                UIImage * imageD = [UIImage imageNamed:@"jd1.png"];
                _imageViewD.image = imageD;
                _invesBtn.userInteractionEnabled = NO;
                _invesBtn.backgroundColor = BlackCCCCCC;
                [_invesBtn setTitle:@"募集结束" forState:UIControlStateNormal];
            }
            
            NSString * timeStampString = [NSString stringWithFormat:@"%@",[dic objectForKey:@"collectDate"]];
            NSTimeInterval _interval=[timeStampString doubleValue] / 1000.0;
            NSDate *date = [NSDate dateWithTimeIntervalSince1970:_interval];
            NSDateFormatter *objDateformat = [[NSDateFormatter alloc] init];
            [objDateformat setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
            NSLog(@"%@",  [objDateformat stringFromDate: date]);
            NSString * string = [objDateformat stringFromDate:date];
            NSString * str = [string substringWithRange:NSMakeRange(0, 10)];
            _timeLabel.text = [NSString stringWithFormat:@"募集期至：%@",str];
            
        }
        [OneTable reloadData];
        
    }];
}

- (void)setProjectItem:(SNProjectListItem *)projectItem
{
    _projectItem = projectItem;
    //    SNProjectDetailIFooterView * footerView = [[SNProjectDetailIFooterView alloc] init];
    //    footerView.tableView = self.tableView;
    //    [self.tableView addSubview:footerView];
    //    [footerView mas_makeConstraints:^(MASConstraintMaker *make) {
    //        make.top.mas_equalTo(212+131+83+72);
    //        make.centerX.mas_equalTo(0);
    //        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH, footerView.height));
    //    }];
    
    WS
    self.projectDetailModel.projectId = projectItem.projectId.stringValue;
    [self.projectDetailModel loadWithCompletion:^(VZModel *model, NSError *error) {
        if (!error) {
            footerView.detailItem = weakSelf.projectDetailModel.detailItem;
            
            TwoTable.contentOffset = CGPointMake(0, 0);
        }
    }];
    
    self.projectImagesModel.projectId = projectItem.projectId.stringValue;
    [self.projectImagesModel loadWithCompletion:^(VZModel *model, NSError *error) {
        if (!error) {
            footerView.photoArray = weakSelf.projectImagesModel.imagesArray;
            
            TwoTable.contentOffset = CGPointMake(0, 0);
        }
    }];
    
    self.findAllModel.projectId = projectItem.projectId.stringValue;
    [self.findAllModel loadWithCompletion:^(VZModel *model, NSError *error) {
        if (!error) {
            footerView.listArray = weakSelf.findAllModel.listArray;
            
            TwoTable.contentOffset = CGPointMake(0, 0);
        }
    }];
    
    _nhsylNumber.text = [NSString stringWithFormat:@"%.2f",[projectItem.rate floatValue]];
    if ([projectItem.periodtypeid integerValue] == 1) {
        _xmqxNumber.text = [NSString stringWithFormat:@"%@天", projectItem.loanperiod];
    } else if ([projectItem.periodtypeid integerValue] == 2) {
        _xmqxNumber.text = [NSString stringWithFormat:@"%@个月", projectItem.loanperiod];
    } else if ([projectItem.periodtypeid integerValue] == 3) {
        _xmqxNumber.text = [NSString stringWithFormat:@"%@年", projectItem.loanperiod];
    }
    _qtjeNumber.text = [NSString stringWithFormat:@"%@起投", projectItem.minbidamount];
    _mjzeNumber.text = [NSString stringWithFormat:@"%@元", projectItem.amount];
    NSLog(@"%@",projectItem.process);
    _nameLabel.text = [NSString stringWithFormat:@"项目名称：%@",projectItem.title];
    _syktNum.text = [NSString stringWithFormat:@"%@",projectItem.remainamount];
    _syktNumber.text = [NSString stringWithFormat:@"/%@",projectItem.amount];
    
    
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return 0;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 0;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    CGFloat height;
    if([tableView isEqual:OneTable])
    {
        height = 10;
    }else
    {
        return 200;
    }
    return height;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = (UITableViewCell*)[tableView  dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    cell.backgroundColor = [UIColor colorWithHexString:@"#ededed"];
    //    OneTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    return cell;
}
//- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
//    lastContentOffset = scrollView.contentOffset.y;
//}
//
//- (void)scrollViewDidScroll:(UIScrollView *)scrollView
//{
//    CGPoint offset = scrollView.contentOffset;
//    if (lastContentOffset<offset.y) {
//        if (offset.y>50) {
//            [tableView setContentOffset:CGPointMake(0, 499)];
//        }
//    }else{
////        if (offset.y>120) {
//            [tableView setContentOffset:CGPointMake(0, 0)];
////        }
//    }
//
//}

//- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
//    CGPoint offset = scrollView.contentOffset;
////    CGSize size = scrollView.contentSize;
////    float h = size.height;
//    if (lastContentOffset<offset.y) {
//        if (offset.y>10) {
//            [_tableView setContentOffset:CGPointMake(0, 499)];
//        }
//    }
//
//}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end

