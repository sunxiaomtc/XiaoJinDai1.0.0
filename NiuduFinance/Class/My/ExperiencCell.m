//
//  ExperiencCell.m
//  NiuduFinance
//
//  Created by 123 on 17/3/29.
//  Copyright © 2017年 liuyong. All rights reserved.
//

#import "ExperiencCell.h"
#import "ProjectProgressView.h"

@interface ExperiencCell()
@property (nonatomic, strong)UILabel * projectTitleNewLab;
@property (nonatomic, strong)UILabel * tulabel;
@property (nonatomic, strong)UIImageView * imgeView;
@property (nonatomic, strong)UILabel * castLabel;
@property (nonatomic, strong)UIView * lineView;
//预期年化
@property (nonatomic, strong)UILabel * percent;
@property (nonatomic, strong)UILabel * annualNum;
@property (nonatomic, strong)UILabel * annual;
//投资期限
@property (nonatomic, strong)UILabel * timeLabel;
@property (nonatomic, strong)UILabel * timeLimitNum;
@property (nonatomic, strong)UILabel * timeLimit;

//立即投资
@property (nonatomic, strong)UILabel * touLabl;
//剩余可投
@property (nonatomic, strong)UILabel * remain;
//进度条
@property (nonatomic, strong)UIView * progress;

//进度
@property (nonatomic, strong)UILabel * progressLabel;


@end
@implementation ExperiencCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code

}

- (void)setuptitle:(NSString *)title tulabel:(NSString *)tulabel imgeView:(BOOL )imgeView castLabel:(NSString *)castLabel lineView:(BOOL)lineView annual:(NSString *)annual annualNum:(NSString *)annualNum percent:(NSString *)percent timeLimit:(NSString *)timeLimit timeLimitNum:(NSString *)timeLimitNum timeLabel:(NSString *)timeLabel touLabl:(NSString *)touLabl remain:(NSString *)remain progressLabel:(NSString *)progressLabel;
{

    if (!IsStrEmpty(title)) {
        _projectTitleNewLab.text = title;
    }
    
    if (!(_projectTitleNewLab)) {
        _projectTitleNewLab = [UILabel new];
    }
    
    if (!IsStrEmpty(tulabel)) {
        
        _tulabel.text = tulabel;
    }
    if (!(_tulabel)) {
        _tulabel = [UILabel new];
    }
    
    if (!IsStrEmpty(castLabel)) {
        
        _castLabel.text = castLabel;
    }
    if (!(_castLabel)) {
        _castLabel = [UILabel new];
    }
    if (!IsStrEmpty(annual)) {
        
        _annual.text = annual;
    }
    if (!(_annual)) {
        _annual = [UILabel new];
    }
    if (!IsStrEmpty(annualNum)) {
        
        _annualNum.text = annualNum;
    }
    if (!(_annualNum)) {
        _annualNum = [UILabel new];
    }
    if (!IsStrEmpty(percent)) {
        
        _percent.text = percent;
    }
    if (!(_percent)) {
        _percent = [UILabel new];
    }
    if (!IsStrEmpty(timeLimit)) {
        
        _timeLimit.text = timeLimit;
    }
    if (!(_timeLimit)) {
        _timeLimit = [UILabel new];
    }
    if (!IsStrEmpty(timeLimitNum)) {
        
        _timeLimitNum.text = timeLimitNum;
    }
    if (!(_timeLimitNum)) {
        _timeLimitNum = [UILabel new];
    }
    if (!IsStrEmpty(timeLabel)) {
        
        _timeLabel.text = timeLabel;
    }
    if (!(_timeLabel)) {
        _timeLabel = [UILabel new];
    }
    if (!IsStrEmpty(touLabl)) {
        
        _touLabl.text = touLabl;
    }
    if (!(_touLabl)) {
        _touLabl = [UILabel new];
    }
    if (!IsStrEmpty(remain)) {
        
        _remain.text = remain;
    }
    if (!(_remain)) {
        _remain = [UILabel new];
    }
    if (!IsStrEmpty(progressLabel)) {
        
        _progressLabel.text = progressLabel;
    }
    if (!(_progressLabel)) {
        _progressLabel = [UILabel new];
    }
    
    [_projectTitleNewLab setFont:[UIFont systemFontOfSize:15]];
    [self.contentView addSubview:_projectTitleNewLab];
    [_projectTitleNewLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(10);
        make.left.mas_equalTo(15);
        make.height.mas_equalTo(15);
    }];
    
    [_tulabel setFont:[UIFont systemFontOfSize:11]];
    [_tulabel setTextColor:[UIColor orangeColor]];
    _tulabel.layer.borderColor = [[UIColor colorWithHexString:@"FF8C31"]CGColor];
    _tulabel.layer.borderWidth = 0.5f;
    _tulabel.layer.cornerRadius = 3.0f;
    _tulabel.layer.masksToBounds = YES;
    [self.contentView addSubview:_tulabel];
    [_tulabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_projectTitleNewLab.mas_right).with.offset(5);
        make.bottom.equalTo(_projectTitleNewLab.mas_bottom);
        make.height.mas_equalTo(16);
    }];
    
    if (!(_imgeView)) {
        _imgeView = [UIImageView new];
    }
    
    UIImage * image = [UIImage imageNamed:@"体验.png"];
    _imgeView.image = image;
    [self.contentView addSubview:_imgeView];
    [_imgeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.size.mas_equalTo(CGSizeMake(30, 32));
    }];
    
    [_castLabel setFont:[UIFont systemFontOfSize:13]];
    [_castLabel setTextColor:[UIColor colorWithHexString:@"#A9A9A9"]];
    [self.contentView addSubview:_castLabel];
    [_castLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(13);
        make.right.equalTo(_imgeView.mas_left);
        make.height.mas_equalTo(13);
    }];
    
    _lineView = [UIView new];
    [_lineView setBackgroundColor:[UIColor colorWithHexString:@"#CDCDCD"]];
    [self.contentView addSubview:_lineView];
    [_lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_projectTitleNewLab.mas_bottom).with.offset(9);
        make.left.mas_equalTo(15);
        make.right.mas_equalTo(0);
        make.height.mas_equalTo(1);
    }];
    
    [_annual setFont:[UIFont systemFontOfSize:13]];
    [_annual setTextColor:[UIColor colorWithHexString:@"#A9A9A9"]];
    [self.contentView addSubview:_annual];
    [_annual mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(77);
        make.centerX.equalTo(self.contentView.mas_left).with.offset(SCREEN_WIDTH/6-6);
        make.height.mas_equalTo(13);
    }];
    
    [_annualNum setTextColor:[UIColor redColor]];
    [_annualNum setFont:[UIFont systemFontOfSize:31]];
    [self.contentView addSubview:_annualNum];
    [_annualNum mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(_annual.mas_top).with.offset(-9);
        make.right.equalTo(_annual.mas_centerX).with.offset(2);
        make.height.mas_equalTo(23);
    }];
    
    [_percent setTextColor:[UIColor redColor]];
    [_percent setFont:[UIFont systemFontOfSize:15]];
    [self.contentView addSubview:_percent];
    [_percent mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_annualNum.mas_right).with.offset(0);
        make.bottom.equalTo(_annualNum.mas_bottom).with.offset(0);
        make.height.mas_equalTo(11);
    }];
    
    [_timeLimit setFont:[UIFont systemFontOfSize:13]];
    [_timeLimit setTextColor:[UIColor colorWithHexString:@"#A9A9A9"]];
    [self.contentView addSubview:_timeLimit];
    [_timeLimit mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(77);
        make.height.mas_equalTo(13);
        make.centerX.equalTo(self.contentView.mas_left).with.offset(SCREEN_WIDTH/8*4-8);
    }];
    
    [_timeLimitNum setTextColor:[UIColor redColor]];
    [_timeLimitNum setFont:[UIFont systemFontOfSize:31]];
    [self.contentView addSubview:_timeLimitNum];
    [_timeLimitNum mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(_timeLimit.mas_top).with.offset(-9);
        make.right.equalTo(_timeLimit.mas_centerX).with.offset(2);
        make.height.mas_equalTo(23);
    }];
    
    [_timeLabel setTextColor:[UIColor redColor]];
    [_timeLabel setFont:[UIFont systemFontOfSize:15]];
    [self.contentView addSubview:_timeLabel];
    [_timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_timeLimitNum.mas_right).with.offset(0);
        make.bottom.equalTo(_timeLimitNum.mas_bottom).with.offset(0);
        make.height.mas_equalTo(11);
    }];
    
    
    _touLabl.layer.cornerRadius = 5.0f;
    _touLabl.clipsToBounds = YES;
    _touLabl.textAlignment = NSTextAlignmentCenter;
//    [_touLabl setText:@""];
    [_touLabl setTextColor:[UIColor whiteColor]];
    [_touLabl setBackgroundColor:[UIColor colorWithHexString:@"#019BFF"]];
    [_touLabl setFont:[UIFont systemFontOfSize:15]];
    [self.contentView addSubview:_touLabl];
    [_touLabl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.lineView.mas_bottom).with.offset(21);
        make.centerX.equalTo(self.contentView.mas_left).with.offset(SCREEN_WIDTH/6*5);
        make.height.mas_equalTo(28);
        make.width.mas_equalTo(100);
    }];
    
    
//    _progress = [UIView new];
//    _progress.backgroundColor = BlackCCCCCC;
//    [self.contentView addSubview:_progress];
//    [_progress mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(_annual.mas_bottom).with.offset(9);
//        make.left.mas_equalTo(15);
//        make.right.mas_equalTo(0);
//        make.height.mas_equalTo(3);
//    }];
    
    [_remain setTextColor:[UIColor colorWithHexString:@"#A9A9A9"]];
    [_remain setFont:[UIFont systemFontOfSize:12]];
    [self.contentView addSubview:_remain];
    [_remain mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.bottom.mas_equalTo(-6);
        make.height.mas_equalTo(12);
    }];
    
    [_progressLabel setTextColor:[UIColor colorWithHexString:@"#A9A9A9"]];
    [_progressLabel setFont:[UIFont systemFontOfSize:12]];
    [self.contentView addSubview:_progressLabel];
    [_progressLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-15);
        make.bottom.mas_equalTo(-6);
        make.height.mas_equalTo(12);
    }];
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
