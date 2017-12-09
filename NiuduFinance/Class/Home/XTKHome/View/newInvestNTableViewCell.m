//
//  newInvestNTableViewCell.m
//  NiuduFinance
//
//  Created by 沈益南 on 2017/10/23.
//  Copyright © 2017年 liuyong. All rights reserved.
//

#import "newInvestNTableViewCell.h"
//@property (nonatomic, strong) UIImageView * titleImage;
//@property (nonatomic, strong) UILabel *titleLab;
//@property (nonatomic, strong) UILabel *percentLab;
//@property (nonatomic, strong) UILabel *addPercentLab;
//@property (nonatomic, strong) UIButton *investBtn;     

@implementation newInvestNTableViewCell


#pragma mark - 懒加载

-(UIView *)backgroundNView{
    if (_backgroundNView == nil) {
        _backgroundNView = [UIView new];
        _backgroundNView.backgroundColor = [UIColor whiteColor];
        [self addSubview:_backgroundNView];
        [_backgroundNView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(15);
            make.left.mas_equalTo(15);
            make.right.mas_equalTo(-15);
            make.bottom.mas_equalTo(0);
        }];
    }
    return _backgroundNView;
}

-(UIView *)titleBackGroundView{
    if (_titleBackGroundView == nil) {
        _titleBackGroundView = [UIView new];
        _titleBackGroundView.backgroundColor = [UIColor whiteColor];
        [self.backgroundNView addSubview:_titleBackGroundView];
        [_titleBackGroundView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.bounds.size.width/4);
            make.right.mas_equalTo(0);
            make.top.mas_equalTo(0);
            make.bottom.mas_equalTo(0);
        }];
    }
    return _titleBackGroundView;
    
}

-(UILabel *)titleLab{
    if (_titleLab == nil) {
        _titleLab = [UILabel new];
        [self.titleBackGroundView addSubview:_titleLab];
        _titleLab.font = [UIFont systemFontOfSize:12];
        _titleLab.textColor = [UIColor lightGrayColor];
        _titleLab.textAlignment = NSTextAlignmentCenter;
        [_titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(15);
            make.centerX.mas_equalTo(0);
            make.width.mas_equalTo(100);
//            make.height.mas_equalTo(20);
        }];
    }
    return _titleLab;
}

-(UILabel *)percentLab{
    if (_percentLab == nil) {
        _percentLab = [UILabel new];
        [self.titleBackGroundView  addSubview:_percentLab];
//        _percentLab.backgroundColor = [UIColor redColor];
        _percentLab.textColor = UIcolors;
        _percentLab.font = [UIFont systemFontOfSize:30];
        _percentLab.textAlignment = NSTextAlignmentRight;
        [_percentLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.titleLab.mas_bottom).offset(12);
            make.centerX.mas_equalTo(0);
            make.left.mas_equalTo(0);
            make.right.mas_equalTo(-100);
//            NSLog(@"----------%d",self.titleBackGroundView.bounds.size.width/3);
//            make.height.mas_equalTo(40);
        }];
    }
    return _percentLab;
}

-(UILabel *)addPercentLab{
    if (_addPercentLab == nil) {
        _addPercentLab = [UILabel new];
        [self.titleBackGroundView  addSubview:_addPercentLab];
        _addPercentLab.textColor = UIcolors;
          _addPercentLab.font = [UIFont systemFontOfSize:15];
        [_addPercentLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.titleLab.mas_bottom).offset(12);
            make.left.mas_equalTo(self.percentLab.mas_right).offset(5);
            make.width.mas_equalTo(100);
            make.height.mas_equalTo(20);
        }];
    }
    return _addPercentLab;
}

-(UILabel *)investBtn{
    if (_investBtn == nil) {
        _investBtn = [UILabel new];
        [self.titleBackGroundView  addSubview:_investBtn];
//        [_investBtn setTitleColor:UIcolors forState:(UIControlStateNormal)];
//        [_investBtn.titleLabel setFont:[UIFont systemFontOfSize:13]];
//        [_investBtn setTitle:@"立即投资" forState:(UIControlStateNormal)];
        _investBtn.textColor = UIcolors;
        _investBtn.font = [UIFont systemFontOfSize:13];
        _investBtn.text = @"立即投资";
        _investBtn.textAlignment = NSTextAlignmentCenter;
        _investBtn.layer.masksToBounds = YES;
        _investBtn.layer.borderWidth = 0.5;
        _investBtn.layer.borderColor = UIcolors.CGColor;
        [_investBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.percentLab.mas_bottom).offset(12);
            make.centerX.mas_equalTo(0);
            make.width.mas_equalTo(69);
            make.height.mas_equalTo(26);
        }];
    }
    return _investBtn;
}

-(UIImageView *)titleImage{
    if (_titleImage == nil) {
        _titleImage = [UIImageView new];
        [self.backgroundNView  addSubview:_titleImage];
        [_titleImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(0);
            make.left.mas_equalTo(0);
            make.bottom.mas_equalTo(0);
            make.width.mas_equalTo(self.bounds.size.width/4);
        }];
    }
    return _titleImage;
}

//- (void)awakeFromNib {
//    [super awakeFromNib];
//}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
