//
//  BenefitsCell.m
//  NiuduFinance
//
//  Created by andrewliu on 16/10/25.
//  Copyright © 2016年 liuyong. All rights reserved.
//

#import "BenefitsCell.h"

@interface BenefitsCell()
@property (weak, nonatomic) IBOutlet UILabel *moneyLabel;
//全程通用 //起投期限
@property (weak, nonatomic) IBOutlet UILabel *typeLabel;
//有效期
@property (weak, nonatomic) IBOutlet UILabel *dataLabel;
//来源
@property (weak, nonatomic) IBOutlet UILabel *sourceLabel;
//起投金额
@property (weak, nonatomic) IBOutlet UILabel *qiTouLabel;
//背景图片
@property (weak, nonatomic) IBOutlet UIImageView *bgImageView;
@property (nonatomic,strong)NSDictionary *modelDic;

@property (weak, nonatomic) IBOutlet UILabel *titile;

@property (weak, nonatomic) IBOutlet UILabel *yuanLabel;

@end

@implementation BenefitsCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)creditorState:(HongbaoState)state model:(NSDictionary *)modelDic{
    _modelDic = modelDic;
    
    NSString * ss = [NSString stringWithFormat:@"%@",[modelDic objectForKey:@"type"]];
    int type = [ss intValue];
    if (type == 1) {
        [_titile setText:@"现金券"];
        [_yuanLabel setText:@"元"];
        //起投期限
        self.typeLabel.text = [NSString stringWithFormat:@"起投期限:%@月",[modelDic objectForKey:@"loanperiod"]];
    }else{
        [_titile setText:@"加息券"];
        [_yuanLabel setText:@"%"];
        self.typeLabel.text = [NSString stringWithFormat:@"起投期限:%@天",[modelDic objectForKey:@"loanperiod"]];
    }
    if (state == HongbaoStateAbandon) {
        UIImage *image = [UIImage imageNamed:@"002.png"];
        self.bgImageView.image = image;
        [_yuanLabel setTextColor:[UIColor colorWithHexString:@"#666666"]];
        [_titile setTextColor:[UIColor colorWithHexString:@"#666666"]];
        [_moneyLabel setTextColor:[UIColor colorWithHexString:@"#666666"]];
        
    }else{
        self.bgImageView.image = [UIImage imageNamed:@"001.png"];
        [_yuanLabel setTextColor:[UIColor colorWithHexString:@"#0097FA"]];
        [_titile setTextColor:[UIColor colorWithHexString:@"#0097FA"]];
        [_moneyLabel setTextColor:[UIColor colorWithHexString:@"#0097FA"]];
    }
    
    //现金红包券
    self.moneyLabel.text = [NSString stringWithFormat:@"%@",[modelDic objectForKey:@"bounsvalue"]];
    if (SCREEN_HEIGHT == 480 || SCREEN_HEIGHT == 568) {
        self.moneyLabel.font = [UIFont systemFontOfSize:35];
    }
    
    
    NSString * timeStampString = [NSString stringWithFormat:@"%@",[modelDic objectForKey:@"validate"]];
    NSTimeInterval _interval=[timeStampString doubleValue] / 1000.0;
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:_interval];
    NSDateFormatter *objDateformat = [[NSDateFormatter alloc] init];
    [objDateformat setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSLog(@"%@",  [objDateformat stringFromDate: date]);
    NSString * string = [objDateformat stringFromDate:date];
    NSString * str = [string substringWithRange:NSMakeRange(0, 10)];
    //有效期年月日
    self.dataLabel.text = [NSString stringWithFormat:@"有  效  期:%@",str];
    //起投来源
    self.sourceLabel.text = [NSString stringWithFormat:@"来       源:%@",[modelDic objectForKey:@"sourcename"]];
//    //起投期限
//    self.typeLabel.text = [NSString stringWithFormat:@"起投期限:%@月",[modelDic objectForKey:@"loanperiod"]];
    //起投金额
    self.qiTouLabel.text = [NSString stringWithFormat:@"起投金额:%@元",[modelDic objectForKey:@"bidamount"]];
    
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
