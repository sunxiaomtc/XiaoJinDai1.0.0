 //
//  XProjectConfirmController.m
//  NiuduFinance
//
//  Created by 123 on 17/7/20.
//  Copyright © 2017年 liuyong. All rights reserved.
//

#import "XProjectConfirmController.h"
#import "SNProjectDetailModel.h"
#import "XProjectDetailsController.h"
#import "XProjectDetailsCell.h"
#import "SNProjectInvestModel.h"
#import "WebPageVC.h"
#import "ZHBPickerView.h"
#import "AppDelegate.h"
#import "BankNewTopUpViewController.h"

@interface XProjectConfirmController ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate,ZHBPickerViewDataSource,ZHBPickerViewDelegate,UIAlertViewDelegate>
{
    NSInteger selectIndex;
}
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) UIView * dhView;
@property (nonatomic, strong) UILabel * dhTitleLabe;
@property (nonatomic, strong) UIImageView * imageVie;
@property (nonatomic, strong) UIView * firstView;
@property (nonatomic, strong) UIImageView * diImageView;
@property (nonatomic, strong) UILabel * titleLab;
@property (nonatomic, strong) UILabel * nhsylLab;
@property (nonatomic, strong) UILabel * rateLabe;
@property (nonatomic, strong) UILabel * xmqxLabe;
@property (nonatomic, strong) UILabel * timeLabe;
@property (nonatomic, strong) UILabel * syktLbel;
@property (nonatomic, strong) UILabel * syktNumb;
@property (nonatomic, strong) UILabel * kyyeLabe;
@property (nonatomic, strong) UILabel * kyyeNumb;
@property (nonatomic, strong) UIView  * twoView;
@property (nonatomic, strong) UILabel * tzjeLabe;
@property (nonatomic, strong) UITextField * tzjeTextField;
@property (nonatomic, strong) UIView  * lineView;
@property (nonatomic, strong) UIButton * yeqtBtn;
@property (nonatomic, strong) UILabel * yqsyLabe;
@property (nonatomic, strong) UILabel * yqsyNumb;
@property (nonatomic, strong) UIView * threeView;
@property (nonatomic, strong) UILabel * syyhLabe;
@property (nonatomic, strong) UILabel * yhqLabel;
@property (nonatomic, strong) UIImageView * jtImage;
@property (nonatomic, strong) UIButton * confirmBtn;

@property (nonatomic, strong) UILabel *addLab;

@property (nonatomic,strong)NSMutableArray *mutArray;
@property (nonatomic,strong)NSString *tzjeAmountStr;
@property (nonatomic, strong) SNProjectInvestModel * investModel;
@property (nonatomic,strong) NSString *hongbaoid;
@property (nonatomic,strong) NSMutableArray *canUseHongBaoArr;
//   筛选红包
@property (nonatomic,strong)NSMutableArray *selectHongBaoArr;

//   筛选红包后的ID
@property (nonatomic,strong)NSMutableArray *selectIDHongBaoArr;
@property (nonatomic,strong)ZHBPickerView *zhBPickerView;
@property (nonatomic,assign) NSInteger hongBaoCount;

@property (nonatomic,strong) UIButton *backBtn;

@property (nonatomic,strong)NSDictionary * projectDic;

//
@property (nonatomic,strong)NSString * keYongStr;
@end

@implementation XProjectConfirmController

- (SNProjectInvestModel *)investModel
{
    if (!_investModel) {
        _investModel = [SNProjectInvestModel new];
        _investModel.key = @"__SNProjectInvestModel__";
        _investModel.requestType = VZModelCustom;
    }
    return _investModel;
}
- (void)setProjectId:(int)projectId
{
    _projectId = projectId;
    NSLog(@"====%d",_projectId);
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    self.navigationItem.title = @"确认投资";
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor blackColor],NSFontAttributeName:[UIFont systemFontOfSize:17]}];
    UIButton *customView = [UIButton buttonWithType:UIButtonTypeCustom];
    customView.frame = CGRectMake(0, 0, 44, 44);
    customView.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [customView setImage:[UIImage imageNamed:@"黑色返回按钮"] forState:UIControlStateNormal];
    [customView addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:customView];
    
    [self totalAssets];
    if (_projectId > 0) {
        [self getDetail];
        [self getProjectDetailsData];
        [self getXianJinData];
    }
    //隐藏导航栏
//    [self.navigationController setNavigationBarHidden:YES animated:NO];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    _hongbaoid = @"0";
    _hongBaoCount = 0;
    _hongBaoArray = [NSMutableArray array];
    _selectHongBaoArr =[NSMutableArray array];
    _selectIDHongBaoArr = [NSMutableArray array];
    _getHongBaoArray= [NSMutableArray array];
    _projectDic = [NSDictionary dictionary];
    _canUseHongBaoArr = [NSMutableArray array];
//    _dhView = [UIView new];
//    [_dhView setBackgroundColor:[UIColor whiteColor]];
//    [self.view addSubview:_dhView];
//    [_dhView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.mas_equalTo(0);
//        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH, 64));
//    }];
    
//    _dhTitleLabe = [UILabel new];
//    [_dhTitleLabe setText:@"确认投资"];
//    [_dhTitleLabe setFont:[UIFont systemFontOfSize:17]];
//    [self.dhView addSubview:_dhTitleLabe];
//    [_dhTitleLabe mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.centerX.mas_equalTo(0);
//        make.top.mas_equalTo(34);
//        make.height.mas_equalTo(16);
//    }];
    
    [_dhView setHidden:YES];
    
    
//    _imageVie = [UIImageView new];
//    UIImage * image = [UIImage imageNamed:@"黑色返回按钮"];
//    _imageVie.image = image;
//    [self.dhView addSubview:_imageVie];
//    [_imageVie mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.mas_equalTo(34);
//        make.left.mas_equalTo(15);
//        make.size.mas_equalTo(CGSizeMake(15, 15));
//    }];
//
//    UITapGestureRecognizer *labelTapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(labelClick)];
//    [_imageVie addGestureRecognizer:labelTapGestureRecognizer];
//    _imageVie.userInteractionEnabled = YES;
    
    _firstView = [UIView new];
//    _firstView.backgroundColor = [UIColor yellowColor];
    [_tableView setTableHeaderView:_firstView];
    [self.tableView addSubview:_firstView];
    [_firstView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH, 215));
    }];

    _diImageView = [UIImageView new];
//    _diImageView.backgroundColor = [UIColor yellowColor];
    UIImage * imageD = [UIImage imageNamed:@"矩形-11"];
    _diImageView.image = imageD;
    [self.firstView addSubview:_diImageView];
    [_diImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.left.right.mas_equalTo(_firstView).mas_offset(0);
    }];
    
    _titleLab = [UILabel new];
    [_titleLab setText:@""];
    [_titleLab setFont:[UIFont systemFontOfSize:15]];
    [_titleLab setTextColor:[UIColor whiteColor]];
    [self.firstView addSubview:_titleLab];
    [_titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(10);
        make.left.mas_equalTo(15);
    }];

    _rateLabe = [UILabel new];
    _rateLabe.text = @"%";
    [_rateLabe setFont:[UIFont systemFontOfSize:46]];
    [_rateLabe setTextColor:[UIColor whiteColor]];
    [self.firstView addSubview:_rateLabe];
    [_rateLabe mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_titleLab.mas_bottom).mas_offset(42);
        make.centerX.mas_equalTo(self.firstView).mas_offset(0);
    }];
    _addLab = [UILabel new];
    _addLab.text = @"%";
    [_addLab setFont:[UIFont systemFontOfSize:20]];
    [_addLab setTextColor:[UIColor whiteColor]];
    [self.firstView addSubview:_addLab];
    [_addLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_rateLabe.mas_right).offset(5);
        make.top.mas_equalTo(_titleLab.mas_bottom).mas_offset(42);
        make.width.mas_equalTo(100);
        make.height.mas_equalTo(20);
    }];
    
    _nhsylLab = [UILabel new];
    [_nhsylLab setText:@"预期年化"];
    [_nhsylLab setFont:[UIFont systemFontOfSize:15]];
    [_nhsylLab setTextColor:[UIColor whiteColor]];
    [self.firstView addSubview:_nhsylLab];
    [_nhsylLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_rateLabe.mas_bottom).mas_offset(5);
        make.centerX.mas_equalTo(self.firstView).mas_offset(0);
    }];
    
    
    _timeLabe = [UILabel new];
    [_timeLabe setText:@""];
    [_timeLabe setFont:[UIFont systemFontOfSize:17]];
    [_timeLabe setTextColor:[UIColor whiteColor]];
    [self.firstView addSubview:_timeLabe];
    [_timeLabe mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_nhsylLab.mas_bottom).with.offset(12);
        make.right.mas_equalTo(-15);
    }];

    _xmqxLabe = [UILabel new];
    [_xmqxLabe setText:@"项目期限"];
    [_xmqxLabe setFont:[UIFont systemFontOfSize:11]];
    [_xmqxLabe setTextColor:[UIColor whiteColor]];
    [self.firstView addSubview:_xmqxLabe];
    [_xmqxLabe mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_timeLabe.mas_bottom).mas_offset(5);
        make.right.mas_equalTo(-16);
    }];
    
    _syktNumb = [UILabel new];
    [_syktNumb setText:@""];
    [_syktNumb setFont:[UIFont systemFontOfSize:17]];
    [_syktNumb setTextColor:[UIColor whiteColor]];
    [self.firstView addSubview:_syktNumb];
    [_syktNumb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_nhsylLab.mas_bottom).with.offset(12);
        make.left.mas_equalTo(15);
    }];
    
    _syktLbel = [UILabel new];
    [_syktLbel setText:@"项目剩余可投 （元）"];
    [_syktLbel setFont:[UIFont systemFontOfSize:11]];
    [_syktLbel setTextColor:[UIColor whiteColor]];
    [self.firstView addSubview:_syktLbel];
    [_syktLbel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_syktNumb.mas_bottom).with.offset(5);
        make.left.mas_equalTo(15);
    }];
    
    
    
    _kyyeLabe = [UILabel new];
    [_kyyeLabe setText:@"可用余额"];
    [_kyyeLabe setFont:[UIFont systemFontOfSize:12]];
    [_kyyeLabe setTextColor:[UIColor colorWithHexString:@"#9A9A9A"]];
    [self.tableView addSubview:_kyyeLabe];
    [_kyyeLabe mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_firstView.mas_bottom).with.offset(10);
        make.left.mas_equalTo(15);
        make.height.mas_equalTo(12);
    }];
    
    _kyyeNumb = [UILabel new];
    [_kyyeNumb setText:@"元"];
    [_kyyeNumb setFont:[UIFont systemFontOfSize:13]];
    [_kyyeNumb setTextColor:[UIColor blackColor]];
    [self.tableView addSubview:_kyyeNumb];
    [_kyyeNumb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_kyyeLabe.mas_right).with.offset(10);
        make.top.equalTo(_firstView.mas_bottom).with.offset(10);
        make.height.mas_equalTo(12);
    }];
    
    _twoView = [UIView new];
    [_twoView setBackgroundColor:[UIColor whiteColor]];
    [self.tableView addSubview:_twoView];
    [_twoView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_firstView.mas_bottom).with.offset(32);
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH, 50));
    }];
    
    _tzjeLabe = [UILabel new];
    [_tzjeLabe setText:@"投资金额 (元)"];
    [_tzjeLabe setFont:[UIFont systemFontOfSize:14]];
    [self.twoView addSubview:_tzjeLabe];
    [_tzjeLabe mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(0);
        make.left.mas_equalTo(15);
        make.height.mas_equalTo(13);
    }];
    
    _tzjeTextField = [UITextField new];
    _tzjeTextField.delegate = self;
    _tzjeTextField.placeholder = @"(投资金额≥100元)";
    _tzjeTextField.font = [UIFont systemFontOfSize:14];
    _tzjeTextField.keyboardType = UIKeyboardTypeNumberPad;
    [_tzjeTextField addTarget:self action:@selector(textFieldChange:) forControlEvents:UIControlEventEditingChanged];
    [self.twoView addSubview:_tzjeTextField];
    [_tzjeTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(0);
        make.left.equalTo(_tzjeLabe.mas_right).with.offset(5);
        make.height.mas_equalTo(13);
    }];
    
    _lineView = [UIView new];
    [_lineView setBackgroundColor:[UIColor colorWithHexString:@"#EEEEEE"]];
    [self.twoView addSubview:_lineView];
    [_lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(0);
        make.right.mas_equalTo(-78);
        make.size.mas_equalTo(CGSizeMake(1, 24));
    }];
    
    _yeqtBtn = [UIButton new];
    [_yeqtBtn setTitle:@"余额全投" forState:UIControlStateNormal];
    _yeqtBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [_yeqtBtn addTarget:self action:@selector(yeqtBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [_yeqtBtn setTitleColor:UIcolors forState:UIControlStateNormal];
    [self.twoView addSubview:_yeqtBtn];
    [_yeqtBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(0);
        make.right.mas_equalTo(-15);
        make.height.mas_equalTo(13);
    }];
    
    _yqsyLabe = [UILabel new];
    [_yqsyLabe setText:@"预期收益"];
    [_yqsyLabe setFont:[UIFont systemFontOfSize:12]];
    [_yqsyLabe setTextColor:[UIColor colorWithHexString:@"#9A9A9A"]];
    [self.tableView addSubview:_yqsyLabe];
    [_yqsyLabe mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_twoView.mas_bottom).with.offset(10);
        make.left.mas_equalTo(15);
        make.height.mas_equalTo(12);
    }];
    
    _yqsyNumb = [UILabel new];
    [_yqsyNumb setText:@"0.00元"];
    [_yqsyNumb setFont:[UIFont systemFontOfSize:13]];
    [_yqsyNumb setTextColor:[UIColor blackColor]];
    [self.tableView addSubview:_yqsyNumb];
    [_yqsyNumb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_yqsyLabe.mas_right).with.offset(10);
        make.top.equalTo(_twoView.mas_bottom).with.offset(10);
        make.height.mas_equalTo(12);
    }];
    
    _threeView = [UIView new];
    [_threeView setBackgroundColor:[UIColor whiteColor]];
    [self.tableView addSubview:_threeView];
    [_threeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_twoView.mas_bottom).with.offset(32);
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH, 50));
    }];
    UITapGestureRecognizer * tapYhqLabel = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapLabelClick)];
    [_threeView addGestureRecognizer:tapYhqLabel];
    _threeView.userInteractionEnabled = YES;
    
    _syyhLabe = [UILabel new];
    [_syyhLabe setText:@"使用优惠"];
    [_syyhLabe setTextColor:[UIColor blackColor]];
    [_syyhLabe setFont:[UIFont systemFontOfSize:14]];
    [self.threeView addSubview:_syyhLabe];
    [_syyhLabe mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(0);
        make.left.mas_equalTo(15);
        make.height.mas_equalTo(13);
    }];

    
    _yhqLabel = [UILabel new];
    [_yhqLabel setText:@"无可使用优惠券"];
    [_yhqLabel setFont:[UIFont systemFontOfSize:14]];
    [_yhqLabel setTextColor:[UIColor colorWithHexString:@"#9A9A9A"]];
    [self.threeView addSubview:_yhqLabel];
    [_yhqLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(0);
        make.right.mas_equalTo(-41);
        make.height.mas_equalTo(13);
    }];

    
    _jtImage = [UIImageView new];
    UIImage * image1 = [UIImage imageNamed:@"huix@2x.png"];
    _jtImage.image = image1;
    [self.threeView addSubview:_jtImage];
    [_jtImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(0);
        make.right.mas_equalTo(-20);
        make.size.mas_equalTo(CGSizeMake(15, 15));
    }];
    
    UIView *bottomView = [[UIView alloc]init];
    [_tableView addSubview:bottomView];
    [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.view).mas_offset(0);
        make.centerX.mas_equalTo(0);
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH, 70));
    }];
    bottomView.backgroundColor = [UIColor whiteColor];
    
    _confirmBtn = [UIButton new];
    _confirmBtn.layer.cornerRadius = 18.0f;
    _confirmBtn.clipsToBounds = YES;
    [_confirmBtn setTitle:@"确认投资" forState:UIControlStateNormal];
    _confirmBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    [_confirmBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_confirmBtn setBackgroundColor:UIcolors];
    _confirmBtn.titleLabel.font = [UIFont systemFontOfSize:17];
    [_confirmBtn addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    [_tableView addSubview:_confirmBtn];
    [_confirmBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.view).mas_offset(-15);
        make.centerX.mas_equalTo(0);
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH-80, 40));
    }];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(hongbaoIndex:) name:@"hongbaoNoti" object:nil];
}

//小数点问题
- (NSString *)formatFloat:(float)f
{
    if (fmodf(f, 1)==0) {//如果有一位小数点
        return [NSString stringWithFormat:@"%.0f",f];
    } else if (fmodf(f*10, 1)==0) {//如果有两位小数点
        return [NSString stringWithFormat:@"%.1f",f];
    } else {
        return [NSString stringWithFormat:@"%.2f",f];
    }
}


- (void)getDetail
{
    WS
    [self.httpUtil requestDic4MethodNam:@"v2/accept/project/find" parameters:@{@"projectId":@(_projectId)} result:^(NSDictionary *dic, int status, NSString *msg) {
        NSLog(@"%@",dic);
        if (status == 0) {
        }else{
            _titleLab.text = [NSString stringWithFormat:@"%@",[dic objectForKey:@"title"]];
             NSString *str = [weakSelf formatFloat:([[dic objectForKey:@"rate"] floatValue]-([weakSelf.addRate floatValue]))];
            _rateLabe.text = [str stringByAppendingString:@"%"];
            if([weakSelf.addRate floatValue] > 0)
            {
                _addLab.text = [[NSString stringWithFormat:@"+%@",weakSelf.addRate]stringByAppendingString:@"%"];
            }else
            {
                _addLab.text = @"";
            }
            
            NSString * perStr = [NSString stringWithFormat:@"%@",[dic objectForKey:@"periodtypeid"]];
            if ([perStr integerValue] == 1) {
                _timeLabe.text = [NSString stringWithFormat:@"%@天",[dic objectForKey:@"loanperiod"]];
            } else if ([perStr integerValue] == 2) {
                _timeLabe.text = [NSString stringWithFormat:@"%@个月", [dic objectForKey:@"loanperiod"]];
            } else if ([perStr integerValue] == 3) {
                _timeLabe.text = [NSString stringWithFormat:@"%@年",[dic objectForKey:@"loanperiod"]];
            }
            //最小投资额
            _tzjeTextField.placeholder = [NSString stringWithFormat:@"(投资金额≥%@元)",[dic objectForKey:@"minbidamount"]];
            
            _syktNumb.text = [NSString stringWithFormat:@"%.2f",[[dic objectForKey:@"remainamount"] floatValue]];
        }
        [weakSelf.tableView reloadData];
        
    }];
}

//总资产显示
- (void)totalAssets
{
    NetWorkingUtil *util = [NetWorkingUtil netWorkingUtil];
    [util requestDic4MethodNam:@"v2/accept/account/getUserAssetInfo" parameters:nil result:^(NSDictionary *dic, int status, NSString *msg) {
        NSLog(@"%@",dic);
        if (status == 0) {
            [MBProgressHUD showMessag:msg toView:self.view];
        }else{
            _keYongStr = [NSString stringWithFormat:@"%@",[dic objectForKey:@"mayUseBalance"]];
            _kyyeNumb.text = [NSString stringWithFormat:@"%.2f元",[[dic objectForKey:@"mayUseBalance"] floatValue]];
        }
        [self.tableView reloadData];
    }];
}

- (void)textFieldChange:(UITextField *)textField
{
    [_zhBPickerView removeFromSuperview];
    _tzjeAmountStr = textField.text;
    NSLog(@"dddd");
    
    [self getEarn];
    [self getXianJinData];
    
}
- (void)textFieldDidEndEditing:(UITextField *)textField
{
    NSLog(@"BBBBBBBB");
    NSLog(@"%ld",_hongBaoArray.count);

    _hongBaoCount = 0;
    
    if (!IsStrEmpty(_tzjeAmountStr)) {
        
        for (int i = 0; i < _hongBaoArray.count; i ++) {
            
            _hongBaoCount ++;
        }
    }
    

    [self.tableView reloadData];

}

- (void)yeqtBtnClick {
    NSInteger keYong = [_keYongStr integerValue];
    NSInteger sykt = [_syktNumb.text integerValue];
    if (keYong == 0) {
        [MBProgressHUD showMessag:@"余额不足" toView:self.view];
    }
    if (keYong > 0 && keYong <= sykt) {
        //截取字符串末尾改为0
        NSString * newString = [NSString stringWithFormat:@"%ld",(long)keYong];
        NSString *b = [newString substringFromIndex:newString.length-1];
        NSString *str3 = [newString stringByReplacingOccurrencesOfString:b withString:@"0"];
        _tzjeTextField.text = str3;
    }
    if (keYong > 0 && keYong >= sykt) {
        NSString * newString = [NSString stringWithFormat:@"%ld",(long)sykt];
        NSString *b = [newString substringFromIndex:newString.length];
        NSString *str3 = [newString stringByReplacingOccurrencesOfString:b withString:@"0"];
        NSInteger ssp = [str3 integerValue];
        _tzjeTextField.text = [NSString stringWithFormat:@"%ld",ssp];
    }
    _tzjeAmountStr = _tzjeTextField.text;
    [self getXianJinData];
    [self getEarn];
}

//预期收益
- (void)getEarn {
    int tzje = [_tzjeAmountStr intValue];
    NetWorkingUtil *util = [NetWorkingUtil netWorkingUtil];
    [util requestDic4MethodNam:@"v2/accept/project/investIncome" parameters:@{@"projectId":@(_projectId),@"amount":@(tzje),@"projectType":@(0)} result:^(NSDictionary *dic, int status, NSString *msg) {
        NSLog(@"%@",dic);
        if (status == 0) {
//            [MBProgressHUD showMessag:msg toView:self.view]; //更改2
        }else{
            NSLog(@"%@",[NSString stringWithFormat:@"%.2f元",[[dic objectForKey:@"income"] floatValue]]);
            _yqsyNumb.text = [NSString stringWithFormat:@"%.2f元",[[dic objectForKey:@"income"] floatValue]];
        }
        [self.tableView reloadData];
    }];
}
- (void)getXianJinData {
    if(IsStrEmpty(_tzjeAmountStr))
    {
        return;
    }
    [self.httpUtil requestDic4MethodNam:@"v2/accept/project/findAllBouns" parameters:@{@"projectId":@(_projectId),@"amount":_tzjeAmountStr} result:^(id dic, int status, NSString *msg) {
        NSLog(@"%@",dic);
        
        if (status == 0) {
//            [MBProgressHUD showError:msg toView:self.view];///更改1
        }else{
            NSLog(@"%@",dic);
            [_hongBaoArray removeAllObjects];
            [_hongBaoArray addObjectsFromArray:dic];
            
            _nameArr = [NSMutableArray array];
            for (NSDictionary * dict in  _hongBaoArray) {
                [_nameArr addObject:[dict objectForKey:@"bounsName"]];
            }

            if (_hongBaoArray.count == 0) {
                _yhqLabel.text = @"无可用现金券";
                _threeView.userInteractionEnabled = NO;
            } else {
                //不输入金额的时候，不显示现金券数量这里加了一盒（!）
                if (!IsStrEmpty(_tzjeAmountStr)) {
                    
                    _yhqLabel.text = [NSString stringWithFormat:@"%ld个现金券可用",_hongBaoArray.count];
                    _threeView.userInteractionEnabled = YES;
                }else{
                    if (_hongBaoCount == 0) {
                        _yhqLabel.text = @"无可用现金券";
                        _threeView.userInteractionEnabled = NO;
                    }else{
                        _yhqLabel.text = [NSString stringWithFormat:@"%ld个现金券可用",_hongBaoCount];
                        _threeView.userInteractionEnabled = YES;
                    }
                }
                
            }
            [self loadHongBaoArray];
            
        }
    }];
    
}
- (void)loadHongBaoArray{
    NSString *noUseHongBao = @"不使用现金券";
    [self.canUseHongBaoArr addObject:noUseHongBao];
    [self.canUseHongBaoArr removeAllObjects];
    NSLog(@"%@",_canUseHongBaoArr);
    NSLog(@"%@",_hongBaoArray);

    for (int i=0; i<_hongBaoArray.count; i++) {
        
        NSString *hongBaoStr = [NSString stringWithFormat:@"%@",[_hongBaoArray[i] objectForKey:@"bounsName"]];
        NSLog(@"%@",hongBaoStr);
        
        [self.canUseHongBaoArr addObject:hongBaoStr];
    }
    NSLog(@"%@",_canUseHongBaoArr);

}
- (void)hongbaoIndex:(NSNotification *)info{
    
    NSDictionary *dic =  info.userInfo;
    
    if ([[dic objectForKey:@"hongbao"] isKindOfClass:[NSString class]]) {
        _hongbaoid = @"0";
    }else{
        _hongbaoid = [NSString stringWithFormat:@"%@",[[dic objectForKey:@"hongbao"] objectForKey:@"sentid"]];
        NSLog(@"%@",_hongbaoid);
    }
}
- (void)labelClick
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)tapLabelClick
{
    NSLog(@"456789");

    if (_hongBaoArray.count == 0) {
        return;
    }
    if (!IsStrEmpty(_tzjeTextField.text))
    {
        NSString *noUseHongBao = @"不使用现金券";
        [self.selectHongBaoArr addObject:noUseHongBao];
        NSLog(@"%@",_hongBaoArray);
        for (int i = 0; i < _hongBaoArray.count; i ++) {
            [self.selectHongBaoArr addObject:[_canUseHongBaoArr objectAtIndex:i]];
            [self.selectIDHongBaoArr addObject:[_hongBaoArray objectAtIndex:i]];
        }
    }else{
        return;
    }
    [_tzjeTextField resignFirstResponder];
    if (!(_hongBaoArray.count ==0)) {
        _syyhLabe.tag = 2;
        _zhBPickerView =  [[[NSBundle mainBundle] loadNibNamed:@"ZHBPickerView" owner:self options:nil] firstObject];
        _zhBPickerView.showHongBao = YES;
        _zhBPickerView.dataSource = self;
        _zhBPickerView.delegate = self;
        _zhBPickerView.frame = CGRectMake(0, SCREEN_HEIGHT - 300, SCREEN_WIDTH,300);
        [self.tableView addSubview:_zhBPickerView];
    }else{
        _syyhLabe.tag = 1;
        [_zhBPickerView removeFromSuperview];
    }

}
//  散标
- (void)getProjectDetailsData
{
    [self.httpUtil requestDic4MethodName:@"project/index" parameters:@{@"ProjectId":@(_projectId)} result:^(NSDictionary *dic, int status, NSString *msg) {
        if (status == 1 || status == 2) {
            _projectDic = dic;
        }else{
            [MBProgressHUD showError:msg toView:self.view];
        }
        [_tableView reloadData];
    }];
}
- (void)buttonAction:(UIButton *)btn
{
    if ([AppDelegate checkLogin]){
        NetWorkingUtil *util = [NetWorkingUtil netWorkingUtil];
        [util requestDic4MethodNam:@"v2/accept/user/openHuifuStatus" parameters:nil result:^(NSDictionary *dic, int status, NSString *msg) {
            if (status != 0) {
                NSLog(@"%@",dic);
                Boolean open = [[dic objectForKey:@"status"] boolValue];
                if (!open) {
                    WebPageVC *vc = [[WebPageVC alloc] init];
                    vc.title = @"开通汇付账户";
                    vc.name = @"huifu/openaccount";
                    [self.navigationController pushViewController:vc animated:YES];
                }else {
                    if ( [[_projectDic objectForKey:@"IsNewLender"] integerValue] == 1 &&  [[_projectDic objectForKey:@"IsBid"] integerValue] == 1) {
                        [MBProgressHUD showMessag:@"您已不是新手了，不能投资新手专享标" toView:self.view];
                        return;
                    }
                    if (IsStrEmpty(_tzjeAmountStr)) {
                        [MBProgressHUD showMessag:@"请输入投资金额" toView:self.view];
                        return;
                    }
                    if ([_tzjeAmountStr isEqualToString:@"0"]) {
                        [MBProgressHUD showMessag:@"金额不能为0" toView:self.view];
                        return;
                    }
                    
                    NSLog(@"%@",[_projectDic objectForKey:@"BorrowerId"]);
                    if ([[_projectDic objectForKey:@"BorrowerId"] integerValue] == [User shareUser].userId) {
                        [MBProgressHUD showMessag:@"不能给自己投标" toView:self.view];
                        return;
                    }
                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"您的每份合同,都具有法律效力" message:@"小金袋已和E签宝达成合作，e签宝是一款基于《中华人民共和国电子签名法》的互联网基础应用。 e签宝通过公钥密码技术、第三方电子认证技术、时间戳技术来生成可靠的电子签名。" delegate:self cancelButtonTitle:@"确认使用E签宝" otherButtonTitles:nil, nil];
                    [alert show];
                }
            }
        }];
    }

}


- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(alertView.tag == 888)
    {
        if (buttonIndex == 1) {
            WebPageVC *vc = [[WebPageVC alloc] init];
            vc.title = @"开通汇付账户";
            vc.name = @"huifu/openaccount";
            [self.navigationController pushViewController:vc animated:YES];
        }
    }else
    {
        NSNumber * projectId = [NSNumber numberWithInt:_projectId ];
        self.investModel.projectId = projectId;
        self.investModel.amount = _tzjeAmountStr;
        self.investModel.sendId = _hongbaoid;
        //NSLog(@"%@",_hongbaoid);
        
        WS
        [self.investModel loadWithCompletion:^(VZModel *model, NSError *error) {
            if (!error) {
                WebPageVC *vc = [WebPageVC new];
                vc.isHtmlString = YES;
                vc.name = [weakSelf.investModel.form stringByAppendingString:@"<script type=\"text/javascript\">document .getElementById('huifufrom').submit();</script>"];
                vc.title = @"投资确认";
                [weakSelf.navigationController pushViewController:vc animated:YES];
            } else {
                if([[error localizedDescription] isEqualToString:@"可用余额不足!"])
                {
                    //[MBProgressHUD showMessag:<#(NSString *)#> toView:<#(UIView *)#>];
                    //                MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:[UIApplication sharedApplication].keyWindow animated:YES];
                    //                hud.detailsLabelText = [error localizedDescription];
                    //                hud.detailsLabelFont = [UIFont systemFontOfSize:14.0f];
                    //                // 再设置模式
                    //                hud.mode = MBProgressHUDModeCustomView;
                    //
                    //                // 隐藏时候从父控件中移除
                    //                hud.removeFromSuperViewOnHide = YES;
                    //                // 1.5秒之后再消失
                    //                [hud hide:YES afterDelay:2];
                    [MBProgressHUD showMessag:[error localizedDescription] toView:self.view];
                    [self performSelector:@selector(delayMethod) withObject:nil/*可传任意类型参数*/ afterDelay:2.0];
                    //[weakSelf panduanISOpen];
                }else
                {
                    [MBProgressHUD showMessag:[error localizedDescription] toView:self.view];
                }
            }
        }];
    }
}

-(void)panduanISOpen
{
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    NetWorkingUtil *util = [NetWorkingUtil netWorkingUtil];
    __weak __typeof(self) weakSelf = self;
    [util requestDic4MethodNam:@"v2/accept/user/openHuifuStatus" parameters:nil result:^(NSDictionary *dic, int status, NSString *msg) {
        [MBProgressHUD hideHUDForView:weakSelf.view animated:YES];
        if (status != 0) {
            NSLog(@"%@",dic);
            Boolean open = [[dic objectForKey:@"status"] boolValue];
            NSLog(@"%hhu",open);
            if (!open) {
                //安全退出
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"请先开通汇付" delegate:weakSelf cancelButtonTitle:@"取消" otherButtonTitles:@"马上开通", nil];
                alert.tag = 888;
                [alert show];
            }else {
                [weakSelf panduanChongZhi];
            }
        }
    }];
}

-(void)panduanChongZhi
{
    WS
    [weakSelf.httpUtil requestDic4MethodNam:@"v2/accept/user/findExpressBankCard" parameters:nil result:^(id dic, int status, NSString *msg) {
        NSLog(@"%@",dic);
        if (status == 0) {
            WebPageVC *vc = [[WebPageVC alloc] init];
            vc.title = @"充值";
            vc.name = @"recharge";
            [weakSelf.navigationController pushViewController:vc animated:YES];
        }else {
            BankNewTopUpViewController * bankVC = [BankNewTopUpViewController new];
            [weakSelf.navigationController pushViewController:bankVC animated:YES];
        }
    }];
}

-(void)delayMethod
{
    WebPageVC *vc = [[WebPageVC alloc] init];
    vc.title = @"充值";
    vc.name = @"recharge";
    [self.navigationController pushViewController:vc animated: YES];
    [MBProgressHUD hideAllHUDsForView:self.view animated: YES];
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 0;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 160;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = (UITableViewCell*)[tableView  dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;

    return cell;
}


- (NSInteger)numberOfComponentsInPickerView:(ZHBPickerView *)pickerView
{
    return 1;
}
- (NSArray *)pickerView:(ZHBPickerView *)pickerView titlesForComponent:(NSInteger)component
{
    if (component == 0) {
        if (_selectHongBaoArr.count > 0) {
            return _selectHongBaoArr;
        }
        return self.canUseHongBaoArr;
    }
    return nil;
}

- (void)pickerView:(ZHBPickerView *)pickerView didSelectContent:(NSString *)content
{
    if (IsStrEmpty(_tzjeTextField.text)) {
        _syyhLabe.tag = 1;
        [_zhBPickerView removeFromSuperview];
        return;
    }
    _syyhLabe.tag = 1;
    
    _yhqLabel.text = content;
    _yhqLabel.textColor = [UIColor colorWithHexString:@"#444444"];
    
    NSDictionary *hongbaoDic;
    if (pickerView.isSelected == 0) {
        hongbaoDic = @{@"hongbao":@"不使用现金券"};
    }else{
        hongbaoDic = @{@"hongbao":_selectIDHongBaoArr[pickerView.isSelected - 1]};
    }
    if ([content isEqual:@""]) {
        if (_selectHongBaoArr.count > 0) {
            _yhqLabel.text = _selectHongBaoArr[pickerView.isSelected];
        }else{
            _yhqLabel.text = _canUseHongBaoArr[pickerView.isSelected];
        }
    }
    [[NSNotificationCenter defaultCenter] postNotificationName:@"hongbaoNoti" object:nil userInfo:hongbaoDic];
    [_selectHongBaoArr removeAllObjects];
    [_selectIDHongBaoArr removeAllObjects];

}
- (void)cancelSelectPickerView:(ZHBPickerView *)pickerView
{
    [_selectHongBaoArr removeAllObjects];
    
    [_selectIDHongBaoArr removeAllObjects];
    
    _syyhLabe.tag = 1;
    [_zhBPickerView removeFromSuperview];
}
//修改状态栏为黑色
- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleDefault;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
