//
//  MyCollectionViewCell2.m
//  NiuduFinance
//
//  Created by 小吊丝 on 2017/9/28.
//  Copyright © 2017年 liuyong. All rights reserved.
//

#import "MyCollectionViewCell2.h"

@interface MyCollectionViewCell2 ()

@property(nonatomic, strong)UIImageView *imageView;
@property(nonatomic, strong)UILabel *titleLabel;

@end

@implementation MyCollectionViewCell2

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
    
    [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.mas_equalTo(15);
        make.centerY.mas_equalTo(0);
    }];
    self.imageView.image = [UIImage imageNamed:@"home_users"];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.mas_equalTo(self.imageView.mas_right).offset(10);
        make.centerY.mas_equalTo(self.mas_centerY).offset(0);
    }];
    
    
    self.titleLabel.textColor = [UIColor colorWithHexString:@"#282828"];
    self.titleLabel.font = [UIFont systemFontOfSize:13];
    self.titleLabel.text = @"";
}


-(void)setIndexPath:(NSIndexPath *)indexPath
{
    _indexPath = indexPath;
    if (indexPath.section == 2) {
        if (indexPath.row == 0) {
            self.titleLabel.text = @"投资记录";
            self.imageView.image = [UIImage imageNamed:@"投资记录"];
        }
        if (indexPath.row == 1) {
            self.titleLabel.text = @"资金明细";
            self.imageView.image = [UIImage imageNamed:@"资金明细"];
        }
    }
    
    if (indexPath.section == 3) {
        if (indexPath.row == 0) {
            self.titleLabel.text = @"邀请中心";
            self.imageView.image = [UIImage imageNamed:@"邀请中心"];
        }
        if (indexPath.row == 1) {
            self.titleLabel.text = @"客服管家";
            self.imageView.image = [UIImage imageNamed:@"客服管家"];
        }
    }
}


@end
