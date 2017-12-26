//
//  UICollectionViewCell3.m
//  NiuduFinance
//
//  Created by 小吊丝 on 2017/9/28.
//  Copyright © 2017年 liuyong. All rights reserved.
//

#import "MyCollectionViewCell3.h"

@interface MyCollectionViewCell3 ()

@property(nonatomic, strong) UIView *backGroundView;
@property(nonatomic, strong) UILabel *kfLabel;
@property(nonatomic, strong) UIView *qqView;
@property(nonatomic, strong) UILabel *qqLabel;
@property(nonatomic, strong) UIImageView *qqImageView;
@property(nonatomic, strong) UILabel *qqNumber;
@property(nonatomic, strong) UIView *sjView;
@property(nonatomic, strong)UIImageView *sjImageView;
@property(nonatomic, strong) UILabel *sjLabel;
@property(nonatomic, strong) UILabel *sjNumber;
@property(nonatomic, strong) UILabel *wxLabel;
@property(nonatomic, strong)UIImageView *wxImageView;
@property(nonatomic, strong)UIImageView *ewImageView;

@end

@implementation MyCollectionViewCell3

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self createSubViews];
    }
    return self;
}

- (void)createSubViews {
    self.backgroundColor = [UIColor whiteColor];
    self.backGroundView = [UIView new];
    self.backGroundView.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:self.backGroundView];
    [self.backGroundView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView.mas_top).with.offset(0);
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH, 160));
    }];
    
    self.kfLabel = [UILabel new];
    [self.kfLabel setText:@"专属客服"];
    [self.kfLabel setFont:[UIFont systemFontOfSize:16]];
    [self.backGroundView addSubview:self.kfLabel];
    [self.kfLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(20);
        make.left.mas_equalTo(15);
        make.height.mas_equalTo(15);
    }];
    self.kfLabel.textColor = [UIColor colorWithHexString:@"#282828"];
    
//    self.qqView = [UIView new];
//    self.qqView.backgroundColor = [UIColor whiteColor];
//    [self.backGroundView addSubview:self.qqView];
//    [self.qqView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(_kfLabel.mas_bottom).with.offset(33);
//        make.size.mas_equalTo(CGSizeMake(110, 46));
//        make.left.mas_equalTo(35);
//    }];
//
//    UITapGestureRecognizer * qqRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(qqClick)];
//    [self.qqView addGestureRecognizer:qqRecognizer];
//    self.qqView.userInteractionEnabled = YES;
//
//    self.qqImageView = [UIImageView new];
//    UIImage * qqImage = [UIImage imageNamed:@"qq.png"];
//    self.qqImageView.image = qqImage;
//    [self.qqView addSubview:self.qqImageView];
//    [self.qqImageView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.mas_equalTo(0);
//        make.left.mas_equalTo(0);
//        make.size.mas_equalTo(CGSizeMake(26, 26));
//    }];
//
//    self.qqLabel = [UILabel new];
//    [self.qqLabel setText:@"在线客服"];
//    self.qqLabel.textColor = [UIColor colorWithHexString:@"#282828"];
//    [self.qqLabel setFont:[UIFont systemFontOfSize:15]];
//    [self.qqView addSubview:self.qqLabel];
//    [self.qqLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.centerY.equalTo(self.qqImageView.mas_centerY);
//        make.height.mas_equalTo(14);
//        make.left.equalTo(self.qqImageView.mas_right).with.offset(10);
//    }];
//
//    self.qqNumber = [UILabel new];
//    [self.qqNumber setText:@""];
//    self.qqNumber.textColor = [UIColor colorWithHexString:@"#282828"];
//    [self.qqNumber setFont:[UIFont systemFontOfSize:10]];
//    [self.qqView addSubview:self.qqNumber];
//    [self.qqNumber mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(self.qqLabel.mas_bottom).with.offset(10);
//        make.height.mas_equalTo(14);
//        make.left.equalTo(self.qqImageView.mas_right).with.offset(10);
//    }];
    
    self.sjView = [UIView new];
    self.sjView.backgroundColor = [UIColor whiteColor];
    [self.backGroundView addSubview:self.sjView];
    [self.sjView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_kfLabel.mas_bottom).with.offset(33);
        make.size.mas_equalTo(CGSizeMake(110, 46));
        //make.right.mas_equalTo(self).mas_offset(-35);
        make.centerX.equalTo(self);
    }];
    
    UITapGestureRecognizer * sjRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(sjClick)];
    [self.sjView addGestureRecognizer:sjRecognizer];
    self.sjView.userInteractionEnabled = YES;
    
    self.sjImageView = [UIImageView new];
    UIImage * sjImage = [UIImage imageNamed:@"kf.png"];
    self.sjImageView.image = sjImage;
    [self.sjView addSubview:self.sjImageView];
    [self.sjImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.left.mas_equalTo(0);
        make.size.mas_equalTo(CGSizeMake(26, 26));
    }];
    self.sjLabel = [UILabel new];
    [self.sjLabel setText:@"客服热线"];
    self.sjLabel.textColor = [UIColor colorWithHexString:@"#282828"];
    [self.sjLabel setFont:[UIFont systemFontOfSize:15]];
    [self.sjView addSubview:self.sjLabel];
    [self.sjLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.sjImageView.mas_centerY);
        make.height.mas_equalTo(14);
        make.left.equalTo(self.sjImageView.mas_right).with.offset(10);
    }];
    
    self.sjNumber = [UILabel new];
    [self.sjNumber setText:@"400-679-0008"];
    self.sjNumber.textColor = [UIColor colorWithHexString:@"#282828"];
    [self.sjNumber setFont:[UIFont systemFontOfSize:10]];
    [self.sjView addSubview:self.sjNumber];
    [self.sjNumber mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.sjLabel.mas_bottom).with.offset(10);
        make.height.mas_equalTo(14);
        make.left.equalTo(self.sjImageView.mas_right).with.offset(10);
    }];
    
//    self.wxLabel = [UILabel new];
//    [self.wxLabel setText:@"微信二维码"];
//    self.wxLabel.textColor = [UIColor colorWithHexString:@"#282828"];
//    [self.wxLabel setFont:[UIFont systemFontOfSize:15]];
//    [self.backGroundView addSubview:self.wxLabel];
//    [self.wxLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.centerY.equalTo(self.qqImageView.mas_centerY);
//        make.height.mas_equalTo(15);
//        make.right.mas_equalTo(-26);
//    }];
//    
//    self.wxImageView = [UIImageView new];
//    UIImage * wxImage = [UIImage imageNamed:@"vx.png"];
//    self.wxImageView.image = wxImage;
//    [self.backGroundView addSubview:self.wxImageView];
//    [self.wxImageView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.centerY.equalTo(self.qqImageView.mas_centerY);
//        make.right.equalTo(self.wxLabel.mas_left).with.offset(-10);
//        make.size.mas_equalTo(CGSizeMake(26, 26));
//    }];
    
    
//    self.ewImageView = [UIImageView new];
//    [self.backGroundView addSubview:self.ewImageView];
//    [self.ewImageView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(self.wxLabel.mas_bottom).with.offset(8);
//        make.size.mas_equalTo(CGSizeMake(100, 100));
//        make.centerX.equalTo(self.wxLabel.mas_centerX);
//    }];
//    self.ewImageView.image = [UIImage imageNamed:@"midaiziQR"];
    
//    [self getImage];
}

- (void)getImage
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString * accesstoken = [defaults objectForKey:@"accesstoken"];
    
    
    dispatch_queue_t globalQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_async(globalQueue, ^{
        NSString * str = [NSString stringWithFormat:@"%@v2/accept/user/userQR?UserId=%@&accesstoken=%@&Platform=2&os=%@&version=%@",__API_HEADER__,[NSString stringWithFormat:@"%ld",(long)[User shareUser].userId],accesstoken,kos,kVersion];
        NSURL * url = [NSURL URLWithString:str ];
        NSData *data = [NSData dataWithContentsOfURL:url];
        UIImage *image = [UIImage imageWithData:data];
        NSLog(@"%@",image);
        
        dispatch_async(dispatch_get_main_queue(), ^{
//            self.ewImageView.image = image;
        });
    });
}

-(void)qqClick
{
    if ([self.myCollectionViewCell3Delegate respondsToSelector:@selector(myCollectionViewCell3pCilckType:)]) {
        [self.myCollectionViewCell3Delegate myCollectionViewCell3pCilckType:@"qq"];
    }
}

-(void)sjClick
{
    if ([self.myCollectionViewCell3Delegate respondsToSelector:@selector(myCollectionViewCell3pCilckType:)]) {
        [self.myCollectionViewCell3Delegate myCollectionViewCell3pCilckType:@"电话"];
    }
}


@end
