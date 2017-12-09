//
//  UICollectionViewCell3.h
//  NiuduFinance
//
//  Created by 小吊丝 on 2017/9/28.
//  Copyright © 2017年 liuyong. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MyCollectionViewCell3Delegate <NSObject>

-(void)myCollectionViewCell3pCilckType:(NSString *)cilckType;

@end

@interface MyCollectionViewCell3 : UICollectionViewCell

@property(nonatomic, weak)id<MyCollectionViewCell3Delegate>myCollectionViewCell3Delegate;

@end
