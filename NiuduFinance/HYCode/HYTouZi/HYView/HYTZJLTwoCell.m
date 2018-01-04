//
//  HYTZJLTwoCell.m
//  NiuduFinance
//
//  Created by Apple on 2018/1/4.
//  Copyright © 2018年 liuyong. All rights reserved.
//

#import "HYTZJLTwoCell.h"

@implementation HYTZJLTwoCell

+(instancetype)hyTZJLTwoCellForTableView:(UITableView *)tableView
{
    static NSString *identifier = @"hyTZJLTwoCell";
    
    HYTZJLTwoCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (!cell) {
        
        cell = [[HYTZJLTwoCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    if ([super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        WS
        self.contentView.backgroundColor = [UIColor whiteColor];
        UIImageView *backGroundImageView = [[UIImageView alloc] init];
        [self.contentView addSubview:backGroundImageView];
        [backGroundImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(weakSelf.contentView.mas_left).with.offset(10);
            make.right.mas_equalTo(weakSelf.contentView.mas_right).offset(-10);
            make.top.mas_equalTo(weakSelf.contentView.mas_top).offset(12);
            make.bottom.mas_equalTo(weakSelf.contentView.mas_bottom);
        }];
        backGroundImageView.layer.cornerRadius = 5;
        backGroundImageView.layer.masksToBounds = YES;
        backGroundImageView.backgroundColor = [UIColor colorWithHexString:@"#f1f1f1"];
        
        UILabel *numLabel = [[UILabel alloc] init];
        self.pmLabel = numLabel;
        [self.contentView addSubview:numLabel];
        [numLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(weakSelf.contentView.mas_left).with.offset(20);
            make.centerY.equalTo(backGroundImageView);
        }];
        numLabel.text = @"第3名";
        numLabel.font = [UIFont systemFontOfSize:15];
        numLabel.textColor = Black464646;
        
        UILabel * nameLab = [[UILabel alloc] init];
        //nameLab.text = [NSString stringWithFormat:@"%@", listArray[i][@"name"]];
        //        nameLab.textColor = Black464646;
        nameLab.textColor = Black464646;
        nameLab.font = [UIFont systemFontOfSize:12.f];
        nameLab.text = @"Test";
        self.nameLabel = nameLab;
        [self.contentView addSubview:nameLab];
        [nameLab mas_makeConstraints:^(MASConstraintMaker *make) {
            //            make.left.equalTo(imageV ? imageV.mas_right : weakSelf.listView.mas_left).with.offset(imageV ? 4 : 40);
            make.centerX.equalTo(weakSelf.contentView.mas_centerX).offset(-SCREEN_WIDTH/8*1-10);
            make.centerY.equalTo(backGroundImageView).offset(0);
        }];
        
        UILabel * amountLab = [[UILabel alloc] init];
        //amountLab.text = [NSString stringWithFormat:@"%@元", listArray[i][@"amount"]];
        //amountLab.textColor = i < 3 ? BlueColor : Black464646;
        amountLab.textColor = Black464646;
        amountLab.font = [UIFont systemFontOfSize:12.f];
        amountLab.text = @"test";
        self.priceLabel = amountLab;
        [self.contentView addSubview:amountLab];
        [amountLab mas_makeConstraints:^(MASConstraintMaker *make) {
            //            make.centerX.equalTo(weakSelf.listView.mas_centerX);
            make.centerX.equalTo(weakSelf.contentView.mas_centerX).offset(SCREEN_WIDTH/8*1-10+10);
            make.centerY.equalTo(nameLab.mas_centerY);
        }];
        
        
        UILabel * timeLab = [[UILabel alloc] init];
        //timeLab.text = [[NSDate date] getDateValue:[listArray[i][@"creationdate"] stringValue] andFormatter:@"yyyy-MM-dd"];
        //        timeLab.textColor = Black464646;
        timeLab.textColor = Black464646;
        timeLab.font = [UIFont systemFontOfSize:12.f];
        timeLab.text = @"test";
        self.dateLabel = timeLab;
        [self.contentView addSubview:timeLab];
        [timeLab mas_makeConstraints:^(MASConstraintMaker *make) {
            //            make.centerX.equalTo(weakSelf.listView.mas_right).with.offset(-65);
            make.centerX.equalTo(weakSelf.contentView.mas_centerX).offset(SCREEN_WIDTH/8*3-10+10);
            make.centerY.equalTo(nameLab.mas_centerY).offset(-7);
        }];
        
        UILabel * subtimeLab = [[UILabel alloc] init];
        //subtimeLab.text = [[NSDate date] getDateValue:[listArray[i][@"creationdate"] stringValue] andFormatter:@"HH:mm:ss"];
        //        subtimeLab.textColor = Black464646;
        subtimeLab.textColor = Black464646;
        subtimeLab.font = [UIFont systemFontOfSize:11.f];
        subtimeLab.text = @"test";
        self.timeLabel = subtimeLab;
        [self.contentView addSubview:subtimeLab];
        [subtimeLab mas_makeConstraints:^(MASConstraintMaker *make) {
            //            make.centerX.equalTo(weakSelf.listView.mas_right).with.offset(-65);
            make.centerX.equalTo(weakSelf.contentView.mas_centerX).offset(SCREEN_WIDTH/8*3-10+10);
            make.top.equalTo(timeLab.mas_bottom).offset(3);
        }];
    }
    return self;
}

-(void)setDic:(NSDictionary *)dic
{
    _dic = dic;
    self.nameLabel.text = [NSString stringWithFormat:@"%@",dic[@"name"]];
    self.priceLabel.text = [NSString stringWithFormat:@"%@",dic[@"amount"]];
    self.dateLabel.text = [[NSDate date] getDateValue:[dic[@"creationdate"] stringValue] andFormatter:@"yyyy-MM-dd"];
    self.timeLabel.text = [[NSDate date] getDateValue:[dic[@"creationdate"] stringValue] andFormatter:@"HH:mm:ss"];
}

@end
