//
//  ProjectDetailsViewController.h
//  NiuduFinance
//
//  Created by liuyong on 16/2/26.
//  Copyright © 2016年 liuyong. All rights reserved.
//

#import "BaseViewController.h"
#import "SNProjectListItem.h"
#import "SNDebtListItem.h"

@class ProjectProgressView;
@class ProjectDetailsTableViewCell;
@interface ProjectDetailsViewController : BaseViewController

@property (nonatomic,assign)int projectId;

@property (nonatomic,assign)int productId;

@property (nonatomic,strong)NSString *type;

@property (nonatomic,strong)NSString *IsNewType;

@property (nonatomic, copy) NSString *statueId;

@property (nonatomic,strong) NSMutableArray *hongBaoArray;

@property (nonatomic, strong) SNProjectListItem * projectItem;
@property (nonatomic, strong) SNDebtListItem    * debtItem;

- (void)projectTableViewCell:(ProjectDetailsTableViewCell *)cell supportProject:(id)project;

@end
