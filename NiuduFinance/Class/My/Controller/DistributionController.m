//
//  DistributionController.m
//  NiuduFinance
//
//  Created by 123 on 17/3/23.
//  Copyright © 2017年 liuyong. All rights reserved.
//

#import "DistributionController.h"
@interface DistributionController ()<UITextFieldDelegate>
@property (nonatomic, strong)UIView * firstView;
@property (nonatomic, strong)UILabel * titleLabel;
//好友
@property (nonatomic, strong)UILabel * friendsLabel;
@property (nonatomic, strong)UITextField * friendsField;
@property (nonatomic, strong)UILabel * friendsPercent;
//我的
@property (nonatomic, strong)UILabel * myLabel;
@property (nonatomic, strong)UITextField * myField;
@property (nonatomic, strong)UILabel * myPercent;

@property (nonatomic, strong)UILabel * myInvitation;
@property (nonatomic, strong)UILabel * myPerc;

@property (nonatomic, strong)UIButton * sureBtn;

@property (nonatomic, assign)float floatS;

@end

@implementation DistributionController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _firstView = [UIView new];
    _firstView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_firstView];
    [_firstView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.bottom.mas_equalTo(0);
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH, SCREEN_HEIGHT));
    }];
    
    _titleLabel = [UILabel new];
    [_titleLabel setText:@"加息比例"];
    _titleLabel.textAlignment = NSTextAlignmentCenter;
    [_titleLabel setFont:[UIFont systemFontOfSize:17]];
    [self.firstView addSubview:_titleLabel];
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(10);
        make.centerX.mas_equalTo(0);
        make.size.mas_equalTo(CGSizeMake(100, 30));
    }];
    
    _friendsLabel = [UILabel new];
    [_friendsLabel setText:@"好友加息："];
    _friendsLabel.textAlignment = NSTextAlignmentCenter;
    [_friendsLabel setFont:[UIFont systemFontOfSize:14]];
    [self.firstView addSubview:_friendsLabel];
    [_friendsLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_titleLabel.mas_bottom).with.offset(20);
        make.right.equalTo(_titleLabel.mas_left).with.offset(20);
    }];
    
    _friendsField = [UITextField new];
    _friendsField.delegate = self;
    _friendsField.font = [UIFont systemFontOfSize:14];
    _friendsField.borderStyle = UITextBorderStyleBezel;
    _friendsField.tag = 100;
    [_friendsField addTarget:self action:@selector(editDidEnd:) forControlEvents:UIControlEventEditingChanged];
    [self.firstView addSubview:_friendsField];
    [_friendsField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_friendsLabel.mas_centerY);
        make.left.equalTo(_friendsLabel.mas_right);
        make.size.mas_equalTo(CGSizeMake(100, 25));
    }];
    
    _friendsPercent = [UILabel new];
    [_friendsPercent setText:@"%"];
    [_friendsPercent setFont:[UIFont systemFontOfSize:12]];
    [self.firstView addSubview:_friendsPercent];
    [_friendsPercent mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_friendsField.mas_right).with.offset(3);
        make.bottom.equalTo(_friendsField.mas_bottom);
    }];
    
    
    _myLabel = [UILabel new];
    [_myLabel setText:@"我的加息："];
    _myLabel.textAlignment = NSTextAlignmentCenter;
    [_myLabel setFont:[UIFont systemFontOfSize:14]];
    [self.firstView addSubview:_myLabel];
    [_myLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_friendsLabel.mas_bottom).with.offset(20);
        make.right.equalTo(_titleLabel.mas_left).with.offset(20);
    }];
    
    _myField = [UITextField new];
    _myField.tag = 200;
    _myField.font = [UIFont systemFontOfSize:14];
    _myField.borderStyle = UITextBorderStyleBezel;
    [_myField addTarget:self action:@selector(editDidEnd:) forControlEvents:UIControlEventEditingChanged];
    [self.firstView addSubview:_myField];
    [_myField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_myLabel.mas_centerY);
        make.left.equalTo(_myLabel.mas_right);
        make.size.mas_equalTo(CGSizeMake(100, 25));
    }];
    
    _myPercent = [UILabel new];
    [_myPercent setText:@"%"];
    [_myPercent setFont:[UIFont systemFontOfSize:12]];
    [self.firstView addSubview:_myPercent];
    [_myPercent mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_myField.mas_right).with.offset(3);
        make.bottom.equalTo(_myField.mas_bottom);
    }];
    
    _myInvitation = [UILabel new];
    [_myInvitation setFont:[UIFont systemFontOfSize:14]];
    [self.firstView addSubview:_myInvitation];
    [_myInvitation mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_myLabel.mas_bottom).with.offset(23);
        make.centerX.mas_equalTo(0);
    }];
    
    _myPerc = [UILabel new];
    [_myPerc setText:@"%"];
    [_myPerc setFont:[UIFont systemFontOfSize:14]];
    [self.firstView addSubview:_myPerc];
    [_myPerc mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_myInvitation.mas_right);
        make.bottom.equalTo(_myInvitation.mas_bottom);
    }];
    
    _sureBtn = [UIButton new];
    _sureBtn.layer.cornerRadius = 6.0f;
    [_sureBtn setTitle:@"确定" forState:UIControlStateNormal];
    [_sureBtn setBackgroundColor:[UIColor colorWithHexString:@"#019BFF"]];
    [_sureBtn addTarget:self action:@selector(sureBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    _sureBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [self.firstView addSubview:_sureBtn];
    [_sureBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_myInvitation.mas_bottom).with.offset(30);
        make.size.mas_equalTo(CGSizeMake(100, 28));
        make.centerX.mas_equalTo(0);
    }];
    
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self setupNavi];
    
}
- (void)setupNavi
{
    [self.navigationController setNavigationBarHidden:NO animated:NO];
    self.title = @"加息分配";
    UIButton *customView = [UIButton buttonWithType:UIButtonTypeCustom];
    customView.frame = CGRectMake(0, 0, 44, 44);
    customView.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [customView setImage:[UIImage imageNamed:@"nav_back_normal"] forState:UIControlStateNormal];
    [customView addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:customView];
}

- (void)setId:(int)Id
{
    _Id = Id;
    NSLog(@"%d",_Id);
    
}
- (void)setUserId:(int)userId
{
    _userId = userId;
    [self setInviteReward];
    
}
//获取我的邀请加息
- (void)setInviteReward
{
    
    [self.httpUtil requestDic4MethodNam:@"v2/accept/user/inviteReward" parameters:@{@"userId":@(_userId)} result:^(NSDictionary *dic, int status, NSString *msg) {
        NSLog(@"%@",dic);
        if (status == 0) {
            [MBProgressHUD showMessag:msg toView:self.view];

        }else{
            self.hideNoNetWork = YES;
            _myInvitation.text = [NSString stringWithFormat:@"我的邀请加息为%@",[dic objectForKey:@"rate"]];
            NSLog(@"%@",_myInvitation.text);
            NSString * ssss = [NSString stringWithFormat:@"%@",[dic objectForKey:@"rate"]];
            _floatS = [ssss floatValue];


        }
    }];
    
}

#pragma mark TextField
- (void)editDidEnd:(id)sender {
    UITextField *textField = sender;
    CGFloat value = [textField.text floatValue];
    if (0.0f < value && value < _floatS) {
        CGFloat value2 = _floatS - value;
        NSString *str = [NSString stringWithFormat:@"%.2f",value2];
        if (textField.tag == 100) {
            _myField.text = str;
        } else {
            _friendsField.text = str;
        }
    } else {
        
        [MBProgressHUD showMessag:@"只能输入加息范围的数值,不能为负数" toView:self.view];
    }
}

//只能输入小数点后两位
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    
    NSMutableString * future = [NSMutableString stringWithString:textField.text];
    [future  insertString:string atIndex:range.location];
    
    NSInteger flag=0;
    const NSInteger limited = 2;
    for (int i = future.length-1; i>=0; i--) {
        
        if ([future characterAtIndex:i] == '.') {
            
            if (flag > limited) {
                [MBProgressHUD showMessag:@"只能输入2位小数点" toView:self.view];
                return NO;
                
            }
            
            break;
        }
        flag++;
    }
    
    return YES;
}

- (void)sureBtnClick:(UIButton *)sender
{
    NSLog(@"%@",_myField.text);
    [self.httpUtil requestDic4MethodNam:@"v2/accept/user/assignCoupon" parameters:@{@"id":@(_Id),@"inviteRate":_myField.text} result:^(NSDictionary *dic, int status, NSString *msg) {
        NSLog(@"%@",dic);
        
        if (status == 0) {
            [MBProgressHUD showMessag:msg toView:self.view];
            
        }else{
            self.hideNoNetWork = YES;
            [self.navigationController popViewControllerAnimated:YES];
        }
    }];
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
