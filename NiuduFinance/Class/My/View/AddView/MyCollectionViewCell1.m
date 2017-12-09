//
//  MyCollectionViewCell1.m
//  NiuduFinance
//
//  Created by 小吊丝 on 2017/9/28.
//  Copyright © 2017年 liuyong. All rights reserved.
//

#import "MyCollectionViewCell1.h"

@interface MyCollectionViewCell1 ()

@property(nonatomic, strong)UIImageView *imageView;
@property(nonatomic, strong)UILabel *titleLabel;
@property(nonatomic, strong)UILabel *subLabel;

@end

@implementation MyCollectionViewCell1

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
    self.backgroundColor = [UIColor whiteColor];
    self.imageView = [[UIImageView alloc] init];
    [self addSubview:self.imageView];
    self.titleLabel = [[UILabel alloc] init];
    [self addSubview:self.titleLabel];
    self.subLabel = [[UILabel alloc] init];
    [self addSubview:self.subLabel];

    [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.mas_equalTo(15);
        make.centerY.mas_equalTo(0);
    }];
    self.imageView.image = [UIImage imageNamed:@"home_users"];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.mas_equalTo(self.imageView.mas_right).offset(10);
        make.bottom.mas_equalTo(self.mas_centerY).offset(1);
    }];
    
    [self.subLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.titleLabel.mas_left);
        make.top.mas_equalTo(self.mas_centerY).offset(6);
    }];
    
    self.titleLabel.textColor = [UIColor colorWithHexString:@"#282828"];
    self.subLabel.textColor = [UIColor colorWithHexString:@"#989898"];
    
    self.titleLabel.font = [UIFont systemFontOfSize:13];
    self.subLabel.font = [UIFont systemFontOfSize:11];
    self.titleLabel.text = @"多萨德奥术大师";
    self.subLabel.text = @"奥术大师大所多";
    
}

-(void)setIndexPath:(NSIndexPath *)indexPath
{
    _indexPath = indexPath;
    if (indexPath.row == 0) {
        self.titleLabel.text = @"投资记录";
        self.subLabel.text = @"历史投资记录";
        self.imageView.image = [UIImage imageNamed:@"闲钱生钱"];
    }
    if (indexPath.row == 1) {
        self.titleLabel.text = @"资金明细";
        self.subLabel.text = @"资金流水记录";
        self.imageView.image = [UIImage imageNamed:@"免费体验"];
    }
    if (indexPath.row == 2) {
        self.titleLabel.text = @"优惠券";
        self.subLabel.text = @"查看可用优惠券";
        self.imageView.image = [UIImage imageNamed:@"礼券中心"];
    }
    if (indexPath.row == 3) {
        self.titleLabel.text = @"福利金";
        self.subLabel.text = @"福利金光速变现";
        self.imageView.image = [UIImage imageNamed:@"积分签到"];
    }
}


@end
