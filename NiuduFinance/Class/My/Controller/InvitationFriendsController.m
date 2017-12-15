//
//  InvitationFriendsController.m
//  NiuduFinance
//
//  Created by 123 on 17/3/20.
//  Copyright © 2017年 liuyong. All rights reserved.
//

#import "InvitationFriendsController.h"
#import "InvitationFriendsViewCell.h"
#import "ApplyrRorReward.h"
#import "RewardRetailsVC.h"
#import "NetWorkingUtil.h"
#import "MoreWebViewController.h"

//友盟
#import <UShareUI/UShareUI.h>

@interface InvitationFriendsController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) UIView * firstView;
@property (nonatomic, strong) UILabel * dearLabel;
@property (nonatomic, strong) UILabel * wenlabel;
@property (nonatomic, strong) UILabel * invitaLabel;
@property (nonatomic, strong) UIImageView * imageView;
@property (nonatomic, strong) UIView * twoView;
@property (nonatomic, strong) UILabel * prizeLabel;
@property (nonatomic, strong) UIButton * rulesBtn;
@property (nonatomic, strong) UIImageView * imageView1;
@property (nonatomic, strong) UIImageView * imageView2;
@property (nonatomic, strong) UIImageView * imageView3;
@property (nonatomic, strong) UILabel * label1;
@property (nonatomic, strong) UILabel * label2;
@property (nonatomic, strong) UILabel * label3;


@property (nonatomic, strong) UIView * threeView;
@property (nonatomic, strong) UILabel * myReward;

@property (nonatomic, strong) UILabel * phoneLabel;
@property (nonatomic, strong) UILabel * timeLabel;
@property (nonatomic, strong) UILabel * amountLabel;
@property (nonatomic, strong) UILabel * rewardLabel;
//
@property (nonatomic,assign)NSInteger start;
@property (nonatomic,assign)NSInteger limit;
@property (nonatomic,strong)NSMutableArray * customerArr;

//奖励
@property (nonatomic,strong)NSDictionary *myRewardDic;


@end

@implementation InvitationFriendsController

- (void)viewDidLoad {
    [super viewDidLoad];
    _firstView = [UIView new];
    _start = 0;
    _limit = 10;
    _customerArr = [NSMutableArray array];
    _myRewardDic = [NSDictionary dictionary];

    
    [_firstView setBackgroundColor:[UIColor whiteColor]];
    [self.tableView addSubview:_firstView];
    [_firstView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH, 177));
    }];
    
    _dearLabel = [UILabel new];
    [_dearLabel setText:@"亲爱的,您的邀请码是:"];
    [_dearLabel setFont:[UIFont systemFontOfSize:15]];
    [self.firstView addSubview:_dearLabel];
    [_dearLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(28);
        make.left.right.mas_equalTo(_firstView).mas_offset(0);
        make.height.mas_equalTo(15);
    }];
    _dearLabel.textAlignment = NSTextAlignmentCenter;
    
    _wenlabel = [UILabel new];
    [_wenlabel setText:@"(需要实名认证后生效)"];
    [_wenlabel setFont:[UIFont systemFontOfSize:13]];
    [_wenlabel setTextColor:[UIColor colorWithHexString:@"#808080"]];
    [self.firstView addSubview:_wenlabel];
    [_wenlabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_dearLabel.mas_bottom).with.offset(7);
        make.left.right.mas_equalTo(_firstView).mas_offset(0);
        make.height.mas_equalTo(14);
    }];
    _wenlabel.textAlignment = NSTextAlignmentCenter;
    
    _invitaLabel = [UILabel new];
    [_invitaLabel setFont:[UIFont systemFontOfSize:28]];
    [_invitaLabel setTextColor:[UIColor colorWithHexString:@"#F5635D"]];
    [self.firstView addSubview:_invitaLabel];
    [_invitaLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_wenlabel.mas_bottom).with.offset(29);
        make.left.right.mas_equalTo(_firstView).mas_offset(0);
        make.height.mas_equalTo(32);
    }];
    _invitaLabel.textAlignment = NSTextAlignmentCenter;

//    _imageView = [UIImageView new];
//    UIImage * image = [UIImage imageNamed:@"nb.png"];
//    _imageView.image = image;
//    [self.firstView addSubview:_imageView];
//    [_imageView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.mas_equalTo(28);
//        make.right.mas_equalTo(-15);
//        make.size.mas_equalTo(CGSizeMake(150, 150));
//    }];
    
    _twoView = [UIView new];
    [_twoView setBackgroundColor:[UIColor whiteColor]];
    [self.tableView addSubview:_twoView];
    [_twoView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_firstView.mas_bottom).with.offset(5);
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH, 168));
    }];
    
    _prizeLabel = [UILabel new];
    [_prizeLabel setText:@"邀请有奖"];
    [_prizeLabel setFont:[UIFont systemFontOfSize:15]];
    _prizeLabel.textAlignment = NSTextAlignmentCenter;
    [self.twoView addSubview:_prizeLabel];
    [_prizeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(20);
        make.left.mas_equalTo(15);
        make.height.mas_equalTo(15);
        make.right.mas_equalTo(-15);
    }];
    
//    _rulesBtn = [UIButton new];
//    [_rulesBtn setTitle:@"邀请规则>" forState:UIControlStateNormal];
//    _rulesBtn.tintColor = [UIColor blackColor];
//    [_rulesBtn setTitleColor:[UIColor colorWithHexString:@"#808080"] forState:UIControlStateNormal];
//    [_rulesBtn addTarget:self action:@selector(rulesBtnClick:) forControlEvents:UIControlEventTouchUpInside];
//    _rulesBtn.titleLabel.font = [UIFont systemFontOfSize:11];
//    [self.twoView addSubview:_rulesBtn];
//    [_rulesBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.mas_equalTo(21);
//        make.right.mas_equalTo(-8);
//        make.size.mas_equalTo(CGSizeMake(60, 16));
//    }];
    
    _imageView1 = [UIImageView new];
    UIImage * image1 = [UIImage imageNamed:@"fx.png"];
    _imageView1.image = image1;
    [_twoView addSubview:_imageView1];
    [_imageView1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(34);
        make.top.mas_equalTo(63);
        make.size.mas_equalTo(CGSizeMake(45, 45));
    }];
    
    _label1 = [UILabel new];
    [_label1 setText:@"分享邀请码给好友"];
    [_label1 setFont:[UIFont systemFontOfSize:11]];
    _label1.numberOfLines = 0;
    [_twoView addSubview:_label1];
    [_label1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_imageView1.mas_bottom).with.offset(15);
        make.centerX.equalTo(_imageView1.mas_centerX);
        make.width.mas_equalTo(46);
    }];
    
    
    _imageView2 = [UIImageView new];
    UIImage * image2 = [UIImage imageNamed:@"hy.png"];
    _imageView2.image = image2;
    [_twoView addSubview:_imageView2];
    [_imageView2 mas_makeConstraints:^(MASConstraintMaker *make) {
        //make.left.equalTo(_imageView1.mas_right).with.offset(86);
        make.centerX.mas_equalTo(_twoView.mas_centerX);
        make.top.mas_equalTo(63);
        make.size.mas_equalTo(CGSizeMake(45, 45));
    }];
    
    _label2 = [UILabel new];
    [_label2 setText:@"好友注册后首投金额达到要求"];
    [_label2 setFont:[UIFont systemFontOfSize:11]];
    _label2.numberOfLines = 0;
    [_twoView addSubview:_label2];
    [_label2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_imageView2.mas_bottom).with.offset(15);
        make.centerX.equalTo(_imageView2.mas_centerX);
        make.width.mas_equalTo(90);
    }];
    
    _imageView3 = [UIImageView new];
    UIImage * image3 = [UIImage imageNamed:@"xj.png"];
    _imageView3.image = image3;
    [_twoView addSubview:_imageView3];
    [_imageView3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-34);
        make.top.mas_equalTo(63);
        make.size.mas_equalTo(CGSizeMake(45, 45));
    }];
    
    _label3 = [UILabel new];
    [_label3 setText:@"获得现金奖励"];
    [_label3 setFont:[UIFont systemFontOfSize:11]];
    _label3.numberOfLines = 0;
    [_twoView addSubview:_label3];
    [_label3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_imageView3.mas_bottom).with.offset(15);
        make.centerX.equalTo(_imageView3.mas_centerX);
        make.width.mas_equalTo(46);
    }];
    
//    _threeView = [UIView new];
//    [_threeView setBackgroundColor:[UIColor whiteColor]];
//    [self.tableView addSubview:_threeView];
//    [_threeView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(_twoView.mas_bottom).with.offset(5);
//        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH, 91));
//    }];
//
//    _myReward = [UILabel new];
//    [_myReward setText:@"邀请奖励"];
//    [_myReward setFont:[UIFont systemFontOfSize:13]];
//    [self.threeView addSubview:_myReward];
//    [_myReward mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.mas_equalTo(20);
//        make.left.mas_equalTo(15);
//        make.height.mas_equalTo(13);
//    }];
//
//
//    _phoneLabel = [UILabel new];
//    [_phoneLabel setText:@"手机号"];
//    [_phoneLabel setTextColor:[UIColor colorWithHexString:@"#666666"]];
//    _phoneLabel.textAlignment = NSTextAlignmentCenter;
//    [_phoneLabel setFont:[UIFont systemFontOfSize:13]];
//    [self.threeView addSubview:_phoneLabel];
//    [_phoneLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(_myReward.mas_bottom).with.offset(0);
//        make.bottom.mas_equalTo(0);
//        make.height.mas_equalTo(13);
//        make.centerX.equalTo(self.threeView.mas_left).with.offset(SCREEN_WIDTH/7);
//
//    }];
//
//    _timeLabel = [UILabel new];
//    [_timeLabel setText:@"注册时间"];
//    [_timeLabel setTextColor:[UIColor colorWithHexString:@"#666666"]];
//    _timeLabel.textAlignment = NSTextAlignmentCenter;
//    [_timeLabel setFont:[UIFont systemFontOfSize:13]];
//    [self.threeView addSubview:_timeLabel];
//    [_timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(_phoneLabel.mas_top);
//        make.bottom.mas_equalTo(0);
//        make.height.mas_equalTo(13);
//        make.centerX.equalTo(self.threeView.mas_left).with.offset(SCREEN_WIDTH/7*3);
//    }];
//
//    _amountLabel = [UILabel new];
//    [_amountLabel setText:@"投资金额"];
//    [_amountLabel setTextColor:[UIColor colorWithHexString:@"#666666"]];
//    _amountLabel.textAlignment = NSTextAlignmentCenter;
//    [_amountLabel setFont:[UIFont systemFontOfSize:13]];
//    [self.threeView addSubview:_amountLabel];
//    [_amountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(_phoneLabel.mas_top);
//        make.bottom.mas_equalTo(0);
//        make.height.mas_equalTo(13);
//        make.centerX.equalTo(self.threeView.mas_left).with.offset(SCREEN_WIDTH/6*4);
//
//    }];
//
//    _rewardLabel = [UILabel new];
//    [_rewardLabel setText:@"奖励"];
//    [_rewardLabel setTextColor:[UIColor colorWithHexString:@"#666666"]];
//    _rewardLabel.textAlignment = NSTextAlignmentCenter;
//    [_rewardLabel setFont:[UIFont systemFontOfSize:13]];
//    [self.threeView addSubview:_rewardLabel];
//    [_rewardLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(_phoneLabel.mas_top);
//        make.bottom.mas_equalTo(0);
//        make.height.mas_equalTo(13);
//        make.centerX.equalTo(self.threeView.mas_left).with.offset(SCREEN_WIDTH/7*6);
//    }];
    [self getImage];
    [self getAccountSaftData];
    [self getCustomerList];
}


-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    NSDictionary *mine = [NSDictionary dictionaryWithObject:[UIColor blackColor] forKey:NSForegroundColorAttributeName];
    self.navigationController.navigationBar.titleTextAttributes = mine;
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    [self setupBarButtomItemWithImageName:@"黑色返回按钮" highLightImageName:@"nav_back_select.png" selectedImageName:nil target:self action:@selector(backClick) leftOrRight:YES];
    [self setupNavi];
    [self setupTableView];
}

-(void)backClick
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)setupNavi
{
    [self.navigationController setNavigationBarHidden:NO animated:NO];
    self.title = @"邀请有奖";
    
    UIButton *customView = [UIButton buttonWithType:UIButtonTypeCustom];
    customView.frame = CGRectMake(0, 0, 44, 44);
    customView.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [customView setImage:[UIImage imageNamed:@"黑色返回按钮"] forState:UIControlStateNormal];
    [customView addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:customView];
    
    UIButton *customBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    customBtn.frame = CGRectMake(0, 0, 44, 44);
    customBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    [customBtn setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
    //    [customBtn setImage:[UIImage imageNamed:@"nav_back_normal"] forState:UIControlStateNormal];
    [customBtn setTitle:@"分享" forState:UIControlStateNormal];
    customBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [customBtn addTarget:self action:@selector(onClickedOKbtn) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:customBtn];
}

- (void)onClickedOKbtn {
    
    [MBProgressHUD showMessag:@"邀请码复制成功" toView:self.view];
    UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
    pasteboard.string = _invitaLabel.text;
//    [UMSocialUIManager setPreDefinePlatforms:@[@(UMSocialPlatformType_WechatSession),@(UMSocialPlatformType_WechatTimeLine)]];
//    
//    [UMSocialUIManager showShareMenuViewInWindowWithPlatformSelectionBlock:^(UMSocialPlatformType platformType, NSDictionary *userInfo) {
//        //创建分享消息对象
//        UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
//        
//        //创建网页内容对象
//        //NSString* thumbURL =  @"https://mobile.umeng.com/images/pic/home/social/img-1.png";
//        UIImage * image = [UIImage imageNamed:@"fenxiang.png"];
//        UMShareWebpageObject *shareObject = [UMShareWebpageObject shareObjectWithTitle:@"告别死工资  人脉变钱脉" descr:@"这个季节，最适合赚朋友的钱（邪恶）！~快来米袋子领现金吧~即日起，凡用户邀请好友成功注册，即可赢取好友0.5%年化收益和最高1800元现金哦~更多惊喜..." thumImage:image];
//        
//        
//        //设置网页地址
//        NSString * sst = [NSMutableString stringWithFormat:@"http://m.sanniujinfu.com/v2/open/user/register.jsp?inviter=%@",_invitaLabel.text];
//        shareObject.webpageUrl = sst;
//        
//        //分享消息对象设置分享内容对象
//        messageObject.shareObject = shareObject;
//        
//        //调用分享接口
//        [[UMSocialManager defaultManager] shareToPlatform:platformType messageObject:messageObject currentViewController:self completion:^(id data, NSError *error) {
//            if (error) {
//                UMSocialLogInfo(@"************Share fail with error %@*********",error);
//            }else{
//                if ([data isKindOfClass:[UMSocialShareResponse class]]) {
//                    UMSocialShareResponse *resp = data;
//                    //分享结果消息
//                    UMSocialLogInfo(@"response message is %@",resp.message);
//                    //第三方原始返回的数据
//                    UMSocialLogInfo(@"response originalResponse data is %@",resp.originalResponse);
//                    
//                }else{
//                    UMSocialLogInfo(@"response data is %@",data);
//                }
//            }
//            //                [self alertWithError:error];
//        }];
//    }];
}

- (void)setupTableView{
    
    [self setupRefreshWithTableView:_tableView];
    [self.tableView registerNib:[UINib nibWithNibName:@"InvitationFriendsViewCell" bundle:nil] forCellReuseIdentifier:@"InvitationFriendsViewCell"];
}

- (void)rulesBtnClick:(UIButton *)sender
{
    NSLog(@"123");
    
    MoreWebViewController * moreWebVC = [MoreWebViewController new];
    moreWebVC.titleStr = @"邀请规则";
    moreWebVC.webStr =@"v2/accept/account/inviteRule.jsp";
    self.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:moreWebVC animated:YES];

    
}
- (void)applyRewardBtnClick:(UIButton *)sender
{
    NSLog(@"456");
    ApplyrRorReward * appleVC = [ApplyrRorReward new];
    [self.navigationController pushViewController:appleVC animated:YES];
}
//邀请码
- (void)getAccountSaftData
{
    NetWorkingUtil *util = [NetWorkingUtil netWorkingUtil];
    [util requestDic4MethodNam:@"v2/accept/user/getUserInfo" parameters:nil result:^(NSDictionary *dic, int status, NSString *msg) {
        NSLog(@"_____%@",dic);
        if (status == 0) {
        }else {
            _invitaLabel.text = [[dic objectForKey:@"user" ]objectForKey:@"usernumber"];
        }
    }];
}

- (void)getImage {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString * accesstoken = [defaults objectForKey:@"accesstoken"];
    NSString * str = [NSString stringWithFormat:@"%@v2/accept/user/userQR?UserId=%@&accesstoken=%@&Platform=2&os=%@&version=%@",__API_HEADER__,[NSString stringWithFormat:@"%ld",(long)[User shareUser].userId],accesstoken,kos,kVersion];
    NSURL * url = [NSURL URLWithString:str ];
    NSData *data = [NSData dataWithContentsOfURL:url];
    UIImage *image = [UIImage imageWithData:data];
    _imageView.image = image;
}

- (void)getCustomerList {
//    [self.httpUtil requestDic4MethodNam:@"v2/accept/user/inviteUserList" parameters:@{@"limit":@(_limit),@"start":@(_start)} result:^(id  dic, int status, NSString *msg) {
//        if (status == 0) {
//            if (_customerArr.count == 0) {
//            }
//        }else {
//            [_customerArr addObjectsFromArray:dic];
//            [_tableView.mj_footer resetNoMoreData];
//        }
//        [_tableView reloadData];
//    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _customerArr.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 345+10+91+1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
//        static NSString *CellIdentifier = @"Cell";
//        UITableViewCell *cell = (UITableViewCell*)[tableView  dequeueReusableCellWithIdentifier:CellIdentifier];
//        if (cell == nil) {
//            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
//        }
//        cell.selectionStyle = UITableViewCellSelectionStyleNone;
//        return cell;
    static NSString *cellID = @"InvitationFriendsViewCell";
    
    InvitationFriendsViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [[InvitationFriendsViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (indexPath.row<_customerArr.count) {
        [cell setMyRewardDic:_customerArr[indexPath.row]];
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    RewardRetailsVC * vc = [RewardRetailsVC new];
    vc.userId = [[_customerArr[indexPath.row]objectForKey:@"userId"]intValue];
    [self.navigationController pushViewController:vc animated:YES];
//    DistributionController * vc = [DistributionController new];
//    [self.navigationController pushViewController:vc animated:YES];
}

- (void)headerRefreshloadData {
    if (_customerArr.count<_limit) {
        [MBProgressHUD showMessag:@"没有更多数据了" toView:self.view];
        
        [_tableView.mj_header endRefreshing];
        return;
    }
    _start = _start +_limit;
    [self getCustomerList];
    [_tableView.mj_header endRefreshing];
}

- (void)footerRefreshloadData {
    if (_customerArr.count-_start<_limit) {
        [MBProgressHUD showMessag:@"没有更多数据了" toView:self.view];
        [_tableView.mj_footer endRefreshing];
        return;
    }
    _start = _start +_limit;
    [self getCustomerList];
    [_tableView.mj_footer endRefreshing];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
