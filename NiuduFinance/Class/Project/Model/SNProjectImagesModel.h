//
//  SNProjectImagesModel.h
//  NiuduFinance
//
//  Created by ponta on 2017/2/20.
//  Copyright © 2017年 liuyong. All rights reserved.
//

#import "VZHTTPModel.h"

@interface SNProjectImagesModel : VZHTTPModel

@property (nonatomic, strong) NSString * projectId;

@property (nonatomic, strong) NSArray * imagesArray;

@end
