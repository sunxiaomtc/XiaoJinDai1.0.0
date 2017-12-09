//
//  BankNewTopUpViewController.m
//  NiuduFinance
//
//  Created by 123 on 17/3/1.
//  Copyright © 2017年 liuyong. All rights reserved.
//

#import "BankNewTopUpViewController.h"
#import "WebPageVC.h"
#import "MoreWebViewController.h"
@interface BankNewTopUpViewController ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic,strong) UIView * bankView;
@property (nonatomic,strong) UIImageView * imageView;
@property (nonatomic,strong) UILabel * bankLabel;
@property (nonatomic,strong) UILabel * bankNumberLab;
@property (nonatomic,strong) UIView * topUpView;
@property (nonatomic,strong) UILabel * topUpLabel;
@property (nonatomic,strong) UITextField * amountTextField;
@property (nonatomic,strong) UIButton * topUpBtn;
@property (nonatomic,strong)NSMutableDictionary *bankCardDic;

@property (nonatomic,strong)NSString * amount;
@property (nonatomic,strong)NSString * bankcode;
@property (nonatomic,strong)NSString * bankcodeID;


@end

@implementation BankNewTopUpViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupNavi];
    [self getMyBankCard];
    
    _bankView = [UIView new];
    _bankView.backgroundColor = [UIColor whiteColor];
    self.tableView.tableHeaderView = _bankView;
    [self.tableView addSubview:_bankView];
    [_bankView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(10);
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH, 93));
    }];
    
    _imageView = [UIImageView new];
    //    _imageView.backgroundColor = [UIColor cyanColor];
    [self.bankView addSubview:_imageView];
    [_imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(15);
        make.left.mas_equalTo(15);
        make.size.mas_equalTo(CGSizeMake(65, 65));
    }];
    
    _bankLabel = [UILabel new];
//    [self.bankLabel setText:@"123"];
    [self.bankLabel setFont:[UIFont systemFontOfSize:15]];
    //    _bankLabel.backgroundColor = [UIColor cyanColor];
    [self.tableView addSubview:_bankLabel];
    [_bankLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_bankView.mas_top).with.offset(25);
        make.left.equalTo(_imageView.mas_right).with.offset(19);
    }];
    
    
    _bankNumberLab = [UILabel new];
    //    _bankNumberLab.backgroundColor = [UIColor cyanColor];
//    [self.bankNumberLab setText:@"123123123123"];
    [self.bankNumberLab setFont:[UIFont systemFontOfSize:15]];
    [self.bankView addSubview:_bankNumberLab];
    [_bankNumberLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_bankLabel.mas_bottom).with.offset(12);
        make.left.equalTo(_bankLabel.mas_left).with.offset(0);
    }];
    
    
    _topUpView = [UIView new];
    _topUpView.backgroundColor = [UIColor whiteColor];
    [self.tableView addSubview:_topUpView];
    [_topUpView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_bankView.mas_bottom).with.offset(10);
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH, 46));
    }];
    
    _topUpLabel = [UILabel new];
    [_topUpLabel setText:@"充值金额"];
    [_topUpLabel setFont:[UIFont systemFontOfSize:15]];
    [self.topUpView addSubview:_topUpLabel];
    [_topUpLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(15);
        make.left.mas_equalTo(15);
    }];
    
    _amountTextField = [UITextField new];
    _amountTextField.delegate =self;
    _amountTextField.placeholder = @"请输入充值金额";
    [_amountTextField setFont:[UIFont systemFontOfSize:14]];
    [_amountTextField addTarget:self action:@selector(textChange:) forControlEvents:UIControlEventEditingChanged];
    _amountTextField.keyboardType = UIKeyboardTypeNumberPad;
    [self.topUpView addSubview:_amountTextField];
    [_amountTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-14);
        make.top.mas_equalTo(15);
    }];
    
    _topUpBtn = [UIButton new];
    _topUpBtn.layer.cornerRadius = 5;
    _topUpBtn.userInteractionEnabled = YES;
    [_topUpBtn setTitle:@"充值" forState:UIControlStateNormal];
    _topUpBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    [_topUpBtn setBackgroundColor:[UIColor colorWithHexString:@"#019BFF"]];
    [_topUpBtn addTarget:self action:@selector(topUpBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.tableView addSubview:_topUpBtn];
    [_topUpBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_topUpView.mas_bottom).with.offset(48);
        make.left.mas_equalTo(10);
        make.right.mas_equalTo(-10);
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH-20, 45));
    }];
}

- (void)getMyBankCard//卡号
{
    
    [self.httpUtil requestDic4MethodNam:@"v2/accept/user/findExpressBankCard" parameters:nil result:^(id dic, int status, NSString *msg) {
        
        NSLog(@"%d",status);
        NSLog(@"%@",dic);
        if (status == 0) {
            [MBProgressHUD showMessag:msg toView:self.view];
        }else{
            _bankCardDic=[NSMutableDictionary dictionaryWithDictionary:dic];
            _bankLabel.text = [dic objectForKey:@"bankname"];
            _bankNumberLab.text = [[dic objectForKey:@"BankCard"] objectForKey:@"banknumber"];
            
            _bankcode = [dic objectForKey:@"bankcode"];
            
            if (_bankcode!= nil) {
                NSString * str = [NetWorkingUtil mainURL];
                NSString * srtt = [[[[NSMutableString stringWithString:str]stringByAppendingString:@"resources/static/img/bankicon/" ]stringByAppendingString:_bankcode]stringByAppendingString:@".png"];
                [NetWorkingUtil setImage:_imageView url:srtt defaultIconName:nil successBlock:nil];
            }
            
        }
        
        [_tableView reloadData];
    }];
    
}
-(void)textChange:(UITextField *)theTextField
{
    _bankcodeID = _bankcode;
    if ([_amountTextField.text hasSuffix:@"."]) {
        [MBProgressHUD showMessag:@"请输入整数金额" toView:self.view];
        return;
    }
    
}
- (void)topUpBtnClick:(UIButton *)sender
{
    NSLog(@"点击了");
    NSRange range = [_amountTextField.text rangeOfString:@"."];
    if (_amountTextField.text.length == 0) {
        [MBProgressHUD showMessag:@"请输入充值金额" toView:self.view];
        return;
    }else if (_amountTextField.text.length >= 7){
        [MBProgressHUD showMessag:@"请输入百万以内的金额" toView:self.view];
        return;
    }else if (range.length >0){
        [MBProgressHUD showMessag:@"请输入整数金额" toView:self.view];
        return;
    }
    
    MoreWebViewController * moreWebVC = [MoreWebViewController new];
    moreWebVC.titleStr = @"充值";
    NSString * url = [NSString stringWithFormat:@"hfrecharge?amount=%@&bankCode=%@&typeId=1",_amountTextField.text,_bankcodeID];
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

- (void)setupNavi
{
    [self.navigationController setNavigationBarHidden:NO animated:NO];
    self.title = @"充值";
    
    UIButton *customView = [UIButton buttonWithType:UIButtonTypeCustom];
    customView.frame = CGRectMake(0, 0, 44, 44);
    customView.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [customView setImage:[UIImage imageNamed:@"黑色返回按钮"] forState:UIControlStateNormal];
    [customView addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:customView];
}
- (void)backAction
{
    
    [self.navigationController popViewControllerAnimated:YES];
}

@end
