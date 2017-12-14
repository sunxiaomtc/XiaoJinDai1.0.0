//
//  XProjectDetailsNewController.h
//  NiuduFinance
//
//  Created by 小吊丝 on 2017/9/26.
//  Copyright © 2017年 liuyong. All rights reserved.
//

#import "BaseViewController.h"
#import "SNProjectListItem.h"

@interface XProjectDetailsNewController : BaseViewController

@property (nonatomic, strong) SNProjectListItem * projectItem;
@property (nonatomic,assign)int projectId;
@property (nonatomic,strong)NSString *type;

@end
