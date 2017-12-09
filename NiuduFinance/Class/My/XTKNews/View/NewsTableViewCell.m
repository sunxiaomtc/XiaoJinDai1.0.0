//
//  NewsTableViewCell.m
//  NiuduFinance
//
//  Created by 邢天阔 on 2017/9/28.
//  Copyright © 2017年 liuyong. All rights reserved.
//

#import "NewsTableViewCell.h"

@interface NewsTableViewCell ()

/**消息名字
 */
@property (weak, nonatomic) IBOutlet UILabel *newsNameLabel;
/**消息时间
 */
@property (weak, nonatomic) IBOutlet UILabel *newsTimeLabel;
/**消息内容
 */
@property (weak, nonatomic) IBOutlet UILabel *newsContentLabel;
/**消息类型
 */
@property (weak, nonatomic) IBOutlet UILabel *newsTypeLabel;
@end

@implementation NewsTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(void)setModel:(NewsModel *)model
{
    _newsNameLabel.text = model.title;
    
    //时间戳转成时间
    NSString *dataStr = [NSString stringWithFormat:@"%@",model.creationdate];
    NSString *currentStr = [dataStr substringWithRange:NSMakeRange(0,10)];
    
    NSDateFormatter *stampFormatter = [[NSDateFormatter alloc] init];
    [stampFormatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
    NSDate *stampDate = [NSDate dateWithTimeIntervalSince1970:[currentStr integerValue]];
    _newsTimeLabel.text = [NSString stringWithFormat:@"%@",[stampFormatter stringFromDate:stampDate]];
    
    if ([model.typeId isEqualToString:@"1"]) {
        _newsTypeLabel.text = @"系统消息";
    }
    if ([model.typeId isEqualToString:@"2"]) {
        _newsTypeLabel.text = @"用户消息";
    }
    if ([model.typeId isEqualToString:@"3"]) {
        _newsTypeLabel.text = @"用户消息";
    }
    if ([model.typeId isEqualToString:@"4"]) {
        _newsTypeLabel.text = @"系统信息";
    }
    _newsContentLabel.text = model.content;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
}

@end
