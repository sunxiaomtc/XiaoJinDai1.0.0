//
//  SNHomeProjecCell.m
//  NiuduFinance
//
//  Created by BuJia on 17/2/15.
//  Copyright © 2017年 liuyong. All rights reserved.
//

#import "SNHomeProjecCell.h"

@interface SNHomeProjecCell ()

@property (nonatomic, strong) UILabel * txtLabel;
@property (nonatomic, strong) UILabel * titleLabel;
@property (nonatomic, strong) UILabel * rateLabel;

@property (nonatomic, strong) UILabel * minbidamountLab;
@property (nonatomic, strong) UILabel * loanperiodLab;
@property (nonatomic, strong) UILabel * dayLab;

@property (nonatomic, strong) UILabel  * remainamountLab;

@end

@implementation SNHomeProjecCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        UIView * topLine = [[UIView alloc] initWithFrame:CGRectMake(10, 36, SCREEN_WIDTH - 20, 0.5)];
        topLine.backgroundColor = kLineColor;
        [self.contentView addSubview:topLine];
        
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.font = [UIFont systemFontOfSize:15.f];
        [self.contentView addSubview:_titleLabel];
        WS
        [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(weakSelf.contentView.mas_left).with.offset(10);
            make.centerY.equalTo(weakSelf.contentView.mas_top).with.offset(18);
        }];
        
        UILabel * hintLabel = [[UILabel alloc] init];
        hintLabel.text = @"国企理财";
        hintLabel.layer.masksToBounds = YES;
        hintLabel.layer.cornerRadius = 3.0f;
        hintLabel.layer.borderWidth = 1.f;
        hintLabel.layer.borderColor = [UIColor colorWithHexString:@"#FF7F50"].CGColor;
        hintLabel.textColor = [UIColor colorWithHexString:@"#FF4500"];
        hintLabel.font = [UIFont systemFontOfSize:11.f];
        hintLabel.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:hintLabel];
        [hintLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(weakSelf.titleLabel.mas_right).with.offset(5);
            make.centerY.equalTo(weakSelf.titleLabel.mas_centerY);
            make.size.mas_equalTo(CGSizeMake(48, 16));
        }];

        
        if (SCREEN_WIDTH == 320) {
            
            _txtLabel = [[UILabel alloc] init];
            _txtLabel.text = @"预期年化";
            _txtLabel.font = [UIFont systemFontOfSize:11.f];
            [self.contentView addSubview:_txtLabel];
            [_txtLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(95);
                make.left.equalTo(weakSelf.contentView.mas_left).with.offset(18);
            }];
            
            _rateLabel = [[UILabel alloc] init];
            _rateLabel.textColor = [UIColor redColor];
            _rateLabel.font = [UIFont systemFontOfSize:20.f];
            [self.contentView addSubview:_rateLabel];
            [_rateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerX.equalTo(_txtLabel.mas_centerX).with.offset(-5);
                make.bottom.equalTo(_txtLabel.mas_top).with.offset(-10);
            }];
            
            UILabel * symbolLabel = [[UILabel alloc] init];
            symbolLabel.text = @"%";
            symbolLabel.textColor = [UIColor redColor];
            symbolLabel.font = [UIFont systemFontOfSize:11.f];
            [self.contentView addSubview:symbolLabel];
            [symbolLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(weakSelf.rateLabel.mas_right).with.offset(2);
                make.bottom.equalTo(_rateLabel.mas_bottom).with.offset(-3);
            }];
            
            
            
            //  剩余可投金额
            _remainamountLab = [[UILabel alloc] init];
            _remainamountLab.font = [UIFont systemFontOfSize:11.f];
            [self.contentView addSubview:_remainamountLab];
            [_remainamountLab mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(weakSelf.rateLabel.mas_top).with.offset(5);
                make.right.equalTo(weakSelf.contentView.mas_right).with.offset(-15);
            }];
            
            _statusButton = [UIButton buttonWithType:UIButtonTypeCustom];
            _statusButton.layer.masksToBounds = YES;
            _statusButton.layer.cornerRadius = 4.0f;
            _statusButton.backgroundColor = HEX_COLOR(@"1a9bfb");
            [_statusButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            _statusButton.titleLabel.font = [UIFont systemFontOfSize:15.f];
            [self.contentView addSubview:_statusButton];
            [_statusButton mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(weakSelf.remainamountLab.mas_bottom).with.offset(10);
                make.right.equalTo(weakSelf.contentView.mas_right).with.offset(-15);
                make.size.mas_equalTo(CGSizeMake(85, 27));
            }];
            
            _minbidamountLab = [[UILabel alloc] init];
            _minbidamountLab.numberOfLines = 0;
            _minbidamountLab.adjustsFontSizeToFitWidth = YES;
            _minbidamountLab.font = [UIFont systemFontOfSize:11.f];
            [self.contentView addSubview:_minbidamountLab];
            [_minbidamountLab mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerX.equalTo(weakSelf.contentView.mas_centerX).with.offset(-15);
                make.bottom.equalTo(weakSelf.txtLabel.mas_bottom);
                make.right.lessThanOrEqualTo(weakSelf.statusButton.mas_left).with.offset(-5);
            }];
            
            //  起投金额
            _minbidamountLab = [[UILabel alloc] init];
            _minbidamountLab.numberOfLines = 0;
            _minbidamountLab.adjustsFontSizeToFitWidth = YES;
            _minbidamountLab.font = [UIFont systemFontOfSize:11.f];
            [self.contentView addSubview:_minbidamountLab];
            [_minbidamountLab mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerX.equalTo(weakSelf.contentView.mas_centerX).with.offset(-15);
                make.bottom.equalTo(weakSelf.txtLabel.mas_bottom);
                make.right.lessThanOrEqualTo(weakSelf.statusButton.mas_left).with.offset(-5);
            }];
            
            _loanperiodLab = [[UILabel alloc] init];
            _loanperiodLab.font = [UIFont systemFontOfSize:20.f];
            _loanperiodLab.textColor = [UIColor redColor];
            [self.contentView addSubview:_loanperiodLab];
            [_loanperiodLab mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(weakSelf.minbidamountLab.mas_left).with.offset(60);
                make.bottom.equalTo(weakSelf.minbidamountLab.mas_top).with.offset(18);
            }];
            
            _dayLab = [[UILabel alloc] init];
            _dayLab.text = @"天";
            _dayLab.textColor = _loanperiodLab.textColor;
            _dayLab.font = [UIFont systemFontOfSize:11.f];
            [self.contentView addSubview:_dayLab];
            [_dayLab mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(weakSelf.loanperiodLab.mas_right).with.offset(1);
                make.bottom.equalTo(weakSelf.loanperiodLab.mas_bottom).with.offset(-2);
            }];
            
        }else{
            
            _txtLabel = [[UILabel alloc] init];
            _txtLabel.text = @"预期年化";
            _txtLabel.font = [UIFont systemFontOfSize:13.f];
            [self.contentView addSubview:_txtLabel];
            [_txtLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(95);
                make.left.equalTo(weakSelf.contentView.mas_left).with.offset(18);
            }];
            
            _rateLabel = [[UILabel alloc] init];
            _rateLabel.textColor = [UIColor redColor];
            _rateLabel.font = [UIFont systemFontOfSize:25.f];
            [self.contentView addSubview:_rateLabel];
            [_rateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerX.equalTo(_txtLabel.mas_centerX).with.offset(-5);
                make.bottom.equalTo(_txtLabel.mas_top).with.offset(-10);
            }];
            
            UILabel * symbolLabel = [[UILabel alloc] init];
            symbolLabel.text = @"%";
            symbolLabel.textColor = [UIColor redColor];
            symbolLabel.font = [UIFont systemFontOfSize:12.f];
            [self.contentView addSubview:symbolLabel];
            [symbolLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(weakSelf.rateLabel.mas_right).with.offset(2);
                make.bottom.equalTo(_rateLabel.mas_bottom).with.offset(-3);
            }];
            
            
            
            //  剩余可投金额
            _remainamountLab = [[UILabel alloc] init];
            _remainamountLab.font = [UIFont systemFontOfSize:11.f];
            [self.contentView addSubview:_remainamountLab];
            [_remainamountLab mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(weakSelf.rateLabel.mas_top).with.offset(5);
                make.right.equalTo(weakSelf.contentView.mas_right).with.offset(-15);
            }];
            
            _statusButton = [UIButton buttonWithType:UIButtonTypeCustom];
            _statusButton.layer.masksToBounds = YES;
            _statusButton.layer.cornerRadius = 4.0f;
            _statusButton.backgroundColor = HEX_COLOR(@"1a9bfb");
            [_statusButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            _statusButton.titleLabel.font = [UIFont systemFontOfSize:15.f];
            [self.contentView addSubview:_statusButton];
            [_statusButton mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(weakSelf.remainamountLab.mas_bottom).with.offset(10);
                make.right.equalTo(weakSelf.contentView.mas_right).with.offset(-15);
                make.size.mas_equalTo(CGSizeMake(85, 27));
            }];
            
            
            _minbidamountLab = [[UILabel alloc] init];
            _minbidamountLab.numberOfLines = 0;
            _minbidamountLab.adjustsFontSizeToFitWidth = YES;
            _minbidamountLab.font = [UIFont systemFontOfSize:13.f];
            [self.contentView addSubview:_minbidamountLab];
            [_minbidamountLab mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerX.equalTo(weakSelf.contentView.mas_centerX).with.offset(-20);
                make.bottom.equalTo(weakSelf.txtLabel.mas_bottom);
                make.right.lessThanOrEqualTo(weakSelf.statusButton.mas_left).with.offset(-5);
            }];
            
            //  起投金额
            _minbidamountLab = [[UILabel alloc] init];
            _minbidamountLab.numberOfLines = 0;
            _minbidamountLab.adjustsFontSizeToFitWidth = YES;
            _minbidamountLab.font = [UIFont systemFontOfSize:13.f];
            [self.contentView addSubview:_minbidamountLab];
            [_minbidamountLab mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerX.equalTo(weakSelf.contentView.mas_centerX).with.offset(-15);
                make.bottom.equalTo(weakSelf.txtLabel.mas_bottom);
                make.right.lessThanOrEqualTo(weakSelf.statusButton.mas_left).with.offset(-5);
            }];
            
            _loanperiodLab = [[UILabel alloc] init];
            _loanperiodLab.font = [UIFont systemFontOfSize:20.f];
            _loanperiodLab.textColor = [UIColor redColor];
            [self.contentView addSubview:_loanperiodLab];
            [_loanperiodLab mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(weakSelf.minbidamountLab.mas_left).with.offset(60);
                make.bottom.equalTo(weakSelf.minbidamountLab.mas_top).with.offset(18);
            }];
            
            _dayLab = [[UILabel alloc] init];
            _dayLab.text = @"天";
            _dayLab.textColor = _loanperiodLab.textColor;
            _dayLab.font = [UIFont systemFontOfSize:13.f];
            [self.contentView addSubview:_dayLab];
            [_dayLab mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(weakSelf.loanperiodLab.mas_right).with.offset(1);
                make.bottom.equalTo(weakSelf.loanperiodLab.mas_bottom).with.offset(-2);
            }];
        }
        

        
        UIView * bottomLine = [[UIView alloc] initWithFrame:CGRectMake(0, 125, SCREEN_WIDTH, 0.5)];
        bottomLine.backgroundColor = kLineColor;
        [self.contentView addSubview:bottomLine];
        
        _bottomButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _bottomButton.backgroundColor = [UIColor clearColor];
        [_bottomButton setTitleColor:[UIColor colorWithWhite:0.3 alpha:0.95] forState:UIControlStateNormal];
        _bottomButton.titleLabel.font = [UIFont systemFontOfSize:14.f];
        [self.contentView addSubview:_bottomButton];
        [_bottomButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(weakSelf.contentView.mas_top).with.offset(125);
            make.bottom.equalTo(weakSelf.contentView.mas_bottom);
            make.left.right.equalTo(weakSelf.contentView);
        }];
    }
    return self;
}

- (void)setItem:(SNProjectListItem *)item
{
    _item = item;
    
    if ([item isKindOfClass:[SNProjectListItem class]]) {
        _txtLabel.text = @"预期年化";
        _titleLabel.text = item.title;
        _rateLabel.text = [NSString stringWithFormat:@"%.2f", [item.rate floatValue]];
        
        
        _loanperiodLab.text = item.loanperiod.stringValue;
        
        _dayLab.hidden = NO;
        if ([item.periodtypeid integerValue] == 1) {
            _dayLab.text = @"天";
        } else if ([item.periodtypeid integerValue] == 2) {
            _dayLab.text = @"个月";
        } else if ([item.periodtypeid integerValue] == 3) {
            _dayLab.text = @"年";
        }
        
        NSMutableAttributedString * attStr = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"投资期限:\n起投金额:%@元", item.minbidamount]];
        NSMutableParagraphStyle * paragraphStyle = [[NSMutableParagraphStyle alloc] init];
        [paragraphStyle setLineSpacing:15];
        [attStr addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, attStr.length)];
        _minbidamountLab.attributedText = attStr;
        
        _remainamountLab.text = [NSString stringWithFormat:@"剩余可投:%@元", item.remainamount];
        _statusButton.backgroundColor = [UIColor colorWithWhite:0.5 alpha:0.95];
        if ([item.statusid integerValue] == 1) {  //  1进行中（立即投资）,2待审核,3还款中,4还款结束
            _statusButton.backgroundColor = HEX_COLOR(@"1a9bfb");
            [_statusButton setTitle:@"立即投资" forState:UIControlStateNormal];
        } else if ([item.statusid integerValue] == 2) {
            [_statusButton setTitle:@"待审核" forState:UIControlStateNormal];
        } else if ([item.statusid integerValue] == 3) {
            [_statusButton setTitle:@"还款中" forState:UIControlStateNormal];
        } else if ([item.statusid integerValue] == 4) {
            [_statusButton setTitle:@"还款结束" forState:UIControlStateNormal];
        } else if ([item.statusid integerValue] == -1) {
            [_statusButton setTitle:@"未开始" forState:UIControlStateNormal];
        }
    } else {
        SNDebtListItem * debtItem = (SNDebtListItem *)item;
        
        _txtLabel.text = @"受让人收益率";
        _titleLabel.text = debtItem.title;
        _rateLabel.text = [NSString stringWithFormat:@"%.2f", [debtItem.srrsy floatValue]];
        
        _dayLab.hidden = YES;
        _loanperiodLab.text = debtItem.owingnumber.stringValue;
        
        NSMutableAttributedString * attStr = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"剩余期数:\n购买价格:%.2f元\n末收本息:%.2f元", [debtItem.priceforsale floatValue], [debtItem.receivableamount floatValue]]];
        NSMutableParagraphStyle * paragraphStyle = [[NSMutableParagraphStyle alloc] init];
        [paragraphStyle setLineSpacing:4];
        [attStr addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, attStr.length)];
        _minbidamountLab.attributedText = attStr;
        
        _remainamountLab.text = [NSString stringWithFormat:@"剩余可投:%@份", debtItem.remainCount];
        if ([debtItem.statusid integerValue] == 1) {  //  1马上投资,其他“交易结束”
            _statusButton.backgroundColor = HEX_COLOR(@"1a9bfb");
            [_statusButton setTitle:@"立即投资" forState:UIControlStateNormal];
        } else {
            _statusButton.backgroundColor = [UIColor colorWithWhite:0.5 alpha:0.95];
            [_statusButton setTitle:@"交易结束" forState:UIControlStateNormal];
        }
    }
}

@end
