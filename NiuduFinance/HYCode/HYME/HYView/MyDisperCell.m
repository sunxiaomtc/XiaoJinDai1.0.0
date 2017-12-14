//
//  MyDisperCell.m
//  NiuduFinance
//
//  Created by 123 on 17/7/25.
//  Copyright © 2017年 liuyong. All rights reserved.
//

#import "MyDisperCell.h"

@interface MyDisperCell()

//标题
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

//未收本息
@property (weak, nonatomic) IBOutlet UILabel *weiInterestLabel;
//年化收益
@property (weak, nonatomic) IBOutlet UILabel *shouyiLabel;
//已收本息
@property (weak, nonatomic) IBOutlet UILabel *yiBenXiLabel;
//预期赚取
@property (weak, nonatomic) IBOutlet UILabel *yuQiLabel;
//投资本金
@property (weak, nonatomic) IBOutlet UILabel *benJinLabel;
@property (nonatomic,strong)NSDictionary *modelDic;
@property (weak, nonatomic) IBOutlet UILabel *detailLabel;

@end


@implementation MyDisperCell

- (void)setMyDisperseInvestStat:(MyDisperseInvestStat)myDisperseInvestState
{
    switch (myDisperseInvestState)
    {
        case MyDisperseInvestStatBidding:
            break;
        case MyDisperseInvestStatRufunding:
            break;
        case MyDisperseInvestStatHistory:
            break;
    }
}


-(void)creditorState:(MyDisperseInvestStat)state model:(NSDictionary *)modeIDic
{
    _modelDic = modeIDic;
    [self setMyDisperseInvestStat:state];
    
    _detailLabel.layer.cornerRadius = 5;
    _detailLabel.clipsToBounds = YES;
    
    
    if ([[NSString stringWithFormat:@"%@",[modeIDic objectForKey:@"statusid"]] isEqualToString:@"1"])
    {
        _detailLabel.backgroundColor = [UIColor colorWithHexString:@"#808080"];
        [_detailLabel setText:@"投标中"];
    }else if ([[NSString stringWithFormat:@"%@",[modeIDic objectForKey:@"statusid"]] isEqualToString:@"2"])
    {
        _detailLabel.backgroundColor = [UIColor colorWithHexString:@"#808080"];
        [_detailLabel setText:@"审核中"];
    }else
    {
        _detailLabel.backgroundColor = UIcolors;
        [_detailLabel setText:@"回款详情"];
    }
    
    
    
    NSString *rateStr = [[modeIDic objectForKey:@"rate"] stringValue];
    
    switch (state)
    {
        case MyDisperseInvestStatBidding:
            _nameLabel.text = [modeIDic objectForKey:@"title"] ;
            if ([rateStr rangeOfString:@"."].location != NSNotFound) {
                _shouyiLabel.text = [NSString stringWithFormat:@"%.2f",[[modeIDic objectForKey:@"rate"]floatValue]];
            }else{
                _shouyiLabel.text = [NSString stringWithFormat:@"%.2f",[[modeIDic objectForKey:@"rate"] floatValue]];
                
            }
            _xieYiBtn.titleLabel.text=@"协议";
            _yuQiLabel.text = [NSString stringWithFormat:@"%.2f",[[modeIDic objectForKey:@"interest"] floatValue]];
            _yiBenXiLabel.text = [NSString stringWithFormat:@"%.2f",[[modeIDic objectForKey:@"repayamount"] floatValue]];
            _weiInterestLabel.text = [NSString stringWithFormat:@"%.2f",[[modeIDic objectForKey:@"receivableamount"]floatValue]];
            _benJinLabel.text = [NSString stringWithFormat:@"%.2f",[[modeIDic objectForKey:@"principal"] floatValue]];
            break;
        case MyDisperseInvestStatRufunding:
            _nameLabel.text = [modeIDic objectForKey:@"title"] ;
            if ([rateStr rangeOfString:@"."].location != NSNotFound) {
                _shouyiLabel.text = [NSString stringWithFormat:@"%.2f",[[modeIDic objectForKey:@"rate"]floatValue]];
            }else{
                _shouyiLabel.text = [NSString stringWithFormat:@"%.2f",[[modeIDic objectForKey:@"rate"]floatValue]];
            }
            _xieYiBtn.titleLabel.text=@"协议";
            _yuQiLabel.text = [NSString stringWithFormat:@"%.2f",[[modeIDic objectForKey:@"interest"] floatValue]];
            _yiBenXiLabel.text = [NSString stringWithFormat:@"%.2f",[[modeIDic objectForKey:@"repayamount"]floatValue ]];
            _weiInterestLabel.text = [NSString stringWithFormat:@"%.2f",[[modeIDic objectForKey:@"receivableamount"]floatValue]];
            _benJinLabel.text = [NSString stringWithFormat:@"%.2f",[[modeIDic objectForKey:@"principal"]floatValue]];
            break;
        case MyDisperseInvestStatHistory:
            _nameLabel.text = [modeIDic objectForKey:@"title"] ;
            if ([rateStr rangeOfString:@"."].location != NSNotFound) {
                _shouyiLabel.text = [NSString stringWithFormat:@"%.2f",[[modeIDic objectForKey:@"rate"]floatValue]];
            }else{
                _shouyiLabel.text = [NSString stringWithFormat:@"%.2f",[[modeIDic objectForKey:@"rate"] floatValue]];
            }
            _xieYiBtn.titleLabel.text=@"协议";
            _yuQiLabel.text = [NSString stringWithFormat:@"%.2f",[[modeIDic objectForKey:@"interest"] floatValue]];
            _yiBenXiLabel.text = [NSString stringWithFormat:@"%.2f",[[modeIDic objectForKey:@"repayamount"] floatValue]];
            _weiInterestLabel.text = [NSString stringWithFormat:@"%.2f",[[modeIDic objectForKey:@"receivableamount"]floatValue]];
            _benJinLabel.text = [NSString stringWithFormat:@"%.2f",[[modeIDic objectForKey:@"principal"] floatValue]];
            break;
    }
    
    
    
}

@end
