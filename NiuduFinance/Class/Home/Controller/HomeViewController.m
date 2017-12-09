//
//  HomeViewController.m
//  NiuduFinance
//
//  Created by liuyong on 16/2/24.
//  Copyright © 2016年 liuyong. All rights reserved.
//

#import "HomeViewController.h"
#import "HomeTableViewCell.h"
#import "AdScrollView.h"
#import "ProjectDetailsViewController.h"
#import "DebtDetailsViewController.h"
#import "ReflectUtil.h"
#import "ProjectModel.h"
#import "AppDelegate.h"
#import "NSString+Adding.h"
#import "ProjectNewTableViewCell.h"
#import "SDCycleScrollView.h"
#import "PageWebViewController.h"
#import "ProjectViewController.h"

#import "WebAnnouncementViewController.h"
#import "MoreWebViewController.h"

#import "SNProjectListModel.h"
#import "SNDebtListModel.h"
#import "SNHomeProjecCell.h"
#import "InvitationFriendsController.h"
#import "IntegralViewController.h"
#import "XExperiencCell.h"
#import "ProjectProgressView.h"
#import "ExperienceDetailsController.h"
#import "SNProjectListItem.h"
#import "XProjectDetailsController.h"
//福利金详情
#import "WelfareViewController.h"
@interface HomeViewController ()<UITableViewDataSource,UITableViewDelegate,SDCycleScrollViewDelegate>

//底部tableview
@property (weak, nonatomic) IBOutlet UITableView *homeTableView;
//头部view
@property (strong, nonatomic) IBOutlet UIView *headerTableView;
//头部view的最底下
@property (weak, nonatomic) IBOutlet UIView *bottonView;
//头部view的图片view
@property (weak, nonatomic) IBOutlet UIView *headerView;
//banner图片数组
@property (nonatomic,strong)NSMutableArray *bannerImageArr;
@property (nonatomic,strong)NSMutableArray *recProductArr;
//为了换散标
@property (nonatomic,strong)NSMutableArray *recSanArr;
@property (nonatomic,strong)NSArray * imageNewArr;
//三个button新手专享/散标投资/债权转让
//静
@property (weak, nonatomic) IBOutlet UILabel *lineLabel;
//牛伯伯记文章view
@property (weak, nonatomic) IBOutlet UIView *articleView;
@property (strong, nonatomic) IBOutlet UIView *tailTableView;
@property (strong, nonatomic) IBOutlet UIView *tialBottomView;
@property (nonatomic,strong) UILabel * titleNiu;
@property (nonatomic, assign) NSInteger type;  //  0 1 2 分别为新手专享,散标投资,债权转让
@property (nonatomic, strong) SNProjectListModel * projectModel;
@property (nonatomic, strong) SNProjectListModel * newLenderProjectModel;
@property (nonatomic, strong) SNDebtListModel    * debtModel;

//最新公告
@property (nonatomic, strong) UIView * firstView;
@property (nonatomic, strong) UIImageView * imageView1;
@property (nonatomic, strong) UILabel * textLabel;
@property (nonatomic, strong) UIView * twoView;
@property (nonatomic, strong) UIView * view2;
@property (nonatomic, strong) UIView * view3;
@property (nonatomic, strong) UIView * view4;
@property (nonatomic, strong) UIImageView * imageView2;
@property (nonatomic, strong) UIImageView * imageView3;
@property (nonatomic, strong) UIImageView * imageView4;
@property (nonatomic, strong) UILabel * label2;
@property (nonatomic, strong) UILabel * label3;
@property (nonatomic, strong) UILabel * label4;
//新手专享
@property (nonatomic, strong) UIView * threeView;
@property (nonatomic, strong) UILabel * label5;
@property (nonatomic, strong) UILabel * label6;
@property (nonatomic, strong) UILabel * label7;
@property (nonatomic, strong) UIImageView * imageView5;
@property (nonatomic, strong) UIImageView * imageView6;
@property (nonatomic, strong) UIButton * button1;

@property (nonatomic, strong) UIView * view5;
@property (nonatomic, strong) UIView * view6;
@property (nonatomic, strong) UIView * view7;
@property (nonatomic, strong) UIView * view8;
@property (nonatomic, strong) UIImageView * imageView7;
@property (nonatomic, strong) UIImageView * imageView8;
@property (nonatomic, strong) UIImageView * imageView9;
@property (nonatomic, strong) UIImageView * imageView10;
@property (nonatomic, strong) UILabel * label8;
@property (nonatomic, strong) UILabel * label9;
@property (nonatomic, strong) UILabel * label10;
@property (nonatomic, strong) UILabel * label11;
@property (nonatomic,strong)NSMutableArray * snArr;
@property (nonatomic,strong)NSMutableArray * sbArr;

//牛气分享标
@property (nonatomic, strong) UILabel * label12;
@property (nonatomic, strong) UILabel * label13;

@property (nonatomic,strong)NSDictionary * experienceDic;
@property (nonatomic,strong)NSString *  titlStr;
@property (nonatomic, strong)NSDictionary * myRewardDic;
@property (nonatomic,strong)NSMutableArray * data;

@property (nonatomic,strong)NSString * fljStr;
@property (nonatomic,assign)int noNew;
@end

@implementation HomeViewController

- (SNProjectListModel *)projectModel
{
    if (!_projectModel) {
        _projectModel = [SNProjectListModel new];
        _projectModel.key = @"__SNProjectListModel__";
        _projectModel.requestType = VZModelCustom;
        _projectModel.isHome = YES;
        _projectModel.isNewLender = NO;
    }
    return _projectModel;
}

- (SNProjectListModel *)newLenderProjectModel
{
    if (!_newLenderProjectModel) {
        _newLenderProjectModel = [SNProjectListModel new];
        _newLenderProjectModel.key = @"__SNProjectListModel__";
        _newLenderProjectModel.requestType = VZModelCustom;
        _newLenderProjectModel.isHome = YES;
        _newLenderProjectModel.isNewLender = YES;
    }
    return _newLenderProjectModel;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupTableView];
    _snArr = [NSMutableArray array];
    _sbArr = [NSMutableArray array];
    _experienceDic = [NSDictionary dictionary];
    _myRewardDic = [NSDictionary dictionary];
    _data = [NSMutableArray array];


    _bannerImageArr = [NSMutableArray array];
    _imageNewArr = [NSArray array];
    _recProductArr = [NSMutableArray array];
    _recSanArr = [NSMutableArray array];
    self.homeTableView.showsVerticalScrollIndicator = NO;

    _firstView = [UIView new];
    [_firstView setBackgroundColor:[UIColor colorWithHexString:@"#D7E9F6"]];
    [_homeTableView addSubview:_firstView];
    [_firstView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_headerTableView.mas_bottom);
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH, 30));
    }];
    
    _imageView1 = [UIImageView new];
    UIImage * image1 = [UIImage imageNamed:@"gg.png"];
    _imageView1.image = image1;
    [_firstView addSubview:_imageView1];
    [_imageView1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(0);
        make.left.mas_equalTo(15);
        make.size.mas_equalTo(CGSizeMake(20, 14));
    }];
    
    _textLabel = [UILabel new];
    [_textLabel setFont:[UIFont systemFontOfSize:13]];
    [_firstView addSubview:_textLabel];
    [_textLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(0);
        make.left.equalTo(_imageView1.mas_right).with.offset(15);
    }];
    UITapGestureRecognizer * textLabelNew=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(textLabelNew)];
    _textLabel.userInteractionEnabled = YES;
    [_textLabel addGestureRecognizer:textLabelNew];
    
    _twoView = [UIView new];
    [_twoView setBackgroundColor:[UIColor whiteColor]];
    [_homeTableView addSubview:_twoView];
    [_twoView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_firstView.mas_bottom);
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH, 100));
    }];
    
    
    _view2 = [UIView new];
    [_view2 setBackgroundColor:[UIColor whiteColor]];
    UITapGestureRecognizer * tagImage2=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapPage2)];
    [_view2 addGestureRecognizer:tagImage2];
    [_twoView addSubview:_view2];
    [_view2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(37);
        make.top.mas_equalTo(0);
        make.size.mas_equalTo(CGSizeMake(53, 100));
    }];
    
    _view3 = [UIView new];
    [_view3 setBackgroundColor:[UIColor whiteColor]];
    UITapGestureRecognizer * tagImage3=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapPage3)];
    [_view3 addGestureRecognizer:tagImage3];
    [_twoView addSubview:_view3];
    [_view3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(0);
        make.top.mas_equalTo(0);
        make.size.mas_equalTo(CGSizeMake(53, 100));
    }];
    
    
    _view4 = [UIView new];
    [_view4 setBackgroundColor:[UIColor whiteColor]];
    UITapGestureRecognizer * tagImage4=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapPage4)];
    [_view4 addGestureRecognizer:tagImage4];
    [_twoView addSubview:_view4];
    [_view4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-37);
        make.top.mas_equalTo(0);
        make.size.mas_equalTo(CGSizeMake(53, 100));
    }];
    
    
    _imageView2 = [UIImageView new];
    UIImage * image2 = [UIImage imageNamed:@"qd.png"];
    _imageView2.image = image2;
    [_view2 addSubview:_imageView2];
    [_imageView2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(14);
        make.left.mas_equalTo(0);
        make.size.mas_equalTo(CGSizeMake(53, 53));
    }];
    
    _imageView3 = [UIImageView new];
    UIImage * image3 = [UIImage imageNamed:@"tjj.png"];
    _imageView3.image = image3;
    [_view3 addSubview:_imageView3];
    [_imageView3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(0);
        make.top.mas_equalTo(14);
        make.size.mas_equalTo(CGSizeMake(53, 53));
    }];

    _imageView4 = [UIImageView new];
    UIImage * image4 = [UIImage imageNamed:@"zx.png"];
    _imageView4.image = image4;
    [_view4 addSubview:_imageView4];
    [_imageView4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(14);
        make.right.mas_equalTo(0);
        make.size.mas_equalTo(CGSizeMake(53, 53));
    }];
    
    _label2 = [UILabel new];
    [_label2 setText:@"每日签到"];
    [_label2 setFont:[UIFont systemFontOfSize:12]];
    [_twoView addSubview:_label2];
    [_label2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_imageView2.mas_bottom).with.offset(8);
        make.centerX.equalTo(_imageView2.mas_centerX);
        make.height.mas_equalTo(12);
    }];
    
    _label3 = [UILabel new];
    [_label3 setText:@"推拿荐奖"];
    [_label3 setFont:[UIFont systemFontOfSize:12]];
    [_twoView addSubview:_label3];
    [_label3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_imageView3.mas_bottom).with.offset(8);
        make.centerX.equalTo(_imageView3.mas_centerX);
        make.height.mas_equalTo(12);
    }];
    _label4 = [UILabel new];
    [_label4 setText:@"最新活动"];
    [_label4 setFont:[UIFont systemFontOfSize:12]];
    [_twoView addSubview:_label4];
    [_label4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_imageView4.mas_bottom).with.offset(8);
        make.centerX.equalTo(_imageView4.mas_centerX);
        make.height.mas_equalTo(12);
    }];


    _threeView = [UIView new];
    [_threeView setBackgroundColor:[UIColor whiteColor]];
    [_homeTableView addSubview:_threeView];
    [_threeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_twoView.mas_bottom).with.offset(5);
        make.size.mas_equalTo (CGSizeMake(SCREEN_WIDTH, 227));
    }];

    _label5 = [UILabel new];
    [_label5 setText:@"新 手 专 享"];
    [_label5 setFont:[UIFont systemFontOfSize:15]];
    [_threeView addSubview:_label5];
    [_label5 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(15);
        make.centerX.mas_equalTo(0);
        make.height.mas_equalTo(15);
    }];
    
    _label6 = [UILabel new];
    [_label6 setText:@"0.00%"];
    [_label6 setTextColor:[UIColor redColor]];
    [_label6 setFont:[UIFont systemFontOfSize:34]];
    [_threeView addSubview:_label6];
    [_label6 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_label5.mas_bottom).with.offset(33);
        make.centerX.mas_equalTo(0);
        make.height.mas_equalTo(27);
    }];
    


    _label7 = [UILabel new];
    [_label7 setText:@"预期年化"];
    [_label7 setFont:[UIFont systemFontOfSize:10]];
    [_threeView addSubview:_label7];
    [_label7 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_label6.mas_bottom).with.offset(9);
        make.centerX.mas_equalTo(0);
        make.height.mas_equalTo(10);
    }];
    _imageView5 = [UIImageView new];
    UIImage * image5 = [UIImage imageNamed:@"hj.png"];
    _imageView5.image = image5;
    [_threeView addSubview:_imageView5];
    [_imageView5 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_label6.mas_right);
        make.bottom.mas_equalTo(_label6.mas_top);
        make.size.mas_equalTo(CGSizeMake(18, 18));
    }];
    _imageView6 = [UIImageView new];
    UIImage * image6 = [UIImage imageNamed:@"dxian.png"];
    _imageView6.image = image6;
    [_threeView addSubview:_imageView6];
    [_imageView6 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_label7.mas_bottom).with.offset(15);
        make.left.mas_equalTo(15);
        make.right.mas_equalTo(-15);
        make.height.mas_equalTo(1);
    }];
    
    _button1 = [UIButton new];
    _button1.layer.cornerRadius = 16.0f;
    _button1.clipsToBounds = YES;
    [_button1.layer setBorderWidth:1];
    _button1.layer.borderColor = [UIColor colorWithHexString:@"#019BFF"].CGColor;
    _button1.titleLabel.font = [UIFont systemFontOfSize:14];
    _button1.titleLabel.textAlignment = NSTextAlignmentCenter;
    [_button1 setTitle:@"马 上 抢 购" forState:UIControlStateNormal];
    [_button1 setTitleColor:[UIColor colorWithHexString:@"#019BFF"] forState:UIControlStateNormal];
    [_button1 setBackgroundColor:[UIColor whiteColor]];
    [_button1 addTarget:self action:@selector(touBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [_threeView addSubview:_button1];
    [_button1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_imageView6.mas_bottom).with.offset(18);
        make.centerX.mas_equalTo(0);
        make.left.mas_equalTo(30);
        make.right.mas_equalTo(-30);
        make.height.mas_equalTo(38);
    }];

    
    _view5 = [UIView new];
    [_view5 setBackgroundColor:[UIColor whiteColor]];
    [_threeView addSubview:_view5];
    [_view5 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_button1.mas_bottom).with.offset(20);
        make.centerX.equalTo(_threeView.mas_left).with.offset(SCREEN_WIDTH/5);
        make.size.mas_equalTo(CGSizeMake(59, 14));
    }];
    
    _imageView7= [UIImageView new];
    UIImage * image7 = [UIImage imageNamed:@"mx.png"];
    _imageView7.image = image7;
    [_view5 addSubview:_imageView7];
    [_imageView7 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(0);
        make.size.mas_equalTo(CGSizeMake(12, 12));
        make.left.equalTo(_view5.mas_left);
    }];
    
    _label8 = [UILabel new];
    [_label8 setText:@"满标计息"];
    [_label8 setFont:[UIFont systemFontOfSize:10]];
    [_view5 addSubview:_label8];
    [_label8 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_imageView7.mas_right).with.offset(6);
        make.centerY.mas_equalTo(0);
        make.height.mas_equalTo(10);
    }];
    
    _view6 = [UIView new];
    [_view6 setBackgroundColor:[UIColor whiteColor]];
    [_threeView addSubview:_view6];
    [_view6 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_button1.mas_bottom).with.offset(20);
        make.centerX.equalTo(_threeView.mas_left).with.offset(SCREEN_WIDTH/5*2);
        make.size.mas_equalTo(CGSizeMake(59, 14));
    }];
    
    _imageView8= [UIImageView new];
    UIImage * image8 = [UIImage imageNamed:@"bx.png"];
    _imageView8.image = image8;
    [_view6 addSubview:_imageView8];
    [_imageView8 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(0);
        make.size.mas_equalTo(CGSizeMake(12, 12));
        make.left.equalTo(_view6.mas_left);
    }];
    
    _label9 = [UILabel new];
    [_label9 setText:@"本息安心"];
    [_label9 setFont:[UIFont systemFontOfSize:10]];
    [_view6 addSubview:_label9];
    [_label9 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_imageView8.mas_right).with.offset(6);
        make.centerY.mas_equalTo(0);
        make.height.mas_equalTo(10);
    }];
    
    _view7 = [UIView new];
    [_view7 setBackgroundColor:[UIColor whiteColor]];
    [_threeView addSubview:_view7];
    [_view7 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_button1.mas_bottom).with.offset(20);
        make.centerX.equalTo(_threeView.mas_left).with.offset(SCREEN_WIDTH/5*3);
        make.size.mas_equalTo(CGSizeMake(59, 14));
    }];
    
    _imageView9= [UIImageView new];
    UIImage * image9 = [UIImage imageNamed:@"wz.png"];
    _imageView9.image = image9;
    [_view7 addSubview:_imageView9];
    [_imageView9 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(0);
        make.size.mas_equalTo(CGSizeMake(12, 12));
        make.left.equalTo(_view7.mas_left);
    }];
    
    _label10 = [UILabel new];
    [_label10 setText:@"本息安心"];
    [_label10 setFont:[UIFont systemFontOfSize:10]];
    [_view7 addSubview:_label10];
    [_label10 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_imageView9.mas_right).with.offset(6);
        make.centerY.mas_equalTo(0);
        make.height.mas_equalTo(10);
    }];
    
    _view8 = [UIView new];
    [_view8 setBackgroundColor:[UIColor whiteColor]];
    [_threeView addSubview:_view8];
    [_view8 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_button1.mas_bottom).with.offset(20);
        make.centerX.equalTo(_threeView.mas_left).with.offset(SCREEN_WIDTH/5*4);
        make.size.mas_equalTo(CGSizeMake(59, 14));
    }];
    
    
    _imageView10= [UIImageView new];
    UIImage * image10 = [UIImage imageNamed:@"hg.png"];
    _imageView10.image = image10;
    [_view8 addSubview:_imageView10];
    [_imageView10 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(0);
        make.size.mas_equalTo(CGSizeMake(12, 12));
        make.left.equalTo(_view8.mas_left);
    }];
    
    _label10 = [UILabel new];
    [_label10 setText:@"合规透明"];
    [_label10 setFont:[UIFont systemFontOfSize:10]];
    [_view8 addSubview:_label10];
    [_label10 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_imageView10.mas_right).with.offset(6);
        make.centerY.mas_equalTo(0);
        make.height.mas_equalTo(10);
    }];
    
    _label12 = [UILabel new];
    [_label12 setFont:[UIFont systemFontOfSize:10]];
    [_label12 setBackgroundColor:[UIColor colorWithHexString:@"#0096FF"]];
    [_homeTableView addSubview:_label12];
    [_label12 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_threeView.mas_bottom).with.offset(11);
        make.left.mas_equalTo(15);
        make.size.mas_equalTo(CGSizeMake(4, 13));
    }];
    
    _label13 = [UILabel new];
    [_label13 setText:@"牛气分享标"];
    [_label13 setFont:[UIFont systemFontOfSize:15]];
    [_homeTableView addSubview:_label13];
    [_label13 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_label12.mas_centerY);
        make.left.equalTo(_label12.mas_right).with.offset(8);
        make.height.mas_equalTo(15);
    }];
    self.type = 0;
    WS
    [self.newLenderProjectModel loadWithCompletion:^(VZModel *model, NSError *error) {
        if (!error && weakSelf.newLenderProjectModel.objects.count) {
            [weakSelf.recProductArr addObject:weakSelf.newLenderProjectModel.objects[0]];
            [weakSelf.homeTableView reloadData];
        }
    }];
    [self.projectModel loadWithCompletion:^(VZModel *model, NSError *error) {
        if (!error && weakSelf.projectModel.objects.count) {
            [weakSelf.recSanArr addObject:weakSelf.projectModel.objects[0]];
            [weakSelf.homeTableView reloadData];
        }
    }];

    [self.newLenderProjectModel loadWithCompletion:nil];
    [self.projectModel loadWithCompletion:nil];

    [self.tialBottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(weakSelf.tailTableView);
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH, 30));
    }];
    [self getSanBiao];
    [self getExperience];
    [self getAll];
    [self getExper];
    [self getWelfarePayments];
    [self getNewAccment];

}
- (void)getNewAccment
{
    [self.httpUtil requestDic4MethodNam:@"v2/open/affiche/findAll" parameters:@{@"start":@(0),@"limit":@(1)} result:^(id dic, int status, NSString *msg) {
        
        if (status == 0) {
            [MBProgressHUD showMessag:msg toView:self.view];
            
        }else{
            [_data addObjectsFromArray:dic];
            
            if (_data != nil && [_data count]>0) {
                NSLog(@"%@",_data[0]);
                
                NSString * title = [_data [0]objectForKey:@"title"];
                NSLog(@"%@",title);
//                [_titleBtn setTitle:title forState:UIControlStateNormal];
                [_textLabel setText:title];
                NSLog(@"%@",_textLabel);
                
                NSInteger k = [[_data [0]objectForKey:@"newsinformationid"] integerValue];
                _textLabel.tag = k;
                
                NSLog(@"%@",[_data [0]objectForKey:@"newsinformationid"]);
                NSLog(@"%ld",_textLabel.tag);
            }
        }
    }];
}
- (void)textLabelNew
{
    NSString *string = [[NSString alloc] initWithFormat:@"%ld",_textLabel.tag];
    NSLog(@"%@",string);
    NSString * srtt = [[[NSMutableString stringWithString:@""]stringByAppendingString:@"v2/open/appAfficheDetail.jsp?id=" ]stringByAppendingString:string];
    
    NSLog(@"%@",srtt);
    MoreWebViewController * moreWebVC = [MoreWebViewController new];
    moreWebVC.titleStr = @"最新公告";
    moreWebVC.webStr = srtt;
    NSLog(@"%@",moreWebVC.webStr);
    [self.navigationController pushViewController:moreWebVC animated:YES];
}

-(void)tapPage2
{
    NSLog(@"2");
    if ([[User userFromFile].isOpenAccount integerValue] == 0 ) {
        return;
    }else{
    IntegralViewController * integralVC = [IntegralViewController new];
    [self.navigationController pushViewController:integralVC animated:YES];
    }
}
-(void)tapPage3
{
    NSLog(@"3");
    if ([[User userFromFile].isOpenAccount integerValue] == 0 ) {
        return;
    }else{
        //NSString * srtt = [[NSMutableString stringWithString:@""]stringByAppendingString:@"v2/accept/account/appinvitereward.jsp" ];
        //MoreWebViewController * moreWebVC = [MoreWebViewController new];
        //moreWebVC.titleStr = @"拿推荐奖";
        //moreWebVC.webStr = srtt ;
        //NSLog(@"%@",moreWebVC.webStr);
        //[self.navigationController pushViewController:moreWebVC animated:YES];
        InvitationFriendsController * invitationVC = [InvitationFriendsController new];
        [self.navigationController pushViewController:invitationVC animated:YES];
    }
}
-(void)tapPage4
{
    NSLog(@"4");
    NSString * srtt = [[NSMutableString stringWithString:@""]stringByAppendingString:@"v2/open/activity.jsp" ];
    MoreWebViewController * moreWebVC = [MoreWebViewController new];
    moreWebVC.titleStr = @"最新活动";
    moreWebVC.webStr = srtt ;
    NSLog(@"%@",moreWebVC.webStr);
    [self.navigationController pushViewController:moreWebVC animated:YES];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:animated];
    if (self.hideNoNetWork == NO) {
        [self getHomeData];
        [self getImageUrl];
    }
    [self getSanBiao];
    [self getExper];

}

- (void)setupTableView
{
    self.homeTableView.tableHeaderView = self.headerTableView;
    self.homeTableView.tableFooterView = self.tailTableView;
    [self getExper];
    //首页下拉刷新
    [self setupRefreshWithTableView:_homeTableView];
}

//散标投资
- (void)getSanBiao
{
    
    [self.httpUtil requestDic4MethodNam:@"v2/open/project/list" parameters:@{@"limit":@(1),@"isNewLender":@(0),@"start":@(0)} result:^(id dic, int status, NSString *msg) {
        if (status == 0) {
        }else{
            [_sbArr addObjectsFromArray:dic];
            if (_sbArr.count == 0) {
                return ;
            }
            
            NSLog(@"%@",_label6.text);
            [_homeTableView.mj_footer resetNoMoreData];
        }
        
        
        }];
}

//我的资产
- (void)getAll{
//    if (![AppDelegate checkLogin]){
//    }else{
        [self.httpUtil requestDic4MethodNam:@"v2/accept/user/getUserInfo" parameters:nil result:^(NSDictionary *dic, int status, NSString *msg) {
            NSLog(@"%@",dic);
            if (status == 0) {
                
            }else{
                //1是新手 0不是
                NSString * styStr = [NSString stringWithFormat:@"%@",[dic objectForKey:@"isNewer"]];
                _noNew = [styStr intValue];
                if (_noNew == 1) {
                    if (_snArr.count == 0) {
                        return ;
                    }
                    _label5.text = @"新 手 专 享";
                    NSString * sst = [NSString stringWithFormat:@"%@",[_snArr[0] objectForKey:@"rate"]];
                    _label6.text = [[NSString stringWithFormat:@"%.2f",[sst floatValue]] stringByAppendingString:@"%"];
                }else{
  
                    if (_sbArr.count == 0) {
                        return ;
                    }
                    _label5.text = @"散 标 投 资";
                    NSString * sst = [NSString stringWithFormat:@"%@",[_sbArr[0] objectForKey:@"rate"]];
                    _label6.text = [[NSString stringWithFormat:@"%.2f",[sst floatValue]] stringByAppendingString:@"%"];
                    
                }
            }
            
        }];
//    }
}
//新手专享
- (void)getExperience
{
    
    [self.httpUtil requestArr4MethodNam:@"v2/open/project/list" parameters:@{@"start":@(0),@"limit":@(1),@"isNewLender":@(1)} result:^(NSArray *arr, int status, NSString *msg) {
        if (status == 0) {
        }else{
            [_snArr addObjectsFromArray:arr];
            if (_snArr.count == 0) {
                return ;
            }
            
            NSString * sst = [NSString stringWithFormat:@"%@",[_snArr[0] objectForKey:@"rate"]];
            _label6.text = [[NSString stringWithFormat:@"%.2f",[sst floatValue]] stringByAppendingString:@"%"];

            NSLog(@"%@",_label6.text);
            [_homeTableView.mj_footer resetNoMoreData];
        }
        
    } convertClassName:nil key:nil];
    
}

- (void)touBtnClick:(UIButton *)btn
{
    if (![AppDelegate checkLogin]) return;
    
//    self.type = 0;
    
       //如果没有登录
    if (![AppDelegate checkLogin]) {
        if (_newLenderProjectModel.objects.count) {
            [self.recProductArr addObject:self.newLenderProjectModel.objects[0]];
        } else {
            WS
            [self.newLenderProjectModel loadWithCompletion:^(VZModel *model, NSError *error) {
                if (!error && weakSelf.newLenderProjectModel.objects.count) {
                    [weakSelf.recProductArr addObject:weakSelf.newLenderProjectModel.objects[0]];
                    [weakSelf.homeTableView reloadData];
                } else {
                    
                }
            }];
        }
        SNProjectListItem * projectItem = _recProductArr[btn.tag];
        self.hidesBottomBarWhenPushed=YES;
        //    ProjectDetailsViewController * projectDetailsVC = [ProjectDetailsViewController new];
        XProjectDetailsController * projectDetailsVC = [XProjectDetailsController new];
        projectDetailsVC.projectId = projectItem.projectId.intValue;
        projectDetailsVC.projectItem = projectItem;
        [self.navigationController pushViewController:projectDetailsVC animated:YES];
        self.hidesBottomBarWhenPushed=NO;

    }else{
        if (_noNew == 1) {
            if (_newLenderProjectModel.objects.count) {
                [self.recProductArr addObject:self.newLenderProjectModel.objects[0]];
            } else {
                WS
                [self.newLenderProjectModel loadWithCompletion:^(VZModel *model, NSError *error) {
                    if (!error && weakSelf.newLenderProjectModel.objects.count) {
                        [weakSelf.recProductArr addObject:weakSelf.newLenderProjectModel.objects[0]];
                        [weakSelf.homeTableView reloadData];
                    } else {
                        
                    }
                }];
            }
            SNProjectListItem * projectItem = _recProductArr[btn.tag];
            self.hidesBottomBarWhenPushed=YES;
            //    ProjectDetailsViewController * projectDetailsVC = [ProjectDetailsViewController new];
            XProjectDetailsController * projectDetailsVC = [XProjectDetailsController new];
            projectDetailsVC.projectId = projectItem.projectId.intValue;
            projectDetailsVC.projectItem = projectItem;
            [self.navigationController pushViewController:projectDetailsVC animated:YES];
            self.hidesBottomBarWhenPushed=NO;
        }else{
            if (_projectModel.objects.count) {
                [self.recSanArr addObject:self.projectModel.objects[0]];
            } else {
                WS
                [self.projectModel loadWithCompletion:^(VZModel *model, NSError *error) {
                    if (!error && weakSelf.projectModel.objects.count) {
                        [weakSelf.recSanArr addObject:weakSelf.projectModel.objects[0]];
                        [weakSelf.homeTableView reloadData];
                    } else {
                        
                    }
                }];
            }
            SNProjectListItem * projectItem = _recSanArr[btn.tag];
            self.hidesBottomBarWhenPushed=YES;
            //    ProjectDetailsViewController * projectDetailsVC = [ProjectDetailsViewController new];
            XProjectDetailsController * projectDetailsVC = [XProjectDetailsController new];
            projectDetailsVC.projectId = projectItem.projectId.intValue;
            projectDetailsVC.projectItem = projectItem;
            [self.navigationController pushViewController:projectDetailsVC animated:YES];
            self.hidesBottomBarWhenPushed=NO;
        }

    }
    
}
- (void)getHomeData
{
    MBProgressHUD *hud = [MBProgressHUD showStatus:nil toView:self.view];
    [self.httpUtil requestDic4MethodName:@"home/index" parameters:nil result:^(NSDictionary *dic, int status, NSString *msg) {
        if (status == 1 || status == 2) {
            
            [hud hide:YES];
            self.hideNoNetWork = YES;
        }else{
//刷新
            [hud dismissErrorStatusString:msg hideAfterDelay:1.0];
            self.hideNoNetWork = NO;
        }
        [_homeTableView reloadData];
    }];
}

- (void)getImageUrl
{

    [self.httpUtil requestArr4MethodNam:@"v2/open/ad/findAll" parameters:nil result:^(NSArray *arr, int status, NSString *msg) {
        NSLog(@"%@",arr);
        _imageNewArr = arr;

        if (status == 0) {
            [MBProgressHUD showMessag:msg toView:self.view];
            self.hideNoNetWork = NO;
        }else{

            NSMutableArray *imageUrlArr = [NSMutableArray array];
            for (NSDictionary *dict in _imageNewArr) {
               [imageUrlArr addObject:[dict objectForKey:@"imageurl"]];
            }
            SDCycleScrollView *autoScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0.0, 0.0,SCREEN_WIDTH, 215.0) imageURLStringsGroup:imageUrlArr];
            autoScrollView.delegate = self;
            [_headerView addSubview:autoScrollView];
        }

        [_homeTableView reloadData];

    } convertClassName:nil key:nil];
    
}
//我的福利金
- (void)getWelfarePayments
{
    //做登录的判断   不弹出登录页面
    if (![AppDelegate checkLoginNew])
    {
        _fljStr = @"福利金为0元";
    }

    NetWorkingUtil *util = [NetWorkingUtil netWorkingUtil];
    [util requestDic4MethodNam:@"v2/accept/account/getUserAssetInfo" parameters:nil result:^(NSDictionary *dic, int status, NSString *msg) {
        NSLog(@"%@",dic);
        _myRewardDic = dic;
        
        if (status == 0) {
            [MBProgressHUD showMessag:msg toView:self.view];
        }else{
            _fljStr = [NSString stringWithFormat:@"我的福利金%@元",[_myRewardDic objectForKey:@"welfareFund"]];
        }
        [self.homeTableView reloadData];
    }];
}
//体验金
- (void)getExper
{
    [self.httpUtil requestDic4MethodNam:@"v2/open/project/welfareFind" parameters:nil result:^(NSDictionary *dic, int status, NSString *msg) {
        NSLog(@"%@",dic);
        if (status == 0) {
        }else{
            _experienceDic = dic;
            _titlStr = [NSString stringWithFormat:@"%@",[_experienceDic objectForKey:@"title"]];
            [_homeTableView.mj_footer resetNoMoreData];

        }
        [_homeTableView reloadData];
        
    }];

}
//返回有多少个Sections
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
//    if (!IsStrEmpty(_titlStr)) {
//        return 1;
//    }else
    
        return 1;
}
//对应的section有多少个元素，也就是多少行
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
//    if (!IsStrEmpty(_titlStr)) {
//        return 1;
//    }else
        return 1;

}
//指定的 row 的高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 160;
}
//section的header view 的高度
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 5+30+100+5+227+30;
}

//section的footer view 的高度
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString  *cellId = @"XExperiencCell";
    XExperiencCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (cell ==nil) {
        cell = [[XExperiencCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    cell.selectionStyle = UITableViewScrollPositionNone;
    
    NSString * title;
    NSString * tulabel;
    BOOL  hideImage;
    NSString * cast;
    BOOL  lineView;
    NSString * annual;
    NSString * annualNum;
    NSString * percent;
    NSString * timeLimit;
    NSString * timeLimitNum;
    NSString * timeLabel;
    NSString * touLabl;
    NSString * remain;
    NSString * progressLabel;
    NSString * sss;


    cast = [NSString stringWithFormat:@"%@元",[_experienceDic objectForKey:@"minbidamount"]];
    timeLimitNum = [NSString stringWithFormat:@"%@",[_experienceDic objectForKey:@"loanperiod"]];
    timeLabel = [NSString stringWithFormat:@"%@",[_experienceDic objectForKey:@"periodtypeidName"]];
    sss= [NSString stringWithFormat:@"%@",[_experienceDic objectForKey:@"statusid"]];
    annualNum = [NSString stringWithFormat:@"%@",[_experienceDic objectForKey:@"rate"]];

    title = _fljStr;
    tulabel = @"国资出品";
    hideImage = YES;
    lineView = NO;
    annual = @"预期年化";
    percent = @"%";
    timeLimit = @"投资期限";
    if ([sss isEqualToString:@"2"]) {
        touLabl = @"立即投资";
    }else{
        touLabl = @"已结束";
    }
    UITapGestureRecognizer *tapGesture=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(event:)];
    [cell.touLabl addGestureRecognizer:tapGesture];
    cell.touLabl.userInteractionEnabled = YES;

    remain = [NSString stringWithFormat:@"剩余可投:%@元",[_experienceDic objectForKey:@"remainamount"]];

//    NSString * sst = [NSString stringWithFormat:@"进度:%@",[_experienceDic objectForKey:@"process"]];
//    progressLabel = [NSString stringWithFormat:@"%@%@",sst,@"%"];
    progressLabel = @"起投金额";
    NSLog(@"%@",progressLabel);
    [cell setuptitle:title tulabel:nil imgeView:hideImage castLabel:cast lineView:lineView annual:annual annualNum:annualNum percent:percent timeLimit:timeLimit timeLimitNum:timeLimitNum timeLabel:timeLabel touLabl:touLabl remain:nil progressLabel:progressLabel];
    return cell;
}
-(void)event:(UITapGestureRecognizer *)recognizer
{
    if (![AppDelegate checkLogin]) return;
    NSString * sss = [NSString stringWithFormat:@"%@",[_experienceDic objectForKey:@"statusid"]];
    if ([sss isEqualToString:@"2"]) {
//        ExperienceDetailsController * vc = [ExperienceDetailsController new];
//        [self.navigationController pushViewController:vc animated:YES];
        self.hidesBottomBarWhenPushed=YES;
        WelfareViewController * vc = [WelfareViewController new];
        [self.navigationController pushViewController:vc animated:YES];
        self.hidesBottomBarWhenPushed=NO;
    }else{
        
    }
}
//跳转投资页面
//- (void)skipBtnClick
//{
//    self.tabBarController.selectedIndex = 1;
//    
//    UINavigationController * naVC = self.tabBarController.viewControllers[1];
//    ProjectViewController * projectVC = (ProjectViewController *)naVC.viewControllers[0];
//    [projectVC didSelectItemViewAtIndex:self.type];
//}

- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index{
    NSLog(@"%@",[_imageNewArr[index] objectForKey:@"url"]);
    
    if (!IsStrEmpty([_imageNewArr[index] objectForKey:@"url"])) {
        
        PageWebViewController *pageWebVC = [PageWebViewController new];
        pageWebVC.urlStr = [_imageNewArr[index] objectForKey:@"url"];
        pageWebVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:pageWebVC animated:YES];
    }
}



- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    self.hideNaviBar = NO;
    
}


- (void)headerRefreshloadData
{
    [self getSanBiao];
    [self getAll];
    [self getExper];
    [_homeTableView.mj_header endRefreshing];
}
- (void)footerRefreshloadData
{
    [self getExper];
    [_homeTableView.mj_footer endRefreshing];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
