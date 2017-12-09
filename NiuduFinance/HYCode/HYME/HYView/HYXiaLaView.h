//
//  HYXiaLaView.h
//  NiuduFinance
//
//  Created by Apple on 2017/12/4.
//  Copyright © 2017年 liuyong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HYXiaLaView : UIView<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, weak) UITableView *mainTV;

@property (nonatomic, weak) UIButton *mcBtn;

@property (nonatomic, strong) NSArray *titleArr;

@property (nonatomic, strong) NSArray *dataArr;

@property (nonatomic, strong) NSArray *resultArr;

@end
