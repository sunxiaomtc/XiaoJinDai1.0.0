//
//  XProjectConfirmController.h
//  NiuduFinance
//
//  Created by 123 on 17/7/20.
//  Copyright © 2017年 liuyong. All rights reserved.
//

#import "BaseViewController.h"
#import "SNProjectListItem.h"
@interface XProjectConfirmController : BaseViewController
@property (nonatomic,assign)int projectId;
@property (nonatomic,strong) NSMutableArray *hongBaoArray;
//新现金红包
@property (nonatomic,strong) NSMutableArray * nameArr;
@property (nonatomic,strong) NSMutableArray *getHongBaoArray;
@property (nonatomic,copy) NSString *addRate;

@end
