//
//  IntegralHeaderView.m
//  NiuduFinance
//
//  Created by andrewliu on 16/9/18.
//  Copyright © 2016年 liuyong. All rights reserved.
//

#import "IntegralHeaderView.h"
#import "Masonry.h"
#import "QLTurntableView.h"

#define FONTSize [UIFont systemFontOfSize:14];

@interface IntegralHeaderView()<TurntableViewDelegate,UIAlertViewDelegate>

@property (nonatomic,strong) UILabel *canUserIntegraLabel;

@property (nonatomic,strong) UILabel *integrateNumLabel;

@property (nonatomic,strong) UILabel *monthLabel;

@property (nonatomic,strong) UILabel *monthNumLabel;

@property (nonatomic,strong) UILabel *sumIntegrateNumLabel;

@property(nonatomic,strong) CAShapeLayer * progrssLayer;

@property (nonatomic,strong) QLTurntableView * turntable;
@property (nonatomic,strong) UILabel * label;//展示

@property (nonatomic, retain) NSArray *imageArray;//图片数组
@property (nonatomic, retain) NSArray *prizeArray;//奖励数组
@property (nonatomic, retain) NSArray *numberArray;//概率数组--百分制
@end

@implementation IntegralHeaderView


- (instancetype)init
{
    if (self=[super init]) {
        
        self.backgroundColor = [UIColor whiteColor];
        
        
    }
    return self;
}

- (void)setDic:(NSDictionary *)dic
{
    _dic = dic;
    [self loadView];

    
}
- (void)loadView{

    UILabel * cjLabel = [UILabel new];
    [cjLabel setText:@"签到抽奖"];
    [cjLabel setFont:[UIFont systemFontOfSize:13]];
    [self addSubview:cjLabel];

    UIButton * rlueBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [rlueBtn setTitle:@"规则" forState:UIControlStateNormal];
    [rlueBtn setTitleColor:[UIColor colorWithHexString:@"#999999"] forState:UIControlStateNormal];
    rlueBtn.titleLabel.font = [UIFont systemFontOfSize:13];
    [self addSubview:rlueBtn];
    
    _imageArray = @[@"现金奖励",@"提供特权券",@"现金券",@"现金券",@"加息券",@"现金券",@"一枝花",@"一只狗"];
    _prizeArray = @[@"3元",@"T+1",@"30元",@"10元",@"1%",@"50元",@"特别奖",@"托养奖"];
    
    //此处数组数据为百分制数据，即概率为整数10%，1%等等，即最小为1%OR0,则不会为其他
    _numberArray = @[@10.f,@20.f,@15.f,@20.f,@0.f,@20.f,@5.f,@10.f];
    
    // 转盘View
    self.turntable = [[QLTurntableView alloc] initWithFrame:CGRectMake(0, 45, SCREEN_WIDTH-100, SCREEN_WIDTH-100) ImageArr:_imageArray PrizeArr:_prizeArray NumberArr:_numberArray];
    self.turntable.center = self.center;
    self.turntable.delegate = self;
    //可修改几分制概率，但上面的概率数组一律为百分制数据，具体的分制转换已封装
        self.turntable.probabilityModel = TurntableProbabilityExtremely;
        self.turntable.btnClickNum = 2;
    [self addSubview:self.turntable];
    [self.turntable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(45);
        make.centerX.mas_equalTo(0);
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH-100, SCREEN_WIDTH-100));
    }];
    
    //显示奖励的label
    self.label = [[UILabel alloc] init];
    self.label.textAlignment = NSTextAlignmentCenter;
    self.label.backgroundColor = [UIColor whiteColor];
    [self addSubview:self.label];
    [self.label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.turntable.mas_bottom).with.offset(25);
        make.centerX.mas_equalTo(0);
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH-100, 30));
    }];
    
    _canUserIntegraLabel = [[UILabel alloc] init];
    _canUserIntegraLabel.text = @"可用积分:";
    [_canUserIntegraLabel setTextColor:Nav019BFF];
    _canUserIntegraLabel.font = FONTSize;
    [self addSubview:_canUserIntegraLabel];
    
    _integrateNumLabel = [[UILabel alloc] init];
    if (IsStrEmpty([[_dic objectForKey:@"Integral"] stringValue])) {
      _integrateNumLabel.text = @"";
    }else{
        _integrateNumLabel.text = [NSString stringWithFormat:@"%@",[_dic objectForKey:@"Integral"]];
    }
    
    _integrateNumLabel.font = FONTSize;
    [_integrateNumLabel setTextColor:Nav019BFF];
    [self addSubview:_integrateNumLabel];
    
    _monthLabel = [[UILabel alloc]init];
    _monthLabel.text = @"本月获得:";
    _monthLabel.font = FONTSize;
    [_monthLabel setTextColor:[UIColor colorWithHexString:@"#999999"]];
    [self addSubview:_monthLabel];
    
    _monthNumLabel = [[UILabel alloc] init];
    _monthNumLabel.text = [NSString stringWithFormat:@"%@",IsStrEmpty([[_dic objectForKey:@"MonthIntegral"] stringValue])?@"":[_dic objectForKey:@"MonthIntegral"]];
    _monthNumLabel.font = FONTSize;
    [_monthNumLabel setTextColor:[UIColor colorWithHexString:@"#999999"]];
    [self addSubview:_monthNumLabel];
    
    
    //添加约束
//    __weak typeof (self)weakSelf = self;
    
    [cjLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(20);
        make.left.mas_equalTo(15);
        make.height.mas_equalTo(13);
    }];
    
    [rlueBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(20);
        make.right.mas_equalTo(-15);
        make.height.mas_equalTo(13);
    }];
//    [_canUserIntegraLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(weakSelf).offset(8);
//        make.bottom.equalTo(weakSelf).offset(5);
//        make.width.mas_equalTo(65);
//        make.height.mas_equalTo(35);
//        
//    }];
//    
//    [_integrateNumLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.bottom.equalTo(_canUserIntegraLabel);
//        make.left.equalTo(_canUserIntegraLabel.mas_right).offset(1);
//        make.width.mas_equalTo(65);
//        make.height.mas_equalTo(35);
//    }];
//    
//    [_monthLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.centerX.equalTo(weakSelf).offset(-10);
//        make.top.bottom.equalTo(_canUserIntegraLabel);
//        make.width.mas_equalTo(65);
//        make.height.mas_equalTo(35);
//    }];
//    
//    [_monthNumLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.bottom.equalTo(_monthLabel);
//        make.left.equalTo(_monthLabel.mas_right).offset(0);
//        make.width.mas_equalTo(65);
//        make.height.mas_equalTo(35);
//    }];

    
    
}
- (void)TurnTableViewDidFinishWithIndex:(NSInteger)index BtnClickNum:(NSInteger)btnClickNum{
    if (btnClickNum == 0) {
        // 点击后的次数显示
        self.label.text = [NSString stringWithFormat:@"恭喜您抽中%@",_prizeArray[index]];
        UIAlertView * aleart = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:self.label.text delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [aleart show];
        self.label.text = [NSString stringWithFormat:@"您的次数已用尽"];
    }else{
        // 转盘结束后调用，显示获得的对应奖励
        self.label.text = [NSString stringWithFormat:@"恭喜您抽中%@",_prizeArray[index]];
    }
    
    
}


@end
