//
//  welfareNTableViewCell.m
//  NiuduFinance
//
//  Created by 沈益南 on 2017/10/23.
//  Copyright © 2017年 liuyong. All rights reserved.
//

#import "welfareNTableViewCell.h"

@implementation welfareNTableViewCell

-(void)layout{
    [self titlecycleLab];
    [self cycleLab];
    [self titleStartInvestingLab];
    [self startInvestingLab];
    [self titleLabTwo];
    
}

-(UIView *)backgroundNView{
    if (_backgroundNView == nil) {
        _backgroundNView = [UIView new];
        _backgroundNView.backgroundColor = [UIColor whiteColor];
        [self addSubview:_backgroundNView];
        [_backgroundNView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(0);
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
//                _percentLab.backgroundColor = [UIColor redColor];
        _percentLab.textColor = UIcolors;
        _percentLab.font = [UIFont systemFontOfSize:30];
        _percentLab.textAlignment = NSTextAlignmentLeft;
        [_percentLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.titleLab.mas_bottom).offset(12);
//            make.centerX.mas_equalTo(0);
            make.left.mas_equalTo(50);
            make.width.mas_equalTo(100);
//                        NSLog(@"----------%d",self.titleBackGroundView.bounds.size.width/3);
//                        make.height.mas_equalTo(40);
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

//@property (nonatomic, strong) UILabel *titleLabTwo;
//@property (nonatomic, strong) UILabel *titlecycleLab;
//@property (nonatomic, strong) UILabel *cycleLab;
//@property (nonatomic, strong) UILabel *titleStartInvestingLab;
//@property (nonatomic, strong) UILabel *startInvestingLab;

-(UILabel *)titleLabTwo{//预期年化副标题
    if (_titleLabTwo == nil) {
        _titleLabTwo = [UILabel new];
        [self.titleBackGroundView addSubview:_titleLabTwo];
        _titleLabTwo.text = @"历史年化利率";
        _titleLabTwo.font = [UIFont systemFontOfSize:12];
        _titleLabTwo.textColor = [UIColor lightGrayColor];
        [_titleLabTwo mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.percentLab.mas_bottom).offset(10);
            make.left.mas_equalTo(50);
            make.width.mas_equalTo(50);
        }];
    }
    return _titleLabTwo;
}

-(UILabel *)titlecycleLab{//标题周期
    if (_titlecycleLab == nil) {
        _titlecycleLab = [UILabel new];
        [self.titleBackGroundView addSubview:_titlecycleLab];
//        _titlecycleLab.backgroundColor = [UIColor redColor];
        _titlecycleLab.text = @"周期";
        _titlecycleLab.font = [UIFont systemFontOfSize:10];
        _titlecycleLab.textColor = [UIColor lightGrayColor];
        [_titlecycleLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(-40);
            make.top.mas_equalTo(self.titleLab.mas_bottom).offset(30);
            make.width.mas_equalTo(50);
        }];
    }
    return _titlecycleLab;
}

-(UILabel *)cycleLab{//周期
    if (_cycleLab == nil) {
        _cycleLab = [UILabel new];
        [self.titleBackGroundView addSubview:_cycleLab];
        _cycleLab.text = @"周期";
        _cycleLab.font = [UIFont systemFontOfSize:10];
        _cycleLab.textAlignment = NSTextAlignmentRight;
        _cycleLab.textColor = UIcolors;
        [_cycleLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(self.titlecycleLab.mas_left).offset(-5);
            make.top.mas_equalTo(self.titleLab.mas_bottom).offset(30);
             make.width.mas_equalTo(50);
        }];
    }
    return _cycleLab;
}

-(UILabel *)titleStartInvestingLab{//起投标题
    if (_titleStartInvestingLab == nil) {
        _titleStartInvestingLab = [UILabel new];
        [self.titleBackGroundView addSubview:_titleStartInvestingLab];
        _titleStartInvestingLab.text = @"起投";
        _titleStartInvestingLab.font = [UIFont systemFontOfSize:10];
        _titleStartInvestingLab.textColor = [UIColor lightGrayColor];
        [_titleStartInvestingLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(-40);
            make.top.mas_equalTo(self.cycleLab.mas_bottom).offset(8);
            make.width.mas_equalTo(50);
           
        }];
        
    }
    return _titleStartInvestingLab;
}

-(UILabel *)startInvestingLab{
    if (_startInvestingLab == nil) {
        _startInvestingLab = [UILabel new];
        [self.titleBackGroundView addSubview:_startInvestingLab];
        _startInvestingLab.text = @"";
        _startInvestingLab.textAlignment = NSTextAlignmentRight;
        _startInvestingLab.font = [UIFont systemFontOfSize:10];
        _startInvestingLab.textColor = UIcolors;
        [_startInvestingLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(self.titleStartInvestingLab.mas_left).offset(-5);
            make.top.mas_equalTo(self.cycleLab.mas_bottom).offset(8);
             make.width.mas_equalTo(50);
        }];
    }
    return _startInvestingLab;
}
//
-(UILabel *)investBtn{
    if (_investBtn == nil) {
        _investBtn = [UILabel new];
        [self.titleBackGroundView  addSubview:_investBtn];
//        [_investBtn setTitleColor:UIcolors forState:(UIControlStateNormal)];
        _investBtn.textColor = UIcolors;
//        [_investBtn.titleLabel setFont:[UIFont systemFontOfSize:13]];
        _investBtn.font = [UIFont systemFontOfSize:13];
//        [_investBtn setTitle:@"立即投资" forState:(UIControlStateNormal)];
        _investBtn.text = @"立即投资";
        _investBtn.textAlignment = NSTextAlignmentCenter;
        _investBtn.layer.masksToBounds = YES;
        _investBtn.layer.borderWidth = 0.5;
        _investBtn.layer.borderColor = UIcolors.CGColor;
        [_investBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.titleLabTwo.mas_bottom).offset(15);
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


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
