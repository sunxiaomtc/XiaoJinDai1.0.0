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
    
    if(iPhone5)
    {
        self.bfbLeftLayout.constant = 57;
    }
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

-(void)setBfbStr:(NSString *)bfbStr
{
    _bfbStr = bfbStr;
//    NSString *str = [NSString stringWithFormat:@"%@%%",bfbStr];
//    NSMutableAttributedString *attrString = [[NSMutableAttributedString alloc] initWithString:str];
//    [attrString addAttribute:NSFontAttributeName
//                    value:[UIFont systemFontOfSize:40.0f]
//                    range:NSMakeRange(0, bfbStr.length)];
//    [attrString addAttribute:NSFontAttributeName
//                       value:[UIFont systemFontOfSize:20.0f]
//                       range:NSMakeRange(str.length - 1, 1)];
//    [attrString addAttribute:NSForegroundColorAttributeName
//                    value:qianhui(241, 62, 52)
//                    range:NSMakeRange(0, attrString.length)];
//    self.bfbLabel.attributedText = attrString;
    if(![bfbStr isKindOfClass:[NSNull class]] && ![bfbStr isEqualToString:@"(null)"] && bfbStr.length > 0)
    {
        NSLog(@"%@",bfbStr);
        self.bfbLabel.text = [NSString stringWithFormat:@"%@",bfbStr];
    }
    
}

-(void)setAddBFBStr:(NSString *)addBFBStr
{
    _addBFBStr = addBFBStr;
    if(![addBFBStr isKindOfClass:[NSNull class]] && ![addBFBStr isEqualToString:@"(null)"] && addBFBStr.length > 0)
    {
        float add = [addBFBStr floatValue];
        if(add > 0)
        {
            self.addBFBLabel.text = [NSString stringWithFormat:@"(+%@%%)",addBFBStr];
        }else
        {
            self.addBFBLabel.text = @"";
        }
        
    }
    
}

-(void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    
}

-(void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated
{

}

@end
