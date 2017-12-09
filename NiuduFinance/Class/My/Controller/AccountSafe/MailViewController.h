//
//  MailViewController.h
//  NiuduFinance
//
//  Created by andrewliu on 16/9/17.
//  Copyright © 2016年 liuyong. All rights reserved.
//

#import "BaseViewController.h"

typedef void (^MailReturnBlock)(NSString *mailReturn);

@interface MailViewController : BaseViewController

@property (nonatomic,assign) BOOL isOldMail;

@property (nonatomic,copy) MailReturnBlock mailReturn;

@end
