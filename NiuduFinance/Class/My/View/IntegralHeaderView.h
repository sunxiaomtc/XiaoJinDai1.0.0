//
//  IntegralHeaderView.h
//  NiuduFinance
//
//  Created by andrewliu on 16/9/18.
//  Copyright © 2016年 liuyong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface IntegralHeaderView : UIView
{
    UIImageView *image1,*image2;
    float random;
    float orign;
}

@property (nonatomic,strong) NSDictionary *dic;
@end
