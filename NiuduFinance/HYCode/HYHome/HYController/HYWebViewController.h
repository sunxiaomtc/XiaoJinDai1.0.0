//
//  HYWebViewController.h
//  NiuduFinance
//
//  Created by Apple on 2017/12/11.
//  Copyright © 2017年 liuyong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SNProjectListItem.h"

@interface HYWebViewController : UIViewController

@property (nonatomic, copy) NSString *urlStr;

/******************************/
@property (nonatomic, strong) SNProjectListItem * projectItem;
@property (nonatomic,assign)int projectId;
@property (nonatomic,strong)NSString *type;
@property (nonatomic,copy) NSString *addrate;
@property (nonatomic,copy) NSString *resultsRatess;
@property (nonatomic, strong) NSArray *recProductArr;

@end
