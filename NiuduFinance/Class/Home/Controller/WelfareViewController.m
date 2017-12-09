//
//  WelfareViewController.m
//  NiuduFinance
//
//  Created by 123 on 17/7/31.
//  Copyright © 2017年 liuyong. All rights reserved.
//

#import "WelfareViewController.h"
#import "CWNumberKeyboard.h"
#import "MLMCircleView.h"

@interface WelfareViewController ()<UITableViewDelegate,UITableViewDataSource,UICollectionViewDelegateFlowLayout,UICollectionViewDelegate,UICollectionViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong)UIView * firstView;
@property (nonatomic, strong)UIImageView * imageVie;
@property (nonatomic, strong)UILabel * dhTitleLabe;
@property (nonatomic, strong)UIView * lineView;
@property (nonatomic, strong)UIView * lineView1;
@property (nonatomic, strong)UILabel * lcqxLabel;
@property (nonatomic, strong)UILabel * lcqxLabelNum;
@property (nonatomic, strong)UILabel * qtjeLabel;
@property (nonatomic, strong)UILabel * qtjeLabelNum;
@property (nonatomic, strong)UIView * twoView;
@property (nonatomic, strong)UILabel * fljLabel;
@property (nonatomic, strong)UILabel * fljLabelNum;

@property (nonatomic, strong)UIView * threeView;
@property (nonatomic, strong)UILabel * dslxLabel;
@property (nonatomic, strong)UILabel * dslxNum;

@property (nonatomic, strong)UILabel * ljsyLabel;
@property (nonatomic, strong)UILabel * ljsyNum;

@property (nonatomic, strong)UILabel * ztjeLabel;
@property (nonatomic, strong)UILabel * ztjeNum;

@property (nonatomic, strong)UILabel * ljtzLabel;
@property (nonatomic, strong)UILabel * ljtzNum;

@property (nonatomic, strong) UIButton * invesBtn;
@property (nonatomic, strong) UIView * syktView;
@property (nonatomic, strong) UILabel * syktLabel;
@property (nonatomic, strong) UILabel * syktNum;
@property (nonatomic, strong) UILabel * syktNumber;

@property (strong, nonatomic) CWNumberKeyboard *numberKb;
@property (nonatomic, strong) NSString * tzStr;
@property (nonatomic, strong) NSDictionary * flDic;
@property (nonatomic, strong) UICollectionView * collectionView;
@property (nonatomic, assign) float process;

@property (nonatomic, strong) UILabel * nhsyLabel;
@property (nonatomic, strong) UILabel * rateLabel;
@property (nonatomic, strong) UILabel * sytxLabel;

@end

@implementation WelfareViewController
static NSString * const reuseIdentifier = @"Cell";


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    [self getExper];
    [self getWelfarePayments];
    //隐藏导航栏
    [self.navigationController setNavigationBarHidden:YES animated:NO];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    _flDic = [NSDictionary alloc];
    _firstView = [UIView new];
    [_firstView setBackgroundColor:[UIColor cyanColor]];
    [_tableView addSubview:_firstView];
    [_firstView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.centerX.mas_equalTo(0);
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH, 254));
    }];

    UIImageView * firstImage = [UIImageView new];
    UIImage * image = [UIImage imageNamed:@"矩形-11"];
    firstImage.image = image;
    [_firstView addSubview:firstImage];
    [firstImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(0);
        make.top.mas_equalTo(0);
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH, 254));
    }];
    
    
    _dhTitleLabe = [UILabel new];
    [_dhTitleLabe setText:@"福利金"];
    [_dhTitleLabe setTextColor:[UIColor whiteColor]];
    [_dhTitleLabe setFont:[UIFont systemFontOfSize:17]];
    [self.firstView addSubview:_dhTitleLabe];
    [_dhTitleLabe mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(0);
        make.top.mas_equalTo(33);
        make.height.mas_equalTo(17);
    }];
    
    _imageVie = [UIImageView new];
    UIImage * image1 = [UIImage imageNamed:@"nav_back_normal.png"];
    _imageVie.image = image1;
    [self.firstView addSubview:_imageVie];
    [_imageVie mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(34);
        make.left.mas_equalTo(15);
        make.size.mas_equalTo(CGSizeMake(9, 15));
    }];
    
    UITapGestureRecognizer *labelTapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(labelClick)];
    [_imageVie addGestureRecognizer:labelTapGestureRecognizer];
    _imageVie.userInteractionEnabled = YES;
    
    UICollectionViewFlowLayout *flow = [UICollectionViewFlowLayout new];
    flow.minimumLineSpacing = 1;
    flow.minimumInteritemSpacing = 1;
    flow.itemSize = CGSizeMake(141, 141);
    flow.sectionInset = UIEdgeInsetsMake(1, 1, 1, 1);
    _collectionView = [[UICollectionView alloc] initWithFrame:self.view.frame collectionViewLayout:flow];
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    _collectionView.backgroundColor = [UIColor clearColor];
    [_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
    [self.firstView addSubview:_collectionView];
    [_collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_dhTitleLabe.mas_bottom).with.offset(22);
        make.centerX.mas_equalTo(0);
        make.size.mas_equalTo(CGSizeMake(141, 141));
    }];
    
    _nhsyLabel = [UILabel new];
    [_nhsyLabel setText:@"年化收益(%)"];
    [_nhsyLabel setFont:[UIFont systemFontOfSize:11]];
    [_nhsyLabel setTextColor:[UIColor whiteColor]];
    [self.firstView addSubview:_nhsyLabel];
    [_nhsyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_dhTitleLabe.mas_bottom).with.offset(51);
        make.centerX.mas_equalTo(0);
        make.height.mas_equalTo(11);
    }];
    
    _rateLabel = [UILabel new];
    [_rateLabel setText:@"0.00"];
    [_rateLabel setFont:[UIFont systemFontOfSize:28]];
    [_rateLabel setTextColor:[UIColor whiteColor]];
    [self.firstView addSubview:_rateLabel];
    [_rateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_nhsyLabel.mas_bottom).with.offset(14);
        make.centerX.mas_equalTo(0);
        make.height.mas_equalTo(21);
    }];
    
    _sytxLabel = [UILabel new];
    _sytxLabel.layer.cornerRadius = 10.0f;
    _sytxLabel.clipsToBounds = YES;
    _sytxLabel.layer.borderWidth = 1;
    _sytxLabel.layer.borderColor = [UIColor whiteColor].CGColor;
    [_sytxLabel setText:@"收益可提现"];
    _sytxLabel.textAlignment = NSTextAlignmentCenter;
    [_sytxLabel setFont:[UIFont systemFontOfSize:11]];
    [_sytxLabel setTextColor:[UIColor whiteColor]];
    [self.firstView addSubview:_sytxLabel];
    [_sytxLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_rateLabel.mas_bottom).with.offset(13);
        make.centerX.mas_equalTo(0);
        make.size.mas_equalTo(CGSizeMake(73, 21));
    }];
    
    
    _lineView = [UIView new];
    [_lineView setBackgroundColor:[UIColor colorWithHexString:@"#EEEEEE"]];
    [self.firstView addSubview:_lineView];
    [_lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(-33);
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH, 1));
    }];
    
    _lineView1 = [UIView new];
    [_lineView1 setBackgroundColor:[UIColor colorWithHexString:@"#EEEEEE"]];
    [self.firstView addSubview:_lineView1];
    [_lineView1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(0);
        make.size.mas_equalTo(CGSizeMake(1, 33));
        make.bottom.mas_equalTo(0);
    }];
    
    _lcqxLabel = [UILabel new];
    [_lcqxLabel setText:@"理财期限(天)"];
    [_lcqxLabel setTextColor:[UIColor colorWithHexString:@"#FFFFFF"]];
    [_lcqxLabel setFont:[UIFont systemFontOfSize:12]];
    [self.firstView addSubview:_lcqxLabel];
    [_lcqxLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(-11);
        make.left.mas_equalTo(15);
        make.height.mas_equalTo(12);
    }];
    
    _lcqxLabelNum = [UILabel new];
    [_lcqxLabelNum setText:@"0"];
    [_lcqxLabelNum setTextColor:[UIColor whiteColor]];
    [_lcqxLabelNum setFont:[UIFont systemFontOfSize:12]];
    [self.firstView addSubview:_lcqxLabelNum];
    [_lcqxLabelNum mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_lcqxLabel.mas_centerY);
        make.right.equalTo(_lineView1.mas_left).with.offset(-16);
        make.height.mas_equalTo(10);
    }];
    
    _qtjeLabel = [UILabel new];
    [_qtjeLabel setText:@"起投金额(元)"];
    [_qtjeLabel setTextColor:[UIColor colorWithHexString:@"#FFFFFF"]];
    [_qtjeLabel setFont:[UIFont systemFontOfSize:12]];
    [self.firstView addSubview:_qtjeLabel];
    [_qtjeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(-11);
        make.left.equalTo(_lineView1.mas_right).with.offset(15);
        make.height.mas_equalTo(12);
    }];
    
    _qtjeLabelNum = [UILabel new];
    [_qtjeLabelNum setText:@"0.00"];
    [_qtjeLabelNum setTextColor:[UIColor whiteColor]];
    [_qtjeLabelNum setFont:[UIFont systemFontOfSize:12]];
    [self.firstView addSubview:_qtjeLabelNum];
    [_qtjeLabelNum mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_qtjeLabel.mas_centerY);
        make.right.mas_equalTo(-16);
        make.height.mas_equalTo(10);
    }];
    
    _twoView = [UIView new];
    [_twoView setBackgroundColor: [UIColor whiteColor]];
    [self.tableView addSubview:_twoView];
    [_twoView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_firstView.mas_bottom);
        make.centerX.mas_equalTo(0);
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH, 92));
    }];
    
    _fljLabel = [UILabel new];
    [_fljLabel setText:@"福利金余额(元)"];
    [_fljLabel setFont:[UIFont systemFontOfSize:12]];
    [_fljLabel setTextColor:[UIColor colorWithHexString:@"#9A9A9A"]];
    [self.twoView addSubview:_fljLabel];
    [_fljLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(24);
        make.centerX.mas_equalTo(0);
        make.height.mas_equalTo(12);
    }];
    
    _fljLabelNum = [UILabel new];
    [_fljLabelNum setText:@"0.00"];
    [_fljLabelNum setFont:[UIFont systemFontOfSize:26]];
    [_fljLabelNum setTextColor:[UIColor colorWithHexString:@"#FF0000"]];
    [self.twoView addSubview:_fljLabelNum];
    [_fljLabelNum mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_fljLabel.mas_bottom).with.offset(13);
        make.centerX.mas_equalTo(0);
        make.height.mas_equalTo(20);
    }];
    
    _threeView = [UIView new];
    [_threeView setBackgroundColor:[UIColor whiteColor]];
    [self.tableView addSubview:_threeView];
    [_threeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_twoView.mas_bottom).with.offset(5);
        make.centerX.mas_equalTo(0);
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH, 197));
    }];
    
    _dslxLabel = [UILabel new];
    [_dslxLabel setText:@"待收利息(元)"];
    [_dslxLabel setTextColor:[UIColor colorWithHexString:@"#9A9A9A"]];
    [_dslxLabel setFont:[UIFont systemFontOfSize:12]];
    [self.threeView addSubview:_dslxLabel];
    [_dslxLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(54);
        make.centerX.equalTo(self.threeView.mas_left).with.offset(SCREEN_WIDTH/4);
        make.height.mas_equalTo(12);
    }];
    
    _dslxNum = [UILabel new];
    [_dslxNum setText:@"0.00"];
    [_dslxNum setTextColor:[UIColor blackColor]];
    [_dslxNum setFont:[UIFont systemFontOfSize:19]];
    [self.threeView addSubview:_dslxNum];
    [_dslxNum mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(_dslxLabel.mas_centerX);
        make.height.mas_equalTo(14);
        make.bottom.equalTo(_dslxLabel.mas_top).with.offset(-11);
    }];
    
    _ljsyLabel = [UILabel new];
    [_ljsyLabel setText:@"累计收益(元)"];
    [_ljsyLabel setTextColor:[UIColor colorWithHexString:@"#9A9A9A"]];
    [_ljsyLabel setFont:[UIFont systemFontOfSize:12]];
    [self.threeView addSubview:_ljsyLabel];
    [_ljsyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(54);
        make.centerX.equalTo(self.threeView.mas_left).with.offset(SCREEN_WIDTH/4*3);
        make.height.mas_equalTo(12);
    }];
    
    _ljsyNum = [UILabel new];
    [_ljsyNum setText:@"0.00"];
    [_ljsyNum setTextColor:[UIColor blackColor]];
    [_ljsyNum setFont:[UIFont systemFontOfSize:19]];
    [self.threeView addSubview:_ljsyNum];
    [_ljsyNum mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(_ljsyLabel.mas_centerX);
        make.height.mas_equalTo(14);
        make.bottom.equalTo(_ljsyLabel.mas_top).with.offset(-11);
    }];
    
    _ztjeLabel = [UILabel new];
    [_ztjeLabel setText:@"在投金额(元)"];
    [_ztjeLabel setTextColor:[UIColor colorWithHexString:@"#9A9A9A"]];
    [_ztjeLabel setFont:[UIFont systemFontOfSize:12]];
    [self.threeView addSubview:_ztjeLabel];
    [_ztjeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(-33);
        make.centerX.equalTo(self.threeView.mas_left).with.offset(SCREEN_WIDTH/4);
        make.height.mas_equalTo(12);
    }];
    
    _ztjeNum = [UILabel new];
    [_ztjeNum setText:@"0.00"];
    [_ztjeNum setTextColor:[UIColor blackColor]];
    [_ztjeNum setFont:[UIFont systemFontOfSize:19]];
    [self.threeView addSubview:_ztjeNum];
    [_ztjeNum mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(_ztjeLabel.mas_centerX);
        make.height.mas_equalTo(14);
        make.bottom.equalTo(_ztjeLabel.mas_top).with.offset(-11);
    }];
    
    _ljtzLabel = [UILabel new];
    [_ljtzLabel setText:@"累计投资金额(元)"];
    [_ljtzLabel setTextColor:[UIColor colorWithHexString:@"#9A9A9A"]];
    [_ljtzLabel setFont:[UIFont systemFontOfSize:12]];
    [self.threeView addSubview:_ljtzLabel];
    [_ljtzLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(-33);
        make.centerX.equalTo(self.threeView.mas_left).with.offset(SCREEN_WIDTH/4*3);
        make.height.mas_equalTo(12);
    }];
    
    _ljtzNum = [UILabel new];
    [_ljtzNum setText:@"0.00"];
    [_ljtzNum setTextColor:[UIColor blackColor]];
    [_ljtzNum setFont:[UIFont systemFontOfSize:19]];
    [self.threeView addSubview:_ljtzNum];
    [_ljtzNum mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(_ljtzLabel.mas_centerX);
        make.height.mas_equalTo(14);
        make.bottom.equalTo(_ljtzLabel.mas_top).with.offset(-11);
    }];
    
    _invesBtn = [UIButton new];
    [_invesBtn setTitle:@"立即投资" forState:UIControlStateNormal];
    [_invesBtn setBackgroundColor:UIcolors];
    [_invesBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_invesBtn];
    [_invesBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(0);
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH, 61));
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
    [_syktNumber setText:@"/0.00"];
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

    
}

- (void)btnClick:(UIButton *)btn
{
    NSLog(@"123456");
    if (!_numberKb) {
        _numberKb = [[CWNumberKeyboard alloc] init];
        [self.view addSubview:_numberKb];
    }
    [_numberKb setHidden:NO];
    [_numberKb showNumKeyboardViewAnimateWithPrice:self.tzStr andBlock:^(NSString *priceString) {
        self.tzStr = priceString;
    }];
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
            _fljLabelNum.text = [NSString stringWithFormat:@"%.2f",[[dic objectForKey:@"welfareFund"] floatValue]];
            _dslxNum.text = [NSString stringWithFormat:@"%.2f",[[dic objectForKey:@"fundReceivableInterest"] floatValue]];
            _ljsyNum.text = [NSString stringWithFormat:@"%.2f",[[dic objectForKey:@"fundIncome"] floatValue]];
            _ztjeNum.text = [NSString stringWithFormat:@"%.2f",[[dic objectForKey:@"fundInvest"] floatValue]];
            _ljtzNum.text = [NSString stringWithFormat:@"%.2f",[[dic objectForKey:@"fundInvestTotal"] floatValue]];
        }
        [self.tableView reloadData];
    }];
}

//体验金
- (void)getExper
{
    [self.httpUtil requestDic4MethodNam:@"v2/accept/project/welfareFind" parameters:nil result:^(NSDictionary *dic, int status, NSString *msg) {
        NSLog(@"%@",dic);
        if (status == 0) {
        }else{
            _flDic = dic;

            _syktNum.text = [NSString stringWithFormat:@"%@",[dic objectForKey:@"remainamount"]];
            _syktNumber.text = [NSString stringWithFormat:@"/%@",[dic objectForKey:@"amount"]];
            _qtjeLabelNum.text = [NSString stringWithFormat:@"%.2f",[[dic objectForKey:@"minbidamount"] floatValue]];
            _lcqxLabel.text = [NSString stringWithFormat:@"理财期限(%@)",[dic objectForKey:@"periodtypeidName"]];
            _lcqxLabelNum.text = [NSString stringWithFormat:@"%@",[dic objectForKey:@"loanperiod"]];
            
//            if ([[dic objectForKey:@"statusid"] intValue]== 1) {
//                [_invesBtn setTitle:@"立即投资" forState:UIControlStateNormal];
//            }else if ([[dic objectForKey:@"statusid"] intValue]== 2)
//            {
//                _invesBtn.userInteractionEnabled = NO;
//                [_invesBtn setTitle:@"待审核" forState:UIControlStateNormal];
//
//            }else if ([[dic objectForKey:@"statusid"] intValue]== 3)
//            {
//                _invesBtn.userInteractionEnabled = NO;
//                [_invesBtn setTitle:@"还款中" forState:UIControlStateNormal];
//
//            }else if ([[dic objectForKey:@"statusid"] intValue]== 4)
//            {
//                _invesBtn.userInteractionEnabled = NO;
//                [_invesBtn setTitle:@"还款结束" forState:UIControlStateNormal];
//
//            }else if ([[dic objectForKey:@"statusid"] intValue]== -10000)
//            {
//                _invesBtn.userInteractionEnabled = NO;
//                [_invesBtn setTitle:@"不是新手" forState:UIControlStateNormal];
//
//            }else if ([[dic objectForKey:@"statusid"] intValue]== -1)
//            {
//                _invesBtn.userInteractionEnabled = NO;
//                [_invesBtn setTitle:@"未开始" forState:UIControlStateNormal];
//
//            }

            MLMCircleView *circle = [[MLMCircleView alloc] initWithFrame:CGRectMake(0, 0, 141,141)];
            circle.center = CGPointMake(141/2, 141/2);
            circle.bottomWidth = 4;
            circle.progressWidth = 4;
            circle.fillColor = [UIColor whiteColor];
            circle.bgColor = [UIColor colorWithHexString:@"#7177B2"];
            circle.dotDiameter = 20;
            circle.edgespace = 5;
            circle.dotImage = [UIImage imageNamed:@"brightDot"];
            [circle drawProgress];
            NSString * str = [NSString stringWithFormat:@"%@",[_flDic objectForKey:@"process"]];
            _process = [str floatValue]/100;
            [circle setProgress:_process];
            [self.collectionView addSubview:circle];
            
            _rateLabel.text = [NSString stringWithFormat:@"%.2f",[[dic objectForKey:@"rate"] floatValue]];
            [_tableView.mj_footer resetNoMoreData];
            
        }
        [_tableView reloadData];
        
    }];
    
}

- (void)labelClick
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 4;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    cell.backgroundColor = [UIColor clearColor];
    for (MLMCircleView *view in cell.subviews) {
        [view removeFromSuperview];
    }
    switch (indexPath.row) {
        case 0:
        {
            [self type1:cell];
        }
            break;
        default:
            break;
    }
    
    return cell;
}
- (void)type1:(UICollectionViewCell *)cell {
//    MLMCircleView *circle = [[MLMCircleView alloc] initWithFrame:CGRectMake(0, 0, cell.width,cell.width)];
//    circle.center = CGPointMake(cell.width/2, cell.height/2);
//    circle.bottomWidth = 4;
//    circle.progressWidth = 4;
//    circle.fillColor = [UIColor whiteColor];
//    circle.bgColor = [UIColor colorWithWhite:1 alpha:.5];
//    circle.dotDiameter = 20;
//    circle.edgespace = 5;
//    circle.dotImage = [UIImage imageNamed:@"brightDot"];
//    [circle drawProgress];
//
//    [circle setProgress:_process];
    //单机手势
//    [circle tapHandle:^{
//        
//    }];
//    
//    [cell addSubview:circle];
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 0;
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
    
    return 254+92+197+10+111;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 10;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = (UITableViewCell*)[tableView  dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    return cell;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
