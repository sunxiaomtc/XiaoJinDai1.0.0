//
//  MyCreditorCell.m
//  NiuduFinance
//
//  Created by zhoupushan on 16/3/10.
//  Copyright © 2016年 liuyong. All rights reserved.
//

#import "MyCreditoNewCell.h"
#import "NetWorkingUtil.h"

@interface MyCreditoNewCell()
//标题
@property (nonatomic,strong)UILabel * nameLabel;

//分割线
@property (nonatomic,strong)UIView * lineView;
//年化收益
@property (nonatomic,strong)UILabel * yearRateLabel;
//百分号
@property (nonatomic,strong)UILabel * percentLabel;

//剩余期数
@property (nonatomic,strong)UILabel * volumeLabel;
//期
@property (nonatomic,strong)UILabel * periodLabel;

//未收本息数字
@property (nonatomic,strong)UILabel * unRefundTitleLabel;
//未收本息
@property (nonatomic,strong)UILabel * interestLabel;
//元
@property (nonatomic,strong)UILabel * yuanLabel;
//下期还款
@property (nonatomic,strong)UILabel * bottomRightLabel;
@property (nonatomic,strong)NSDictionary *modelDic;

@property (nonatomic,strong)UILabel * buyLabel;
@property (nonatomic,strong)UILabel * yuLabel;


@property (nonatomic,strong)UILabel * yearRaLabel;
@property (nonatomic,strong)UILabel * volumLabel;
@property (nonatomic,strong)UILabel * nextTimeLabel;
@property (nonatomic,strong)UILabel * nextHuanLabel;

@end
@implementation MyCreditoNewCell

- (void)awakeFromNib {
    
    _nameLabel        = [UILabel new];
    _agreementLabel   = [UILabel new];
    _lineView         = [UIView new];
    _yearRateLabel    = [UILabel new];
    _percentLabel     = [UILabel new];
    _volumeLabel      =[UILabel new];
    _periodLabel      = [UILabel new];
    _unRefundTitleLabel = [UILabel new];
    _interestLabel    = [UILabel new];
    _yuanLabel        = [UILabel new];
    _bottomRightLabel = [UILabel new];
    _buyLabel         = [UILabel new];
    _yuLabel          = [UILabel new];
    _creditorInvestLabel = [UILabel new];
    
    
    _yearRaLabel      = [UILabel new];
    _volumLabel       = [UILabel new];
    _nextTimeLabel    = [UILabel new];
    _nextHuanLabel    = [UILabel new];
}

#pragma mark - Setter
- (void)setCreditorState:(CreditorStat)creditorStat
{
    _creditorStat = creditorStat;
    BOOL buyLabel;
    BOOL yuLabel;
    BOOL nextHuanLa;
    BOOL agreement;
     switch (creditorStat) {
             //
        case CreditorStateCanTransfe:
             buyLabel = NO;
             yuLabel = NO;
             nextHuanLa = NO;
             agreement = NO;
            break;
             //
        case CreditorStateRefundin:
             buyLabel = NO;
             yuLabel = NO;
             nextHuanLa = NO;
             agreement = NO;
            break;
             //转让协议
        case CreditorStateHistor:
             buyLabel = YES;
             yuLabel = YES;
             nextHuanLa = YES;
             agreement = YES;
            break;
    }
    _nextHuanLabel.hidden = !nextHuanLa;
    _buyLabel.hidden = !buyLabel;
    _yuLabel.hidden = !yuLabel;
    _agreementLabel.hidden = !agreement;
}

#pragma mark - Public
- (void)creditorState:(CreditorStat)state model:(NSDictionary *)modelDic
{
    _modelDic = modelDic;


    [self setCreditorState:state];
    
    if (_creditorStat == CreditorStateCanTransfe) {
        //标题
        [_nameLabel setFont:[UIFont systemFontOfSize:15]];
        _nameLabel.text = [modelDic objectForKey:@"title"];
        [self.contentView addSubview:_nameLabel];
        [_nameLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(10);
            make.left.mas_equalTo(10);
        }];
        
        [_agreementLabel setText:@"转让协议"];
        [_agreementLabel setFont:[UIFont systemFontOfSize:13]];
        [_agreementLabel setTextColor:Nav019BFF];
        [self.contentView addSubview:_agreementLabel];
        [_agreementLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(13);
            make.right.mas_equalTo(-13);
        }];
        
        
        [_lineView setBackgroundColor:[UIColor colorWithHexString:@"#F5F5F5"]];
        [self.contentView addSubview:_lineView];
        [_lineView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(34);
            make.left.mas_equalTo(15);
            make.right.mas_equalTo(0);
            make.height.mas_equalTo(1);
        }];
        
        [_interestLabel setFont:[UIFont systemFontOfSize:13]];
        [_interestLabel setTextColor:[UIColor colorWithHexString:@"999999"]];
        [_interestLabel setText:@"未收本息"];
        [self.contentView addSubview:_interestLabel];
        [_interestLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(24);
            make.bottom.mas_equalTo(-18);
        }];
        
        
        [_unRefundTitleLabel setFont:[UIFont systemFontOfSize:15]];
        [_unRefundTitleLabel setTextColor:[UIColor colorWithHexString:@"FF0000"]];
        _unRefundTitleLabel.text = [NSString stringWithFormat:@"%.2f",[[modelDic objectForKey:@"receivableAmount"] floatValue]];
        [self.contentView addSubview:_unRefundTitleLabel];
        [_unRefundTitleLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(_interestLabel.mas_centerX).with.offset(-5);
            make.bottom.equalTo(_interestLabel.mas_top).with.offset(-9);
        }];
        
        [_yuanLabel setText:@"元"];
        [_yuanLabel setFont:[UIFont systemFontOfSize:12]];
        [_yuanLabel setTextColor:[UIColor colorWithHexString:@"FF0000"]];
        [self.contentView addSubview:_yuanLabel];
        [_yuanLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_unRefundTitleLabel.mas_right).with.offset(0);
            make.bottom.equalTo(_unRefundTitleLabel.mas_bottom).with.offset(-2);
        }];
        
        
        [_yearRaLabel setTextColor:[UIColor colorWithHexString:@"999999"]];
        [_yearRaLabel setFont:[UIFont systemFontOfSize:13]];
        [_yearRaLabel setText:@"年化收益："];
        [self.contentView addSubview:_yearRaLabel];
        [_yearRaLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_lineView.mas_bottom).with.offset(12);
            make.left.mas_equalTo(100);
        }];
        
        //年化收益
//        [_yearRateLabel setTextColor:[UIColor colorWithHexString:@"999999"]];
        [_yearRateLabel setFont:[UIFont systemFontOfSize:13]];
        _yearRateLabel.text = [NSString stringWithFormat:@"%.2f",[[modelDic objectForKey:@"rate"] floatValue]];
        [self.contentView addSubview:_yearRateLabel];
        [_yearRateLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(_yearRaLabel.mas_bottom).with.offset(0);
            make.left.equalTo(_yearRaLabel.mas_right).with.offset(0);
        }];
        
        //百分号
        [_percentLabel setText:@"%"];
        [_percentLabel setTextColor:[UIColor colorWithHexString:@"999999"]];
        [_percentLabel setFont:[UIFont systemFontOfSize:13]];
        [self.contentView addSubview:_percentLabel];
        [_percentLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_yearRateLabel.mas_right).with.offset(0);
            make.bottom.equalTo(_yearRateLabel.mas_bottom).with.offset(0);
        }];
        
        
        [_volumLabel setTextColor:[UIColor colorWithHexString:@"999999"]];
        [_volumLabel setFont:[UIFont systemFontOfSize:13]];
        [_volumLabel setText:@"剩余期数："];
        [self.contentView addSubview:_volumLabel];
        [_volumLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_yearRaLabel.mas_bottom).with.offset(7);
            make.left.equalTo(_yearRaLabel.mas_left).with.offset(0);
        }];
        
        
        //剩余期数
//        [_volumeLabel setTextColor:[UIColor colorWithHexString:@"999999"]];
        [_volumeLabel setFont:[UIFont systemFontOfSize:13]];
        _volumeLabel.text = [NSString stringWithFormat:@"%@",[modelDic objectForKey:@"remainCount"]];
        [self.contentView addSubview:_volumeLabel];
        [_volumeLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_volumLabel.mas_right).with.offset(0);
            make.bottom.equalTo(_volumLabel.mas_bottom).with.offset(0);
        }];
        
        [_periodLabel setTextColor:[UIColor colorWithHexString:@"999999"]];
        [_periodLabel setFont:[UIFont systemFontOfSize:13]];
        [_periodLabel setText:@"期"];
        [self.contentView addSubview:_periodLabel];
        [_periodLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_volumeLabel.mas_right).with.offset(0);
            make.bottom.equalTo(_volumeLabel.mas_bottom).with.offset(0);
        }];
        
        
        
        [_nextTimeLabel setFont:[UIFont systemFontOfSize:13]];
        [_nextTimeLabel setTextColor:[UIColor colorWithHexString:@"999999"]];
        [_nextTimeLabel setText:@"下期还款日："];
        [self.contentView addSubview:_nextTimeLabel];
        [_nextTimeLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_yearRaLabel.mas_left).with.offset(0);
            make.top.equalTo(_volumeLabel.mas_bottom).with.offset(8);
        }];
        
        
        
        NSString * timeStampString = [NSString stringWithFormat:@"%@",[modelDic objectForKey:@"dueDate"]];
        NSTimeInterval _interval=[timeStampString doubleValue] / 1000.0;
        NSDate *date = [NSDate dateWithTimeIntervalSince1970:_interval];
        NSDateFormatter *objDateformat = [[NSDateFormatter alloc] init];
        [objDateformat setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        NSLog(@"%@",  [objDateformat stringFromDate: date]);
        NSString * string = [objDateformat stringFromDate:date];
        NSString * str = [string substringWithRange:NSMakeRange(0, 10)];
        [_bottomRightLabel setFont:[UIFont systemFontOfSize:13]];
//        [_bottomRightLabel setTextColor:[UIColor colorWithHexString:@"999999"]];
        self.bottomRightLabel.text = [NSString stringWithFormat:@"%@",str];
        [self.contentView addSubview:_bottomRightLabel];
        [_bottomRightLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(_nextTimeLabel.mas_bottom).with.offset(0);
            make.left.equalTo(_nextTimeLabel.mas_right).with.offset(0);
        }];
        
        [_creditorInvestLabel setText:@"转让"];
        [_creditorInvestLabel setTextAlignment:NSTextAlignmentCenter];
        _creditorInvestLabel.layer.cornerRadius = 5;
        _creditorInvestLabel.clipsToBounds = YES;
        [_creditorInvestLabel setTextColor:[UIColor whiteColor]];
        _creditorInvestLabel.backgroundColor = Nav019BFF;
        [_creditorInvestLabel setFont:[UIFont systemFontOfSize:12]];
        [self.contentView addSubview:_creditorInvestLabel];
        [_creditorInvestLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(-10);
            make.bottom.mas_equalTo(-28);
            make.size.mas_equalTo(CGSizeMake(75, 26));
        }];
        
        
    }else if (_creditorStat == CreditorStateRefundin){
        
        if ([[NSString stringWithFormat:@"%@", [modelDic objectForKey:@"auditstatusid"]] isEqualToString:@"1"]) {
            _creditorInvestLabel.text = @"撤回";
        }else if ([[NSString stringWithFormat:@"%@",[modelDic objectForKey:@"auditstatusid"]] isEqualToString:@"2"]){
            _creditorInvestLabel.text = @"转让中";
        }
         
        //标题
        [_nameLabel setFont:[UIFont systemFontOfSize:15]];
        _nameLabel.text = [modelDic objectForKey:@"title"];
        [self.contentView addSubview:_nameLabel];
        [_nameLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(10);
            make.left.mas_equalTo(10);
        }];
        
        [_agreementLabel setText:@"转让协议"];
        [_agreementLabel setFont:[UIFont systemFontOfSize:13]];
        [_agreementLabel setTextColor:Nav019BFF];
        [self.contentView addSubview:_agreementLabel];
        [_agreementLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(13);
            make.right.mas_equalTo(-13);
        }];
        
        
        [_lineView setBackgroundColor:[UIColor colorWithHexString:@"#F5F5F5"]];
        [self.contentView addSubview:_lineView];
        [_lineView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(34);
            make.left.mas_equalTo(15);
            make.right.mas_equalTo(0);
            make.height.mas_equalTo(2);
        }];
        
        [_interestLabel setFont:[UIFont systemFontOfSize:13]];
        [_interestLabel setText:@"已转金额"];
        [_interestLabel setTextColor:[UIColor colorWithHexString:@"999999"]];
        [self.contentView addSubview:_interestLabel];
        [_interestLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(24);
            make.bottom.mas_equalTo(-18);
        }];
        
        //已转金额
        [_unRefundTitleLabel setFont:[UIFont systemFontOfSize:15]];
        [_unRefundTitleLabel setTextColor:[UIColor colorWithHexString:@"FF0000"]];
        _unRefundTitleLabel.text = [NSString stringWithFormat:@"%.2f",[[modelDic objectForKey:@"funding"] floatValue]];
        [self.contentView addSubview:_unRefundTitleLabel];
        [_unRefundTitleLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(_interestLabel.mas_centerX).with.offset(-5);
            make.bottom.equalTo(_interestLabel.mas_top).with.offset(-9);
        }];
        
        [_yuanLabel setText:@"元"];
        [_yuanLabel setFont:[UIFont systemFontOfSize:12]];
        [_yuanLabel setTextColor:[UIColor colorWithHexString:@"FF0000"]];
        [self.contentView addSubview:_yuanLabel];
        [_yuanLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_unRefundTitleLabel.mas_right).with.offset(0);
            make.bottom.equalTo(_unRefundTitleLabel.mas_bottom).with.offset(-2);
        }];
        
        
        [_yearRaLabel setText:@"转让单价："];
        [_yearRaLabel setTextColor:[UIColor colorWithHexString:@"999999"]];
        [_yearRaLabel setFont:[UIFont systemFontOfSize:13]];
        [self.contentView addSubview:_yearRaLabel];
        [_yearRaLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_lineView.mas_bottom).with.offset(12);
            make.left.mas_equalTo(100);
        }];
        //转让单价
        [_yearRateLabel setFont:[UIFont systemFontOfSize:13]];
        NSString * year = [modelDic objectForKey:@"share"];
        float yearRect = [year floatValue];
        _yearRateLabel.text = [NSString stringWithFormat:@"%.2f",yearRect];
        [self.contentView addSubview:_yearRateLabel];
        [_yearRateLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_yearRaLabel.mas_right).with.offset(0);
            make.bottom.equalTo(_yearRaLabel.mas_bottom).with.offset(0);
        }];
        
        
        [_percentLabel setText:@"元/份"];
        [_percentLabel setTextColor:[UIColor colorWithHexString:@"999999"]];
        [_percentLabel setFont:[UIFont systemFontOfSize:13]];
        [self.contentView addSubview:_percentLabel];
        [_percentLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_yearRateLabel.mas_right).with.offset(0);
            make.bottom.equalTo(_yearRateLabel.mas_bottom).with.offset(0);
        }];
        
        
        
        [_volumLabel setText:@"转让总额："];
        [_volumLabel setFont:[UIFont systemFontOfSize:13]];
        [_volumLabel setTextColor:[UIColor colorWithHexString:@"999999"]];
        [self.contentView addSubview:_volumLabel];
        [_volumLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_yearRaLabel.mas_bottom).with.offset(7);
            make.left.equalTo(_yearRaLabel.mas_left).with.offset(0);
        }];

        //转让总额
        [_volumeLabel setFont:[UIFont systemFontOfSize:13]];
        NSString * volume = [modelDic objectForKey:@"priceforsale"];
        float volumeLa = [volume floatValue];
        _volumeLabel.text = [NSString stringWithFormat:@"%.2f",volumeLa];
        [self.contentView addSubview:_volumeLabel];
        [_volumeLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_volumLabel.mas_right).with.offset(0);
            make.bottom.equalTo(_volumLabel.mas_bottom).with.offset(0);
        }];
        
        
        [_periodLabel setText:@"元"];
        [_periodLabel setTextColor:[UIColor colorWithHexString:@"999999"]];
        [_periodLabel setFont:[UIFont systemFontOfSize:13]];
        [self.contentView addSubview:_periodLabel];
        [_periodLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_volumeLabel.mas_right).with.offset(0);
            make.bottom.equalTo(_volumeLabel.mas_bottom).with.offset(0);
        }];
        
        
        
        
        [_nextTimeLabel setText:@"剩余时间："];
        [_nextTimeLabel setTextColor:[UIColor colorWithHexString:@"999999"]];
        [_nextTimeLabel setFont:[UIFont systemFontOfSize:13]];
        [self.contentView addSubview:_nextTimeLabel];
        [_nextTimeLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_volumLabel.mas_bottom).with.offset(8);
            make.left.equalTo(_volumLabel.mas_left).with.offset(0);
        }];
        
        
        
        _bottomRightLabel.text = [NSString stringWithFormat:@"%@",[modelDic objectForKey:@"remaindate"]];
        NSLog(@"%@",_bottomRightLabel.text);
        [_bottomRightLabel setFont:[UIFont systemFontOfSize:13]];
        [self.contentView addSubview:_bottomRightLabel];
        [_bottomRightLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(_nextTimeLabel.mas_bottom).with.offset(0);
            make.left.equalTo(_nextTimeLabel.mas_right).with.offset(0);
        }];
        
        [_creditorInvestLabel setTextAlignment:NSTextAlignmentCenter];
        _creditorInvestLabel.layer.cornerRadius = 5;
        _creditorInvestLabel.clipsToBounds = YES;
        [_creditorInvestLabel setTextColor:[UIColor whiteColor]];
        _creditorInvestLabel.backgroundColor = Nav019BFF;
        [_creditorInvestLabel setFont:[UIFont systemFontOfSize:12]];
        [self.contentView addSubview:_creditorInvestLabel];
        [_creditorInvestLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(-10);
            make.bottom.mas_equalTo(-28);
            make.size.mas_equalTo(CGSizeMake(75, 26));
        }];
    }else if (_creditorStat == CreditorStateHistor){
        //标题
        [_nameLabel setFont:[UIFont systemFontOfSize:15]];
        _nameLabel.text = [[modelDic objectForKey:@"project" ]objectForKey:@"title"];
        [self.contentView addSubview:_nameLabel];
        [_nameLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(10);
            make.left.mas_equalTo(10);
        }];
        
        [_agreementLabel setText:@"转让协议"];
        [_agreementLabel setFont:[UIFont systemFontOfSize:13]];
        [_agreementLabel setTextColor:Nav019BFF];
        [self.contentView addSubview:_agreementLabel];
        [_agreementLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(13);
            make.right.mas_equalTo(-13);
        }];
        
        
        [_lineView setBackgroundColor:[UIColor colorWithHexString:@"#F5F5F5"]];
        [self.contentView addSubview:_lineView];
        [_lineView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(34);
            make.left.mas_equalTo(15);
            make.right.mas_equalTo(0);
            make.height.mas_equalTo(2);
        }];
        //未收金额
        [_interestLabel setText:@"未收金额"];
        [_interestLabel setTextColor:[UIColor colorWithHexString:@"999999"]];
        [_interestLabel setFont:[UIFont systemFontOfSize:13]];
        [self.contentView addSubview:_interestLabel];
        [_interestLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(24);
            make.bottom.mas_equalTo(-18);
        }];
        
        [_unRefundTitleLabel setFont:[UIFont systemFontOfSize:15]];
        [_unRefundTitleLabel setTextColor:[UIColor colorWithHexString:@"FF0000"]];
        _unRefundTitleLabel.text = [NSString stringWithFormat:@"%.2f",[[modelDic objectForKey:@"receivableAmount"] floatValue]];
        [self.contentView addSubview:_unRefundTitleLabel];
        [_unRefundTitleLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(_interestLabel.mas_centerX).with.offset(-5);
            make.bottom.equalTo(_interestLabel.mas_top).with.offset(-9);
        }];
        
        [_yuanLabel setText:@"元"];
        [_yuanLabel setFont:[UIFont systemFontOfSize:12]];
        [_yuanLabel setTextColor:[UIColor colorWithHexString:@"FF0000"]];
        [self.contentView addSubview:_yuanLabel];
        [_yuanLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_unRefundTitleLabel.mas_right).with.offset(0);
            make.bottom.equalTo(_unRefundTitleLabel.mas_bottom).with.offset(-2);
        }];
        
        [_yearRaLabel setText:@"受转让收益："];
        [_yearRaLabel setFont:[UIFont systemFontOfSize:13]];
        [_yearRaLabel setTextColor:[UIColor colorWithHexString:@"999999"]];
        [self.contentView addSubview:_yearRaLabel];
        [_yearRaLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_lineView.mas_bottom).with.offset(5);
            make.left.mas_equalTo(100);
        }];
        
        //受转让收益
        [_yearRateLabel setFont:[UIFont systemFontOfSize:13]];
        _yearRateLabel.text = [NSString stringWithFormat:@"%.2f",[[modelDic objectForKey:@"srrsy"]floatValue]];
        [_yearRateLabel setTintColor:[UIColor orangeColor]];
        [self.contentView addSubview:_yearRateLabel];
        [_yearRateLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(_yearRaLabel.mas_bottom).with.offset(0);
            make.left.equalTo(_yearRaLabel.mas_right).with.offset(0);
        }];
        
        //百分号
        [_percentLabel setText:@"%"];
        [_percentLabel setTextColor:[UIColor colorWithHexString:@"999999"]];
        [_percentLabel setFont:[UIFont systemFontOfSize:13]];
        [self.contentView addSubview:_percentLabel];
        [_percentLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_yearRateLabel.mas_right).with.offset(0);
            make.bottom.equalTo(_yearRateLabel.mas_bottom).with.offset(0);
        }];
        
        
        [_volumLabel setText:@"预期赚取："];
        [_volumLabel setFont:[UIFont systemFontOfSize:13]];
        [_volumLabel setTextColor:[UIColor colorWithHexString:@"999999"]];
        [self.contentView addSubview:_volumLabel];
        [_volumLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_yearRaLabel.mas_bottom).with.offset(3);
            make.left.equalTo(_yearRaLabel.mas_left).with.offset(0);
        }];

        //预期赚取
        [_volumeLabel setFont:[UIFont systemFontOfSize:13]];
        _volumeLabel.text = [NSString stringWithFormat:@"%.2f",[[modelDic objectForKey:@"receivableinterest"]floatValue]];
        [self.contentView addSubview:_volumeLabel];
        [_volumeLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_volumLabel.mas_right).with.offset(0);
            make.bottom.equalTo(_volumLabel.mas_bottom).with.offset(0);
        }];
        
        [_periodLabel setText:@"元"];
        [_periodLabel setTextColor:[UIColor colorWithHexString:@"999999"]];
        [_periodLabel setFont:[UIFont systemFontOfSize:13]];
        [self.contentView addSubview:_periodLabel];
        [_periodLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_volumeLabel.mas_right).with.offset(0);
            make.bottom.equalTo(_volumeLabel.mas_bottom).with.offset(0);
        }];
        
        
        [_nextTimeLabel setText:@"购买价格："];
        [_nextTimeLabel setFont:[UIFont systemFontOfSize:13]];
        [_nextTimeLabel setTextColor:[UIColor colorWithHexString:@"999999"]];
        [self.contentView addSubview:_nextTimeLabel];
        [_nextTimeLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_volumLabel.mas_bottom).with.offset(3);
            make.left.equalTo(_volumLabel.mas_left).with.offset(0);
        }];
        
        
        //购买价格
        [_bottomRightLabel setFont:[UIFont systemFontOfSize:13]];
        _bottomRightLabel.text = [NSString stringWithFormat:@"%.2f",[[modelDic objectForKey:@"realprice"]floatValue]];
        [_bottomRightLabel setFont:[UIFont systemFontOfSize:13]];
        [self.contentView addSubview:_bottomRightLabel];
        [_bottomRightLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_nextTimeLabel.mas_right).with.offset(0);
            make.bottom.equalTo(_nextTimeLabel.mas_bottom).with.offset(0);
        }];
        
        [_yuLabel setText:@"元"];
        [_yuLabel setTextColor:[UIColor colorWithHexString:@"999999"]];
        [_yuLabel setFont:[UIFont systemFontOfSize:13]];
        [self.contentView addSubview:_yuLabel];
        [_yuLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_bottomRightLabel.mas_right).with.offset(0);
            make.bottom.equalTo(_bottomRightLabel.mas_bottom).with.offset(0);
        }];
        
        
        
        [_nextHuanLabel setText:@"下期还款："];
        [_nextHuanLabel setTextColor:[UIColor colorWithHexString:@"999999"]];
        [_nextHuanLabel setFont:[UIFont systemFontOfSize:13]];
        [self.contentView addSubview:_nextHuanLabel];
        [_nextHuanLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_nextTimeLabel.mas_bottom).with.offset(4);
            make.left.equalTo(_nextTimeLabel.mas_left).with.offset(0);
        }];
        
        
        NSString * timeStampString = [NSString stringWithFormat:@"%@",[modelDic objectForKey:@"dueDate"]];
        NSTimeInterval _interval=[timeStampString doubleValue] / 1000.0;
        NSDate *date = [NSDate dateWithTimeIntervalSince1970:_interval];
        NSDateFormatter *objDateformat = [[NSDateFormatter alloc] init];
        [objDateformat setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        NSLog(@"%@",  [objDateformat stringFromDate: date]);
        NSString * string = [objDateformat stringFromDate:date];
        NSString * str = [string substringWithRange:NSMakeRange(0, 10)];
        [_buyLabel setFont:[UIFont systemFontOfSize:13]];
        self.buyLabel.text = [NSString stringWithFormat:@"%@",str];
        [self.contentView addSubview:_buyLabel];
        [_buyLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_nextHuanLabel.mas_right).with.offset(0);
            make.bottom.equalTo(_nextHuanLabel.mas_bottom).with.offset(0);
        }];
        
        [_creditorInvestLabel setText:@"回款详情"];
        [_creditorInvestLabel setTextAlignment:NSTextAlignmentCenter];
        _creditorInvestLabel.layer.cornerRadius = 5;
        _creditorInvestLabel.clipsToBounds = YES;
        [_creditorInvestLabel setTextColor:[UIColor whiteColor]];
        _creditorInvestLabel.backgroundColor = Nav019BFF;
        [_creditorInvestLabel setFont:[UIFont systemFontOfSize:12]];
        [self.contentView addSubview:_creditorInvestLabel];
        [_creditorInvestLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(-10);
            make.bottom.mas_equalTo(-28);
            make.size.mas_equalTo(CGSizeMake(75, 26));
        }];
    }
}

#pragma mark - Action
- (IBAction)creditorInvestClike
{
    if([self.delegate respondsToSelector:@selector(creditorInvestAction:)])
    {
        [self.delegate creditorInvestAction:self];
    }
}

@end
