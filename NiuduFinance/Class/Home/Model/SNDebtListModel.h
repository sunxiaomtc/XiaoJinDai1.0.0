//
//  SNDebtListModel.h
//  NiuduFinance
//
//  Created by BuJia on 17/2/17.
//  Copyright © 2017年 liuyong. All rights reserved.
//

#import "VZHTTPListModel.h"
#import "SNDebtListItem.h"

@interface SNDebtListModel : VZHTTPListModel

@property (nonatomic, assign) BOOL isHome;
@property (nonatomic, assign) NSInteger start;

@end
