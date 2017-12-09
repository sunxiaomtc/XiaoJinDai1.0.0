//
//  HomeNewExclusiveCell.m
//  NiuduFinance
//
//  Created by 邢天阔 on 2017/9/28.
//  Copyright © 2017年 liuyong. All rights reserved.
//

#import "HomeNewExclusiveCell.h"

@interface HomeNewExclusiveCell ()

/**新人专享标
 */
@property (weak, nonatomic) IBOutlet UILabel *homeNewExclusiveLabel;


/**预期年化
 */
@property (weak, nonatomic) IBOutlet UILabel *anticipationLabel;
/**立即抢购
 */
@property (weak, nonatomic) IBOutlet UIButton *homeSnapUpButton;
@end

@implementation HomeNewExclusiveCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.homeSnapUpButton.layer.cornerRadius = 20.0f;
//    self.homeSnapUpButton.layer.borderWidth = 1;
//    self.homeSnapUpButton.layer.borderColor = [[UIColor colorWithRed:0.10 green:0.60 blue:0.99 alpha:1.00] CGColor];
    [self.homeSnapUpButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.homeSnapUpButton setBackgroundColor:UIcolors];
//    self.homeSnapUpButton.layer.borderColor = [UIColor colorWithHexString:@"0096ff"].CGColor;
//    self.homeSnapUpButton.layer.borderWidth = 1.0f;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
}

@end
