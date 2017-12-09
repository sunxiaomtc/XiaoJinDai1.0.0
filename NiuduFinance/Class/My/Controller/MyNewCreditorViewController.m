//
//  MyNewCreditorViewController.m
//  NiuduFinance
//
//  Created by 123 on 17/2/20.
//  Copyright © 2017年 liuyong. All rights reserved.
//

#import "MyNewCreditorViewController.h"
#import "TransferViewController.h"
#import "MyCreditorViewController.h"

@interface MyNewCreditorViewController ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic,strong)UIView * setUpView;
@property (nonatomic,strong)UILabel * setLabel;
@property (nonatomic,strong)UIView * lineView;
//转让单价
@property (nonatomic,strong)UILabel * danpriceLabel;
@property (nonatomic,strong)UITextField * scopeTextField;
//元/份
@property (nonatomic,strong)UILabel * eachLabel;
//范围
@property (nonatomic,strong)UILabel * theScopeLabel;
@property (nonatomic,strong)UIImageView * imageView;
@property (nonatomic,strong)UILabel * theMaxLabel;



@property (nonatomic,strong)UIView * lineTwoView;
//总价
@property (nonatomic,strong)UILabel * totalPriceLabel;
//转让人收益率
@property (nonatomic,strong)UILabel * assignorLabel;
@property (nonatomic,strong)UIView * threeView;
//折价金额
@property (nonatomic,strong)UILabel * discountLabel;
//受让人收益率
@property (nonatomic,strong)UILabel * receivinLabel;


//债权情况
@property (nonatomic,strong)UIView * detailsView;
@property (nonatomic,strong)UILabel * detailsLabel;
@property (nonatomic,strong)UIView * linView;
//价值
@property (nonatomic,strong)UILabel * valueLabel;
//时间
@property (nonatomic,strong)UILabel * timeLabel;
//
@property (nonatomic,strong)UIView * linTwoView;
//待回款
@property (nonatomic,strong)UILabel * receivableLabel;
//剩余期限
@property (nonatomic,strong)UILabel * yutimeLabel;


//
@property (nonatomic,strong)UIView * linThreeView;
//已回款
@property (nonatomic,strong)UILabel * hasReceivableLabel;
@property (nonatomic,strong)UILabel * principalLabel;
@property (nonatomic,strong)UIView * linfourView;


@property (nonatomic,strong)UIButton * nextBtn;


@property (nonatomic,strong)NSDictionary * projectDic;
@end

@implementation MyNewCreditorViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _setUpView = [UIView new];
    _setUpView.frame = CGRectMake(0, 10, SCREEN_WIDTH, 212);
    _setUpView.backgroundColor = [UIColor whiteColor];
    [self.tableView addSubview:_setUpView];
    
    
    
    _setLabel = [UILabel new];
    [_setLabel setText:@"转让设置"];
    [_setLabel setFont:[UIFont systemFontOfSize:16]];
    [_setUpView addSubview:_setLabel];
    [_setLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(16);
        make.left.mas_equalTo(15);
    }];
    
    _lineView = [UIView new];
    [_lineView setBackgroundColor:[UIColor colorWithHexString:@"#F5F5F5"]];
    [_setUpView addSubview:_lineView];
    [_lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(45);
        make.left.mas_equalTo(15);
        make.right.mas_equalTo(0);
        make.height.mas_equalTo(2);
    }];
    
    _danpriceLabel = [UILabel new];
    [_danpriceLabel setText:@"转让单价:"];
    [_danpriceLabel setFont:[UIFont systemFontOfSize:14]];
    [_setUpView addSubview:_danpriceLabel];
    [_danpriceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_lineView.mas_bottom).with.offset(13);
        make.left.mas_offset(32);
    }];
    
    _scopeTextField = [UITextField new];
    _scopeTextField.placeholder = @"转让单价不可超出范围";
    [_scopeTextField setFont:[UIFont systemFontOfSize:13]];
    [_scopeTextField addTarget:self action:@selector(textFieldChange:) forControlEvents:UIControlEventEditingChanged];
    [_setUpView addSubview:_scopeTextField];
    [_scopeTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_danpriceLabel.mas_right).with.offset(9);
        make.bottom.equalTo(_danpriceLabel.mas_bottom).with.offset(0);
    }];
    
    
    _eachLabel = [UILabel new];
    [_eachLabel setText:@"元/份"];
    [_eachLabel setFont:[UIFont systemFontOfSize:14]];
    [_setUpView addSubview:_eachLabel];
    [_eachLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-35);
        make.bottom.equalTo(_danpriceLabel.mas_bottom).with.offset(0);
    }];
    
    
    _imageView = [UIImageView new];
    UIImage * image = [UIImage imageNamed:@"0.7.png"];
    _imageView.image = image;
    [_setUpView addSubview:_imageView];
    [_imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_scopeTextField.mas_left).with.offset(0);
        make.top.equalTo(_scopeTextField.mas_bottom).with.offset(15);
    }];
    
    _theScopeLabel = [UILabel new];
    //    [_theScopeLabel setText:@"范围0.00~10.1119"];
    [_theScopeLabel setFont:[UIFont systemFontOfSize:13]];
    [_theScopeLabel setTextColor:[UIColor colorWithHexString:@"#019BFF"]];
    [_setUpView addSubview:_theScopeLabel];
    [_theScopeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_imageView.mas_right).with.offset(5);
        make.bottom.equalTo(_imageView.mas_bottom).with.offset(2);
    }];
    
    _theMaxLabel = [UILabel new];
    [_theMaxLabel setFont:[UIFont systemFontOfSize:13]];
    [_theMaxLabel setTextColor:[UIColor colorWithHexString:@"#019BFF"]];
    [_setUpView addSubview:_theMaxLabel];
    [_theMaxLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_theScopeLabel.mas_right).with.offset(5);
        make.bottom.equalTo(_theScopeLabel.mas_bottom).with.offset(0);
    }];
    
    
    _lineTwoView = [UIView new];
    [_lineTwoView setBackgroundColor:[UIColor colorWithHexString:@"#F5F5F5"]];
    [_setUpView addSubview:_lineTwoView];
    [_lineTwoView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_theScopeLabel.mas_bottom).with.offset(15);
        make.left.mas_equalTo(15);
        make.right.mas_equalTo(0);
        make.height.mas_equalTo(1);
    }];
    
    
    _totalPriceLabel = [UILabel new];
    [_totalPriceLabel setText:@"转让总价：0.00元"];
    [_totalPriceLabel setFont:[UIFont systemFontOfSize:14]];
    [_setUpView addSubview:_totalPriceLabel];
    [_totalPriceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_lineTwoView.mas_bottom).with.offset(15);
        make.left.mas_equalTo(32);
    }];
    
    
    _assignorLabel = [UILabel new];
    [_assignorLabel setText:@"转让人收益率：0.00%"];
    [_assignorLabel setFont:[UIFont systemFontOfSize:14]];
    [_setUpView addSubview:_assignorLabel];
    [_assignorLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(_totalPriceLabel.mas_bottom).with.offset(0);
        make.right.mas_equalTo(-33);
    }];
    
    _threeView = [UIView new];
    [_threeView setBackgroundColor:[UIColor colorWithHexString:@"#F5F5F5"]];
    [_setUpView addSubview:_threeView];
    [_threeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_totalPriceLabel.mas_bottom).with.offset(16);
        make.left.mas_equalTo(15);
        make.right.mas_equalTo(0);
        make.height.mas_equalTo(1);
    }];

    
    _discountLabel = [UILabel new];
    [_discountLabel setText:@"折价金额：0.00元"];
    [_discountLabel setFont:[UIFont systemFontOfSize:14]];
    [_setUpView addSubview:_discountLabel];
    [_discountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_threeView.mas_bottom).with.offset(14);
        make.left.mas_equalTo(32);
    }];
    
    
    _receivinLabel = [UILabel new];
    [_receivinLabel setText:@"受让人收益率：0.00%"];
    [_receivinLabel setFont:[UIFont systemFontOfSize:14]];
    [_setUpView addSubview:_receivinLabel];
    [_receivinLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(_discountLabel.mas_bottom).with.offset(0);
        make.left.equalTo(_assignorLabel.mas_left).with.offset(0);
    }];
    
    
    _detailsView = [UIView new];
    _detailsView.backgroundColor = [UIColor whiteColor];
    _detailsView.frame = CGRectMake(0, _setUpView.height+20, SCREEN_WIDTH, 212);
    [self.tableView addSubview:_detailsView];
    
    _detailsLabel = [UILabel new];
    [_detailsLabel setText:@"债权情况"];
    [_detailsLabel setFont:[UIFont systemFontOfSize:16]];
    [_detailsView addSubview:_detailsLabel];
    [_detailsLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(16);
        make.left.mas_equalTo(15);
    }];
    
    _linView = [UIView new];
    [_linView setBackgroundColor:[UIColor colorWithHexString:@"#F5F5F5"]];
    [_detailsView addSubview:_linView];
    [_linView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(45);
        make.left.mas_equalTo(15);
        make.right.mas_equalTo(0);
        make.height.mas_equalTo(2);
    }];
    
    _valueLabel = [UILabel new];
//    [_valueLabel setText:@"债券价值：1000000元"];
    [_valueLabel setFont:[UIFont systemFontOfSize:14]];
    [_detailsView addSubview:_valueLabel];
    [_valueLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_linView.mas_bottom).with.offset(15);
        make.left.mas_equalTo(32);
    }];
    
    
    _timeLabel = [UILabel new];
//    [_timeLabel setText:@"持有时间：30天"];
    [_timeLabel setFont:[UIFont systemFontOfSize:14]];
    [_detailsView addSubview:_timeLabel];
    [_timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(_valueLabel.mas_bottom).with.offset(0);
        make.right.mas_equalTo(-65);
    }];
    
    
    _linTwoView = [UIView new];
    [_linTwoView setBackgroundColor:[UIColor colorWithHexString:@"#F5F5F5"]];
    [_detailsView addSubview:_linTwoView];
    [_linTwoView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_valueLabel.mas_bottom).with.offset(16);
        make.left.mas_equalTo(15);
        make.right.mas_equalTo(0);
        make.height.mas_equalTo(1);
    }];
    
    
    _receivableLabel = [UILabel new];
//    [_receivableLabel setText:@"待回款：222000元"];
    [_receivableLabel setFont:[UIFont systemFontOfSize:14]];
    [_detailsView addSubview:_receivableLabel];
    [_receivableLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_linTwoView.mas_bottom).with.offset(14);
        make.left.mas_equalTo(32);
    }];
    
    
    _yutimeLabel = [UILabel new];
//    [_yutimeLabel setText:@"剩余期限：60天"];
    [_yutimeLabel setFont:[UIFont systemFontOfSize:14]];
    [_detailsView addSubview:_yutimeLabel];
    [_yutimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(_receivableLabel.mas_bottom).with.offset(0);
        make.left.equalTo(_timeLabel.mas_left).with.offset(0);
    }];
    
    _linThreeView = [UIView new];
    [_linThreeView setBackgroundColor:[UIColor colorWithHexString:@"#F5F5F5"]];
    [_detailsView addSubview:_linThreeView];
    [_linThreeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_receivableLabel.mas_bottom).with.offset(16);
        make.left.mas_equalTo(15);
        make.right.mas_equalTo(0);
        make.height.mas_equalTo(1);
    }];
    
    
    _hasReceivableLabel = [UILabel new];
//    [_hasReceivableLabel setText:@"已回款：222元"];
    [_hasReceivableLabel setFont:[UIFont systemFontOfSize:14]];
    [_detailsView addSubview:_hasReceivableLabel];
    [_hasReceivableLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_linThreeView.mas_bottom).with.offset(14);
        make.left.mas_equalTo(32);
    }];
    
    
    _principalLabel = [UILabel new];
    //    [_principalLabel setText:@"剩余期限：60天"];
    [_principalLabel setFont:[UIFont systemFontOfSize:14]];
    [_detailsView addSubview:_principalLabel];
    [_principalLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(_hasReceivableLabel.mas_bottom).with.offset(0);
        make.left.equalTo(_timeLabel.mas_left).with.offset(0);
    }];
    
    _linfourView = [UIView new];
    [_linfourView setBackgroundColor:[UIColor colorWithHexString:@"#F5F5F5"]];
    [_detailsView addSubview:_linfourView];
    [_linfourView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_hasReceivableLabel.mas_bottom).with.offset(16);
        make.left.mas_equalTo(15);
        make.right.mas_equalTo(0);
        make.height.mas_equalTo(1);
    }];
    
    
    _nextBtn = [UIButton new];
    _nextBtn.clipsToBounds=YES;
    _nextBtn.layer.cornerRadius=5;
    _nextBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    [_nextBtn setTitle:@"下一步" forState:UIControlStateNormal];
    [_nextBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_nextBtn setBackgroundColor:[UIColor colorWithHexString:@"#019BFF"]];
    [_nextBtn addTarget:self action:@selector(nextClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.tableView addSubview:_nextBtn];
    [_nextBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_setUpView.height+10+20+_detailsView.height+24);
        make.left.mas_equalTo(10);
        make.right.mas_equalTo(-10);
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH-20, 45));
    }];
    
    

    
}

- (void)setProjectId:(int)projectId
{
    _projectId = projectId;
    
    NSLog(@"%d",_projectId);
    [self getTransfer];
}




- (void)getTransfer
{

    NSLog(@"%d",_projectId);
    [self.httpUtil requestDic4MethodNam:@"v2/accept/debt/mayTransgerDetail" parameters:@{@"id":@(_projectId)} result:^(NSDictionary * dic, int status, NSString *msg) {
        NSLog(@"%@",dic);
        if (status == 0) {
            [MBProgressHUD showMessag:msg toView:self.view];
        }else{
            self.hideNoNetWork = YES;
            NSLog(@"%@",dic);
            
            _projectDic = dic;
            _valueLabel.text = [NSString stringWithFormat:@"债权价值：%.2f元",[[dic objectForKey:@"receivableValue"] floatValue]];
            _receivableLabel.text = [NSString stringWithFormat:@"待回款：%.2f元",[[dic objectForKey:@"receivableAmount"] floatValue]];
            _hasReceivableLabel.text = [NSString stringWithFormat:@"已回款：%.2f元",[[dic objectForKey:@"repayAmount"] floatValue]];
            _principalLabel.text = [NSString stringWithFormat:@"持有本金：%.2f元",[[dic objectForKey:@"receivablePrincipal"] floatValue]];
            _timeLabel.text = [NSString stringWithFormat:@"持有时间：%@天",[dic objectForKey:@"postDays"] ];
            _yutimeLabel.text = [NSString stringWithFormat:@"剩余期限：%@天",[dic objectForKey:@"remainDays"]];
            NSString * min= [_projectDic objectForKey:@"minAmount"];
            NSString * max= [_projectDic objectForKey:@"maxAmount"];
            float minmax = [min floatValue];
            _theScopeLabel.text = [NSString stringWithFormat:@"范围：%.4f",minmax];
            float maxmin = [max floatValue];
            _theMaxLabel.text = [NSString stringWithFormat:@"~%.4f",maxmin];
            
            NSLog(@"%@",_theScopeLabel.text);
            
            [_tableView.mj_footer resetNoMoreData];
            
        }
        [_tableView reloadData];
        
    }];
}

-(void)textFieldChange:(UITextField *)theTextField
{    
    NSString * min= [_projectDic objectForKey:@"minAmount"];
    double minAmount = [min doubleValue];
    NSString * max= [_projectDic objectForKey:@"maxAmount"];
    double  maxAmount= [max doubleValue];
    NSLog(@"%@",theTextField.text);
    
    NSString * ste = [NSString stringWithFormat:@"%@",theTextField.text];
    _price = [ste floatValue];
    if (maxAmount < _price ) {
     [MBProgressHUD showError:@"价格太高了,必须在范围内" toView:self.view];
    }
    if (minAmount >_price) {
     [MBProgressHUD showError:@"价格太低了,必须在范围内" toView:self.view];
    }
    
    //总份数
    NSString * copie = [_projectDic objectForKey:@"copies"];
    float copies = [copie floatValue];
    NSLog(@"%.2f",copies);
    //持有本金
    NSString * receivablePrincipa = [_projectDic objectForKey:@"receivablePrincipal"];
    float receivablePrincipal = [receivablePrincipa floatValue];
    
    //输入单价
    NSString * scopeTextField = _scopeTextField.text;
    float textFiled = [scopeTextField floatValue];

    //份数
    float number = receivablePrincipal/10;
    //折价
    float discountLabel = receivablePrincipal - textFiled * number;

    
    _discountLabel.text = [NSString stringWithFormat:@"折价金额：%.2f",discountLabel];
    
    
    //持有天数
    NSString * timeLabe = [_projectDic objectForKey:@"postDays"];
    float time = [timeLabe floatValue];

    //转让总价
    float totalPriceLabe = number * textFiled;
    _totalPriceLabel.text = [NSString stringWithFormat:@"转让总价：%.2f",totalPriceLabe];
    
    //手续费=转让总价*0.001
    //转让人收益率 =（已收回款-折价-手续费）/持有本金/持有天数*365*1*100
    
    //持有本金
    NSString * principalLabe =[_projectDic objectForKey:@"receivablePrincipal"];
    float principalLabel = [principalLabe intValue];
    
    //已收回款
    double repayAmount = [[_projectDic objectForKey:@"repayAmount"] doubleValue];
    
    
    float a = repayAmount - discountLabel - (copies * textFiled) * 0.001;
    float b =  a / principalLabel;
    float assignorLabel = b / time * 365 * 1 * 100;
    
    if (time == 0) {
        _assignorLabel.text = @"转让人收益率：0.00%";
    }else{
        _assignorLabel.text =[NSString stringWithFormat:@"转让人收益率：%.2f%@", assignorLabel, @"%"];
    }
    
    //剩余天数
    NSString * yuTime = [_projectDic objectForKey:@"remainDays"];
    float yuTim = [yuTime floatValue];
    
    NSString * receivableAmoun = [_projectDic objectForKey:@"receivableAmount"];
    float receivableAmount = [receivableAmoun floatValue];
    
    //受让人收益率=(待回款-转让总价)/转让总价/剩余天数*365*1/0.995*100;
    float receivinLabe = (receivableAmount - totalPriceLabe) / totalPriceLabe / yuTim * 365*1 / 0.995*100;
    
    if (yuTim == 0) {
        _receivinLabel.text = @"受让人收益率：0.00%";
    }else{
        _receivinLabel.text = [NSString stringWithFormat:@"受让人收益率：%.2f%@", receivinLabe, @"%"];
    }
    
}


- (void)nextClick:(UIButton *)sender
{
    
    if (_price == 0) {
        [MBProgressHUD showError:@"请输入转让单价" toView:self.view];
        return;
    }else{
        TransferViewController * vc = [TransferViewController new];
        vc.projectId = [[_projectDic objectForKey:@"projectId" ]intValue];
        vc.price = *(&(_price));
        vc.projectDic = _projectDic;
        [self.navigationController pushViewController:vc animated:YES];
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 0;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 0;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = (UITableViewCell*)[tableView  dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    return cell;
}

@end
