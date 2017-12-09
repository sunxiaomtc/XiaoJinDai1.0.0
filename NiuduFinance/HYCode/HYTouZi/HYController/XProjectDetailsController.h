//
//  XProjectDetailsController.h
//  NiuduFinance
//
//  Created by 123 on 17/7/19.
//  Copyright © 2017年 liuyong. All rights reserved.
//

#import "BaseViewController.h"
#import "SNProjectListItem.h"
@interface XProjectDetailsController : BaseViewController
@property (nonatomic, strong) SNProjectListItem * projectItem;
@property (nonatomic,assign)int projectId;
@property (nonatomic,strong)NSString *type;
@property (nonatomic,copy) NSString *addrate;
@property (nonatomic,assign) double resultsRate;
@end
