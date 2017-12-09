//
//  TransferViewController.h
//  NiuduFinance
//
//  Created by 123 on 17/2/20.
//  Copyright © 2017年 liuyong. All rights reserved.
//

#import "BaseViewController.h"

@interface TransferViewController : BaseViewController
@property (nonatomic,strong)NSString * totalPrice;
@property (nonatomic,assign)int projectId;
@property (nonatomic,assign)double price;
@property (nonatomic, strong) NSDictionary * projectDic;
@end
