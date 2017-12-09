//
//  homeBullSharingCell.m
//  NiuduFinance
//
//  Created by 邢天阔 on 2017/9/28.
//  Copyright © 2017年 liuyong. All rights reserved.
//

#import "homeBullSharingCell.h"

@interface homeBullSharingCell ()


/**预期年化
 */
@property (weak, nonatomic) IBOutlet UILabel *annualLabel;
/**投资期限
 */
@property (weak, nonatomic) IBOutlet UILabel *InvestmentHorizonLabel;
/**金额
 */
@property (weak, nonatomic) IBOutlet UILabel *moneyLabel;
/**立即投资
 */
@property (weak, nonatomic) IBOutlet UIButton *investButton;

@end

@implementation homeBullSharingCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.investButton.layer.cornerRadius = 20.0f;
    
    [self.investButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.investButton setBackgroundColor:UIcolors];
}

- (void)setExperienceDic:(NSDictionary *)experienceDic {
    _experienceDic = experienceDic;
    self.annualLabel.text = [[NSString stringWithFormat:@"%@",experienceDic[@"rate"]] stringByAppendingString:@"%"];
    self.moneyLabel.text = [NSString stringWithFormat:@"%@元",experienceDic[@"minbidamount"]];
    self.InvestmentHorizonLabel.text = [NSString stringWithFormat:@"%@天",experienceDic[@"loanperiod"]];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
