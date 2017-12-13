//
//  HomeHeaderView.m
//  NiuduFinance
//
//  Created by 邢天阔 on 2017/9/27.
//  Copyright © 2017年 liuyong. All rights reserved.
//

#import "HomeHeaderView.h"
#import "SDCycleScrollView.h"
#import "CCPScrollView.h"
#import "ZHMeHeader.h"

const CGFloat kMenuButtonHeight = 90.0;

@interface HomeHeaderView ()<SDCycleScrollViewDelegate>

/**文字轮播
 */
@property (nonatomic, weak) CCPScrollView *ccpView;
/**轮播图view
 */
@property (nonatomic, weak) SDCycleScrollView *bannerView;

/**按钮的文字图片数组
 */
@property (nonatomic, copy) NSArray *menuImages;
@property (nonatomic, copy) NSArray *menuTitles;

@property (nonatomic, weak) UIView *btnView1;

@property (nonatomic, weak) UIView *btnView2;

@end

@implementation HomeHeaderView

- (NSArray *)menuImages {
    if (!_menuImages) {
        _menuImages = @[
                        @"图层-34",
                        @"图层-33",
                        @"图层-35"];
    }
    return _menuImages;
}
- (NSArray *)menuTitles {
    if (!_menuTitles) {
        _menuTitles = @[@"每日签到",@"邀请有奖",@"关于我们"];
    }
    return _menuTitles;
}


- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor colorWithHexString:@"f2f2f2"];
        [self createHeaderView];
    }
    return self;
}
#pragma mark - 返回头部试图的高度
+ (CGFloat)homeHeaderHight {
    return SCREEN_WIDTH/375 *335.0f;
}


#pragma mark - 创建头部试图
- (void)createHeaderView {

//    轮播图view
    UIView *scrollView = [[UIView alloc]init];
    [self addSubview:scrollView];
    [scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self).mas_offset(0);
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH, SCREEN_WIDTH/375 *205));
    }];
    scrollView.backgroundColor = [UIColor whiteColor];
    
    SDCycleScrollView *bannerView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_WIDTH/375 *205) delegate:self placeholderImage:nil];
    bannerView.backgroundColor = [UIColor whiteColor];
    bannerView.pageDotColor = [UIColor lightGrayColor];
    self.bannerView = bannerView;
    //设置bannerView的图片数组
    [scrollView addSubview:bannerView];
    
//    广播的view
    UIView *radioView = [[UIView alloc]init];
    [self addSubview:radioView];
    [radioView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(scrollView.mas_bottom).mas_offset(0);
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH, SCREEN_WIDTH/375 *46));
    }];
    radioView.backgroundColor = [UIColor whiteColor];
    
    UIImageView *radioImagView = [[UIImageView alloc]init];
    [radioView addSubview:radioImagView];
    [radioImagView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self).mas_offset(12);
        make.centerY.mas_equalTo(radioView).mas_offset(0);
    }];
    [radioImagView setImage:[UIImage imageNamed:@"home-lb"]];
    
    UIButton *machButton = [[UIButton alloc]init];
    [radioView addSubview:machButton];
    [machButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self).mas_offset(-5);
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH/375*55, SCREEN_WIDTH/375 *46));
        make.centerY.mas_equalTo(radioView).mas_offset(0);
    }];
    [machButton setTitle:@"更多>>" forState:UIControlStateNormal];
    [machButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    machButton.titleLabel.font = [UIFont systemFontOfSize:13];
    [machButton addTarget:self action:@selector(machButtonClick) forControlEvents:UIControlEventTouchUpInside];
    
//    文字滚动view
    CCPScrollView *ccpView = [[CCPScrollView alloc]initWithFrame:CGRectMake(40, 0, SCREEN_WIDTH-SCREEN_WIDTH/375*100, SCREEN_WIDTH/375 *46)];
    [radioView addSubview:ccpView];
    ccpView.titleFont = 12;
    ccpView.titleColor = [UIColor blackColor];
    self.ccpView = ccpView;
    
//    滚动文字点击按钮的view
    UIView *buttonView = [[UIView alloc]init];
    [self addSubview:buttonView];
    [buttonView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(radioView.mas_bottom).mas_offset(12.0f);
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH-30, SCREEN_WIDTH/375 *90));
        make.centerX.mas_equalTo(self);
    }];
    buttonView.backgroundColor = [UIColor whiteColor];
    
    for(int i = 0; i < 2; i++)
    {
        UIView *view = [[UIView alloc] init];
        view.frame = CGRectMake(((SCREEN_WIDTH - 30) / 2) * i, 0, (SCREEN_WIDTH - 30) / 2, SCREEN_WIDTH/375 * 90);
        view.backgroundColor = [UIColor whiteColor];
        if(i == 0)
        {
            self.btnView1 = view;
        }else
        {
            self.btnView2 = view;
        }
        [buttonView addSubview:view];
        
        UIImageView *iv = [[UIImageView alloc] init];
        iv.frame = CGRectMake(0.6 * (SCREEN_WIDTH / 2), (view.frame.size.height - 43) / 2, 43, 43);
        [view addSubview:iv];
        
        UILabel *lable = [[UILabel alloc] init];
        lable.frame = CGRectMake(0.15 * (SCREEN_WIDTH / 2), ((SCREEN_WIDTH/375 * 90) - 40) / 2, 68, 40);
        if(i == 0)
        {
            lable.text = @"新人福利注册即送";
            iv.image = [UIImage imageNamed:@"home-lw"];
        }else
        {
            lable.text = @"邀请有奖高额返现";
            iv.image = [UIImage imageNamed:@"home-yqhy"];
        }
        lable.numberOfLines = 0;
        lable.textColor = qianhui71Color;
        lable.font = [UIFont systemFontOfSize:14.0f];
        [view addSubview:lable];
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(0, 0, SCREEN_WIDTH / 2, SCREEN_WIDTH/375 * 90);
        btn.backgroundColor = [UIColor clearColor];
        [btn addTarget:self action:@selector(btnCLick:) forControlEvents:UIControlEventTouchUpInside];
        btn.tag = 1000 + i;
        [view addSubview:btn];
    }
    
    UILabel *line = [[UILabel alloc] init];
    line.backgroundColor = qianhui220Color;
    [buttonView addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(buttonView.top).offset(((SCREEN_WIDTH/375 * 90) - 54) / 2);
        make.centerX.mas_equalTo(buttonView.centerX);
        make.size.mas_equalTo(CGSizeMake(1, 54));
    }];
    
    
//    [self.menuImages enumerateObjectsUsingBlock:^(id  _Nonnull obj,
//                                                  NSUInteger idx,
//                                                  BOOL * _Nonnull stop) {
//        VerticalButton *button = [VerticalButton buttonWithType:UIButtonTypeCustom];
//        button.tag = idx;
//        button.origin = CGPointMake(idx*(SCREEN_WIDTH - 30)/_menuImages.count, 0);
//        button.size = CGSizeMake((SCREEN_WIDTH - 30)/_menuImages.count, SCREEN_WIDTH/375 *90);
//        button.titleLabel.font = [UIFont systemFontOfSize:12];
//        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//        [button setImage:[UIImage imageNamed:_menuImages[idx]] title:self.menuTitles[idx] forState:UIControlStateNormal];
//        [button addTarget:self action:@selector(selectItem:) forControlEvents:UIControlEventTouchUpInside];
//        [buttonView addSubview:button];
//    }];
}

-(void)btnCLick:(UIButton *)btn
{
    if(_btnClickBlock)
    {
        self.btnClickBlock(btn.tag - 1000);
    }
}

#pragma marl - 按钮的点击事件
- (void)selectItem:(UIButton *)sender {
    if (_HomeButtonBlock) {
        _HomeButtonBlock (sender.tag);
    }
}
#pragma mark bannerView的代理方法
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index {
    NSMutableArray *marray = [NSMutableArray array];
    for (NSDictionary *dic in self.bannerArray) {
        [marray addObject:dic[@"url"]];
    }
    if (_HomeScrollViewBlock) {
        _HomeScrollViewBlock (marray[index]);
    }
}
#pragma mark - 广播文字数据数组以及点击事件
- (void)setTitleArray:(NSArray *)titleArray {
    _titleArray = titleArray;
    NSMutableArray *marray = [NSMutableArray array];
    NSMutableArray *titleIDArray = [NSMutableArray array];
    for (NSDictionary *dic in titleArray) {
        [marray addObject:dic[@"title"]];
        [titleIDArray addObject:dic[@"newsinformationid"]];
    }
    if (titleArray.count != 0) {
       self.ccpView.titleArray = marray; 
    }
    [self.ccpView clickTitleLabel:^(NSInteger index,NSString *titleString) {
        if (_HomeTitleBlock) {
            _HomeTitleBlock(titleIDArray[index]);
        }
    }];
}
#pragma mark - 轮播图数据数组
- (void)setBannerArray:(NSArray *)bannerArray {
    _bannerArray = bannerArray;
    NSMutableArray *marray = [NSMutableArray array];
    for (NSDictionary *dic in bannerArray) {
        [marray addObject:dic[@"imageurl"]];
    }
    self.bannerView.imageURLStringsGroup = marray;
}
#pragma mark - 更多按钮的点击事件
- (void)machButtonClick {
    if (_HomeMachButtonBlock) {
        _HomeMachButtonBlock();
    }
}


@end
