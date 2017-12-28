//
//  MyNewHeaderView.m
//  NiuduFinance
//
//  Created by 小吊丝 on 2017/9/28.
//  Copyright © 2017年 liuyong. All rights reserved.
//

#import "MyNewHeaderView.h"

@interface MyNewHeaderView ()

@property(nonatomic, strong)UIImageView *headerImageView;
@property(nonatomic, strong)UIImageView *messageImageView;
@property(nonatomic, strong)UILabel *messageLabel;
@property(nonatomic, strong)UIImageView *chongZhiImageView;
@property(nonatomic, strong)UIImageView *tiXianImageView;
@property(nonatomic, strong)UILabel *nameLabel;
@property(nonatomic, strong)UILabel *ziChanLabel;
@property(nonatomic, strong)UILabel *ziChanNumLabel;
@property(nonatomic, strong)UILabel *yuELabel;
@property(nonatomic, strong)UILabel *yuENumLabel;
@property(nonatomic, strong)UILabel *shouYiLabel;
@property(nonatomic, strong)UILabel *shouYiNumLabel;
@property(nonatomic, strong)UILabel *chongZhiLabel;
@property(nonatomic, strong)UILabel *tiXianLabel;

@property(nonatomic, strong)UIButton *button1;//头像未登录
@property(nonatomic, strong)UIButton *button2;//消息
@property(nonatomic, strong)UIButton *button3;//充值
@property(nonatomic, strong)UIButton *button4;//提现

@end

@implementation MyNewHeaderView

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self createSubViews];
    }
    return self;
}

-(void)createSubViews
{
    UIImageView *imageView = [[UIImageView alloc] init];
    [self addSubview:imageView];
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.right.top.bottom.mas_equalTo(0);
    }];
    imageView.image = [UIImage imageNamed:@"矩形-11"];
    
    //头像
    self.headerImageView = [[UIImageView alloc] init];
    [self addSubview:self.headerImageView];
    [self.headerImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.mas_equalTo(27);
        make.top.mas_equalTo(45);
        make.size.mas_equalTo(CGSizeMake(33, 33));
    }];
//    self.headerImageView.backgroundColor = [UIColor redColor];
    
    //消息
    self.messageImageView = [[UIImageView alloc] init];
    [self addSubview:self.messageImageView];
    [self.messageImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.mas_equalTo(-27);
        make.centerY.mas_equalTo(self.headerImageView.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(50, 26));
    }];
//    self.messageImageView.backgroundColor = [UIColor redColor];
    
    //消息数量
    self.messageLabel = [[UILabel alloc] init];
    [self addSubview:self.messageLabel];
    [self.messageLabel mas_makeConstraints:^(MASConstraintMaker *make) {

        make.centerX.mas_equalTo(self.messageImageView.mas_right).offset(0);
        make.centerY.mas_equalTo(self.headerImageView.mas_top).offset(0);
        make.size.mas_equalTo(CGSizeMake(20, 20));
    }];
    self.messageLabel.font = [UIFont systemFontOfSize:10];
//    self.messageLabel.textColor = [UIColor redColor];
//    self.messageLabel.backgroundColor = [UIColor greenColor];
    self.messageLabel.text = @"";
    
    //未登录
    self.nameLabel = [[UILabel alloc] init];
    [self addSubview:self.nameLabel];
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.mas_equalTo(self.headerImageView.mas_right).offset(10);
        make.centerY.mas_equalTo(self.headerImageView.mas_centerY);
    }];
    self.nameLabel.font = [UIFont systemFontOfSize:12];
    self.nameLabel.textColor = [UIColor whiteColor];
//    self.nameLabel.backgroundColor = [UIColor redColor];
//    self.nameLabel.text = @"未登录";
    self.nameLabel.text = @"";
    
    //总资产(元)
    self.ziChanLabel = [[UILabel alloc] init];
    [self addSubview:self.ziChanLabel];
    [self.ziChanLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(80);
        make.centerX.mas_equalTo(0);
    }];
    self.ziChanLabel.font = [UIFont systemFontOfSize:11];
    self.ziChanLabel.textColor = [UIColor whiteColor];
//    self.ziChanLabel.backgroundColor = [UIColor redColor];
    self.ziChanLabel.text = @"总资产(元)";
    //总资产(元)   数字
    self.ziChanNumLabel = [[UILabel alloc] init];
    [self addSubview:self.ziChanNumLabel];
    [self.ziChanNumLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(self.ziChanLabel.mas_bottom).offset(6);
        make.centerX.mas_equalTo(0);
        make.height.mas_equalTo(22);
    }];
    self.ziChanNumLabel.font = [UIFont systemFontOfSize:22];
    self.ziChanNumLabel.textColor = [UIColor whiteColor];
//    self.ziChanNumLabel.backgroundColor = [UIColor redColor];
    self.ziChanNumLabel.text = @"";
    
    //账户余额
    self.yuELabel = [[UILabel alloc] init];
    [self addSubview:self.yuELabel];
    [self.yuELabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerX.mas_equalTo(self.mas_left).mas_equalTo(85);
        make.top.mas_equalTo(self.ziChanNumLabel.mas_bottom).offset(15);
    }];
    self.yuELabel.font = [UIFont systemFontOfSize:11];
    self.yuELabel.textColor = [UIColor whiteColor];
//    self.yuELabel.backgroundColor = [UIColor redColor];
    self.yuELabel.text = @"账户余额";
    //账户余额   数字
    self.yuENumLabel = [[UILabel alloc] init];
    [self addSubview:self.yuENumLabel];
    [self.yuENumLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(self.yuELabel.mas_bottom).offset(6);
        make.centerX.mas_equalTo(self.yuELabel.mas_centerX);
        make.height.mas_equalTo(22);
    }];
    self.yuENumLabel.font = [UIFont systemFontOfSize:22];
    self.yuENumLabel.textColor = [UIColor whiteColor];
//    self.yuENumLabel.backgroundColor = [UIColor redColor];
    self.yuENumLabel.text = @"";
    
    
    //累计收益
    self.shouYiLabel = [[UILabel alloc] init];
    [self addSubview:self.shouYiLabel];
    [self.shouYiLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerX.mas_equalTo(self.mas_right).mas_equalTo(-85);
        make.top.mas_equalTo(self.yuELabel.mas_top);
    }];
    self.shouYiLabel.font = [UIFont systemFontOfSize:11];
    self.shouYiLabel.textColor = [UIColor whiteColor];
//    self.shouYiLabel.backgroundColor = [UIColor redColor];
    self.shouYiLabel.text = @"累计收益";
    //累计收益   数字
    self.shouYiNumLabel = [[UILabel alloc] init];
    [self addSubview:self.shouYiNumLabel];
    [self.shouYiNumLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(self.yuENumLabel.mas_top);
        make.centerX.mas_equalTo(self.shouYiLabel.mas_centerX);
        make.height.mas_equalTo(22);
    }];
    self.shouYiNumLabel.font = [UIFont systemFontOfSize:22];
    self.shouYiNumLabel.textColor = [UIColor whiteColor];
//    self.shouYiNumLabel.backgroundColor = [UIColor redColor];
    self.shouYiNumLabel.text = @"";
    
    //横线
    UIView *lineView1 = [[UIView alloc] init];
    [self addSubview:lineView1];
    [lineView1 mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.mas_equalTo(40);
        make.right.mas_equalTo(-40);
        make.height.mas_equalTo(0.5);
        make.top.mas_equalTo(self.shouYiNumLabel.mas_bottom).offset(17);
    }];
    lineView1.backgroundColor = [UIColor whiteColor];
    
    //竖线
    UIView *lineView2 = [[UIView alloc] init];
    [self addSubview:lineView2];
    [lineView2 mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerX.mas_equalTo(0);
        make.height.mas_equalTo(15);
        make.width.mas_equalTo(0.5);
        make.top.mas_equalTo(lineView1.mas_bottom).offset(18);
    }];
    lineView2.backgroundColor = [UIColor whiteColor];
    
    //充值 imageView
    self.chongZhiImageView = [[UIImageView alloc] init];
    [self addSubview:self.chongZhiImageView];
    [self.chongZhiImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerY.mas_equalTo(lineView2.mas_centerY);
        make.left.mas_equalTo(82);
        make.size.mas_equalTo(CGSizeMake(20, 20));
    }];
//    self.chongZhiImageView.backgroundColor = [UIColor redColor];
    
    //充值  label
    self.chongZhiLabel = [[UILabel alloc] init];
    [self addSubview:self.chongZhiLabel];
    [self.chongZhiLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerY.mas_equalTo(self.chongZhiImageView.mas_centerY);
        make.left.mas_equalTo(self.chongZhiImageView.mas_right).offset(8);
    }];
    self.chongZhiLabel.font = [UIFont systemFontOfSize:14];
    self.chongZhiLabel.textColor = [UIColor whiteColor];
//    self.chongZhiLabel.backgroundColor = [UIColor redColor];
    self.chongZhiLabel.text = @"充值";
    
    //提现  label
    self.tiXianLabel = [[UILabel alloc] init];
    [self addSubview:self.tiXianLabel];
    [self.tiXianLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerY.mas_equalTo(lineView2.mas_centerY);
        make.right.mas_equalTo(-82);
    }];
    self.tiXianLabel.font = [UIFont systemFontOfSize:14];
    self.tiXianLabel.textColor = [UIColor whiteColor];
//    self.tiXianLabel.backgroundColor = [UIColor redColor];
    self.tiXianLabel.text = @"提现";
    
    //提现 imageView
    self.tiXianImageView = [[UIImageView alloc] init];
    [self addSubview:self.tiXianImageView];
    [self.tiXianImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerY.mas_equalTo(self.tiXianLabel.mas_centerY);
        make.right.mas_equalTo(self.tiXianLabel.mas_left).offset(-8);
        make.size.mas_equalTo(CGSizeMake(20, 20));
    }];
//    self.tiXianImageView.backgroundColor = [UIColor redColor];
    
    
    //button1
    self.button1 = [[UIButton alloc] init];
    [self addSubview:self.button1];
    [self.button1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.headerImageView.mas_left);
        make.top.mas_equalTo(self.headerImageView.mas_top);
        make.bottom.mas_equalTo(self.headerImageView.mas_bottom);
        make.right.mas_equalTo(self.nameLabel.mas_right);
    }];
    [self.button1 addTarget:self action:@selector(buttonAction:) forControlEvents:(UIControlEventTouchUpInside)];
    //button2
    //原消息 -》 设置
    self.button2 = [[UIButton alloc] init];
    [self.button2 setTitle:@"设置" forState:UIControlStateNormal];
    [self.button2 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.button2.titleLabel.font = [UIFont systemFontOfSize:15.0f];
    [self addSubview:self.button2];
    WS
    [self.button2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakSelf.messageImageView.mas_left);
        make.top.mas_equalTo(weakSelf.messageLabel.mas_top);
        make.bottom.mas_equalTo(weakSelf.messageImageView.mas_bottom);
        make.right.mas_equalTo(weakSelf.nameLabel.mas_right);
    }];
    [self.button2 addTarget:self action:@selector(buttonAction:) forControlEvents:(UIControlEventTouchUpInside)];
    //button3
    self.button3 = [[UIButton alloc] init];
    [self addSubview:self.button3];
    [self.button3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.chongZhiImageView.mas_left);
        make.top.mas_equalTo(self.chongZhiImageView.mas_top);
        make.bottom.mas_equalTo(self.chongZhiImageView.mas_bottom);
        make.right.mas_equalTo(self.chongZhiLabel.mas_right);
    }];
    [self.button3 addTarget:self action:@selector(buttonAction:) forControlEvents:(UIControlEventTouchUpInside)];
    //button4
    self.button4 = [[UIButton alloc] init];
    [self addSubview:self.button4];
    [self.button4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.tiXianImageView.mas_left);
        make.top.mas_equalTo(self.tiXianImageView.mas_top);
        make.bottom.mas_equalTo(self.tiXianImageView.mas_bottom);
        make.right.mas_equalTo(self.tiXianLabel.mas_right);
    }];
    [self.button4 addTarget:self action:@selector(buttonAction:) forControlEvents:(UIControlEventTouchUpInside)];
    
    self.headerImageView.image = [UIImage imageNamed:@"user-未登录"];
    //self.messageImageView.image = [UIImage imageNamed:@"消息"];
    self.chongZhiImageView.image = [UIImage imageNamed:@"充值"];
    self.tiXianImageView.image = [UIImage imageNamed:@"提现"];
    
}

-(void)buttonAction:(UIButton *)button
{
    if (button == self.button1) {
        if ([self.myNewHeaderViewDelegate respondsToSelector:@selector(myNewHeaderViewButtonAction:)]) {
            [self.myNewHeaderViewDelegate myNewHeaderViewButtonAction:1];
        }
    }
    if (button == self.button2) {
        if ([self.myNewHeaderViewDelegate respondsToSelector:@selector(myNewHeaderViewButtonAction:)]) {
            [self.myNewHeaderViewDelegate myNewHeaderViewButtonAction:1];
        }
    }
    if (button == self.button3) {
        if ([self.myNewHeaderViewDelegate respondsToSelector:@selector(myNewHeaderViewButtonAction:)]) {
            [self.myNewHeaderViewDelegate myNewHeaderViewButtonAction:3];
        }
    }
    if (button == self.button4) {
        if ([self.myNewHeaderViewDelegate respondsToSelector:@selector(myNewHeaderViewButtonAction:)]) {
            [self.myNewHeaderViewDelegate myNewHeaderViewButtonAction:4];
        }
    }
}

-(void)setModel:(MyNewModel *)model
{
    _model = model;
    if(model.user.mobile.length > 10)
    {
        NSString *qb = [model.user.mobile substringToIndex:3];
        NSString *ho = [model.user.mobile substringFromIndex:7];
        NSString *all = [NSString stringWithFormat:@"%@****%@",qb,ho];
        self.nameLabel.text = all;
    }else
    {
        self.nameLabel.text = model.user.mobile;
    }
    self.shouYiNumLabel.text = [NSString stringWithFormat:@"%.2f",[model.income doubleValue]];
    self.yuENumLabel.text = model.mayUseBalance;
    self.ziChanNumLabel.text = model.balance;
}





/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
