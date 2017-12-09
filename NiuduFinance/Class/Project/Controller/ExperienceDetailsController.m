//
//  ExperienceDetailsController.m
//  NiuduFinance
//
//  Created by 123 on 17/4/7.
//  Copyright © 2017年 liuyong. All rights reserved.
//

#import "ExperienceDetailsController.h"
#import "ProjectProgressView.h"
#import "MyDisperseInvestViewController.h"
#import "MyViewController.h"
@interface ExperienceDetailsController ()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
//  头部View
@property (nonatomic, strong) UIView * headerView;
@property (nonatomic, strong) UILabel * headerTitle;
@property (nonatomic, strong) UIView * lineView;
@property (nonatomic, strong) UILabel * annualTitle;
@property (nonatomic, strong) UILabel * annualNum;
@property (nonatomic, strong) UILabel * percent;
@property (nonatomic, strong) UILabel * hintLabel;
@property (nonatomic, strong) UILabel * label1;
@property (nonatomic, strong) UILabel * label2;

@property (nonatomic, strong) UIView * twoView;
@property (nonatomic, strong) UILabel * remain;
@property (nonatomic, strong) UILabel * amount;
@property (nonatomic, strong) UILabel * remainNum;
@property (nonatomic, strong) UILabel * amountNum;
@property (nonatomic, strong) UIView * line;
@property (nonatomic, strong) ProjectProgressView * progressView;
@property (nonatomic, strong) UILabel * progressLabel;

@property (nonatomic, strong) UIView * threeView;
@property (nonatomic, strong) UILabel * balance;
@property (nonatomic, strong) UIView * line1;
@property (nonatomic, strong) UITextField * amountText;
@property (nonatomic, strong) UILabel * yuan;
@property (nonatomic, strong) UIButton * touBtn;//立即投资
@property (nonatomic, strong) UIView * line2;
@property (nonatomic, strong) UILabel * expected;
@property (nonatomic, strong) UILabel * earnings;

@property (nonatomic, strong) UIView * wenView;
@property (nonatomic, strong) UILabel * wenLabel;

@property (nonatomic, strong) UIView * fourView;
@property (nonatomic, strong) UILabel * fourLabel;

@property (nonatomic, strong)NSDictionary * experienceDic;
@property (nonatomic, strong)NSDictionary * myRewardDic;
@property (nonatomic, strong)NSString * projectId;
@property (nonatomic, strong)UIAlertView *alert ;
@end

@implementation ExperienceDetailsController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    _experienceDic = [NSDictionary dictionary];
    _myRewardDic = [NSDictionary dictionary];

    _headerView = [UIView new];
    _headerView.backgroundColor = [UIColor colorWithHexString:@"#019BFF"];
    [self.tableView addSubview:_headerView];
    [_headerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH, 225));
    }];
    
    _headerTitle = [UILabel new];
//    [_headerTitle setText:@"语委会发哦IE混分巨兽破地方"];
    [_headerTitle setFont:[UIFont systemFontOfSize:15]];
    [_headerTitle setTextColor:[UIColor whiteColor]];
    [self.headerView addSubview:_headerTitle];
    [_headerTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(22);
        make.centerX.mas_equalTo(0);
        make.height.mas_equalTo(16);
    }];
    
    _lineView = [UIView new];
    [_lineView setBackgroundColor:[UIColor whiteColor]];
    [self.headerView addSubview:_lineView];
    [_lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_headerTitle.mas_bottom).with.offset(17);
        make.left.mas_equalTo(25);
        make.right.mas_equalTo(-25);
        make.height.mas_equalTo(1);
    }];
    
    _annualTitle = [UILabel new];
    [_annualTitle setText:@"预期年化"];
    [_annualTitle setFont:[UIFont systemFontOfSize:13]];
    [_annualTitle setTextColor:[UIColor whiteColor]];
    [self.headerView addSubview:_annualTitle];
    [_annualTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(135);
        make.centerX.mas_equalTo(0);
        make.height.mas_equalTo(13);
    }];
    
    _annualNum = [UILabel new];
//    [_annualNum setText:@"15"];
    [_annualNum setTextColor:[UIColor whiteColor]];
    [_annualNum setFont:[UIFont systemFontOfSize:53]];
    [self.headerView addSubview:_annualNum];
    [_annualNum mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(_annualTitle.mas_centerX).with.offset(10);
        make.bottom.equalTo(_annualTitle.mas_top).with.offset(-15);
        make.height.mas_equalTo(39);
    }];
    
    
    _percent = [UILabel new];
    [_percent setText:@"%"];
    [_percent setFont:[UIFont systemFontOfSize:27]];
    [_percent setTextColor:[UIColor whiteColor]];
    [self.headerView addSubview:_percent];
    [_percent mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_annualNum.mas_right).with.offset(0);
        make.bottom.equalTo(_annualNum.mas_bottom).with.offset(0);
        make.height.mas_equalTo(20);
    }];
    
    _hintLabel = [UILabel new];
    _hintLabel.layer.cornerRadius = 3.0f;
    _hintLabel.layer.masksToBounds = YES;
    _hintLabel.backgroundColor = [UIColor whiteColor];
    [_hintLabel setText:@"国资出品，安心投资"];
    [_hintLabel setFont:[UIFont systemFontOfSize:10]];
    [_hintLabel setTextColor:[UIColor colorWithHexString:@"#019BFF"]];
    [self.headerView addSubview:_hintLabel];
    [_hintLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_lineView.mas_bottom).with.offset(17);
        make.left.equalTo(_annualNum.mas_right);
        make.height.mas_equalTo(15);
    }];
    
    
    for (NSInteger i = 0; i < 3; i++) {
        UILabel * label = [[UILabel alloc] init];
        label.tag = 100 + i;
        label.layer.masksToBounds = YES;
        label.layer.cornerRadius = 6.0f;
        label.layer.borderWidth = 0.5f;
        label.layer.borderColor = [UIColor whiteColor].CGColor;
        label.textAlignment = NSTextAlignmentCenter;
        label.textColor = [UIColor whiteColor];
        label.font = [UIFont systemFontOfSize:14];
        label.adjustsFontSizeToFitWidth = YES;
        [_headerView addSubview:label];
    }
    CGFloat width = (SCREEN_WIDTH - 100) / 2.f;
    
    _label1 = [_headerView viewWithTag:100];
//    _label1.text = @"3个月";
    [_label1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(-31);
        make.centerX.equalTo(self.headerView.mas_left).with.offset(SCREEN_WIDTH/3);
        make.size.mas_equalTo(CGSizeMake(width, 26));
    }];
    
    _label2 = [_headerView viewWithTag:101];
//    _label2.text = @"100起投";
    [_label2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(-31);
        make.centerX.equalTo(self.headerView.mas_left).with.offset(SCREEN_WIDTH/3*2);
        make.size.mas_equalTo(CGSizeMake(width, 26));
    }];
    
    _twoView = [UIView new];
    [_twoView setBackgroundColor:[UIColor whiteColor]];
    [self.tableView addSubview:_twoView];
    [_twoView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(225+10);
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH, 99));
    }];
    
    _remain = [UILabel new];
    [_remain setText:@"剩余可投 (元)"];
    [_remain setFont:[UIFont systemFontOfSize:13]];
    [self.twoView addSubview:_remain];
    [_remain mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(21);
        make.centerX.equalTo(self.twoView.mas_left).with.offset(SCREEN_WIDTH/6+20);
        make.height.mas_equalTo(13);
    }];
    
    _remainNum = [UILabel new];
//    [_remainNum setText:@"10000.00"];
    [_remainNum setFont:[UIFont systemFontOfSize:14]];
    [self.twoView addSubview:_remainNum];
    [_remainNum mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_remain.mas_bottom).with.offset(14);
        make.centerX.equalTo(_remain.mas_centerX);
        make.height.mas_equalTo(11);
    }];
    
    _amount = [UILabel new];
    [_amount setText:@"借款总额 (元)"];
    [_amount setFont:[UIFont systemFontOfSize:13]];
    [self.twoView addSubview:_amount];
    [_amount mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(21);
        make.centerX.equalTo(self.twoView.mas_left).with.offset(SCREEN_WIDTH/6*5-20);
        make.height.mas_equalTo(13);
    }];
    
    _amountNum = [UILabel new];
//    [_amountNum setText:@"10000.00"];
    [_amountNum setFont:[UIFont systemFontOfSize:14]];
    [self.twoView addSubview:_amountNum];
    [_amountNum mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_amount.mas_bottom).with.offset(14);
        make.centerX.equalTo(_amount.mas_centerX);
        make.height.mas_equalTo(11);
    }];
    
    _line = [UIView new];
    [_line setBackgroundColor:[UIColor colorWithHexString:@"#CDCDCD"]];
    [self.twoView addSubview:_line];
    [_line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(16);
        make.centerX.mas_equalTo(0);
        make.size.mas_equalTo(CGSizeMake(1, 47));
    }];
    
    _progressView = [ProjectProgressView new];
    _progressView.backgroundColor = HEX_COLOR(@"#dddddd");
    _progressView.isShowProgressText = NO;
    [self.twoView addSubview:_progressView];
    [_progressView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(-16);
        make.left.mas_equalTo(15);
        make.right.mas_equalTo(-76);
        make.height.mas_equalTo(3);
    }];
    
    _progressLabel = [UILabel new];
//    [_progressLabel setText:@"进度:50%"];
    [_progressLabel setFont:[UIFont systemFontOfSize:10]];
    [self.twoView addSubview:_progressLabel];
    [_progressLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-13);
        make.bottom.mas_equalTo(-14);
        make.height.mas_equalTo(10);
    }];
    
    _threeView = [UIView new];
    [_threeView setBackgroundColor:[UIColor whiteColor]];
    [self.tableView addSubview:_threeView];
    [_threeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(225+10+99+5);
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH, 146));
    }];
    
    _balance = [UILabel new];
//    [_balance setText:@"账户"];
    [_balance setFont:[UIFont systemFontOfSize:14]];
    [self.threeView addSubview:_balance];
    [_balance mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(16);
        make.left.mas_equalTo(16);
        make.height.mas_equalTo(15);
    }];
    
    _line1 = [UILabel new];
    [_line1 setBackgroundColor:[UIColor colorWithHexString:@"#CDCDCD"]];
    [self.threeView addSubview:_line1];
    [_line1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_balance.mas_bottom).with.offset(15);
        make.left.mas_equalTo(15);
        make.right.mas_equalTo(0);
        make.height.mas_equalTo(1);
    }];
    
    _amountText = [UITextField new];
    _amountText.delegate = self;
//    _amountText.clearButtonMode=UITextFieldViewModeWhileEditing;
    _amountText.placeholder = @"请输入投资金额 10元/份";
    [_amountText setFont:[UIFont systemFontOfSize:14]];
    [_amountText addTarget:self action:@selector(editDidEnd:) forControlEvents:UIControlEventEditingChanged];
    [self.threeView addSubview:_amountText];
    [_amountText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.top.equalTo(_line1.mas_bottom).with.offset(24);
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH/2, 16));
    }];
    
    _yuan = [UILabel new];
    [_yuan setText:@"元"];
    [_yuan setFont:[UIFont systemFontOfSize:14]];
    [self.threeView addSubview:_yuan];
    [_yuan mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_amountText.mas_right).with.offset(10);
        make.bottom.equalTo(_amountText.mas_bottom).with.offset(-2);
        make.height.mas_equalTo(13);
    }];
    
    _touBtn = [UIButton new];
    _touBtn.layer.cornerRadius = 5.0f;
    _touBtn.clipsToBounds = YES;
    _touBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    _touBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
    [_touBtn setTitle:@"立即投资" forState:UIControlStateNormal];
    [_touBtn setTintColor:[UIColor whiteColor]];
    [_touBtn setBackgroundColor:[UIColor colorWithHexString:@"#019BFF"]];
    [_touBtn addTarget:self action:@selector(touBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.threeView addSubview:_touBtn];
    [_touBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_line1.mas_bottom).with.offset(11);
        make.right.mas_equalTo(-10);
        make.size.mas_equalTo(CGSizeMake(103, 32));
    }];
    
    _line2 = [UILabel new];
    [_line2 setBackgroundColor:[UIColor colorWithHexString:@"#CDCDCD"]];
    [self.threeView addSubview:_line2];
    [_line2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_amountText.mas_bottom).with.offset(12);
        make.left.mas_equalTo(15);
        make.right.mas_equalTo(0);
        make.height.mas_equalTo(1);
    }];
    
    _expected = [UILabel new];
    [_expected setText:@"预期收益"];
    [_expected setFont:[UIFont systemFontOfSize:14]];
    [self.threeView addSubview:_expected];
    [_expected mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_line2.mas_bottom).with.offset(17);
        make.left.mas_equalTo(15);
        make.height.mas_equalTo(14);
    }];
    
    _earnings = [UILabel new];
    [_earnings setFont:[UIFont systemFontOfSize:14]];
    [_earnings setText:@"0元"];
    [self.threeView addSubview:_earnings];
    [_earnings mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_line2.mas_bottom).with.offset(20);
        make.right.mas_equalTo(-11);
        make.height.mas_equalTo(13);
    }];
    
    _wenView = [UIView new];
    [_wenView setBackgroundColor:[UIColor whiteColor]];
    [self.tableView addSubview:_wenView];
    [_wenView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(225+10+99+5+146+5);
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH, 40));
    }];
    
    _wenLabel = [UILabel new];
    [_wenLabel setText:@"什么是牛气分享标"];
    [_wenLabel setFont:[UIFont systemFontOfSize:15]];
    [self.wenView addSubview:_wenLabel];
    [_wenLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(10);
        make.centerX.mas_equalTo(0);
        make.height.mas_equalTo(15);
    }];
    
    _fourView = [UIView new];
    [_fourView setBackgroundColor:[UIColor whiteColor]];
    [self.tableView addSubview:_fourView];
    [_fourView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(225+10+99+5+146+5+40+5);
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH, 230));
    }];
    
    _fourLabel = [UILabel new];
    _fourLabel.numberOfLines = 0;
//    [_fourLabel setText:@"什么是牛气分享标"];
    [_fourLabel setFont:[UIFont systemFontOfSize:12]];
    [self.fourView addSubview:_fourLabel];
    [_fourLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(10);
        make.centerX.mas_equalTo(0);
        make.left.mas_equalTo(15);
        make.right.mas_equalTo(-15);
    }];
    
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self setupNavi];
    [self getExperience];
    [self getWelfarePayments];
    [self getProjectDetails];
}

- (void)setupNavi
{
    [self.navigationController setNavigationBarHidden:NO animated:NO];
    self.title = @"投资详情";
    UIButton *customView = [UIButton buttonWithType:UIButtonTypeCustom];
    customView.frame = CGRectMake(0, 0, 44, 44);
    customView.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [customView setImage:[UIImage imageNamed:@"nav_back_normal"] forState:UIControlStateNormal];
    [customView addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:customView];
}

//体验金
- (void)getExperience
{
    
    [self.httpUtil requestDic4MethodNam:@"v2/accept/project/welfareFind" parameters:nil result:^(NSDictionary *dic, int status, NSString *msg) {
        NSLog(@"%@",dic);
        _experienceDic = dic;
        if (status == 0) {
            [MBProgressHUD showMessag:msg toView:self.view];
        }else{
            _headerTitle.text = [NSString stringWithFormat:@"%@",[dic objectForKey:@"title"]];
            _annualNum.text = [NSString stringWithFormat:@"%@",[dic objectForKey:@"rate"]];
            NSString * sst1 = [NSString stringWithFormat:@"%@",[dic objectForKey:@"periodtypeidName"]];
            NSString * sst2 = [NSString stringWithFormat:@"%@",[dic objectForKey:@"loanperiod"]];
            _label1.text = [NSString stringWithFormat:@"%@%@",sst2,sst1];
            _label2.text = [NSString stringWithFormat:@"%@元起投",[dic objectForKey:@"minbidamount"]];
            _remainNum.text = [NSString stringWithFormat:@"%@",[dic objectForKey:@"remainamount"]];
            _amountNum.text = [NSString stringWithFormat:@"%@",[dic objectForKey:@"amount"]];
            _progressView.progressValue = [[dic objectForKey:@"process" ]floatValue];
            NSString * sst3 = [NSString stringWithFormat:@"进度:%@",[_experienceDic objectForKey:@"process"]];
            _progressLabel.text = [NSString stringWithFormat:@"%@%@",sst3,@"%"];
            _projectId = [NSString stringWithFormat:@"%@",[dic objectForKey:@"projectId"]];

        }
        [self.tableView reloadData];

    }];
    
}

- (void)getWelfarePayments
{
    NetWorkingUtil *util = [NetWorkingUtil netWorkingUtil];
    [util requestDic4MethodNam:@"v2/accept/account/getUserAssetInfo" parameters:nil result:^(NSDictionary *dic, int status, NSString *msg) {
        NSLog(@"%@",dic);
        _myRewardDic = dic;

        if (status == 0) {
            [MBProgressHUD showMessag:msg toView:self.view];
        }else{
            _balance.text = [NSString stringWithFormat:@"福利金余额(元)%@",[dic objectForKey:@"welfareFund"]];
        }
        [self.tableView reloadData];
    }];
}

- (void)editDidEnd:(id)sender
{
    UITextField *textField = sender;
    if (IsStrEmpty(textField.text)) {
        _earnings.text = nil;
    }else{
        NSLog(@"%@",_earnings.text);
        if ([[_experienceDic objectForKey:@"periodtypeidName"]isEqual:@"天"]) {
            NSString *srcStr = [NSString stringWithFormat:@"%f",[textField.text floatValue] * [[_experienceDic objectForKey:@"rate"]floatValue] / 360 / 100 * [[_experienceDic objectForKey:@"loanperiod"]intValue]];
            NSRange range = [srcStr rangeOfString:@"."];
            NSString *str = [srcStr substringToIndex:range.location + 3];
            _earnings.text = str;
        }
        if ([[_experienceDic objectForKey:@"periodtypeidName"]isEqual:@"个月"]) {
            NSString *srcStr = [NSString stringWithFormat:@"%f",[textField.text floatValue] * [[_experienceDic objectForKey:@"rate"]floatValue] / 12 / 100 * [[_experienceDic objectForKey:@"loanperiod"]intValue]];
            NSRange range = [srcStr rangeOfString:@"."];
            NSString *str = [srcStr substringToIndex:range.location + 3];
            _earnings.text = str;
            
        }
        if ([[_experienceDic objectForKey:@"periodtypeidName"]isEqual:@"年"]) {
            NSString *srcStr = [NSString stringWithFormat:@"%f",[textField.text floatValue] * [[_experienceDic objectForKey:@"rate"]floatValue] / 100 * [[_experienceDic objectForKey:@"loanperiod"]intValue]];
            NSRange range = [srcStr rangeOfString:@"."];
            NSString *str = [srcStr substringToIndex:range.location + 3];
            _earnings.text = str;
            
        }
    }
}

- (void)touBtnClick:(id)sender
{
    NSLog(@"123456789");

    if (IsStrEmpty(_amountText.text)) {
        [MBProgressHUD showMessag:@"请输入金额" toView:self.view];
        return ;
    }
    
    if ([[_myRewardDic objectForKey:@"welfareFund"] floatValue]==0) {
        [MBProgressHUD showMessag:@"福利金余额为0" toView:self.view];
        //延迟2秒返回
        [self performSelector:@selector(delayMethod) withObject:self afterDelay:2.0];
        return ;
    }
    if ([_amountText.text integerValue] % 10 != 0) {
        [MBProgressHUD showMessag:@"投标金额不是10的倍数,不能投标" toView:self.view];
        [self performSelector:@selector(delayMethod) withObject:self afterDelay:2.0];

        return;
    }
    if ([_amountText.text floatValue]>[[_myRewardDic objectForKey:@"welfareFund"] floatValue]) {
        [MBProgressHUD showMessag:@"投资金额超出福利金范围" toView:self.view];
        [self performSelector:@selector(delayMethod) withObject:self afterDelay:2.0];

        return;
    }


    [self.httpUtil requestDic4MethodNam:@"v2/accept/project/welfareInvest" parameters:@{@"projectId":_projectId,@"amount":_amountText.text} result:^(NSDictionary *dic, int status, NSString *msg) {
        NSLog(@"%@",dic);
        _experienceDic = dic;
        if (status == 0) {
            [MBProgressHUD showMessag:msg toView:self.view];
            [self performSelector:@selector(delayMethod) withObject:self afterDelay:2.0];
        }else{
            NSLog(@"%@",msg);
            [MBProgressHUD showMessag:msg toView:self.view];
            _alert = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"投标成功" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [_alert show];

        }
        [self.tableView reloadData];
        
    }];
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
        MyDisperseInvestViewController * VC = [MyDisperseInvestViewController new];
        [self.navigationController pushViewController:VC animated:YES];
    
}
- (void)delayMethod{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)getProjectDetails
{
    [self.httpUtil requestDic4MethodNam:@"v2/accept/project/welfareFind" parameters:nil result:^(NSDictionary *dic, int status, NSString *msg) {
        NSLog(@"%@",dic);
        _experienceDic = dic;
        if (status == 0) {
            [MBProgressHUD showMessag:msg toView:self.view];
        }else{
            _fourLabel.text = [NSString stringWithFormat:@"%@",[dic objectForKey:@"projectintroduce"]];
            NSLog(@"%@",_fourLabel.text);
        }
        [self.tableView reloadData];
        
    }];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
//每个区有多少行
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = (UITableViewCell*)[tableView  dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;

     return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return 10.0;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 120;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 225+10+99+10+146+10+5+55+80;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

    
}

@end
