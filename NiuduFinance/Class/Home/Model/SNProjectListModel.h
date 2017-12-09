//
//  SNProjectListModel.h
//  NiuduFinance
//
//  Created by BuJia on 17/2/15.
//  Copyright © 2017年 liuyong. All rights reserved.
//

#import "VZHTTPListModel.h"
#import "SNProjectListItem.h"

@interface SNProjectListModel : VZHTTPListModel

@property (nonatomic, assign) BOOL isHome;
@property (nonatomic, assign) BOOL isNewLender;
@property (nonatomic, assign) NSInteger start;
@property (nonatomic , assign) NSUInteger  avative;
@end
