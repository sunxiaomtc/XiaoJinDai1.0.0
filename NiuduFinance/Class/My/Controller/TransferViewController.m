//
//  TransferViewController.m
//  NiuduFinance
//
//  Created by 123 on 17/2/20.
//  Copyright © 2017年 liuyong. All rights reserved.
//

#import "TransferViewController.h"
#import "MyCreditorViewController.h"

@interface TransferViewController ()

@property (nonatomic,strong)UIView * priceView;
@property (nonatomic,strong)UILabel * transLabel;
@property (nonatomic,strong)UIView * linView;
@property (nonatomic,strong)UILabel* expectLabel;
@property (nonatomic,strong)UIView * linTwoView;
@property (nonatomic,strong)UILabel* forecastLabel;
@property (nonatomic,strong)UILabel * perCentLabel;
@property (nonatomic,strong)UIImageView * imageView;
@property (nonatomic,strong)UILabel * agreementLab;
@property (nonatomic,strong)UIButton * transBtn;




@end

@implementation TransferViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _priceView = [UIView new];
    [_priceView setBackgroundColor:[UIColor whiteColor]];
    _priceView.frame = CGRectMake(0, 10, SCREEN_WIDTH, 136);
    [self.view addSubview:_priceView];
    
    _transLabel = [UILabel new];
    [_transLabel setText:@"转让价格"];
    [_transLabel setFont:[UIFont systemFontOfSize:16]];
    [_priceView addSubview:_transLabel];
    [_transLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(16);
        make.left.mas_equalTo(15);
    }];
    
    _linView = [UIView new];
    [_linView setBackgroundColor:[UIColor colorWithHexString:@"#F5F5F5"]];
    [_priceView addSubview:_linView];
    [_linView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(45);
        make.left.mas_equalTo(15);
        make.right.mas_equalTo(0);
        make.height.mas_equalTo(2);
    }];
    
    
    _expectLabel = [UILabel new];
    [_expectLabel setFont:[UIFont systemFontOfSize:14]];
    [_priceView addSubview:_expectLabel];
    [_expectLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_linView.mas_bottom).with.offset(15);
        make.left.mas_equalTo(32);
    }];

    _linTwoView = [UIView new];
    [_linTwoView setBackgroundColor:[UIColor colorWithHexString:@"#F5F5F5"]];
    [_priceView addSubview:_linTwoView];
    [_linTwoView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_expectLabel.mas_bottom).with.offset(15);
        make.left.mas_equalTo(15);
        make.right.mas_equalTo(0);
        make.height.mas_equalTo(2);
    }];
    
    _forecastLabel = [UILabel new];
    [_forecastLabel setFont:[UIFont systemFontOfSize:14]];
    [_priceView addSubview:_forecastLabel];
    [_forecastLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_linTwoView.mas_bottom).with.offset(15);
        make.left.mas_equalTo(32);
    }];
    
    _perCentLabel = [UILabel new];
    [_perCentLabel setText:@"转让手续费收取实际成交金额的0.1%"];
    [_perCentLabel setFont:[UIFont systemFontOfSize:13]];
    [self.view addSubview:_perCentLabel];
    [_perCentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_priceView.mas_bottom).with.offset(10);
        make.left.mas_equalTo(31);
    }];
    
    _imageView = [UIImageView new];
    UIImage * image = [UIImage imageNamed:@"0.7.png"];
    _imageView.image = image;
    [self.view addSubview:_imageView];
    [_imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_perCentLabel.mas_bottom).with.offset(48);
        make.left.mas_equalTo(121);
    }];
    
    _agreementLab = [UILabel new];
    [_agreementLab setText:@"同意债权转让协议"];
    [_agreementLab setFont:[UIFont systemFontOfSize:14]];
    [_agreementLab setTextColor:[UIColor colorWithHexString:@"#019BFF"]];
    [self.view addSubview:_agreementLab];
    [_agreementLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_imageView.mas_right).with.offset(8);
        make.bottom.equalTo(_imageView.mas_bottom).with.offset(0);
    }];
    
    _transBtn = [UIButton new];
    _transBtn.clipsToBounds=YES;
    _transBtn.layer.cornerRadius=5;
    _transBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    [_transBtn setTitle:@"转让" forState:UIControlStateNormal];
    [_transBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_transBtn setBackgroundColor:[UIColor colorWithHexString:@"#019BFF"]];
    [_transBtn addTarget:self action:@selector(transClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_transBtn];
    [_transBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_agreementLab.mas_bottom).with.offset(10);
        make.left.mas_equalTo(10);
        make.right.mas_equalTo(-10);
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH-20, 45));
    }];
}

- (void)setProjectId:(int)projectId
{
    _projectId = projectId;
    
    NSLog(@"%d",_projectId);
}

- (void)setPrice:(double)price
{
    _price = price;
}

- (void)setProjectDic:(NSDictionary *)projectDic
{
    _projectDic = projectDic;
    
    NSString * copie = [_projectDic objectForKey:@"copies"];
    CGFloat fee = ([copie integerValue] * _price) * 0.001;
    [_expectLabel setText:[NSString stringWithFormat:@"预计成交后到账：%.2f元", [copie integerValue] * _price - fee]];
    
    [_forecastLabel setText:[NSString stringWithFormat:@"预估转让手续费：%.2f元/份", fee]];
}

- (void)transClick:(UIButton *)sender
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"确定转让!" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:@"取消", nil];
    [alert show];
}


- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    if (buttonIndex==1) {
        return;
    }else{
        [self getTrans];
    }
}

- (void)getTrans
{
    [self.httpUtil requestDic4MethodNam:@"v2/accept/debt/transfer" parameters:@{@"projectId":@(_projectId),@"price":@(_price)} result:^(NSDictionary * dic, int status, NSString *msg) {
        NSLog(@"%@",dic);
        
        if (status == 0) {
            NSArray * array = self.navigationController.viewControllers;
            for (UIViewController * vc in array) {
                if ([vc isKindOfClass:[MyCreditorViewController class]]) {
                    
                    [self settiShi];
                    [self.navigationController popToViewController:vc animated:YES];
                    return ;
                }
            }
        }else{
            self.hideNoNetWork = YES;
            NSLog(@"%@",dic);
        }
    }];
}

- (void)settiShi{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"转让成功" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [alert show];
}

@end
