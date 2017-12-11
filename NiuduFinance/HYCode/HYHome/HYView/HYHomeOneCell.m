//
//  HYHomeOneCell.m
//  NiuduFinance
//
//  Created by Apple on 2017/12/9.
//  Copyright © 2017年 liuyong. All rights reserved.
//

#import "HYHomeOneCell.h"

@implementation HYHomeOneCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.xszxLabel.text = @"新\n手\n专\n享\n";
    
//    self.buyBtn.layer.cornerRadius = 13.0f;
//    self.buyBtn.layer.masksToBounds = YES;
    
    self.bgView.layer.cornerRadius = 5.0f;
    self.bgView.layer.masksToBounds = YES;
}

//- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
//    [super setSelected:selected animated:animated];
//
//    // Configure the view for the selected state
//}
- (IBAction)buyClick:(UIButton *)sender {
    if(_buyBlock)
    {
        self.buyBlock();
    }
}

-(void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    
}

-(void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated
{

}

@end
