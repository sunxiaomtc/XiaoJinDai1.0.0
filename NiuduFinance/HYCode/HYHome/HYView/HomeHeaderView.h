//
//  HomeHeaderView.h
//  NiuduFinance
//
//  Created by 邢天阔 on 2017/9/27.
//  Copyright © 2017年 liuyong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HomeHeaderView : UIView

/**头部试图的高度
 */
+ (CGFloat)homeHeaderHight;
/**按钮的点击事件
 */
@property (nonatomic, copy) void (^HomeButtonBlock)(NSInteger buttonTag);
/**轮播图的点击
 */
@property (nonatomic, copy) void (^HomeScrollViewBlock)(NSString *scrollViewID);

@property (nonatomic, copy) void (^HomeTitleBlock)(NSString *titltID);

@property (nonatomic, copy) void (^HomeMachButtonBlock)(void);

/**轮播图数据数组
 */
@property (nonatomic, copy) NSArray *bannerArray;
/**广播文字数据数组
 */
@property (nonatomic, copy) NSArray *titleArray;
@end
