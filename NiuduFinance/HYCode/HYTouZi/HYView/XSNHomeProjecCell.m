//
//  XSNHomeProjecCell.m
//  NiuduFinance
//
//  Created by 123 on 17/7/14.
//  Copyright © 2017年 liuyong. All rights reserved.
//

#import "XSNHomeProjecCell.h"
#import "ProjectProgressView.h"
@interface XSNHomeProjecCell ()

@property (nonatomic, strong) UILabel * txtLabel;
@property (nonatomic, strong) UILabel * titleLabel;
@property (nonatomic, strong) UILabel * rateLabel;

@property (nonatomic, strong) UILabel * minbidamountLab;
@property (nonatomic, strong) UILabel * loanperiodLab;
@property (nonatomic, strong) UILabel * dayLab;
@property (nonatomic, strong) UILabel * symbolLabel;
@property (nonatomic ,strong) UILabel *addLab;
@property (nonatomic, strong) UILabel * remainamountLab;

@property (nonatomic, strong) UILabel * labelLoanperiod;
@property (nonatomic, strong) ProjectProgressView * progressView;
@property (nonatomic, strong) UILabel * progressLabel;
//剩余可投文字
@property (nonatomic, strong) UILabel * syktLabel;
@property (nonatomic, strong) UILabel * mjzeLabel;


@property (nonatomic, strong) UIImageView * image;
@end

@implementation XSNHomeProjecCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
//        UIView * topLine = [[UIView alloc] initWithFrame:CGRectMake(10, 36, SCREEN_WIDTH - 20, 0.5)];
//        topLine.backgroundColor = kLineColor;
//        [self.contentView addSubview:topLine];
        UIImageView * imag = [UIImageView new];
        UIImage * imagee = [UIImage imageNamed:@"dxian.png"];
        imag.image = imagee;
        [self.contentView addSubview:imag];
        [imag mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(36);
            make.left.mas_equalTo(10);
            make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH-20, 0.5));
        }];
        
        
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.font = [UIFont systemFontOfSize:15.f];
        [self.contentView addSubview:_titleLabel];
        WS
        [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(weakSelf.contentView.mas_left).with.offset(10);
            make.centerY.equalTo(weakSelf.contentView.mas_top).with.offset(18);
        }];
        
        _image = [UIImageView new];
        [self.contentView addSubview:_image];
        [_image mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(0);
            make.right.mas_equalTo(0);
            make.size.mas_equalTo(CGSizeMake(46, 46));
        }];
        
        
        
            _txtLabel = [[UILabel alloc] init];
            _txtLabel.text = @"预期年化";
            _txtLabel.font = [UIFont systemFontOfSize:13.f];
            [self.contentView addSubview:_txtLabel];
            [_txtLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(88);
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
        
        _addLab = [[UILabel alloc]init];
        _addLab.textColor = [UIColor redColor];
        _addLab.text = @"(+1.1%)";
        _addLab.font = [UIFont systemFontOfSize:18];
        [self.contentView addSubview:_addLab];
        [_addLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(_rateLabel.mas_right).offset(5);
            make.bottom.equalTo(_txtLabel.mas_top).with.offset(-30);
            make.width.mas_equalTo(100);
            make.height.mas_equalTo(20);
        }];
            
            _symbolLabel = [[UILabel alloc] init];
            _symbolLabel.text = @"%";
            _symbolLabel.textColor = [UIColor redColor];
            _symbolLabel.font = [UIFont systemFontOfSize:12.f];
            [self.contentView addSubview:_symbolLabel];
            [_symbolLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(weakSelf.rateLabel.mas_right).with.offset(2);
                make.bottom.equalTo(_rateLabel.mas_bottom).with.offset(-3);
            }];
            
//            _statusButton = [UIButton buttonWithType:UIButtonTypeCustom];
//            _statusButton.layer.masksToBounds = YES;
//            _statusButton.layer.cornerRadius = 4.0f;
//            _statusButton.backgroundColor = HEX_COLOR(@"1a9bfb");
//            [_statusButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//            _statusButton.titleLabel.font = [UIFont systemFontOfSize:15.f];
//            [self.contentView addSubview:_statusButton];
//            [_statusButton mas_makeConstraints:^(MASConstraintMaker *make) {
//                make.centerY.mas_equalTo(0);
//                make.right.equalTo(weakSelf.contentView.mas_right).with.offset(-15);
//                make.size.mas_equalTo(CGSizeMake(85, 27));
//            }];

            //  起投金额
//            _minbidamountLab = [[UILabel alloc] init];
//            _minbidamountLab.numberOfLines = 0;
//            _minbidamountLab.adjustsFontSizeToFitWidth = YES;
//            _minbidamountLab.font = [UIFont systemFontOfSize:11.f];
//            [_minbidamountLab setTextColor:[UIColor colorWithHexString:@"#A9A9A9"]];
//            [self.contentView addSubview:_minbidamountLab];
//            [_minbidamountLab mas_makeConstraints:^(MASConstraintMaker *make) {
//                make.centerY.equalTo(weakSelf.titleLabel.mas_centerY).with.offset(0);
//                make.right.mas_equalTo(-15);
//            }];
        
            _loanperiodLab = [[UILabel alloc] init];
            _loanperiodLab.font = [UIFont systemFontOfSize:23.f];
            _loanperiodLab.textColor = [UIColor blackColor];
            [self.contentView addSubview:_loanperiodLab];
            [_loanperiodLab mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerX.equalTo(weakSelf.contentView.mas_centerX).with.offset(-15);
                make.bottom.equalTo(_txtLabel.mas_top).with.offset(-10);
//                make.right.lessThanOrEqualTo(weakSelf.statusButton.mas_left).with.offset(-5);
            }];
            
            _labelLoanperiod = [UILabel new];
            [_labelLoanperiod setText:@"期限"];
            _labelLoanperiod.font = [UIFont systemFontOfSize:13.f];
            [self.contentView addSubview:_labelLoanperiod];
            [_labelLoanperiod mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerX.mas_equalTo(0);
                make.bottom.equalTo(_txtLabel.mas_bottom);
//                make.height.mas_equalTo(15);
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
        
        
        _progressView = [ProjectProgressView new];
        _progressView.layer.cornerRadius = 2.0f;
        _progressView.layer.masksToBounds = YES;
        _progressView.backgroundColor = BlackCCCCCC;
        [self.contentView addSubview:_progressView];
        [_progressView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_txtLabel.mas_bottom).with.offset(12);
            make.left.mas_equalTo(10);
            make.right.mas_equalTo(-35);
            make.height.mas_equalTo(2);
        }];
        

        
        _syktLabel = [UILabel new];
        [_syktLabel setText:@"剩余可投"];
        [_syktLabel setFont:[UIFont systemFontOfSize:13]];
        [self.contentView addSubview:_syktLabel];
        [_syktLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(88);
            make.right.equalTo(weakSelf.contentView.mas_right).with.offset(-18);
        }];
        
        //  剩余可投金额
        _remainamountLab = [[UILabel alloc] init];
        _remainamountLab.font = [UIFont systemFontOfSize:16.f];
        [self.contentView addSubview:_remainamountLab];
        [_remainamountLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(_loanperiodLab.mas_bottom).with.offset(0);
            make.centerX.equalTo(_syktLabel.mas_centerX);
        }];
        
        _progressLabel = [[UILabel alloc] init];
        _progressLabel.font = [UIFont systemFontOfSize:11.f];
        [_progressLabel setTextColor:UIcolors];
        [self.contentView addSubview:_progressLabel];
        [_progressLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(weakSelf.progressView.mas_right).with.offset(5);
            make.centerY.equalTo(weakSelf.progressView.mas_centerY);
            
        }];

        _mjzeLabel = [UILabel new];
        [_mjzeLabel setFont:[UIFont systemFontOfSize:11]];
        [self.contentView addSubview:_mjzeLabel];
        [_mjzeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(weakSelf.progressView.mas_bottom).with.offset(10);
            make.height.mas_offset(10);
            make.right.mas_offset(-15);
        }];
    }
    return self;
}

//小数点问题
- (NSString *)formatFloat:(float)f
{
    if (fmodf(f, 1)==0) {//如果有一位小数点
        return [NSString stringWithFormat:@"%.0f",f];
    } else if (fmodf(f*10, 1)==0) {//如果有两位小数点
        return [NSString stringWithFormat:@"%.1f",f];
    } else {
        return [NSString stringWithFormat:@"%.2f",f];
    }
}


- (void)setItem:(SNProjectListItem *)item
{
    _item = item;
    
    if ([item isKindOfClass:[SNProjectListItem class]]) {
        _txtLabel.text = @"年化收益率";
        _titleLabel.text = item.title;
        
        NSString *str = [self formatFloat:([item.rate floatValue]-([item.addRate floatValue]))];
           _rateLabel.text = str;
        float add = [item.addRate floatValue];
        if(add > 0)
        {
            _addLab.text = [[NSString stringWithFormat:@"+%@", item.addRate ] stringByAppendingString:@"%"];
        }else
        {
            _addLab.text = @"";
        }
        
        _loanperiodLab.text = item.loanperiod.stringValue;
        NSLog(@"%@",_loanperiodLab.text);

        NSString *ssss = [[NSString stringWithFormat:@"%@",item.process] stringByAppendingString:@"%"];
        
        _progressLabel.text = ssss;
        NSString * sst = [NSString stringWithFormat:@"%@",item.process];
        //
        _progressView.progressValue = [sst doubleValue];
        _dayLab.hidden = NO;
        if ([item.periodtypeid integerValue] == 1) {
            _dayLab.text = @"天";
        } else if ([item.periodtypeid integerValue] == 2) {
            _dayLab.text = @"个月";
        } else if ([item.periodtypeid integerValue] == 3) {
            _dayLab.text = @"年";
        }
        
//        NSMutableAttributedString * attStr = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"投资期限:\n起投金额:%@元", item.minbidamount]];
//        NSMutableParagraphStyle * paragraphStyle = [[NSMutableParagraphStyle alloc] init];
//        [paragraphStyle setLineSpacing:15];
//        [attStr addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, attStr.length)];
//        _minbidamountLab.attributedText = attStr;
        
//        _minbidamountLab.text = [NSString stringWithFormat:@"%@起投",item.minbidamount];
        _remainamountLab.text = [NSString stringWithFormat:@"%@元", item.remainamount];
        NSString * muzeStr = [NSString stringWithFormat:@"%@",item.amount];
        double all = [muzeStr doubleValue] / 10000.0f;
        _mjzeLabel.text = [NSString stringWithFormat:@"募集总额 %.1f万",all];
//        NSString *pdss = [NSString stringWithFormat:@"%@",item.statusid];
        //|| [pdss isEqualToString:@"-1"] || [pdss isEqualToString:@"-2"]
        if (_type == 1) {
//            UIImage * image = [UIImage imageNamed:@"tjdd.png"];
//            _image.image = image;
            [_titleLabel setTextColor:[UIColor blackColor]];
            [_rateLabel setTextColor:[UIColor redColor]];
            [_loanperiodLab setTextColor:[UIColor blackColor]];
            [_syktLabel setTextColor:[UIColor colorWithHexString:@"#E1E1E1"]];
            [_labelLoanperiod setTextColor:[UIColor colorWithHexString:@"#E1E1E1"]];
            [_mjzeLabel setTextColor:[UIColor blackColor]];
            [_dayLab setTextColor:[UIColor blackColor]];
            //[_progressLabel setTextColor:[UIColor blackColor]];
            [_remainamountLab setTextColor:[UIColor blackColor]];
            [_symbolLabel setTextColor:[UIColor redColor]];
            [_txtLabel setTextColor:[UIColor colorWithHexString:@"#E1E1E1"]];

        }else{

            UIImage * image = [UIImage imageNamed:@"gaoqin.png"];
            _image.image = image;
            [_titleLabel setTextColor:[UIColor colorWithHexString:@"#9A9A9A"]];
            [_rateLabel setTextColor:[UIColor colorWithHexString:@"#9A9A9A"]];
            [_loanperiodLab setTextColor:[UIColor colorWithHexString:@"#9A9A9A"]];
            [_syktLabel setTextColor:[UIColor colorWithHexString:@"#E1E1E1"]];
            [_labelLoanperiod setTextColor:[UIColor colorWithHexString:@"#E1E1E1"]];
            [_mjzeLabel setTextColor:[UIColor colorWithHexString:@"#9A9A9A"]];
            [_dayLab setTextColor:[UIColor colorWithHexString:@"#9A9A9A"]];
            //[_progressLabel setTextColor:[UIColor colorWithHexString:@"#9A9A9A"]];
            [_remainamountLab setTextColor:[UIColor colorWithHexString:@"#9A9A9A"]];
            [_symbolLabel setTextColor:[UIColor colorWithHexString:@"#9A9A9A"]];
            [_txtLabel setTextColor:[UIColor colorWithHexString:@"#E1E1E1"]];
        }

//        _statusButton.backgroundColor = [UIColor colorWithWhite:0.5 alpha:0.95];
//        if ([item.statusid integerValue] == 1) {  //  1进行中（立即投资）,2待审核,3还款中,4还款结束
//            _statusButton.backgroundColor = HEX_COLOR(@"1a9bfb");
//            [_statusButton setTitle:@"立即投资" forState:UIControlStateNormal];
//        } else if ([item.statusid integerValue] == 2) {
//            [_statusButton setTitle:@"待审核" forState:UIControlStateNormal];
//        } else if ([item.statusid integerValue] == 3) {
//            [_statusButton setTitle:@"还款中" forState:UIControlStateNormal];
//        } else if ([item.statusid integerValue] == 4) {
//            [_statusButton setTitle:@"还款结束" forState:UIControlStateNormal];
//        } else if ([item.statusid integerValue] == -1) {
//            [_statusButton setTitle:@"未开始" forState:UIControlStateNormal];
//        }
    } 
}

@end
