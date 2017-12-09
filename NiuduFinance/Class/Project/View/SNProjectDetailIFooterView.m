//
//  SNProjectDetailIFooterView.m
//  NiuduFinance
//
//  Created by ponta on 2017/2/19.
//  Copyright © 2017年 liuyong. All rights reserved.
//

#import "SNProjectDetailIFooterView.h"
#import "SNProjectDetailModel.h"
#import "SNDebtDetailModel.h"
#import "ShowBigImage.h"

@interface SNProjectDetailIFooterView ()

@property (nonatomic, strong) UIView   * line;
@property (nonatomic, strong) UIButton * desBtn;
@property (nonatomic, strong) UIButton * photoBtn;
@property (nonatomic, strong) UIButton * listBtn;

@property (nonatomic, strong) UIView  * desView;
@property (nonatomic, strong) UILabel * projectintroduce;     //  项目介绍
@property (nonatomic, strong) UILabel * enterpriseintroduce;  //  借款企业介绍
@property (nonatomic, strong) UILabel * riskmanagement;       //  风控保障

@property (nonatomic, strong) UIView * photoView;

@property (nonatomic, strong) UIView * listView;

@end

@implementation SNProjectDetailIFooterView

- (UIView *)photoView
{
    if (!_photoView) {
        _photoView = [[UIView alloc] init];
        _photoView.hidden = YES;
        _photoView.backgroundColor = [UIColor whiteColor];
        [self addSubview:_photoView];
        WS
        [_photoView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(weakSelf.mas_left);
            make.right.equalTo(weakSelf.mas_right);
            make.top.equalTo(weakSelf.mas_top).with.offset(48);
            make.height.mas_equalTo(@40);
        }];
        
        UILabel * titleLab = [[UILabel alloc] init];
        titleLab.text = @"项目图片";
        titleLab.textColor = Black464646;
        titleLab.font = [UIFont systemFontOfSize:14.f];
        [_photoView addSubview:titleLab];
        [titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(weakSelf.photoView.mas_left).with.offset(20);
            make.centerY.equalTo(weakSelf.photoView.mas_top).with.offset(15);
        }];
    }
    return _photoView;
}

- (UIView *)listView
{
    if (!_listView) {
        _listView = [[UIView alloc] init];
        _listView.hidden = YES;
        _listView.backgroundColor = [UIColor whiteColor];
        [self addSubview:_listView];
        WS
        [_listView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(weakSelf.mas_left);
            make.right.equalTo(weakSelf.mas_right);
            make.top.equalTo(weakSelf.mas_top).with.offset(48);
            make.height.mas_equalTo(@40);
        }];
        
        UILabel * listTitle1 = [[UILabel alloc] init];
        listTitle1.text = @"当前排名";
        listTitle1.textColor = Black464646;
        listTitle1.font = [UIFont systemFontOfSize:14.f];
        [_listView addSubview:listTitle1];
        [listTitle1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(weakSelf.listView.mas_centerX).offset(-SCREEN_WIDTH/8*3);
            make.centerY.equalTo(weakSelf.listView.mas_top).with.offset(15);
        }];
        UILabel * listTitle2 = [[UILabel alloc] init];
        listTitle2.text = @"投资用户";
        listTitle2.textColor = Black464646;
        listTitle2.font = [UIFont systemFontOfSize:14.f];
        [_listView addSubview:listTitle2];
        [listTitle2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(weakSelf.listView.mas_centerX).offset(-SCREEN_WIDTH/8*1-5);
            make.centerY.equalTo(weakSelf.listView.mas_top).with.offset(15);
        }];
        UILabel * listTitle3 = [[UILabel alloc] init];
        listTitle3.text = @"投资金额";
        listTitle3.textColor = Black464646;
        listTitle3.font = [UIFont systemFontOfSize:14.f];
        [_listView addSubview:listTitle3];
        [listTitle3 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(weakSelf.listView.mas_centerX).offset(SCREEN_WIDTH/8*1-5);
            make.centerY.equalTo(weakSelf.listView.mas_top).with.offset(15);
        }];
        UILabel * listTitle4 = [[UILabel alloc] init];
        listTitle4.text = @"投资时间";
        listTitle4.textColor = Black464646;
        listTitle4.font = [UIFont systemFontOfSize:14.f];
        [_listView addSubview:listTitle4];
        [listTitle4 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(weakSelf.listView.mas_centerX).offset(SCREEN_WIDTH/8*3-5);
            make.centerY.equalTo(weakSelf.listView.mas_top).with.offset(15);
        }];
        
        
        UIView * listLine = [[UIView alloc] init];
        listLine.backgroundColor = Black999999;
        [_listView addSubview:listLine];
        [listLine mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(weakSelf.listView.mas_top).with.offset(30);
            make.left.equalTo(weakSelf.listView.mas_left).with.offset(8);
            make.right.equalTo(weakSelf.listView.mas_right).with.offset(-8);
            make.height.mas_equalTo(@0.5);
        }];
    }
    return _listView;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.backgroundColor = HEX_COLOR(@"#ededed");
        
        WS
        NSArray * nameArr = @[@"项目描述", @"项目图片", @"投资记录"];
        for (NSInteger i = 0; i < 3; i++) {
            UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
            button.tag = 100 + i;
            button.backgroundColor = [UIColor whiteColor];
            [button setTitle:nameArr[i] forState:UIControlStateNormal];
            button.titleLabel.font = [UIFont systemFontOfSize:15.f];
            [button setTitleColor:i ? [UIColor blackColor] : UIcolors forState:UIControlStateNormal];
            [button addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:button];
            [button mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(weakSelf.mas_left).with.offset(SCREEN_WIDTH / 3.f * i);
                make.top.equalTo(weakSelf.mas_top).with.offset(5);
                make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH / 3.f, 35));
            }];
            
            if (i == 0)
                _desBtn = button;
            else if (i == 1)
                _photoBtn = button;
            else
                _listBtn = button;
        }
        
        _line = [[UIView alloc] init];
        _line.backgroundColor = UIcolors;
        [self addSubview:_line];
        [_line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(weakSelf.mas_left);
            make.bottom.equalTo(weakSelf.mas_top).with.offset(40);
            make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH / 3.f, 2));
        }];
        
        //  项目描述
        _desView = [[UIView alloc] init];
        [self addSubview:_desView];
        [_desView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(weakSelf.mas_left);
            make.right.equalTo(weakSelf.mas_right);
            make.top.equalTo(weakSelf.mas_top).with.offset(48);
        }];
        
        UIView * projectintroduceV = [[UIView alloc] init];
        projectintroduceV.backgroundColor = [UIColor whiteColor];
        [_desView addSubview:projectintroduceV];
        [projectintroduceV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.right.equalTo(weakSelf.desView);
        }];
        
        UILabel * projectintroduceTitle = [[UILabel alloc] init];
        projectintroduceTitle.text = @"项目介绍";
        projectintroduceTitle.textColor = Black464646;
        projectintroduceTitle.font = [UIFont systemFontOfSize:14.f];
        [projectintroduceV addSubview:projectintroduceTitle];
        [projectintroduceTitle mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(projectintroduceV.mas_left).with.offset(8);
            make.centerY.equalTo(projectintroduceV.mas_top).with.offset(15);
        }];
        
        UIView * projectintroduceLine = [[UIView alloc] init];
        projectintroduceLine.backgroundColor = Black999999;
        [projectintroduceV addSubview:projectintroduceLine];
        [projectintroduceLine mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(projectintroduceV.mas_top).with.offset(30);
            make.left.equalTo(projectintroduceV.mas_left).with.offset(8);
            make.right.equalTo(projectintroduceV.mas_right).with.offset(-8);
            make.height.mas_equalTo(@0.5);
        }];
        
        _projectintroduce = [[UILabel alloc] init];
        _projectintroduce.numberOfLines = 0;
        _projectintroduce.font = [UIFont systemFontOfSize:13.f];
        _projectintroduce.textColor = Black999999;
        [projectintroduceV addSubview:_projectintroduce];
        [_projectintroduce mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(projectintroduceTitle.mas_left).with.offset(15);
            make.top.equalTo(projectintroduceLine.mas_bottom).with.offset(6);
            make.right.equalTo(projectintroduceLine.mas_right).with.offset(-15);
            make.bottom.equalTo(projectintroduceV.mas_bottom).with.offset(-10);
        }];
        
        UIView * enterpriseintroduceV = [[UIView alloc] init];
        enterpriseintroduceV.backgroundColor = [UIColor whiteColor];
        [_desView addSubview:enterpriseintroduceV];
        [enterpriseintroduceV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(projectintroduceV.mas_bottom).with.offset(8);
            make.left.right.equalTo(weakSelf.desView);
        }];
        
        UILabel * enterpriseintroduceTitle = [[UILabel alloc] init];
        enterpriseintroduceTitle.text = @"借款企业介绍";
        enterpriseintroduceTitle.textColor = Black464646;
        enterpriseintroduceTitle.font = [UIFont systemFontOfSize:14.f];
        [enterpriseintroduceV addSubview:enterpriseintroduceTitle];
        [enterpriseintroduceTitle mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(enterpriseintroduceV.mas_left).with.offset(8);
            make.centerY.equalTo(enterpriseintroduceV.mas_top).with.offset(15);
        }];
        
        UIView * enterpriseintroduceLine = [[UIView alloc] init];
        enterpriseintroduceLine.backgroundColor = Black999999;
        [enterpriseintroduceV addSubview:enterpriseintroduceLine];
        [enterpriseintroduceLine mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(enterpriseintroduceV.mas_top).with.offset(30);
            make.left.equalTo(enterpriseintroduceV.mas_left).with.offset(8);
            make.right.equalTo(enterpriseintroduceV.mas_right).with.offset(-8);
            make.height.mas_equalTo(@0.5);
        }];
        
        _enterpriseintroduce = [[UILabel alloc] init];
        _enterpriseintroduce.numberOfLines = 0;
        _enterpriseintroduce.font = [UIFont systemFontOfSize:13.f];
        _enterpriseintroduce.textColor = Black999999;
        [enterpriseintroduceV addSubview:_enterpriseintroduce];
        [_enterpriseintroduce mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(enterpriseintroduceTitle.mas_left).with.offset(15);
            make.top.equalTo(enterpriseintroduceLine.mas_bottom).with.offset(6);
            make.right.equalTo(enterpriseintroduceLine.mas_right).with.offset(-15);
            make.bottom.equalTo(enterpriseintroduceV.mas_bottom).with.offset(-10);
        }];
        
        UIView * riskmanagementV = [[UIView alloc] init];
        riskmanagementV.backgroundColor = [UIColor whiteColor];
        [_desView addSubview:riskmanagementV];
        [riskmanagementV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(enterpriseintroduceV.mas_bottom).with.offset(8);
            make.left.right.equalTo(weakSelf.desView);
            make.bottom.equalTo(weakSelf.desView.mas_bottom);
        }];
        
        UILabel * riskmanagementTitle = [[UILabel alloc] init];
        riskmanagementTitle.text = @"风控保障";
        riskmanagementTitle.textColor = Black464646;
        riskmanagementTitle.font = [UIFont systemFontOfSize:14.f];
        [riskmanagementV addSubview:riskmanagementTitle];
        [riskmanagementTitle mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(riskmanagementV.mas_left).with.offset(8);
            make.centerY.equalTo(riskmanagementV.mas_top).with.offset(15);
        }];
        
        UIView * riskmanagementLine = [[UIView alloc] init];
        riskmanagementLine.backgroundColor = Black999999;
        [riskmanagementV addSubview:riskmanagementLine];
        [riskmanagementLine mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(riskmanagementV.mas_top).with.offset(30);
            make.left.equalTo(riskmanagementV.mas_left).with.offset(8);
            make.right.equalTo(riskmanagementV.mas_right).with.offset(-8);
            make.height.mas_equalTo(@0.5);
        }];
        
        _riskmanagement = [[UILabel alloc] init];
        _riskmanagement.numberOfLines = 0;
        _riskmanagement.font = [UIFont systemFontOfSize:13.f];
        _riskmanagement.textColor = Black999999;
        [riskmanagementV addSubview:_riskmanagement];
        [_riskmanagement mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(riskmanagementTitle.mas_left).with.offset(15);
            make.top.equalTo(riskmanagementLine.mas_bottom).with.offset(6);
            make.right.equalTo(riskmanagementLine.mas_right).with.offset(-15);
            make.bottom.equalTo(riskmanagementV.mas_bottom).with.offset(-10);
        }];
        
        [_desView layoutIfNeeded];
        self.frame = CGRectMake(0, 0, SCREEN_WIDTH, 58 + _desView.frame.size.height);
    }
    return self;
}

- (void)setDetailItem:(id)detailItem
{
    if ([detailItem isKindOfClass:[SNProjectDetailItem class]]) {
        _projectintroduce.text = ((SNProjectDetailItem *)detailItem).projectintroduce;
        _enterpriseintroduce.text = ((SNProjectDetailItem *)detailItem).enterpriseintroduce;
        _riskmanagement.text = ((SNProjectDetailItem *)detailItem).riskmanagement;
    } else {
        _projectintroduce.text = ((SNDebtDetailItem *)detailItem).projectintroduce;
        _enterpriseintroduce.text = ((SNDebtDetailItem *)detailItem).enterpriseintroduce;
        _riskmanagement.text = ((SNDebtDetailItem *)detailItem).riskmanagement;
    }
    
    if (!self.desView.hidden) {
        [self layoutIfNeeded];
        //添加了111
        self.frame = CGRectMake(0, 0, SCREEN_WIDTH,111+ 58 + _desView.frame.size.height);
        
        [self performSelector:@selector(addFooterView) withObject:nil afterDelay:0.1f];
    }

}

- (void)setPhotoArray:(NSArray *)photoArray
{
    CGFloat width = SCREEN_WIDTH / 2 - 30;
    for (NSInteger i = 0; i < photoArray.count; i++) {
        UIImageView * imageV = [[UIImageView alloc] initWithFrame:CGRectMake(i % 2 ? (width + 40) : 20, 40 + i / 2 * (width + 20), width, width)];
        //为UIImageView1添加点击事件
        UITapGestureRecognizer *tapGestureRecognizer1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(scanBigImageClick1:)];
        [imageV addGestureRecognizer:tapGestureRecognizer1];
        //让UIImageView和它的父类开启用户交互属性
        [imageV setUserInteractionEnabled:YES];
        imageV.layer.masksToBounds = YES;
        imageV.autoresizingMask = UIViewAutoresizingNone;
        imageV.contentMode = UIViewContentModeScaleAspectFill;
        imageV.contentScaleFactor = [[UIScreen mainScreen] scale];
        imageV.backgroundColor = [UIColor colorWithWhite:0.7 alpha:0.95];
        [self.photoView addSubview:imageV];
        
        [imageV sd_setImageWithURL:[NSURL URLWithString:photoArray[i][@"url"]] placeholderImage:[UIImage imageNamed:@"加载中"]];
    }
    
    NSInteger row = photoArray.count / 2 + (photoArray.count % 2 ? 1 : 0);
    //添加了111
    [_photoView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(@(111+40 + (row * (width + 20))));
    }];
}

-(void)scanBigImageClick1:(UITapGestureRecognizer *)tap{
    NSLog(@"点击图片");
    UIImageView *clickedImageView = (UIImageView *)tap.view;
    if (clickedImageView != nil) {
       [ShowBigImage scanBigImageWithImageView:clickedImageView];
    }
}

- (void)setListArray:(NSArray *)listArray
{
    //////////123这里这里这里
    WS
    for (NSInteger i = 0; i < listArray.count; i++) {
        UIImageView * backGroundImageView;
        UIImageView * imageV;
        if (i < 3) {
            backGroundImageView = [[UIImageView alloc] init];
            [self.listView addSubview:backGroundImageView];
            [backGroundImageView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(weakSelf.listView.mas_left).with.offset(10);
                make.centerY.equalTo(weakSelf.listView.mas_top).with.offset(40 + 15 + i * 50+10*(i+1));
                make.right.mas_equalTo(weakSelf.listView.mas_right).offset(-10);
                make.height.mas_equalTo(50);
            }];
            backGroundImageView.layer.cornerRadius = 5;
            backGroundImageView.layer.masksToBounds = YES;
            backGroundImageView.backgroundColor = [UIColor colorWithHexString:@"#84cdfe"];
            
            imageV = [[UIImageView alloc] initWithImage:[UIImage imageNamed:[NSString stringWithFormat:@"number_%@", @(i)]]];
            [self.listView addSubview:imageV];
            [imageV mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(weakSelf.listView.mas_left).with.offset(25);
                make.centerY.equalTo(backGroundImageView).offset(0);
                make.size.mas_equalTo(CGSizeMake(30, 45));
            }];
        }
        if (i >= 3) {
            backGroundImageView = [[UIImageView alloc] init];
            [self.listView addSubview:backGroundImageView];
            [backGroundImageView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(weakSelf.listView.mas_left).with.offset(10);
                make.centerY.equalTo(weakSelf.listView.mas_top).with.offset(40 + 15 + 150+(i-3) * 45 + 10*(i+1));
                make.right.mas_equalTo(weakSelf.listView.mas_right).offset(-10);
                make.height.mas_equalTo(50);
            }];
            backGroundImageView.layer.cornerRadius = 5;
            backGroundImageView.layer.masksToBounds = YES;
            backGroundImageView.backgroundColor = [UIColor colorWithHexString:@"#f1f1f1"];
            
            imageV = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@""]];
            [self.listView addSubview:imageV];
            [imageV mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(weakSelf.listView.mas_left).with.offset(25);
                make.centerY.equalTo(weakSelf.listView.mas_top).with.offset(40 + 15 + i * 45);
                make.size.mas_equalTo(CGSizeMake(30, 45));
            }];
            
            UILabel *numLabel = [[UILabel alloc] init];
            [self.listView addSubview:numLabel];
            [numLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(weakSelf.listView.mas_left).with.offset(15);
                make.centerY.equalTo(backGroundImageView).offset(-5);
            }];
            numLabel.text = [NSString stringWithFormat:@"第%ld名", (long)i+1];
            numLabel.font = [UIFont systemFontOfSize:15];
            numLabel.textColor = Black464646;
        }
        
        UILabel * nameLab = [[UILabel alloc] init];
        nameLab.text = [NSString stringWithFormat:@"%@", listArray[i][@"name"]];
//        nameLab.textColor = Black464646;
        nameLab.textColor = i < 3 ? [UIColor whiteColor] : Black464646;
        nameLab.font = [UIFont systemFontOfSize:12.f];
        [self.listView addSubview:nameLab];
        [nameLab mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.left.equalTo(imageV ? imageV.mas_right : weakSelf.listView.mas_left).with.offset(imageV ? 4 : 40);
            make.centerX.equalTo(weakSelf.listView.mas_centerX).offset(-SCREEN_WIDTH/8*1-10);
            make.centerY.equalTo(backGroundImageView).offset(-5);
        }];
        
        UILabel * amountLab = [[UILabel alloc] init];
        amountLab.text = [NSString stringWithFormat:@"%@元", listArray[i][@"amount"]];
        //amountLab.textColor = i < 3 ? BlueColor : Black464646;
        amountLab.textColor = i < 3 ? [UIColor whiteColor] : Black464646;
        amountLab.font = [UIFont systemFontOfSize:12.f];
        [_listView addSubview:amountLab];
        [amountLab mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.centerX.equalTo(weakSelf.listView.mas_centerX);
            make.centerX.equalTo(weakSelf.listView.mas_centerX).offset(SCREEN_WIDTH/8*1-10+10);
            make.centerY.equalTo(nameLab.mas_centerY);
        }];
        
        
        UILabel * timeLab = [[UILabel alloc] init];
        timeLab.text = [[NSDate date] getDateValue:[listArray[i][@"creationdate"] stringValue] andFormatter:@"yyyy-MM-dd"];
//        timeLab.textColor = Black464646;
        timeLab.textColor = i < 3 ? [UIColor whiteColor] : Black464646;
        timeLab.font = [UIFont systemFontOfSize:12.f];
        [_listView addSubview:timeLab];
        [timeLab mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.centerX.equalTo(weakSelf.listView.mas_right).with.offset(-65);
            make.centerX.equalTo(weakSelf.listView.mas_centerX).offset(SCREEN_WIDTH/8*3-10+10);
            make.centerY.equalTo(nameLab.mas_centerY);
        }];
        
        UILabel * subtimeLab = [[UILabel alloc] init];
        subtimeLab.text = [[NSDate date] getDateValue:[listArray[i][@"creationdate"] stringValue] andFormatter:@"HH:mm:ss"];
//        subtimeLab.textColor = Black464646;
        subtimeLab.textColor = i < 3 ? [UIColor whiteColor] : Black464646;
        subtimeLab.font = [UIFont systemFontOfSize:11.f];
        [_listView addSubview:subtimeLab];
        [subtimeLab mas_makeConstraints:^(MASConstraintMaker *make) {
            //            make.centerX.equalTo(weakSelf.listView.mas_right).with.offset(-65);
            make.centerX.equalTo(weakSelf.listView.mas_centerX).offset(SCREEN_WIDTH/8*3-10+10);
            make.top.equalTo(timeLab.mas_bottom).offset(3);
        }];
    }
    
    [_listView mas_updateConstraints:^(MASConstraintMaker *make) {
        //添加了111
        if (listArray.count == 0) {
            make.height.mas_equalTo(@(111+40 + listArray.count * 50));
        }
        if (listArray.count == 1) {
            make.height.mas_equalTo(@(111+40 + listArray.count * 50));
        }
        if (listArray.count == 2) {
            make.height.mas_equalTo(@(111+40 + listArray.count * 50));
        }
        if (listArray.count == 3) {
            make.height.mas_equalTo(@(111+40 + listArray.count * 50));
        }
        if (listArray.count > 3) {
            make.height.mas_equalTo(@(111+40 + (listArray.count-3) * 45 + 150));
        }
    }];
}

- (void)addFooterView
{
    self.tableView.tableHeaderView = self;
}

- (void)buttonClicked:(UIButton *)button
{
    WS
    [_line mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.mas_left).with.offset(SCREEN_WIDTH / 3.f * (button.tag - 100));
    }];
    
    for (NSInteger i = 100; i < 103; i++) {
        UIButton * btn = [self viewWithTag:i];
        if (btn == button) {
            [btn setTitleColor:UIcolors forState:UIControlStateNormal];
        } else {
            [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        }
    }
    
    if (button.tag == 100) {
        _desView.hidden = NO;
        _photoView.hidden = YES;
        _listView.hidden = YES;
        
        [self layoutIfNeeded];
         //添加了111
        self.frame = CGRectMake(0, 0, SCREEN_WIDTH, 58 + _desView.frame.size.height);
    } else if (button.tag == 101) {
        _desView.hidden = YES;
        self.photoView.hidden = NO;
        _listView.hidden = YES;
         //添加了111
        [self layoutIfNeeded];
        self.frame = CGRectMake(0, 0, SCREEN_WIDTH, 58 + _photoView.frame.size.height);
    } else {
        _desView.hidden = YES;
        _photoView.hidden = YES;
        self.listView.hidden = NO;
         //添加了111
        [self layoutIfNeeded];
        self.frame = CGRectMake(0, 0, SCREEN_WIDTH, 58 + _listView.frame.size.height);
    }
    [self performSelector:@selector(addFooterView) withObject:nil afterDelay:0.001f];
    [self addFooterView];
}

@end
