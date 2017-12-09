//
//  DebtTransferTableViewCell.m
//  NiuduFinance
//
//  Created by liuyong on 16/2/26.
//  Copyright © 2016年 liuyong. All rights reserved.
//

#import "DebtTransferTableViewCell.h"
#import "NetWorkingUtil.h"
#import "DebtModel.h"
#import "User.h"
#import "SNDebtListItem.h"

@implementation DebtTransferTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
//    _debtStateBtn.layer.borderWidth = 1.0;
    _debtStateBtn.layer.cornerRadius = 2.0f;
    _debtStateBtn.layer.masksToBounds = YES;
    
    _rateTitleLab.textColor = HEX_COLOR(@"#999999");
    _owingnumberLab.textColor = HEX_COLOR(@"#999999");
    
    _priceforsaleLab.textColor = HEX_COLOR(@"#999999");
    _receivableamountLab.textColor = HEX_COLOR(@"#999999");
}

- (void)setDebtModel:(DebtModel *)debtModel
{
    _debtModel = debtModel;
    
    if ([debtModel isKindOfClass:[SNDebtListItem class]]) {
        SNDebtListItem * debtItem = (SNDebtListItem *)debtModel;
        
        if ([debtItem.selleruserid integerValue] == [User shareUser].userId) {
            [_debtStateBtn setTitle:@"我的债权" forState:UIControlStateNormal];
            _debtStateBtn.userInteractionEnabled = YES;
            _debtStateBtn.backgroundColor = BlueColor;
        } else {
            if ([debtItem.statusid integerValue] == 1) {
                [_debtStateBtn setTitle:@"马上投资" forState:UIControlStateNormal];
                _debtStateBtn.userInteractionEnabled = YES;
                _debtStateBtn.backgroundColor = BlueColor;
            } else {
                [_debtStateBtn setTitle:@"交易结束" forState:UIControlStateNormal];
                _debtStateBtn.userInteractionEnabled = NO;
                _debtStateBtn.backgroundColor = BlackCCCCCC;
            }
        }
        
        _debtTitleLab.text = debtItem.title;
        _debtRateLab.text = [NSString stringWithFormat:@"%.2f", debtItem.srrsy.floatValue];
        
        NSMutableAttributedString * owingnumberStr = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"剩余期数: %@期", debtItem.owingnumber]];
        [owingnumberStr addAttribute:NSForegroundColorAttributeName value:Black464646 range:NSMakeRange(6, debtItem.owingnumber.stringValue.length)];
        _owingnumberLab.attributedText = owingnumberStr;
        
        
        NSMutableAttributedString * priceforsaleStr = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"购买价格: %.2f元", [debtItem.priceforsale floatValue]]];
        [priceforsaleStr addAttribute:NSForegroundColorAttributeName value:Black464646 range:NSMakeRange(6, debtItem.priceforsale.stringValue.length)];
        _priceforsaleLab.attributedText = priceforsaleStr;
        
        
        NSMutableAttributedString * receivableamountStr = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"未收本息: %.2f元", [debtItem.receivableamount floatValue]]];
        [receivableamountStr addAttribute:NSForegroundColorAttributeName value:Black464646 range:NSMakeRange(6, debtItem.receivableamount.stringValue.length)];
        _receivableamountLab.attributedText = receivableamountStr;
        
        return;
    }
    
    _debtTitleLab.text = _debtModel.title;
    _debtRateLab.text = [NSString stringWithFormat:@"%@",_debtModel.rate];
    
//    if (_debtModel.priceForSaleTypeId == 1) {
//        _debtAmountLab.text = [NSString stringWithFormat:@"%@",_debtModel.priceForSale];
//        _debtAmountTypeLab.text = @"元";
//    }else{
//        _debtAmountLab.text = [NSString stringWithFormat:@"%@",_debtModel.priceForSale];
//    }
//    
//    _surplusNum.text = [NSString stringWithFormat:@"剩%d份",_debtModel.surplusNum];
    
    if (_debtModel.sellerUserId == [User shareUser].userId) {
        [_debtStateBtn setTitle:@"我的债权" forState:UIControlStateNormal];
        _debtStateBtn.userInteractionEnabled = NO;
        _debtStateBtn.backgroundColor = BlackCCCCCC;
    }else{
        
        if (_debtModel.statusId == 1) {
            [_debtStateBtn setTitle:@"马上购买" forState:UIControlStateNormal];
            _debtStateBtn.userInteractionEnabled = YES;
            _debtStateBtn.backgroundColor = NaviColor;
        }else{
            [_debtStateBtn setTitle:@"交易结束" forState:UIControlStateNormal];
            _debtStateBtn.userInteractionEnabled = NO;
            _debtStateBtn.backgroundColor = BlackCCCCCC;
        }
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
