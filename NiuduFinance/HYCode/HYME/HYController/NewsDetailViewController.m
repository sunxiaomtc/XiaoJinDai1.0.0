//
//  NewsDetailViewController.m
//  NiuduFinance
//
//  Created by 邢天阔 on 2017/10/16.
//  Copyright © 2017年 liuyong. All rights reserved.
//

#import "NewsDetailViewController.h"
#import "NewsModel.h"

@interface NewsDetailViewController ()

/**消息类型
 */
@property (nonatomic, weak) UILabel *newsTypeLabel;
/**消息时间
 */
@property (nonatomic, weak) UILabel *newsTimeLabel;
/**消息内容
 */
@property (nonatomic, weak) UILabel *newsContentLabel;
@end

@implementation NewsDetailViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"消息详情";
    [self setupBarButtomItemWithImageName:@"黑色返回按钮" highLightImageName:@"黑色返回按钮" selectedImageName:nil target:self action:@selector(backClick) leftOrRight:YES];
    [self createUIView];
}
#pragma mark - 返回上一个页面
- (void)backClick {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)createUIView {
    UILabel *informLabel = [[UILabel alloc]init];
    [self.view addSubview:informLabel];
    [informLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view).mas_offset(10);
        make.top.mas_equalTo(self.view).mas_offset(10);
    }];
    informLabel.text = @"用户通知";
    informLabel.textColor = [UIColor blackColor];
    informLabel.font = [UIFont systemFontOfSize:13];
    
    UILabel *newsTimeLabel = [[UILabel alloc]init];
    [self.view addSubview:newsTimeLabel];
    [newsTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.view).mas_offset(-10);
        make.top.mas_equalTo(self.view).mas_offset(10);
    }];
    newsTimeLabel.textColor = [UIColor blackColor];
    newsTimeLabel.font = [UIFont systemFontOfSize:13];
    self.newsTimeLabel = newsTimeLabel;
    
    UILabel *newsContentLabel = [[UILabel alloc]init];
    [self.view addSubview:newsContentLabel];
    [newsContentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(newsTimeLabel.mas_bottom).mas_offset(5);
        make.left.mas_equalTo(self.view).mas_offset(10);
        make.right.mas_equalTo(self.view).mas_offset(-10);
    }];
    newsContentLabel.textColor = [UIColor blackColor];
    newsContentLabel.font = [UIFont systemFontOfSize:14];
    newsContentLabel.numberOfLines = 0;
    self.newsContentLabel = newsContentLabel;
    
    UILabel *newsTypeLabel = [[UILabel alloc]init];
    [self.view addSubview:newsTypeLabel];
    [newsTypeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.newsContentLabel.mas_bottom).mas_offset(10);
        make.right.mas_equalTo(self.view).mas_offset(-10);
    }];
    newsTypeLabel.textColor = [UIColor blackColor];
    newsTypeLabel.font = [UIFont systemFontOfSize:13];
    self.newsTypeLabel = newsTypeLabel;
}

- (void)setNewsModel:(NewsModel *)newsModel {
    _newsModel = newsModel;
    //时间戳转成时间
    NSString *dataStr = [NSString stringWithFormat:@"%@",self.newsModel.creationdate];
    NSString *currentStr = [dataStr substringWithRange:NSMakeRange(0,10)];
    
    NSDateFormatter *stampFormatter = [[NSDateFormatter alloc] init];
    [stampFormatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
    NSDate *stampDate = [NSDate dateWithTimeIntervalSince1970:[currentStr integerValue]];
    self.newsTimeLabel.text = [NSString stringWithFormat:@"%@",[stampFormatter stringFromDate:stampDate]];
    
    NSString *contents = self.newsModel.content;
    self.newsContentLabel.text = [NSString stringWithFormat:@"%@",contents];
    
    if ([self.newsModel.typeId isEqualToString:@"1"]) {
        self.newsTypeLabel.text = @"系统消息";
    }
    if ([self.newsModel.typeId isEqualToString:@"2"]) {
        self.newsTypeLabel.text = @"用户消息";
    }
    if ([self.newsModel.typeId isEqualToString:@"3"]) {
        self.newsTypeLabel.text = @"用户消息";
    }
    if ([self.newsModel.typeId isEqualToString:@"4"]) {
        self.newsTypeLabel.text = @"系统信息";
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
