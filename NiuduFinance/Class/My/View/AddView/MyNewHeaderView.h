//
//  MyNewHeaderView.h
//  NiuduFinance
//
//  Created by 小吊丝 on 2017/9/28.
//  Copyright © 2017年 liuyong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyNewModel.h"

@protocol MyNewHeaderViewDelegate <NSObject>

-(void)myNewHeaderViewButtonAction:(NSInteger)index;

@end

@interface MyNewHeaderView : UIView

@property(nonatomic, assign)id<MyNewHeaderViewDelegate>myNewHeaderViewDelegate;

@property(nonatomic, strong)MyNewModel *model;

@end
