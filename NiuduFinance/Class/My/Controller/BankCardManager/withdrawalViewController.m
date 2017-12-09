//
//  withdrawalViewController.m
//  NiuduFinance
//
//  Created by 123 on 17/3/1.
//  Copyright © 2017年 liuyong. All rights reserved.
//

#import "withdrawalViewController.h"
#import "MoreWebViewController.h"
@interface withdrawalViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    UIButton * titBtn;
}
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic,strong) UIView * bankView;
@property (nonatomic,strong) UIImageView * imageView;
@property (nonatomic,strong) UILabel * bankLabel;
@property (nonatomic,strong) UILabel * bankNumberLab;
@property (nonatomic,strong) NSMutableDictionary *bankCardDic;
//新
@property (nonatomic,strong) UIView * twoView;
@property (nonatomic,strong) UILabel * wayLab;
@property (nonatomic,strong) UIView * lineView;
@property (nonatomic,strong) UILabel * jinLabel;
@property (nonatomic,strong) UITextField * amountText;
@property (nonatomic,strong) UILabel * available;
@property (nonatomic,strong) NSNumber * mayUseBalance;  //  可提现的
@property (nonatomic,strong) UIButton * withdrawalBtn;
@property (nonatomic,strong)NSString * bankcodeID;


@end

@implementation withdrawalViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupNavi];
    [self getMyBankCard];
    [self totalAssets];
    _bankView = [UIView new];
    _bankView.backgroundColor = [UIColor whiteColor];
    self.tableView.tableHeaderView = _bankView;
    [self.tableView addSubview:_bankView];
    [_bankView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(10);
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH, 93));
    }];
    
    _imageView = [UIImageView new];
//        _imageView.backgroundColor = [UIColor cyanColor];
    [self.bankView addSubview:_imageView];
    [_imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(15);
        make.left.mas_equalTo(15);
        make.size.mas_equalTo(CGSizeMake(65, 65));
    }];
    
    _bankLabel = [UILabel new];
    [self.bankLabel setText:@"0"];
    [self.bankLabel setFont:[UIFont systemFontOfSize:15]];
//        _bankLabel.backgroundColor = [UIColor cyanColor];
    [self.tableView addSubview:_bankLabel];
    [_bankLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_bankView.mas_top).with.offset(25);
        make.left.equalTo(_imageView.mas_right).with.offset(19);
    }];
    
    
    _bankNumberLab = [UILabel new];
//        _bankNumberLab.backgroundColor = [UIColor cyanColor];
    [self.bankNumberLab setText:@"0"];
    [self.bankNumberLab setFont:[UIFont systemFontOfSize:15]];
    [self.bankView addSubview:_bankNumberLab];
    [_bankNumberLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_bankLabel.mas_bottom).with.offset(12);
        make.left.equalTo(_bankLabel.mas_left).with.offset(0);
    }];
    
    _twoView = [UIView new];
    [_twoView setBackgroundColor:[UIColor whiteColor]];
    [self.tableView addSubview:_twoView];
    [_twoView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(93+10+10);
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH, 80));
    }];
    
    _lineView = [UIView new];
    [_lineView setBackgroundColor:[UIColor colorWithHexString:@"#CDCDCD"]];
    [self.twoView addSubview:_lineView];
    [_lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(0);
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH, 1));
    }];
    
    _wayLab = [UILabel new];
    [_wayLab setText:@"提现方式"];
    [_wayLab setFont:[UIFont systemFontOfSize:15]];
    [self.twoView addSubview:_wayLab];
    [_wayLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(-20);
        make.height.mas_equalTo(15);
        make.left.mas_equalTo(15);
    }];
    
    titBtn = [UIButton new];
    [titBtn setTitle:@"T+1" forState:UIControlStateNormal];
    [titBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    titBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [titBtn addTarget:self action:@selector(addClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.twoView addSubview:titBtn];
    [titBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(-20);
        make.size.mas_equalTo(CGSizeMake(40, 15));
        make.right.mas_equalTo(-20);
    }];
    
    _jinLabel = [UILabel new];
    [_jinLabel setText:@"提现金额"];
    [_jinLabel setFont:[UIFont systemFontOfSize:15]];
    [self.twoView addSubview:_jinLabel];
    [_jinLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(20);
        make.height.mas_equalTo(15);
        make.left.mas_equalTo(15);
    }];
    
    _amountText = [UITextField new];
    [_amountText setPlaceholder:@"请输入提现金额"];
    [_amountText setFont:[UIFont systemFontOfSize:15]];
    [self.twoView addSubview:_amountText];
    [_amountText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(20);
        make.height.mas_equalTo(15);
        make.right.mas_equalTo(-20);
    }];
    
    
    _available = [UILabel new];
    [_available setFont:[UIFont systemFontOfSize:13]];
    [self.tableView addSubview:_available];
    [_available mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(10+93+10+80+10+10);
        make.right.equalTo(self.twoView.mas_right).with.offset(-22);
        make.height.mas_equalTo(14);
    }];
    
    _withdrawalBtn = [UIButton new];
    _withdrawalBtn.layer.cornerRadius = 6.0f;
    [_withdrawalBtn setTitle:@"提现" forState:UIControlStateNormal];
    [_withdrawalBtn setBackgroundColor:Nav019BFF];
    _withdrawalBtn.titleLabel.font = [UIFont systemFontOfSize:18];
    [_withdrawalBtn setTintColor:[UIColor whiteColor]];
    [_withdrawalBtn addTarget:self action:@selector(topUpBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.tableView addSubview:_withdrawalBtn];
    [_withdrawalBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_available.mas_bottom).with.offset(30);
        make.centerX.mas_equalTo(0);
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH-30, 40));
    }];
    
}

- (void)setupNavi
{
    [self.navigationController setNavigationBarHidden:NO animated:NO];
    self.title = @"提现";
    UIButton *customView = [UIButton buttonWithType:UIButtonTypeCustom];
    customView.frame = CGRectMake(0, 0, 44, 44);
    customView.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [customView setImage:[UIImage imageNamed:@"nav_back_normal"] forState:UIControlStateNormal];
    [customView addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:customView];
}

- (void)addClick:(UIButton *)sender
{
    if ([titBtn.titleLabel.text isEqualToString:@"T+1"]) {
        [titBtn setTitle:@"T+0" forState:UIControlStateNormal];
        NSLog(@"%@",titBtn.titleLabel.text);
    }else{
        [titBtn setTitle:@"T+1" forState:UIControlStateNormal];
        NSLog(@"%@",titBtn.titleLabel.text);
    }
    
}
- (void)getMyBankCard//卡号
{
    
    [self.httpUtil requestDic4MethodNam:@"v2/accept/user/getUserInfo" parameters:nil result:^(id dic, int status, NSString *msg) {
        
        NSLog(@"%d",status);
        NSLog(@"%@",dic);
        if (status == 0) {
            [MBProgressHUD showMessag:msg toView:self.view];
        }else{
            _bankCardDic=[NSMutableDictionary dictionaryWithDictionary:dic];
            _bankLabel.text = [[dic objectForKey:@"bankInfo"] objectForKey:@"bankName"];
            _bankNumberLab.text = [[dic objectForKey:@"bankInfo"] objectForKey:@"bankNumber"];
            NSString * bankIocn;
            bankIocn = [[dic objectForKey:@"bankInfo"] objectForKey:@"bankIocn"];
            
            if (bankIocn!= nil) {
                NSString * str = [NetWorkingUtil mainURL];
                NSString * srtt = [[[[NSMutableString stringWithString:str]stringByAppendingString:@"resources/static/img/bankicon/" ]stringByAppendingString:bankIocn]stringByAppendingString:@".png"];
                NSLog(@"%@",srtt);
                [NetWorkingUtil setImage:_imageView url:srtt defaultIconName:@"bankInfo" successBlock:nil];
            }
        }
        
        [_tableView reloadData];
    }];
    
}
//总资产显示
- (void)totalAssets
{
    NetWorkingUtil *util = [NetWorkingUtil netWorkingUtil];
    [util requestDic4MethodNam:@"v2/accept/account/getUserAssetInfo" parameters:nil result:^(NSDictionary *dic, int status, NSString *msg) {
        NSLog(@"%@",dic);
        if (status == 0) {
            [MBProgressHUD showMessag:msg toView:self.view];
        }else{
            NSString * sst = [NSString stringWithFormat:@"%@",[dic objectForKey:@"mayUseBalance"]];
            _mayUseBalance = @([sst floatValue]);
            NSMutableAttributedString * attributedStr = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"可提现金额：%.2f元",[[dic objectForKey:@"mayUseBalance"] floatValue]]];
            [attributedStr addAttribute:NSForegroundColorAttributeName value:NaviFF0000 range:NSMakeRange(6, _mayUseBalance.stringValue.length)];
            _available.attributedText = attributedStr;
            
            

        }
        [self.tableView reloadData];
    }];
}

- (void)topUpBtnClick:(UIButton *)sender
{
    NSLog(@"点击了");
    NSRange range = [_amountText.text rangeOfString:@"."];
    if (_amountText.text.length == 0) {
        [MBProgressHUD showMessag:@"请输入充值金额" toView:self.view];
        return;
    }else if (_amountText.text.length >= 7){
        [MBProgressHUD showMessag:@"请输入百万以内的金额" toView:self.view];
        return;
    }else if (range.length >0){
        [MBProgressHUD showMessag:@"请输入整数金额" toView:self.view];
        return;
    }
    
    MoreWebViewController * moreWebVC = [MoreWebViewController new];
    moreWebVC.titleStr = @"提现";
    NSString * url = [NSString stringWithFormat:@"huifu/verify?amount=%@&bankCode=%@&typeId=2",_amountText.text,_bankcodeID];
    moreWebVC.webStr = url;
    NSLog(@"%@",moreWebVC.webStr);
    [self.navigationController pushViewController:moreWebVC animated:YES];
    
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 0;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = (UITableViewCell*)[tableView  dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if(cell == nil)
    {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    return cell;
}

@end
