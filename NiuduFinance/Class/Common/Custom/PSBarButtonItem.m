//
//  PSBarButtonItem.m
//  PublicFundraising
//
//  Created by Apple on 15/10/9.
//  Copyright © 2015年 Niuduz. All rights reserved.
//

#import "PSBarButtonItem.h"

@implementation PSBarButtonItem
+ (instancetype)itemWithTitle:(NSString *)title
                        barStyle:(PSNavItemStyle)style
                       target:(id)target
                       action:(SEL)action
{
    
    if (style == PSNavItemStyleBack)
    {
        //返回
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.backgroundColor = [UIColor clearColor];
        //nav_back_normal.png
        [btn setImage:[UIImage imageNamed:@"黑色返回按钮"] forState:UIControlStateNormal];
        [btn setImage:[UIImage imageNamed:@"nav_back_select.png"] forState:UIControlStateHighlighted];
        btn.frame = CGRectMake(0, 0, 44, 44);
        btn.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 30);
        
        [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
        PSBarButtonItem *item = [[PSBarButtonItem alloc] initWithCustomView:btn];
        return item;
    }
    else if (style == PSNavItemStyleDone)
    {
//        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
//        [btn setTitle:title forState:UIControlStateNormal];
//        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//        [btn addTarget:target action:action forControlEvents:UIControlStateNormal];
        
        PSBarButtonItem *item = [[PSBarButtonItem alloc]
                                 initWithTitle:title
                                 style:UIBarButtonItemStyleDone
                                 target:target
                                 action:action];
        [item setTitlePositionAdjustment:UIOffsetMake(-5, 0) forBarMetrics:UIBarMetricsDefault];
        
        item.tintColor = [UIColor whiteColor];
        return item;
    }
    else
    {
        return nil;
    }
}

+ (instancetype)itemWithImageName:(NSString *)normalImageName highLightImageName:(NSString *)highImageName selectedImageName:(NSString *)selectedImageName target:(id)target action:(SEL)action
{
        
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.backgroundColor = [UIColor clearColor];
    UIImage *normalImage;
    if (normalImageName)
    {
        normalImage = [UIImage imageNamed:normalImageName]; 
        [btn setImage:normalImage forState:UIControlStateNormal];
    }
    
    if (highImageName)
    {
        [btn setImage:[UIImage imageNamed:highImageName] forState:UIControlStateHighlighted];
    }
    
    if (selectedImageName)
    {
        [btn setImage:[UIImage imageNamed:selectedImageName] forState:UIControlStateSelected];
    }
    
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    CGRect rect = CGRectMake(0, 0, normalImage.size.width, normalImage.size.height);
    btn.frame = rect;
    PSBarButtonItem *item = [[PSBarButtonItem alloc] initWithCustomView:btn];
    return item;
}

- (void)setEnabled:(BOOL)enabled
{
    [super setEnabled:enabled];
    
    if ([self.customView isKindOfClass:[UIControl class]])
    {
        UIControl *ctrl = (UIControl *)self.customView;
        ctrl.enabled = enabled;
    }
}

@end
