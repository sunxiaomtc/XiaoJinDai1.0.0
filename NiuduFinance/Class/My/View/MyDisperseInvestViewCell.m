//
//  MyDisperseInvestViewCell.m
//  NiuduFinance
//
//  Created by 123 on 17/1/20.
//  Copyright © 2017年 liuyong. All rights reserved.
//

#import "MyDisperseInvestViewCell.h"

@interface MyDisperseInvestViewCell()
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
//回款详情
@property (nonatomic,strong)NSDictionary *modelDic;
@property (weak, nonatomic) IBOutlet UILabel *detailLabel;
@property (weak, nonatomic) IBOutlet UILabel *meiInterest;
@property (weak, nonatomic) IBOutlet UILabel *received;

@end


@implementation MyDisperseInvestViewCell

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


//-(void)creditorState:(MyDisperseInvestStat)state model:(NSDictionary *)modeIDic
//{
//    _modelDic = modeIDic;
//    [self setMyDisperseInvestStat:state];
//    
//    _detailLabel.layer.cornerRadius = 5;
//    _detailLabel.clipsToBounds = YES;
//    
//    
//    if ([[NSString stringWithFormat:@"%@",[modeIDic objectForKey:@"statusid"]] isEqualToString:@"1"])
//    {
//        _detailLabel.backgroundColor = [UIColor colorWithHexString:@"#808080"];
//        [_detailLabel setText:@"投标中"];
//    }else if ([[NSString stringWithFormat:@"%@",[modeIDic objectForKey:@"statusid"]] isEqualToString:@"2"])
//    {
//        _detailLabel.backgroundColor = [UIColor colorWithHexString:@"#808080"];
//        [_detailLabel setText:@"审核中"];
//    }else
//    {
//        _detailLabel.backgroundColor = [UIColor colorWithHexString:@"#019BFF"];
//        [_detailLabel setText:@"回款详情"];
//    }
//    
//    
//    
//    NSString *rateStr = [[modeIDic objectForKey:@"rate"] stringValue];
//    
//    switch (state)
//    {
//        case MyDisperseInvestStatBidding:
//            _nameLabel.text = [modeIDic objectForKey:@"title"] ;
//            if ([rateStr rangeOfString:@"."].location != NSNotFound) {
//                _shouyiLabel.text = [NSString stringWithFormat:@"%.2f",[[modeIDic objectForKey:@"rate"]floatValue]];
//            }else{
//                _shouyiLabel.text = [NSString stringWithFormat:@"%.2f",[[modeIDic objectForKey:@"rate"] floatValue]];
//                
//            }
////            _xieYiBtn.titleLabel.text=@"协议";
//            _yuQiLabel.text = [NSString stringWithFormat:@"%.2f",[[modeIDic objectForKey:@"interest"] floatValue]];
//            _yiBenXiLabel.text = [NSString stringWithFormat:@"%.2f",[[modeIDic objectForKey:@"repayamount"] floatValue]];
//            _weiInterestLabel.text = [NSString stringWithFormat:@"%.2f",[[modeIDic objectForKey:@"receivableamount"]floatValue]];
//            _benJinLabel.text = [NSString stringWithFormat:@"%.2f",[[modeIDic objectForKey:@"principal"] floatValue]];
//            break;
//        case MyDisperseInvestStatRufunding:
//            _nameLabel.text = [modeIDic objectForKey:@"title"] ;
//            if ([rateStr rangeOfString:@"."].location != NSNotFound) {
//                _shouyiLabel.text = [NSString stringWithFormat:@"%.2f",[[modeIDic objectForKey:@"rate"]floatValue]];
//            }else{
//                _shouyiLabel.text = [NSString stringWithFormat:@"%.2f",[[modeIDic objectForKey:@"rate"]floatValue]];
//            }
////            _xieYiBtn.titleLabel.text=@"协议";
//            _yuQiLabel.text = [NSString stringWithFormat:@"%.2f",[[modeIDic objectForKey:@"interest"] floatValue]];
//            _yiBenXiLabel.text = [NSString stringWithFormat:@"%.2f",[[modeIDic objectForKey:@"repayamount"]floatValue ]];
//            _weiInterestLabel.text = [NSString stringWithFormat:@"%.2f",[[modeIDic objectForKey:@"receivableamount"]floatValue]];
//            _benJinLabel.text = [NSString stringWithFormat:@"%.2f",[[modeIDic objectForKey:@"principal"]floatValue]];
//            break;
//        case MyDisperseInvestStatHistory:
//            _nameLabel.text = [modeIDic objectForKey:@"title"] ;
//            if ([rateStr rangeOfString:@"."].location != NSNotFound) {
//                _shouyiLabel.text = [NSString stringWithFormat:@"%.2f",[[modeIDic objectForKey:@"rate"]floatValue]];
//            }else{
//                _shouyiLabel.text = [NSString stringWithFormat:@"%.2f",[[modeIDic objectForKey:@"rate"] floatValue]];
//            }
////            _xieYiBtn.titleLabel.text=@"协议";
//            _yuQiLabel.text = [NSString stringWithFormat:@"%.2f",[[modeIDic objectForKey:@"interest"] floatValue]];
//            _yiBenXiLabel.text = [NSString stringWithFormat:@"%.2f",[[modeIDic objectForKey:@"repayamount"] floatValue]];
//            _weiInterestLabel.text = [NSString stringWithFormat:@"%.2f",[[modeIDic objectForKey:@"receivableamount"]floatValue]];
//            _benJinLabel.text = [NSString stringWithFormat:@"%.2f",[[modeIDic objectForKey:@"principal"] floatValue]];
//            break;
//    }
//    
//
//    
//}

-(void)creditorStateModel:(NSDictionary *)modeIDic
{
    _modelDic = modeIDic;
    
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
        _detailLabel.backgroundColor = [UIColor colorWithHexString:@"#019BFF"];
        [_detailLabel setText:@"回款详情"];
    }
    
    
    
    NSString *rateStr = [[modeIDic objectForKey:@"rate"] stringValue];
    
    NSInteger C  = [[[NSUserDefaults standardUserDefaults]objectForKey:@"selectedCo"] integerValue];
    
    NSLog(@"%ld",C);
    
    if (C == 1) {
        _xieYiBtn.hidden = YES;
        [_meiInterest setText:@"未收利息"];
        [_received setText:@"已收利息："];
    }else{
        _xieYiBtn.hidden = NO;
        [_xieYiBtn setTitle:@"协议" forState:UIControlStateNormal];
        [_meiInterest setText:@"未收本息"];
        [_received setText:@"已收本息："];
    }

     _nameLabel.text = [modeIDic objectForKey:@"title"] ;
      if ([rateStr rangeOfString:@"."].location != NSNotFound){
           _shouyiLabel.text = [NSString stringWithFormat:@"%.2f",[[modeIDic objectForKey:@"rate"]floatValue]];
       }else{
            _shouyiLabel.text = [NSString stringWithFormat:@"%.2f",[[modeIDic objectForKey:@"rate"] floatValue]];
      }
   
    _yuQiLabel.text = [NSString stringWithFormat:@"%.2f",[[modeIDic objectForKey:@"interest"] floatValue]];
    _yiBenXiLabel.text = [NSString stringWithFormat:@"%.2f",[[modeIDic objectForKey:@"repayamount"] floatValue]];
    _weiInterestLabel.text = [NSString stringWithFormat:@"%.2f",[[modeIDic objectForKey:@"receivableamount"]floatValue]];
    _benJinLabel.text = [NSString stringWithFormat:@"%.2f",[[modeIDic objectForKey:@"principal"] floatValue]];
    
}
@end
