//
//  PageWebViewController.h
//  WeiPublicFund
//
//  Created by liuyong on 16/6/30.
//  Copyright © 2016年 www.niuduz.com. All rights reserved.
//

#import "BaseViewController.h"
#import "SNProjectListItem.h"

@interface PageWebViewController : BaseViewController

@property (nonatomic, strong) NSString *urlStr;

/******************************/
@property (nonatomic, strong) SNProjectListItem * projectItem;
@property (nonatomic,assign)int projectId;
@property (nonatomic,strong)NSString *type;
@property (nonatomic,copy) NSString *addrate;
@property (nonatomic,copy) NSString *resultsRatess;
@property (nonatomic, strong) NSArray *recProductArr;

@end
