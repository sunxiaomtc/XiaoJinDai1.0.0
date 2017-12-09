//
//  ProjectDetailsViewController.m
//  NiuduFinance
//
//  Created by liuyong on 16/2/26.
//  Copyright © 2016年 liuyong. All rights reserved.
//

#import "ProjectDetailsViewController.h"
#import "ProjectDetailsTableViewCell.h"
#import "InvestCommitViewController.h"
#import "ProjectIntroduceViewController.h"
#import "InvestRecodeViewController.h"
#import "User.h"
#import "NetWorkingUtil.h"
#import "ProjectProgressView.h"
#import "NSDate+Helper.h"
#import "FinanceDetailsViewController.h"
#import "ProjectIntroduceDetailViewController.h"
#import "RechargeViewController.h"
#import "BindingBankCardViewController.h"
#import "WebPageVC.h"
#import "AppDelegate.h"
#import "ProjectProgressView.h"
#import "SNProjectDetailIFooterView.h"

#import "SNProjectDetailModel.h"
#import "SNProjectImagesModel.h"
#import "SNProjectFindAllInvestorModel.h"
#import "SNProjectInvestModel.h"
#import "MoreWebViewController.h"

#import "SNDebtDetailModel.h"
#import "BankNewTopUpViewController.h"
@interface ProjectDetailsViewController () <UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate>
{
    //H
    NSInteger     selectBttonTag;
}

@property (nonatomic, strong) SNProjectDetailModel * projectDetailModel;
@property (nonatomic, strong) SNProjectImagesModel * projectImagesModel;
@property (nonatomic, strong) SNProjectFindAllInvestorModel * findAllModel;
@property (nonatomic, strong) SNProjectInvestModel * investModel;

@property (nonatomic, strong) SNDebtDetailModel * debtDetailModel;

@property (weak, nonatomic) IBOutlet UIButton *investBtn;
@property (weak, nonatomic) IBOutlet UITableView *projectDetailsTableView;

//  头部View
@property (strong, nonatomic) IBOutlet UIView *headerTableView;
@property (strong, nonatomic) IBOutlet UIView *headerView;
@property (strong, nonatomic) IBOutlet UILabel *headerTitle;
@property (strong, nonatomic) IBOutlet UILabel *rateLab;
@property (strong, nonatomic) IBOutlet UILabel *rateTitle;
@property (strong, nonatomic) IBOutlet UILabel *remainamountLab;
@property (strong, nonatomic) IBOutlet UILabel *amountLab;
@property (strong, nonatomic) IBOutlet UILabel *hintLab;  //  国资出品，安心投资



@property (weak, nonatomic) IBOutlet UIImageView *projectImageView;
@property (weak, nonatomic) IBOutlet UILabel *projectAmountLab;
@property (weak, nonatomic) IBOutlet UILabel *projectRateLab;
@property (weak, nonatomic) IBOutlet UILabel *projectTitleLab;
@property (weak, nonatomic) IBOutlet UILabel *projectPeriodLab;
@property (weak, nonatomic) IBOutlet UILabel *projectPeriodTypeLab;
@property (weak, nonatomic) IBOutlet UILabel *crazyRushLab;
@property (weak, nonatomic) IBOutlet ProjectProgressView *progressView;
@property (weak, nonatomic) IBOutlet UILabel *overplusLab;
@property (weak, nonatomic) IBOutlet UILabel *bidAmountLab;
@property (weak, nonatomic) IBOutlet UILabel *returnMoneyTypeLab;
@property (weak, nonatomic) IBOutlet UILabel *peojectAmountTypeLab;
@property (weak, nonatomic) IBOutlet UILabel *crazyLab;
@property (weak, nonatomic) IBOutlet UILabel *PaymentInstructionsLab;

@property (nonatomic,strong)NSDictionary *projectDetailsDic;

@property (nonatomic,strong)NSDictionary *projectFinanceDic;

@property (nonatomic,strong)NSString *investAmountStr;

@property (nonatomic,strong)NSTimer *timer;

@property (strong, nonatomic) NSMutableArray *bankCardsArr;

@property (nonatomic,strong) NSMutableArray *canUseHongBaoArr;

@property (nonatomic,strong) NSString *hongbaoid;

@property (nonatomic,assign) NSInteger hongBaoCount;
//新现金红包
@property (nonatomic,strong) NSMutableArray * nameArr;

@end

@implementation ProjectDetailsViewController

- (SNProjectDetailModel *)projectDetailModel
{
    if (!_projectDetailModel) {
        _projectDetailModel = [SNProjectDetailModel new];
        _projectDetailModel.key = @"__SNProjectDetailModel__";
        _projectDetailModel.requestType = VZModelCustom;
    }
    return _projectDetailModel;
}

- (SNProjectImagesModel *)projectImagesModel
{
    if (!_projectImagesModel) {
        _projectImagesModel = [SNProjectImagesModel new];
        _projectImagesModel.key = @"__SNProjectImagesModel__";
        _projectImagesModel.requestType = VZModelCustom;
    }
    return _projectImagesModel;
}

- (SNProjectFindAllInvestorModel *)findAllModel
{
    if (!_findAllModel) {
        _findAllModel = [SNProjectFindAllInvestorModel new];
        _findAllModel.key = @"__SNProjectFindAllInvestorModel__";
        _findAllModel.requestType = VZModelCustom;
    }
    return _findAllModel;
}

- (SNProjectInvestModel *)investModel
{
    if (!_investModel) {
        _investModel = [SNProjectInvestModel new];
        _investModel.key = @"__SNProjectInvestModel__";
        _investModel.requestType = VZModelCustom;
    }
    return _investModel;
}

- (SNDebtDetailModel *)debtDetailModel
{
    if (!_debtDetailModel) {
        _debtDetailModel = [SNDebtDetailModel new];
        _debtDetailModel.key = @"__SNDebtDetailModel__";
        _debtDetailModel.requestType = VZModelCustom;
    }
    return _debtDetailModel;
}

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])
    {
        self.title = @"投资详情";
        self.hideBottomBar = NO;
        self.hideNaviBar = NO;
        [self backBarItem];
        
    }
    return self;
}
- (void)setProjectId:(int)projectId
{
    _projectId = projectId;
    NSLog(@"====%d",_projectId);
}

- (void)setProductId:(int)productId
{
    _productId = productId;
    
    [self getFinanceInfoData];
}

- (void)setType:(NSString *)type
{
    _type = type;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    
    _projectFinanceDic = [NSDictionary dictionary];
    _bankCardsArr = [NSMutableArray array];
    
    _hongbaoid = @"0";
    
    _hongBaoCount = 0;
    
    [self getMyBankCard];
    
    [self backBarItem];
    
    [self setTableViewInfo];
    _hongBaoArray = [NSMutableArray array];
    _canUseHongBaoArr = [NSMutableArray array];
    [self setupBarButtomItemWithImageName:@"nav_back_normal.png" highLightImageName:@"nav_back_select.png" selectedImageName:nil target:self action:@selector(backClick) leftOrRight:YES];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(hongbaoIndex:) name:@"hongbaoNoti" object:nil];
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


- (NSDictionary *)projectDetailsDic{

    if (_projectDetailsDic==nil) {
        _projectDetailsDic = [NSDictionary dictionary];

    }
    return _projectDetailsDic;
}

- (void)backClick
{
    if (_timer.isValid) {
        [_timer invalidate];
    }
    _timer = nil;
    
    [self.navigationController popViewControllerAnimated:YES];
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    if (_projectId > 0) {
        [self getProjectDetailsData];
        [self getXianJinData];
    }
}

- (void)viewWillDisappear:(BOOL)animated
{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"hidePickerViewNoti" object:nil];
    self.navigationController.navigationBarHidden = NO;
}
#pragma mark -- 查看是否绑定银行卡
- (void)getMyBankCard
{
    [self.httpUtil requestArr4MethodName:@"fund/bankcard" parameters:nil result:^(NSArray *arr, int status, NSString *msg) {
        if (status == 1 || status == 2) {
            
            [_bankCardsArr addObjectsFromArray:arr];
            
            [self.projectDetailsTableView reloadData];
        }else{
            [MBProgressHUD showError:msg toView:self.view];
        }
        
    } convertClassName:nil key:nil];
}




//  散标
- (void)getProjectDetailsData
{
    [self.httpUtil requestDic4MethodName:@"project/index" parameters:@{@"ProjectId":@(_projectId)} result:^(NSDictionary *dic, int status, NSString *msg) {
        if (status == 1 || status == 2) {
            _projectDetailsDic = dic;
            
            [self setHeaderInfo];
            
        }else{
            [MBProgressHUD showError:msg toView:self.view];
        }
        [_projectDetailsTableView reloadData];
    }];
    
    
}


- (void)loadHongBaoArray{
    NSLog(@"%@",_canUseHongBaoArr);

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

- (void)setHeaderInfo
{
   
    [NetWorkingUtil setImage:_projectImageView url:[_projectDetailsDic objectForKey:@"IconUrl"] defaultIconName:nil  successBlock:nil];
    _projectTitleLab.text = [_projectDetailsDic objectForKey:@"Title"];
    
    if ([[_projectDetailsDic objectForKey:@"AmountTypeId"] integerValue] == 1){
        _projectAmountLab.text = [NSString stringWithFormat:@"%@", [_projectDetailsDic objectForKey:@"Amount"]];
        _peojectAmountTypeLab.text = @"元";
        
    }else{
        _projectAmountLab.text = [NSString stringWithFormat:@"%@", [_projectDetailsDic objectForKey:@"Amount"]];
         _peojectAmountTypeLab.text = @"万";
    }
    
    _projectRateLab.text = [NSString stringWithFormat:@"%.2f",[[_projectDetailsDic objectForKey:@"LoanRate"] floatValue]];
    _projectPeriodLab.text = [NSString stringWithFormat:@"%@",[_projectDetailsDic objectForKey:@"LoanDate"]];
    if ([[_projectDetailsDic objectForKey:@"PeriodTypeId"] integerValue] == 1) {
        _projectPeriodTypeLab.text = @"天";
    }else if ([[_projectDetailsDic objectForKey:@"PeriodTypeId"] integerValue] == 2){
        _projectPeriodTypeLab.text = @"个月";
    }else if ([[_projectDetailsDic objectForKey:@"PeriodTypeId"] integerValue] == 3){
        _projectPeriodTypeLab.text = @"年";
    }
   
    
    _progressView.progressValue = [[_projectDetailsDic objectForKey:@"Progress"] floatValue];
    
    _overplusLab.text =  _overplusLab.text = [NSString stringWithFormat:@"%@元", [_projectDetailsDic objectForKey:@"SurplusAmount"]];
    _bidAmountLab.text = [NSString stringWithFormat:@"%@元",[_projectDetailsDic objectForKey:@"MinAmount"]];
    _returnMoneyTypeLab.text = [_projectDetailsDic objectForKey:@"RepaymentType"];
    _PaymentInstructionsLab.text = [_projectDetailsDic objectForKey:@"PaymentInstructions"];
    if ([[_projectDetailsDic objectForKey:@"IsCanBid"] integerValue] == 0) {
        _investBtn.userInteractionEnabled = NO;
        _investBtn.backgroundColor = [UIColor colorWithHexString:@"#CDCDCD"];
    }
    
    [_investBtn setTitle:[_projectDetailsDic objectForKey:@"StatusName"] forState:UIControlStateNormal];
    
    _timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(timeMethodGo:) userInfo:nil repeats:YES];
}
//   判断倒计时
-(void)timeMethodGo:(NSTimer *)timer{
    
    
    if ([_type isEqual:@"理财"]) {
        NSDateComponents *day = [NSDate timeMethodGo:[_projectFinanceDic objectForKey:@"EffectiveDate"]];
        if ([[_projectFinanceDic objectForKey:@"IsFinish"] intValue] == 0) {
            _crazyLab.text = @"疯抢中:";
            _crazyRushLab.text = [NSString stringWithFormat:@" %ld天%ld小时%ld分%ld秒",(long)[day day] , (long)[day hour], (long)[day minute], (long)[day second]];
        }else{
            if ([_statueId intValue] == 1) {
                _crazyLab.text = @"预售中";
            }else{
                _crazyLab.text = @" 已售罄";
            }
            _crazyRushLab.text = @"";
            if (_timer.isValid) {
                [_timer invalidate];
            }
            _timer = nil;
        }
    }else{
        if ([[_projectDetailsDic objectForKey:@"IsFinish"] intValue] == 0) {
            _crazyLab.text = @"开标时间:";
            _crazyRushLab.text = [NSString stringWithFormat:@"%@",[_projectDetailsDic objectForKey:@"RemainTime"]];
        }else{
            if ([_statueId intValue] == 0) {
                _crazyLab.text = @"预审中";
            }else{
                _crazyLab.text = @"已结束";
            }
            _crazyRushLab.text = @"";
            if (_timer.isValid) {
                [_timer invalidate];
            }
            _timer = nil;
        }
    }
}
//  理财
- (void)getFinanceInfoData
{
    [self.httpUtil requestDic4MethodName:@"financialproduct/index" parameters:@{@"ProductId":@(_productId)} result:^(NSDictionary *dic, int status, NSString *msg) {
        if ( status == 1 || status == 2) {
            _projectFinanceDic = dic;
            
            [self setHeaderFinanceInfo];
//            [self loadHongBaoArray];
        }else{
            [MBProgressHUD showError:msg toView:self.view];
        }
        if (_projectFinanceDic != nil) {
            [_projectDetailsTableView reloadData];
        }
    }];
}



- (void)setHeaderFinanceInfo
{
    _projectImageView.image = [UIImage imageNamed:@"home_youxuan"];
    _projectTitleLab.text = [_projectFinanceDic objectForKey:@"Title"];
    
    if ([[_projectFinanceDic objectForKey:@"AmountTypeId"] integerValue] == 1){
        _projectAmountLab.text = [NSString stringWithFormat:@"%@", [_projectFinanceDic objectForKey:@"Amount"]];
        _peojectAmountTypeLab.text = @"元";
    }else{
        _projectAmountLab.text = [NSString stringWithFormat:@"%@", [_projectFinanceDic objectForKey:@"Amount"]];
    }
    _projectRateLab.text = [NSString stringWithFormat:@"%@",[_projectFinanceDic objectForKey:@"Rate"]];
    _projectPeriodLab.text = [NSString stringWithFormat:@"%@",[_projectFinanceDic objectForKey:@"LoanPeriod"]];
    _projectPeriodTypeLab.text = [_projectFinanceDic objectForKey:@"LoanDate"];
    
    
    _progressView.progressValue = [[_projectFinanceDic objectForKey:@"Progress"] floatValue];
    if ([[_projectFinanceDic objectForKey:@"OverplusTypeId"] integerValue] == 1) {
        _overplusLab.text = [NSString stringWithFormat:@"%@元",[_projectFinanceDic objectForKey:@"Overplus"]];
    }else{
        _overplusLab.text = [NSString stringWithFormat:@"%@万元",[_projectFinanceDic objectForKey:@"Overplus"]];
    }
    
    _bidAmountLab.text = [NSString stringWithFormat:@"%@元  (10元/份)",[_projectFinanceDic objectForKey:@"MinAmount"]];
    _returnMoneyTypeLab.text = [_projectFinanceDic objectForKey:@"RepaymentTypeId"];
    
    if ([[_projectFinanceDic objectForKey:@"IsFinish"] integerValue] == 0) {
        _investBtn.userInteractionEnabled = NO;
        _investBtn.backgroundColor = [UIColor colorWithHexString:@"#CDCDCD"];
    }
    
    _timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(timeMethodGo:) userInfo:nil repeats:YES];
}

- (void)setTableViewInfo
{
    _headerView.backgroundColor = HEX_COLOR(@"019BFF");
    _projectDetailsTableView.tableHeaderView = _headerTableView;
    
//    _projectDetailsTableView.tableFooterView = _tailTableView;
    
    [_projectDetailsTableView registerNib:[UINib nibWithNibName:@"ProjectDetailsTableViewCell" bundle:nil] forCellReuseIdentifier:@"ProjectDetailsTableViewCell"];
}

- (void)setProjectItem:(SNProjectListItem *)projectItem
{
    _projectItem = projectItem;
    
    SNProjectDetailIFooterView * footerView = [[SNProjectDetailIFooterView alloc] init];
    footerView.tableView = self.projectDetailsTableView;
    self.projectDetailsTableView.tableFooterView = footerView;
    
    WS
    self.projectDetailModel.projectId = projectItem.projectId.stringValue;
    [self.projectDetailModel loadWithCompletion:^(VZModel *model, NSError *error) {
        if (!error) {
            footerView.detailItem = weakSelf.projectDetailModel.detailItem;
            
            weakSelf.projectDetailsTableView.contentOffset = CGPointMake(0, 0);
        }
    }];
    
    self.projectImagesModel.projectId = projectItem.projectId.stringValue;
    [self.projectImagesModel loadWithCompletion:^(VZModel *model, NSError *error) {
        if (!error) {
            footerView.photoArray = weakSelf.projectImagesModel.imagesArray;
            
            weakSelf.projectDetailsTableView.contentOffset = CGPointMake(0, 0);
        }
    }];
    
    self.findAllModel.projectId = projectItem.projectId.stringValue;
    [self.findAllModel loadWithCompletion:^(VZModel *model, NSError *error) {
        if (!error) {
            footerView.listArray = weakSelf.findAllModel.listArray;
            
            weakSelf.projectDetailsTableView.contentOffset = CGPointMake(0, 0);
        }
    }];
    
    //   UI
    self.headerTitle.text = projectItem.title;
    self.rateLab.text = [NSString stringWithFormat:@"%.2f", [projectItem.rate floatValue]];
    
    self.hintLab.hidden = YES;
    UIView * hintView = [[UIView alloc] init];
    hintView.backgroundColor = [UIColor whiteColor];
    hintView.layer.masksToBounds = YES;
    hintView.layer.cornerRadius = 4.0f;
    [self.headerTableView addSubview:hintView];
    [hintView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(weakSelf.headerTableView.mas_right).with.offset(-10);
        make.top.equalTo(weakSelf.headerTableView.mas_top).with.offset(59);
    }];
    
    UILabel * hintLabel = [[UILabel alloc] init];
    hintLabel.textColor = BlueColor;
    hintLabel.text = @"国资出品,安心投资";
    hintLabel.font = [UIFont systemFontOfSize:12.f];
    [hintView addSubview:hintLabel];
    [hintLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(hintView);
        make.left.equalTo(hintView.mas_left).with.offset(6);
        make.right.equalTo(hintView.mas_right).with.offset(-6);
        make.height.mas_equalTo(@20);
    }];
    
    for (NSInteger i = 0; i < 3; i++) {
        UILabel * label = [[UILabel alloc] init];
        label.tag = 100 + i;
        label.layer.masksToBounds = YES;
        label.layer.cornerRadius = 6.0f;
        label.layer.borderWidth = 0.5f;
        label.layer.borderColor = [UIColor whiteColor].CGColor;
        label.textAlignment = NSTextAlignmentCenter;
        label.textColor = [UIColor whiteColor];
        label.font = [UIFont systemFontOfSize:14];
        label.adjustsFontSizeToFitWidth = YES;
        [_headerTableView addSubview:label];
    }
    
    CGFloat width = (SCREEN_WIDTH - 60) / 3.f;
    
    UILabel * label2 = [_headerTableView viewWithTag:101];
    label2.text = @"先息后本";
    [label2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(weakSelf.headerTableView.mas_centerX);
        make.top.equalTo(weakSelf.headerTableView.mas_top).with.offset(165);
        make.size.mas_equalTo(CGSizeMake(width, 23));
    }];
    
    UILabel * label1 = [_headerTableView viewWithTag:100];
    [label1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(label2.mas_centerY);
        make.right.equalTo(label2.mas_left).with.offset(8);
        make.size.mas_equalTo(CGSizeMake(width, 23));
    }];
    
    UILabel * label3 = [_headerTableView viewWithTag:102];
    [label3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(label2.mas_centerY);
        make.left.equalTo(label2.mas_right).with.offset(-8);
        make.size.mas_equalTo(CGSizeMake(width, 23));
    }];
    
    if ([projectItem.periodtypeid integerValue] == 1) {
        label1.text = [NSString stringWithFormat:@"%@天", projectItem.loanperiod];
    } else if ([projectItem.periodtypeid integerValue] == 2) {
        label1.text = [NSString stringWithFormat:@"%@个月", projectItem.loanperiod];
    } else if ([projectItem.periodtypeid integerValue] == 3) {
        label1.text = [NSString stringWithFormat:@"%@年", projectItem.loanperiod];
    }
    
    label3.text = [NSString stringWithFormat:@"%@起投", projectItem.minbidamount];
    
    self.remainamountLab.text = [NSString stringWithFormat:@"%.2f", [projectItem.remainamount floatValue]];
    self.amountLab.text = [NSString stringWithFormat:@"%.2f", [projectItem.amount floatValue]];
    
    UILabel * progressNum = [[UILabel alloc] init];
    progressNum.text = [NSString stringWithFormat:@"进度：%.f%@", projectItem.process.floatValue, @"%"];
    progressNum.font = [UIFont systemFontOfSize:12.f];
    [_headerTableView addSubview:progressNum];
    [progressNum mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakSelf.headerTableView.mas_top).with.offset(320);
        make.right.equalTo(weakSelf.headerTableView.mas_right).with.offset(-10);
    }];
    
    ProjectProgressView * progressView = [[ProjectProgressView alloc] init];
    progressView.backgroundColor = HEX_COLOR(@"#dddddd");
    progressView.isShowProgressText = NO;
    [_headerTableView addSubview:progressView];
    [progressView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.headerTableView.mas_left).with.offset(10);
        make.centerY.equalTo(progressNum.mas_centerY);
        make.right.equalTo(progressNum.mas_left).with.offset(-8);
        make.height.mas_equalTo(@4);
    }];
    
    progressView.progressValue = projectItem.process.floatValue;
}

- (void)setDebtItem:(SNDebtListItem *)debtItem
{
    _debtItem = debtItem;
    
    //   UI
    self.headerTitle.text = debtItem.title;
    self.rateLab.text = [NSString stringWithFormat:@"%.2f", [debtItem.srrsy floatValue]];
    self.rateTitle.text = @"受让人年化";
    
    WS
    self.hintLab.hidden = YES;
    UIView * hintView = [[UIView alloc] init];
    hintView.backgroundColor = [UIColor whiteColor];
    hintView.layer.masksToBounds = YES;
    hintView.layer.cornerRadius = 4.0f;
    [self.headerTableView addSubview:hintView];
    [hintView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(weakSelf.headerTableView.mas_right).with.offset(-10);
        make.top.equalTo(weakSelf.headerTableView.mas_top).with.offset(59);
    }];
    
    UILabel * hintLabel = [[UILabel alloc] init];
    hintLabel.textColor = BlueColor;
    hintLabel.text = @"国资出品,安心投资";
    hintLabel.font = [UIFont systemFontOfSize:12.f];
    [hintView addSubview:hintLabel];
    [hintLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(hintView);
        make.left.equalTo(hintView.mas_left).with.offset(6);
        make.right.equalTo(hintView.mas_right).with.offset(-6);
        make.height.mas_equalTo(@20);
    }];
    
    for (NSInteger i = 0; i < 3; i++) {
        UILabel * label = [[UILabel alloc] init];
        label.tag = 100 + i;
        label.layer.masksToBounds = YES;
        label.layer.cornerRadius = 6.0f;
        label.layer.borderWidth = 0.5f;
        label.layer.borderColor = [UIColor whiteColor].CGColor;
        label.textAlignment = NSTextAlignmentCenter;
        label.textColor = [UIColor whiteColor];
        label.font = [UIFont systemFontOfSize:14];
        label.adjustsFontSizeToFitWidth = YES;
        [_headerTableView addSubview:label];
    }
    
    CGFloat width = (SCREEN_WIDTH - 60) / 3.f;
    
    UILabel * label2 = [_headerTableView viewWithTag:101];
    label2.text = @"先息后本";
    [label2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(weakSelf.headerTableView.mas_centerX);
        make.top.equalTo(weakSelf.headerTableView.mas_top).with.offset(165);
        make.size.mas_equalTo(CGSizeMake(width, 23));
    }];
    
    UILabel * label1 = [_headerTableView viewWithTag:100];
    [label1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(label2.mas_centerY);
        make.right.equalTo(label2.mas_left).with.offset(8);
        make.size.mas_equalTo(CGSizeMake(width, 23));
    }];
    
    UILabel * label3 = [_headerTableView viewWithTag:102];
    [label3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(label2.mas_centerY);
        make.left.equalTo(label2.mas_right).with.offset(-8);
        make.size.mas_equalTo(CGSizeMake(width, 23));
    }];
    
    
    //  数据
    SNProjectDetailIFooterView * footerView = [[SNProjectDetailIFooterView alloc] init];
    footerView.tableView = self.projectDetailsTableView;
    self.projectDetailsTableView.tableFooterView = footerView;
    
    
    self.debtDetailModel.debtDealID = debtItem.debtdealid.stringValue;
    [self.debtDetailModel loadWithCompletion:^(VZModel *model, NSError *error) {
        if (!error) {
            SNDebtDetailItem * detailItem = weakSelf.debtDetailModel.detailItem;
            footerView.detailItem = detailItem;
            
            label1.text = [NSString stringWithFormat:@"剩余%@%@", detailItem.owingnumber, detailItem.periodtypeidName];
            
            label3.text = [NSString stringWithFormat:@"%@份起投", detailItem.mincopies];
            
            self.remainamountLab.text = [NSString stringWithFormat:@"%.2f", [detailItem.remainamount floatValue]];
            self.amountLab.text = [NSString stringWithFormat:@"%.2f", [detailItem.amount floatValue]];
            
            UILabel * progressNum = [[UILabel alloc] init];
            progressNum.text = [NSString stringWithFormat:@"进度：%.f%@", detailItem.process.floatValue, @"%"];
            progressNum.font = [UIFont systemFontOfSize:12.f];
            [_headerTableView addSubview:progressNum];
            [progressNum mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.equalTo(weakSelf.headerTableView.mas_top).with.offset(320);
                make.right.equalTo(weakSelf.headerTableView.mas_right).with.offset(-10);
            }];
            
            ProjectProgressView * progressView = [[ProjectProgressView alloc] init];
            progressView.backgroundColor = HEX_COLOR(@"#dddddd");
            progressView.isShowProgressText = NO;
            [_headerTableView addSubview:progressView];
            [progressView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(weakSelf.headerTableView.mas_left).with.offset(10);
                make.centerY.equalTo(progressNum.mas_centerY);
                make.right.equalTo(progressNum.mas_left).with.offset(-8);
                make.height.mas_equalTo(@4);
            }];
            
            progressView.progressValue = detailItem.process.floatValue;
        }
    }];
    
    self.projectImagesModel.projectId = debtItem.projectid.stringValue;
    [self.projectImagesModel loadWithCompletion:^(VZModel *model, NSError *error) {
        if (!error) {
            footerView.photoArray = weakSelf.projectImagesModel.imagesArray;
        }
    }];
    
    self.findAllModel.debtDealId = debtItem.debtdealid.stringValue;
    [self.findAllModel loadWithCompletion:^(VZModel *model, NSError *error) {
        if (!error) {
            footerView.listArray = weakSelf.findAllModel.listArray;
        }
    }];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.debtItem) return 145;
    return 193;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 15;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString  *cellId = @"ProjectDetailsTableViewCell";
    ProjectDetailsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (cell ==nil) {
        cell = [[ProjectDetailsTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    
    cell.selectionStyle = UITableViewScrollPositionNone;
    cell.delegate = self;
    if ([_type isEqual:@"理财"]) {
        if (IsStrEmpty([_projectFinanceDic objectForKey:@"AvailableBalance"])) {
            cell.availableBalanceStr = @"0";
        }else{
            cell.availableBalanceStr = [NSString stringWithFormat:@"%@",[_projectFinanceDic objectForKey:@"AvailableBalance"]];
        }
        
        cell.type = @"理财";
        cell.investTextField.userInteractionEnabled = YES;
        if (_hongBaoArray.count == 0) {
            cell.hongbaoTextField.text = @"无可用现金券";
        }else{
            cell.hongbaoTextField.text = [NSString stringWithFormat:@"%ld个现金券可用",_hongBaoArray.count];
        }
        
//        cell.hongbaoArray = self.canUseHongBaoArr;
        cell.dic = _projectFinanceDic;
    } else {
        
        //  账户余额
        if (![_projectDetailsDic objectForKey:@"AvailableBalance"]) {
            cell.availableBalanceStr = @"0";
        } else {
            cell.availableBalanceStr = [_projectDetailsDic objectForKey:@"AvailableBalance"];
        }
        
        if (self.projectItem) {
            cell.investTextField.placeholder = @"请输入投资金额 10元/份";
            cell.typeLab.text = @"元";
            cell.threeLeftLab.text = @"预期收益";
            
            if (!cell.earningsTextField.text.length)
                cell.earningsTextField.text = @"元";
            
            //  1进行中（立即投资）,2待审核,3还款中,4还款结束,-10000不是新手，-1未开始
            if ([self.projectDetailModel.detailItem.statusid integerValue] == 1) {
                cell.projectInvestBtn.backgroundColor = BlueColor;
                [cell.projectInvestBtn setTitle:@"立即投资" forState:UIControlStateNormal];
            } else if ([self.projectDetailModel.detailItem.statusid integerValue] == 2)  {
                cell.projectInvestBtn.userInteractionEnabled = NO;
                cell.projectInvestBtn.backgroundColor = BlackCCCCCC;
                [cell.projectInvestBtn setTitle:@"待审核" forState:UIControlStateNormal];
            } else if ([self.projectDetailModel.detailItem.statusid integerValue] == 3) {
                cell.projectInvestBtn.userInteractionEnabled = NO;
                cell.projectInvestBtn.backgroundColor = BlackCCCCCC;
                [cell.projectInvestBtn setTitle:@"还款中" forState:UIControlStateNormal];
            } else if ([self.projectDetailModel.detailItem.statusid integerValue] == 4) {
                cell.projectInvestBtn.userInteractionEnabled = NO;
                cell.projectInvestBtn.backgroundColor = BlackCCCCCC;
                [cell.projectInvestBtn setTitle:@"还款结束" forState:UIControlStateNormal];
            } else if ([self.projectDetailModel.detailItem.statusid.stringValue isEqualToString:@"-10000"]) {
                cell.projectInvestBtn.userInteractionEnabled = NO;
                cell.projectInvestBtn.backgroundColor = BlackCCCCCC;
                [cell.projectInvestBtn setTitle:@"不是新手" forState:UIControlStateNormal];
            } else if ([self.projectDetailModel.detailItem.statusid.stringValue isEqualToString:@"-1"]) {
                cell.projectInvestBtn.userInteractionEnabled = NO;
                cell.projectInvestBtn.backgroundColor = BlackCCCCCC;
                [cell.projectInvestBtn setTitle:@"未开始" forState:UIControlStateNormal];
            }
            
            [cell.projectInvestBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [cell.projectInvestBtn addTarget:self action:@selector(btnClickEvent:) forControlEvents:UIControlEventTouchUpInside];
        } else {
            cell.isDebt = YES;
            cell.investTextField.placeholder = @"请输入整数份";
            cell.typeLab.text = @"份";
            cell.earningsTextField.text = [NSString stringWithFormat:@"%.2f元/份", [self.debtDetailModel.detailItem.share floatValue]];
            
            cell.threeLeftLab.text = [NSString stringWithFormat:@"购买金额(元) %.2f", [_investAmountStr floatValue] * [self.debtDetailModel.detailItem.share floatValue]];
            
            [cell.projectInvestBtn setTitle:@"立即投资" forState:UIControlStateNormal];
            [cell.projectInvestBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            cell.projectInvestBtn.backgroundColor = BlueColor;
            [cell.projectInvestBtn addTarget:self action:@selector(btnClickEvent:) forControlEvents:UIControlEventTouchUpInside];
        }
        
        cell.dic = _projectDetailsDic;
        cell.investTextField.userInteractionEnabled = YES;
        cell.investTextField.delegate = self;
        
        if (_hongBaoArray.count == 0) {
            cell.hongbaoTextField.text = @"无可用现金券";
            cell.hongBaoButton.userInteractionEnabled = NO;
        } else {
//不输入金额的时候，不显示现金券数量这里加了一盒（!）
            if (!IsStrEmpty(_investAmountStr)) {
                
                cell.hongbaoTextField.text = [NSString stringWithFormat:@"%ld个现金券可用",_hongBaoArray.count];
                cell.hongBaoButton.userInteractionEnabled = YES;
            }else{
                if (_hongBaoCount == 0) {
                    cell.hongbaoTextField.text = @"无可用现金券";
                    cell.hongBaoButton.userInteractionEnabled = NO;
                }else{
                    cell.hongbaoTextField.text = [NSString stringWithFormat:@"%ld个现金券可用",_hongBaoCount];
                    cell.hongBaoButton.userInteractionEnabled = YES;
                }
            }
            cell.getHongBaoArray = _hongBaoArray;
            cell.hongbaoArray = _canUseHongBaoArr;
        }
    }
    
    [cell.investTextField addTarget:self action:@selector(textFieldChange:) forControlEvents:UIControlEventEditingChanged];
    
    if (self.debtItem && [self.debtItem.selleruserid integerValue] == [User shareUser].userId) {
        [cell.projectInvestBtn setTitle:@"我的债权" forState:UIControlStateNormal];
        cell.projectInvestBtn.userInteractionEnabled = NO;
        cell.projectInvestBtn.backgroundColor = BlackCCCCCC;
    }
    
    return cell;
}

- (void)textFieldChange:(UITextField *)textField
{
    _investAmountStr = textField.text;

    if (self.debtItem) {
        ProjectDetailsTableViewCell * cell = [self.projectDetailsTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
        
        cell.investTextField.placeholder = @"请输入整数份";
        cell.typeLab.text = @"份";
        cell.earningsTextField.text = [NSString stringWithFormat:@"%.2f元/份", [self.debtDetailModel.detailItem.share floatValue]];
        
        cell.threeLeftLab.text = [NSString stringWithFormat:@"购买金额(元) %.2f", [_investAmountStr floatValue] * [self.debtDetailModel.detailItem.share floatValue]];

    }
    [_hongBaoArray removeAllObjects];
    [self getXianJinData];

}
- (void)getXianJinData
{
    if(IsStrEmpty(_investAmountStr))
    {
        return;
    }
    [self.httpUtil requestDic4MethodNam:@"v2/accept/project/findAllBouns" parameters:@{@"projectId":@(_projectId),@"amount":_investAmountStr} result:^(id dic, int status, NSString *msg) {
        NSLog(@"%@",dic);
        
        if (status == 0) {
            [MBProgressHUD showError:msg toView:self.view];
        }else{
            NSLog(@"%@",dic);
            
            [_hongBaoArray removeAllObjects];
            [_hongBaoArray addObjectsFromArray:dic];
            
            _nameArr = [NSMutableArray array];
            for (NSDictionary * dict in  _hongBaoArray) {
                [_nameArr addObject:[dict objectForKey:@"bounsName"]];
            }

            ProjectDetailsTableViewCell * cell = [self.projectDetailsTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
            if (_hongBaoArray.count == 0) {
                cell.hongbaoTextField.text = @"无可用现金券";
            }else{
                cell.hongbaoTextField.text = [NSString stringWithFormat:@"%ld个现金券可用",_hongBaoArray.count];
            }
            [self loadHongBaoArray];
            
        }
    }];
    
}
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"TextBeginHidePickerViewNoti" object:nil];
    
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    _hongBaoCount = 0;
    
    if (!IsStrEmpty(_investAmountStr)) {
        
        NSString *loanDateStr = @"";
        
        if ([[_projectDetailsDic objectForKey:@"PeriodTypeId"] integerValue] == 1) {
            loanDateStr = [NSString stringWithFormat:@"%ld",[[_projectDetailsDic objectForKey:@"LoanDate"] integerValue] / 30];
        }else if ([[_projectDetailsDic objectForKey:@"PeriodTypeId"] integerValue] == 2){
            loanDateStr = [NSString stringWithFormat:@"%@",[_projectDetailsDic objectForKey:@"LoanDate"]];
        }else if ([[_projectDetailsDic objectForKey:@"PeriodTypeId"] integerValue] == 3){
            loanDateStr = [NSString stringWithFormat:@"%ld",[[_projectDetailsDic objectForKey:@"LoanDate"] integerValue] * 12];
        }
        
        for (int i = 0; i < _hongBaoArray.count; i ++) {
            if ([_investAmountStr integerValue] >=[[_hongBaoArray[i] objectForKey:@"bidamount"] integerValue] && [loanDateStr integerValue] >= [[_hongBaoArray[i] objectForKey:@"loanperiod"] integerValue]) {
                
                _hongBaoCount ++;
            }
        }
    }
    [self.projectDetailsTableView reloadData];
    
}

- (IBAction)btnClickEvent:(id)sender {
    

    if ([AppDelegate checkLogin]){
        if ([[User userFromFile].isOpenAccount integerValue] == 0) {
            WebPageVC *vc = [[WebPageVC alloc] init];
            vc.title = @"开通汇付账户";
            vc.name = @"huifu/openaccount";
            [self.navigationController pushViewController:vc animated:YES];
            return;
        }
        NSLog(@"%@",[_projectDetailsDic objectForKey:@"IsNewLender"]);
        NSLog(@"%@",[_projectDetailsDic objectForKey:@"IsBid"]);

        if (self.projectItem && [[_projectDetailsDic objectForKey:@"IsNewLender"] integerValue] == 1 &&  [[_projectDetailsDic objectForKey:@"IsBid"] integerValue] == 1) {
            [MBProgressHUD showMessag:@"您已不是新手了，不能投资新手专享标" toView:self.view];
            return;
        }
        
        if (IsStrEmpty(_investAmountStr)) {
            [MBProgressHUD showMessag:@"请输入投资金额" toView:self.view];
            return;
        }
        NSLog(@"%@",[_projectDetailsDic objectForKey:@"BorrowerId"]);
        if ([[_projectDetailsDic objectForKey:@"BorrowerId"] integerValue] == [User shareUser].userId) {
            [MBProgressHUD showMessag:@"不能给自己投标" toView:self.view];
            return;
        }
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"您的每份合同,都具有法律效力" message:@"小金袋平台已和E签宝达成合作，e签宝是一款基于《中华人民共和国电子签名法》的互联网基础应用。 e签宝通过公钥密码技术、第三方电子认证技术、时间戳技术来生成可靠的电子签名。" delegate:self cancelButtonTitle:@"确认使用E签宝" otherButtonTitles:nil, nil];
        [alert show];


    }
    

}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
    if (self.projectItem) {
        
        
        if (_timer.isValid) {
            [_timer invalidate];
        }
        _timer = nil;
        
        self.investModel.projectId = self.projectItem.projectId;
        self.investModel.amount = _investAmountStr;
        self.investModel.sendId = _hongbaoid;
        NSLog(@"%@",_hongbaoid);

        WS
        [self.investModel loadWithCompletion:^(VZModel *model, NSError *error) {
            if (!error) {
                WebPageVC *vc = [WebPageVC new];
                vc.isHtmlString = YES;
                vc.name = [weakSelf.investModel.form stringByAppendingString:@"<script type=\"text/javascript\">document .getElementById('huifufrom').submit();</script>"];
                vc.title = @"投资确认";
                [weakSelf.navigationController pushViewController:vc animated:YES];
            } else {
                [MBProgressHUD showMessag:[error localizedDescription] toView:self.view];
            }
        }];
    } else {

        
        if (_timer.isValid) {
            [_timer invalidate];
        }
        _timer = nil;
        
        self.investModel.debtDealId = self.debtItem.debtdealid;
        self.investModel.quantity = [_investAmountStr integerValue];
        WS
        [self.investModel loadWithCompletion:^(VZModel *model, NSError *error) {
            if (!error) {
                WebPageVC *vc = [WebPageVC new];
                vc.isHtmlString = YES;
                vc.name = [weakSelf.investModel.form stringByAppendingString:@"<script type=\"text/javascript\">document .getElementById('huifufrom').submit();</script>"];
                vc.title = @"投资确认";
                [weakSelf.navigationController pushViewController:vc animated:YES];
            } else {
                [MBProgressHUD showMessag:[error localizedDescription] toView:self.view];
            }
        }];
    }

}

// 投资记录
- (IBAction)investCountClick:(id)sender {
    
    InvestRecodeViewController *investRecodeVC = [InvestRecodeViewController new];
    investRecodeVC.urlStr = @"project/bidinfo";
    investRecodeVC.projectId = _projectId;
    [self.navigationController pushViewController:investRecodeVC animated:YES];
}

//  项目详情

- (IBAction)projectDetailsClick:(id)sender {
    
    ProjectIntroduceDetailViewController *projectIntroduceVC = [ProjectIntroduceDetailViewController new];
    projectIntroduceVC.projectId = _projectId;
    NSLog(@"test==%d",_projectId);
    [self.navigationController pushViewController:projectIntroduceVC animated:YES];
}

- (void)projectTableViewCell:(ProjectDetailsTableViewCell *)cell supportProject:(id)project
{
    if ([AppDelegate checkLogin]) {
        
        
        if ([[User userFromFile].isOpenAccount integerValue] == 0) {
            WebPageVC *vc = [[WebPageVC alloc] init];
            vc.title = @"开通汇付账户";
            vc.name = @"huifu/openaccount";
            [self.navigationController pushViewController:vc animated:YES];
            return;
        }

        [self.httpUtil requestDic4MethodNam:@"v2/accept/user/findExpressBankCard" parameters:nil result:^(id dic, int status, NSString *msg) {
            
            if (status == 0) {
                WebPageVC *vc = [[WebPageVC alloc] init];
                vc.title = @"充值";
                vc.name = @"recharge";
                [self.navigationController pushViewController:vc animated:YES];
            }else{
                BankNewTopUpViewController * bankVC = [BankNewTopUpViewController new];
                [self.navigationController pushViewController:bankVC animated:YES];
            }
        }];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
