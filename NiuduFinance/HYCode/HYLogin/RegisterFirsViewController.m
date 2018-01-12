//
//  RegisterFirsViewController.m
//  NiuduFinance
//
//  Created by 123 on 17/2/5.
//  Copyright © 2017年 liuyong. All rights reserved.
//

#import "RegisterFirsViewController.h"
#import "ValidateUtil.h"
#import "GestureViewController.h"
#import "User.h"
#import "AppDelegate.h"
#import "PCCircleViewConst.h"
#import "LoginViewController.h"
#import "TabBarController.h"
#import "PageWebViewController.h"

@interface RegisterFirsViewController ()<UITableViewDataSource,UITableViewDelegate,GestureViewControllerDelegate,UITextFieldDelegate,UIAlertViewDelegate>{
    
    int timerSecond;
}
@property(nonatomic, strong)UIImageView *passwordShowImageView;
@property(nonatomic, strong)UIButton *passwordShowImageViewButton;
@property (strong, nonatomic) NSTimer *deadTimer;
@property(nonatomic, strong)UITableView *tableView;
@property (nonatomic, strong) UILabel * phoneLabel;
@property (nonatomic, strong) UITextField * phoneTextField;
@property (nonatomic, strong) UILabel * nameLabel;
@property (nonatomic, strong) UITextField * nameTextField;
@property (nonatomic, strong) UILabel * pwsLabel;
@property (nonatomic, strong) UITextField * pwsTextField;
@property (nonatomic, strong) UILabel * surePwsLabel;
@property (nonatomic, strong) UITextField * surePwsTextField;
@property (nonatomic, strong) UILabel * invitationLabel;
@property (nonatomic, strong) UITextField * invitationTextField;
@property (nonatomic, strong) UILabel * verificationLabel;
@property (nonatomic, strong) UITextField * verificationTextField;
@property (nonatomic, strong) UIButton * verifiBtn;
@property (nonatomic, strong)UITextField *codeField;

@property (nonatomic, strong) UILabel * yanLabel;
@property (nonatomic, strong) UIButton * yanBtn;

@property (nonatomic,strong) NSDictionary *numDic;
@property (nonatomic,strong) User * user;

@end
#define kHeaderViewHeight 166

@implementation RegisterFirsViewController

#pragma mark get checkNumber

-(void)viewWillAppear:(BOOL)animated{
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    //使用NSNotificationCenter 键盘隐藏时
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillBeHidden:) name:UIKeyboardWillHideNotification object:nil];
}

-(void)flashBtnStatus{
    timerSecond --;
    if (timerSecond == 0) {
//        _verifiBtn.backgroundColor = [UIColor colorWithHexString:@"#fcf0ea"];
        _verifiBtn.backgroundColor = [UIColor whiteColor];
        [_verifiBtn setTitle:@"重新获取" forState:UIControlStateNormal];
        [_verifiBtn setTitleColor:[UIColor colorWithHexString:@"#F1835F"] forState:UIControlStateNormal];
        _verifiBtn.userInteractionEnabled = YES;
        [self stopTimer];
    }else{
        
        [_verifiBtn setTitle:[NSString stringWithFormat:@"获取中(%d)",timerSecond] forState:UIControlStateNormal];
    }
}
-(void)startTimer{
    if (!self.deadTimer) {
        timerSecond = 60;
//        _verifiBtn.backgroundColor = [UIColor colorWithHexString:@"#f0f0f0"];
        _verifiBtn.backgroundColor = [UIColor whiteColor];
        [_verifiBtn setTitleColor:[UIColor colorWithHexString:@"#bfbfbf"] forState:UIControlStateNormal];
        [_verifiBtn setTitle:[NSString stringWithFormat:@"获取中(%d)",timerSecond] forState:UIControlStateNormal];
        _verifiBtn.userInteractionEnabled = NO;
        self.deadTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(flashBtnStatus) userInfo:nil repeats:YES];
    }
}
-(void)stopTimer{
    [self.deadTimer invalidate];
    self.deadTimer = nil;
}
-(void)dealloc{
    //移除通知
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [self stopTimer];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _numDic = [NSDictionary dictionary];
    
    _phoneLabel = [UILabel new];
    _phoneLabel.text = @"手机号码：";
    _phoneLabel.font = [UIFont systemFontOfSize:15];
    
    _phoneTextField = [UITextField new];
    _phoneTextField.placeholder = @"请输入手机号码";
    _phoneTextField.clearButtonMode = UITextFieldViewModeAlways;
    _phoneTextField.delegate = self;
    _phoneTextField.font = [UIFont systemFontOfSize:14];
    [_phoneTextField addTarget:self action:@selector(textFieldChange:) forControlEvents:UIControlEventEditingChanged];
    _phoneTextField.keyboardType = UIKeyboardTypeNumberPad;
    
    _nameLabel = [UILabel new];
    _nameLabel.text = @"用  户  名:";
    _nameLabel.font = [UIFont systemFontOfSize:15];
    
    _nameTextField = [UITextField new];
    _nameTextField.placeholder = @"请输入用户名";
    _nameTextField.font = [UIFont systemFontOfSize:14];

    _pwsLabel = [UILabel new];
    _pwsLabel.text = @"密        码:";
    _pwsLabel.font = [UIFont systemFontOfSize:15];
    
    _pwsTextField = [UITextField new];
    _pwsTextField.placeholder = @"8-16位数字字母组合";
    _pwsTextField.secureTextEntry = YES;
    _pwsTextField.font = [UIFont systemFontOfSize:14];
    _pwsTextField.delegate = self;
    [_pwsTextField addTarget:self action:@selector(textFieldChange:) forControlEvents:UIControlEventEditingChanged];
    
    // 输入右侧删除按钮
    _pwsTextField.clearButtonMode = UITextFieldViewModeAlways;
    
    _surePwsLabel = [UILabel new];
    _surePwsLabel.text = @"确认密码:";
    _surePwsLabel.font = [UIFont systemFontOfSize:15];
    
    _surePwsTextField = [UITextField new];
    _surePwsTextField.secureTextEntry = YES;
    _surePwsTextField.placeholder = @"请再次输入密码";
    _surePwsTextField.font = [UIFont systemFontOfSize:14];
    [_surePwsTextField addTarget:self action:@selector(textFieldChange:) forControlEvents:UIControlEventEditingChanged];
    [_surePwsTextField setAutocorrectionType:UITextAutocorrectionTypeNo];
    
    _invitationLabel = [UILabel new];
    _invitationLabel.text = @"邀  请  人:";
    _invitationLabel.font = [UIFont systemFontOfSize:15];
    
    _invitationTextField = [UITextField new];
    _invitationTextField.placeholder = @"请输入码，可以为空";
    _invitationTextField.font = [UIFont systemFontOfSize:14];
    
    _verificationLabel = [UILabel new];
    _verificationLabel.text = @"验  证  码:";
    _verificationLabel.font = [UIFont systemFontOfSize:15];
    
    _verificationTextField = [UITextField new];
    _verificationTextField.delegate = self;
    _verificationTextField.keyboardType = UIKeyboardTypeNumberPad;
    _verificationTextField.placeholder = @"请输入验证码";
    _verificationTextField.font = [UIFont systemFontOfSize:14];
    [_verificationTextField addTarget:self action:@selector(textFieldChange:) forControlEvents:UIControlEventEditingChanged];
    
    
    _verifiBtn = [UIButton new];
    _verifiBtn.layer.cornerRadius = 5.0f;
    //交互性
    _verifiBtn.userInteractionEnabled = YES;
    _verifiBtn.titleLabel.font = [UIFont systemFontOfSize:13];
//    _verifiBtn.backgroundColor = [UIColor colorWithHexString:@"#019BFF"];
    _verifiBtn.backgroundColor = [UIColor whiteColor];
    [_verifiBtn setTitleColor:UIcolors forState:(UIControlStateNormal)];
    [_verifiBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
    [_verifiBtn addTarget:self action:@selector(verifiBtn:) forControlEvents:UIControlEventTouchUpInside];
    

    _yanBtn = [UIButton new];
    _yanBtn.layer.cornerRadius = 4.0f;
    _yanBtn.userInteractionEnabled = YES;
    _yanBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    [_yanBtn setTitle:@"注册" forState:UIControlStateNormal];
    _yanBtn.backgroundColor = [UIColor colorWithHexString:@"#019BFF"];
    [_yanBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_yanBtn addTarget:self action:@selector(yanBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [_tableView addSubview:_yanBtn];
    
//    [self getRegistImage];
    self.passwordShowImageView = [[UIImageView alloc] init];
    _passwordShowImageView.image = [UIImage imageNamed:@"眼睛"];
    self.passwordShowImageViewButton = [[UIButton alloc] init];
    self.passwordShowImageViewButton.backgroundColor = [UIColor clearColor];
    [self.passwordShowImageViewButton addTarget:self action:@selector(passwordShowImageViewButtonAction:) forControlEvents:(UIControlEventTouchUpInside)];
    self.passwordShowImageViewButton.selected = YES;
    
    
    UIView *headerView = [[UIView alloc] init];
    headerView.backgroundColor = [UIColor whiteColor];
    if(isIPhoneX)
    {
        headerView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 280);
    }else
    {
        headerView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 250);
    }
    UIImageView *headerImageView = [[UIImageView alloc] init];
    [headerView addSubview:headerImageView];
    [headerImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.bottom.mas_equalTo(0);
    }];
    headerImageView.backgroundColor = [UIColor whiteColor];
    headerImageView.image = [UIImage imageNamed:@"登陆背景"];
    
    UIImageView *logoImageView = [UIImageView new];
    [headerView addSubview:logoImageView];
    logoImageView.image = [UIImage imageNamed:@"登陆logo"];
    [logoImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(0);
        make.centerY.mas_equalTo(-50);
        
    }];
    
    UIButton *quit = [UIButton new];
    [headerView addSubview:quit];
    [quit setImage:[UIImage imageNamed:@"OX"] forState:UIControlStateNormal];
    [quit addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchDown];
    [quit mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(25);
        make.left.mas_equalTo(10);
        make.width.mas_equalTo(44);
        make.height.mas_equalTo(44);
    }];
    

    if(isIOS11)
    {
        self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, -WDStatusBarHeight, SCREEN_WIDTH, SCREEN_HEIGHT + WDStatusBarHeight) style:(UITableViewStyleGrouped)];
    }else
    {
        self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) style:(UITableViewStyleGrouped)];
    }
    
    [self.view addSubview:self.tableView];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    self.tableView.tableHeaderView = headerView;
    self.tableView.backgroundColor = [UIColor whiteColor];
    self.tableView.bounces = NO;
    [self setupNavi];

    UIView *footerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 40)];
    self.tableView.tableFooterView = footerView;
    
    UILabel *xylabel = [[UILabel alloc] init];
    [footerView addSubview:xylabel];
    [xylabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(0);
        make.bottom.mas_equalTo(-5);
        make.height.mas_equalTo(15);
        make.width.mas_equalTo(SCREEN_WIDTH);
    }];
    xylabel.backgroundColor = [UIColor whiteColor];
    xylabel.textAlignment= NSTextAlignmentCenter;
    xylabel.textColor = kLineColor;
    xylabel.font = [UIFont systemFontOfSize:11];
    xylabel.attributedText = [self changeTextColcrWithTitleStr:@"注册即代表同意《用户协议》" Str:@"《用户协议》"];
    xylabel.userInteractionEnabled = YES;
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapLabel)];
    [xylabel addGestureRecognizer:tap];

}

- (void)getRegistImage
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString * accesstoken = [defaults objectForKey:@"accesstoken"];
    //    NSDictionary *parma = @{@"UserId":[NSString stringWithFormat:@"%ld",(long)[User shareUser].userId],@"Platform":@"2",@"accesstoken":accesstoken,@"version":kVersion,@"os":kos};
    NSString * str = [NSString stringWithFormat:@"http://139.224.54.40:8081/v2/static/image/register_banner.png?UserId=%@&accesstoken=%@&Platform=2&os=%@&version=%@",[NSString stringWithFormat:@"%ld",(long)[User shareUser].userId],accesstoken,kos,kVersion];
    NSURL * url = [NSURL URLWithString:str ];
    NSData *data = [NSData dataWithContentsOfURL:url];
    UIImage *image = [UIImage imageWithData:data];
    NSLog(@"%@",image);
//    _imageView.image = image;
}

- (void)textFieldChange:(UITextField *)textField
{
    if (IsStrEmpty(_phoneTextField.text)) {
        _yanBtn.userInteractionEnabled = YES;
//        _yanBtn.backgroundColor = [UIColor colorWithHexString:@"#CDCDCD"];
    }else if (IsStrEmpty(_verificationTextField.text)){
        _yanBtn.userInteractionEnabled = YES;
//        _yanBtn.backgroundColor = [UIColor colorWithHexString:@"#CDCDCD"];
    }else if (IsStrEmpty(_nameTextField.text)){
        _yanBtn.userInteractionEnabled = YES;
//        _yanBtn.backgroundColor = [UIColor colorWithHexString:@"#CDCDCD"];
    }else if (IsStrEmpty(_pwsTextField.text)){
        _yanBtn.userInteractionEnabled = YES;
//        _yanBtn.backgroundColor = [UIColor colorWithHexString:@"#CDCDCD"];
    }else if (IsStrEmpty(_surePwsTextField.text)){
        _yanBtn.userInteractionEnabled = YES;
//        _yanBtn.backgroundColor = [UIColor colorWithHexString:@"#CDCDCD"];
    } else if (!IsStrEmpty(_phoneTextField.text) && !IsStrEmpty(_verificationTextField.text) && !IsStrEmpty(_pwsTextField.text) && !IsStrEmpty(_surePwsTextField.text)
               ){
        _yanBtn.userInteractionEnabled = YES;
//        _yanBtn.backgroundColor = NaviColor;
    }
}


- (void)verifiBtn:(UIButton *)btn{
    //  获取验证码增加判断
//    MBProgressHUD *hud = [MBProgressHUD showStatus:nil toView:self.view];
    [self.httpUtil requestDic4MethodNam:@"v2/open/verifycode/getRegisterVerifyCode" parameters:@{@"mobile":_phoneTextField.text} result:^(NSDictionary *dic, int status, NSString *msg) {
        [MBProgressHUD showMessag:[NSString stringWithFormat:@"%@",dic] toView:self.view];
        NSLog(@"-------%@",_phoneTextField.text);
        if (status ==0) {
            [MBProgressHUD animateWithDuration:1.0 animations:^{
            } completion:^(BOOL finished) {
            }];

        }else{
            _numDic = dic;
            _verifiBtn.userInteractionEnabled = YES;
            [self startTimer];
            [MBProgressHUD animateWithDuration:1.0 animations:^{
            } completion:^(BOOL finished) {
            }];        }
    }];
//    [self startTimer]
    NSLog(@"1234165");
}

//注册按钮
- (void)yanBtnClick:(UIButton *)btn {
    [self loginAction];
}
//{
//    NSLog(@"66666666");
//    if (_phoneTextField.text.length<11) {
//        [MBProgressHUD showError:@"请输入正确的手机号码" toView:self.view];
//        return;
//    }else if (![self isValidateUsername] || _nameTextField.text.length < 6 || _nameTextField.text.length > 15)
//    {
//        // 快速显示一个提示信息
//        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
//        hud.detailsLabelText = @"用户名由6-15个字符组成，包含字母、数字、下划线，且必须包含字母";
//        // 设置图片
//        hud.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"error.png"]];
//        // 再设置模式
//        hud.mode = MBProgressHUDModeCustomView;
//        
//        // 隐藏时候从父控件中移除
//        hud.removeFromSuperViewOnHide = YES;
//        
//        // 1.5秒之后再消失
//        [hud hide:YES afterDelay:1];
//        
//        return;
//    }else if (_pwsTextField.text.length < 8)
//        
//    {
//        [MBProgressHUD showError:@"请输入最小为8个字符的密码" toView:self.view];
//        return;
//    }else  if ([ValidateUtil characterCountOfString:_pwsTextField.text] == _pwsTextField.text.length || [ValidateUtil characterCharCountOfString:_pwsTextField.text] == _pwsTextField.text.length)
//        
//    {
//        [MBProgressHUD showError:nil toView:self.view];
//        NSArray *huds = [MBProgressHUD allHUDsForView:self.view];
//        MBProgressHUD *hud = huds[0];
//        hud.detailsLabelText = @"密码由字母，数字和特殊字符组成，且必须包含字母";
//        return;
//    }else if (![_pwsTextField.text isEqual:_surePwsTextField.text])
//        
//    {
//        [MBProgressHUD showError:@"两次输入的密码不一致，请重新输入" toView:self.view];
//        return;
//    }else if (_verificationTextField.text.length != 6){
//        [MBProgressHUD showError:@"验证码错误" toView:self.view];
//        return;
//    }
//    
//    
//    [self.httpUtil requestDic4MethodNam:@"v2/open/user/register" parameters:@{@"verifyCode":_verificationTextField.text,@"mobile":_phoneTextField.text,@"username":_nameTextField.text,@"password":_pwsTextField.text,@"inviter":_invitationTextField.text} result:^(NSDictionary *dic, int status, NSString *msg) {
//        
//        
//        
//        if (status == 1 || status == 2) {
//
////            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"您已注册成功" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
////            [alert show];
////          [self performSelector:@selector(delayMethod) withObject:nil afterDelay:0.2];
//            [self loginAction];
//        }else{
//            [MBProgressHUD showMessag:msg toView:self.view];
//
//        }
//    }];
//}

-(void)loginAction
{
    /*
     GestureViewController *gestureVc = [[GestureViewController alloc] init];
     gestureVc.type = GestureViewControllerTypeSetting;
     gestureVc.delegate = self;
     [self.navigationController pushViewController:gestureVc animated:YES];
     */
    //_phoneTextField.text
    //_pwsTextField.text
//    [self.httpUtil requestObj4MethodName:@"user/login" parameters:@{@"UserName":@"18525385358",@"Password":@"11111111a"} result:^(id obj, int status, NSString *msg) {
   // [self.httpUtil requestObj4MethodName:@"user/login" parameters:@{@"UserName":@"18606716927",@"Password":@"a1234567890"} result:^(id obj, int status, NSString *msg) {
    [self.httpUtil requestObj4MethodName:@"user/login" parameters:@{@"UserName":_phoneTextField.text,@"Password":_pwsTextField.text} result:^(id obj, int status, NSString *msg) {
     
        NSLog(@"--------------%@,,,,,%d----%@",self.httpUtil, status, msg);
        if (status == 1 || status == 2) {
            NSDictionary *objS = (NSDictionary *)obj;
            _user = (User *)objS;
            _user.password = @"a1234567890";//_pwsTextField.text;
            
            [_user saveUser];
            
            [_user saveLogin];
            User *user = [User userFromFile];
            NSLog(@"登录成功======%@----%@====%ld",user.userName,user.password,(long)user.userId);
            //登陆之后跳转那个界面
            //            [AppDelegate backToMe];
            //解锁
             [self performSelector:@selector(delayMethod) withObject:nil afterDelay:0.5f];
            
//            [[NSNotificationCenter defaultCenter] postNotificationName:@"注册成功" object:[UIColor brownColor]];
            //未登录状态
            TabBarController *tabbarController = [[TabBarController alloc] init];
            APPDELEGATE.window.rootViewController = tabbarController;
//            020714[self dismissViewControllerAnimated:YES completion:^{
//                
//                
//            }];
        }else{
            NSLog(@"注册后,自动登录失败");
        }
    }
        convertClassName:@"User" key:nil];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    LoginViewController * vc = [[LoginViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
    
}


- (void)delayMethod
{
    [self.httpUtil requestObj4MethodName:@"user/login" parameters:@{@"UserName":_nameTextField.text,@"Password":_pwsTextField.text} result:^(id obj, int status, NSString *msg) {
        if (status == 1 || status == 2) {
            [MBProgressHUD showError:msg toView:self.view];
        }else{
            _user = (User *)obj;
            _user.password = _pwsTextField.text;
            [_user saveUser];
            [_user saveLogin];
            [AppDelegate loginMain];
        }
    } convertClassName:@"User" key:nil];
}

- (void)setupNavi
{
    [self.navigationController setNavigationBarHidden:NO animated:NO];
    self.title = @"注册";
    
//    UIButton *customView = [UIButton buttonWithType:UIButtonTypeCustom];
//    customView.frame = CGRectMake(0, 0, 44, 44);
//    customView.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
//    [customView setImage:[UIImage imageNamed:@"nav_back_normal"] forState:UIControlStateNormal];
//    [customView addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
//    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:customView];
    [self setupBarButtomItemWithImageName:@"关闭" highLightImageName:@"关闭" selectedImageName:nil target:self action:@selector(backAction) leftOrRight:YES];
}
-(void)backAction
{
    [self dismissViewControllerAnimated:YES completion:^{
        
        
    }];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 4;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * celldentifier = @"cell";
     UITableViewCell*cell=[tableView dequeueReusableCellWithIdentifier:celldentifier];
//    if (cell == nil) {
//        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:celldentifier];
//    }
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    if (indexPath.row == 0) {
        UIView *userView = [[UIView alloc]init];
        [cell addSubview:userView];
        userView.layer.masksToBounds = YES;
        userView.layer.borderWidth = 0.5;
        userView.layer.borderColor = [[UIColor colorWithRed:0.70 green:0.70 blue:0.70 alpha:1.00]CGColor];
        userView.layer.cornerRadius = 20;
        [userView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(20);
            make.right.mas_equalTo(-20);
            make.height.mas_equalTo(35);
            make.top.mas_equalTo(0);
        }];

        
        [userView addSubview:_phoneTextField];
        [_phoneTextField mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(20);
            make.centerY.mas_equalTo(0);
            make.height.mas_equalTo(30);
            make.right.mas_equalTo(-20);
        }];
//        UIView *lineView = [[UIView alloc] init];
//        [cell addSubview:lineView];
//        [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
//            
//            make.left.mas_equalTo(40);
//            make.right.mas_equalTo(-40);
//            make.height.mas_equalTo(0.5f);
//            make.bottom.mas_equalTo(0);
//        }];
//        lineView.backgroundColor = [UIColor colorWithHexString:@"#cccccc"];
    }else if (indexPath.row == 1){
//
        UIView *userView = [[UIView alloc]init];
        [cell addSubview:userView];
        userView.layer.masksToBounds = YES;
        userView.layer.borderWidth = 0.5;
        userView.layer.borderColor = [[UIColor colorWithRed:0.70 green:0.70 blue:0.70 alpha:1.00]CGColor];
        userView.layer.cornerRadius = 20;
        [userView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(20);
            make.right.mas_equalTo(-20);
            make.height.mas_equalTo(35);
            make.top.mas_equalTo(0);
        }];

        
        [userView addSubview:self.passwordShowImageView];
        [self.passwordShowImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(0);
            make.right.mas_equalTo(-20);
        }];
        self.passwordShowImageView.userInteractionEnabled = YES;
        [userView addSubview:self.passwordShowImageViewButton];
        [self.passwordShowImageViewButton mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.centerY.mas_equalTo(0);
            make.height.mas_equalTo(40);
            make.width.mas_equalTo(30);
            make.right.mas_equalTo(-20);
        }];
        self.passwordShowImageViewButton.backgroundColor = [UIColor clearColor];
        [userView addSubview:_pwsTextField];
        [_pwsTextField mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(20);
            make.centerY.mas_equalTo(0);
            make.height.mas_equalTo(30);
            make.right.mas_equalTo(self.passwordShowImageViewButton.mas_left).offset(-2);
        }];
//        UIView *lineView = [[UIView alloc] init];
//        [cell addSubview:lineView];
//        [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
//            
//            make.left.mas_equalTo(40);
//            make.right.mas_equalTo(-40);
//            make.height.mas_equalTo(0.5f);
//            make.bottom.mas_equalTo(0);
//        }];
//        lineView.backgroundColor = [UIColor colorWithHexString:@"#cccccc"];
    }else if (indexPath.row == 2){
        
        UIView *userView = [[UIView alloc]init];
        [cell addSubview:userView];
        userView.layer.masksToBounds = YES;
        userView.layer.borderWidth = 0.5;
        userView.layer.borderColor = [[UIColor colorWithRed:0.70 green:0.70 blue:0.70 alpha:1.00]CGColor];
        userView.layer.cornerRadius = 20;
        [userView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(20);
            make.right.mas_equalTo(-20);
            make.height.mas_equalTo(35);
            make.top.mas_equalTo(0);
        }];

        [userView addSubview:_verifiBtn];
        [_verifiBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(0);
            make.right.mas_equalTo(-20);
            make.width.mas_equalTo(100);
            make.height.mas_equalTo(30);
        }];
        [userView addSubview:_verificationTextField];
        [_verificationTextField mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(20);
            make.centerY.mas_equalTo(0);
            make.height.mas_equalTo(30);
            make.right.mas_equalTo(-120);
        }];

    }else if (indexPath.row == 3){
        
//         cell.backgroundColor = [UIColor blueColor];
    
            UIView *userView = [[UIView alloc]init];
            [cell addSubview:userView];
            userView.layer.masksToBounds = YES;
            userView.layer.borderWidth = 0.5;
            userView.layer.borderColor = [[UIColor colorWithRed:0.70 green:0.70 blue:0.70 alpha:1.00]CGColor];
            userView.layer.cornerRadius = 20;
            [userView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(20);
                make.right.mas_equalTo(-20);
                make.height.mas_equalTo(35);
                make.top.mas_equalTo(0);
            }];
            
           _codeField = [UITextField new];
        _codeField.delegate = self;
            _codeField.placeholder = @"请输入邀请码(选填)";
        _codeField.secureTextEntry = YES;
        _codeField.font = [UIFont systemFontOfSize:14];
        [_codeField addTarget:self action:@selector(textFieldChange:) forControlEvents:UIControlEventEditingChanged];
        // 输入右侧删除按钮
        _codeField.clearButtonMode = UITextFieldViewModeAlways;
            [userView addSubview:_codeField];
            [_codeField mas_makeConstraints:^(MASConstraintMaker *make) {
                
                make.left.mas_equalTo(20);
                make.centerY.mas_equalTo(0);
                make.height.mas_equalTo(30);
                make.right.mas_equalTo(-20);
            }];
        UIButton *button2 = [[UIButton alloc] init];
        [cell addSubview:button2];
        [button2 mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.top.mas_equalTo(_codeField.mas_bottom).offset(40);
            make.right.mas_equalTo(-40);
            make.height.mas_equalTo(45);
            make.left.mas_equalTo(40);
        }];
        [button2 setTitle:@"立即注册" forState:(UIControlStateNormal)];
        button2.titleLabel.font = [UIFont systemFontOfSize:14];
        [button2 setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
        [button2 addTarget:self action:@selector(zhuCeButtonAction) forControlEvents:(UIControlEventTouchUpInside)];
        button2.backgroundColor = UIcolors;
        button2.layer.cornerRadius = 45/2;
        button2.layer.masksToBounds = YES;
        
        
//        UILabel *xylabel = [[UILabel alloc] init];
//        [cell addSubview:xylabel];
//        [xylabel mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.centerX.mas_equalTo(0);
//            make.bottom.mas_equalTo(10);
//            make.height.mas_equalTo(15);
//            make.width.mas_equalTo(SCREEN_WIDTH);
//        }];
//        xylabel.backgroundColor = [UIColor whiteColor];
//        xylabel.textAlignment= NSTextAlignmentCenter;
//        xylabel.textColor = kLineColor;
//        xylabel.font = [UIFont systemFontOfSize:11];
//        xylabel.attributedText = [self changeTextColcrWithTitleStr:@"注册即代表同意《用户协议》" Str:@"《用户协议》"];
//        xylabel.userInteractionEnabled = YES;
//
//        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapLabel)];
//        [xylabel addGestureRecognizer:tap];
    }
    return cell;
}
- (void)tapLabel{
    PageWebViewController *pageWebVC = [PageWebViewController new];
    pageWebVC.urlStr = [NSString stringWithFormat:@"%@v2/open/user/agreement.jsp",__API_HEADER__];
    pageWebVC.title = @"注册协议";
    self.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:pageWebVC animated:YES];
    self.hidesBottomBarWhenPushed = NO;
}


-(void)passwordShowImageViewButtonAction:(UIButton *)button
{
    NSLog(@"11===============%d", button.selected);
    button.selected = !button.selected;
    if (button.selected) {
        _pwsTextField.secureTextEntry = NO;
        _passwordShowImageView.image = [UIImage imageNamed:@"眼睛"];
    }else{
        _pwsTextField.secureTextEntry = YES;
        _passwordShowImageView.image = [UIImage imageNamed:@"闭眼"];
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 3) {
        return 100;
    }else {
        return 45;
    }
}

//-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
//{
//    return 95+35;
//}
//
//-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
//{
//    UIView *aView = [[UIView alloc] init];
//    aView.backgroundColor = [UIColor whiteColor];
//    
//    UIButton *button2 = [[UIButton alloc] init];
//    [aView addSubview:button2];
//    [button2 mas_makeConstraints:^(MASConstraintMaker *make) {
//        
//        make.bottom.mas_equalTo(-35);
//        make.right.mas_equalTo(-40);
//        make.height.mas_equalTo(45);
//        make.left.mas_equalTo(40);
//    }];
//    [button2 setTitle:@"立即注册" forState:(UIControlStateNormal)];
//    button2.titleLabel.font = [UIFont systemFontOfSize:14];
//    [button2 setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
//    [button2 addTarget:self action:@selector(zhuCeButtonAction) forControlEvents:(UIControlEventTouchUpInside)];
//    button2.backgroundColor = [UIColor colorWithHexString:@"#0096ff"];
//    button2.layer.cornerRadius = 45/2;
//    button2.layer.masksToBounds = YES;
//    
//    UILabel *label = [[UILabel alloc] init];
//    [aView addSubview:label];
//    [label mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.centerX.mas_equalTo(-0);
//        make.bottom.mas_equalTo(0);
//        make.height.mas_equalTo(15);
//        make.width.mas_equalTo(SCREEN_WIDTH);
//    }];
//    label.backgroundColor = [UIColor whiteColor];
//    label.textAlignment= NSTextAlignmentCenter;
//    label.textColor = kLineColor;
//    label.font = [UIFont systemFontOfSize:11];
//    label.attributedText = [self changeTextColcrWithTitleStr:@"注册即代表同意《用户协议》" Str:@"《用户协议》"];
//    
//    return aView;
//}

-(NSAttributedString *)changeTextColcrWithTitleStr:(NSString *)title Str:(NSString *)str
{
    // 设置标签文字
    NSMutableAttributedString *attrituteString = [[NSMutableAttributedString alloc] initWithString: title];
    // 获取标红的位置和长度
    NSRange range = [title rangeOfString:str]; //获取需要变量文字的文字
    // 设置标签文字的属性
    [attrituteString setAttributes:@{NSForegroundColorAttributeName :UIcolors,   NSFontAttributeName : [UIFont systemFontOfSize:12.0]} range:range];
    return attrituteString;
}

//注册
-(void)zhuCeButtonAction
{
//    [[NSNotificationCenter defaultCenter] postNotificationName:@"zuCeChengGongAction" object:nil];
    _nameTextField.text = _phoneTextField.text;
    _surePwsTextField.text = _pwsTextField.text;
    if (_phoneTextField.text.length<11) {
        [MBProgressHUD showError:@"请输入正确的手机号码" toView:self.view];
        return;
    }
    //else if (![self isValidateUsername] || _nameTextField.text.length < 6 || _nameTextField.text.length > 15)
    else if (_nameTextField.text.length < 6 || _nameTextField.text.length > 15)
    {
//        // 快速显示一个提示信息
//        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
//        hud.detailsLabelText = @"用户名由6-15个字符组成，包含字母、数字、下划线，且必须包含字母";
//        // 设置图片
//        hud.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"error.png"]];
//        // 再设置模式
//        hud.mode = MBProgressHUDModeCustomView;
//
//        // 隐藏时候从父控件中移除
//        hud.removeFromSuperViewOnHide = YES;
//
//        // 1.5秒之后再消失
//        [hud hide:YES afterDelay:1];
        [MBProgressHUD showError:@"请输入最小为8个字符的密码" toView:self.view];
        return;
    }else if (_pwsTextField.text.length < 8)

    {
        [MBProgressHUD showError:@"请输入最小为8个字符的密码" toView:self.view];
        return;
    }else  if ([ValidateUtil characterCountOfString:_pwsTextField.text] == _pwsTextField.text.length || [ValidateUtil characterCharCountOfString:_pwsTextField.text] == _pwsTextField.text.length)

    {
        [MBProgressHUD showError:nil toView:self.view];
        NSArray *huds = [MBProgressHUD allHUDsForView:self.view];
        MBProgressHUD *hud = huds[0];
        hud.detailsLabelText = @"密码由字母，数字和特殊字符组成，且必须包含字母";
        return;
    }else if (![_pwsTextField.text isEqual:_surePwsTextField.text])

    {
        [MBProgressHUD showError:@"两次输入的密码不一致，请重新输入" toView:self.view];
        return;
    }else if (_verificationTextField.text.length != 6){
        [MBProgressHUD showError:@"验证码错误" toView:self.view];
        return;
    }
    
    NSLog(@"inv- %@",_codeField.text);
    //注册请求
    [self.httpUtil requestDic4MethodNam:@"v2/open/user/register" parameters:@{@"verifyCode":_verificationTextField.text,@"mobile":_phoneTextField.text,@"username":_nameTextField.text,@"password":_pwsTextField.text,@"inviter":_codeField.text} result:^(NSDictionary *dic, int status, NSString *msg) {
        if (status == 1 || status == 2) {
//            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"您已注册成功" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
//            [alert show];
//          [self performSelector:@selector(delayMethod) withObject:nil afterDelay:0.2];
            [self loginAction];
        }else {
            [MBProgressHUD showMessag:msg toView:self.view];
        }
    }];
}

- (BOOL)isValidateUsername {
    NSString *regex = @"^[a-zA-Z0-9_]*[a-zA-Z]+[a-zA-Z0-9_]*$";   //以A开头，e结尾
    //    @"name MATCHES %@",regex
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    //    [regextestmobile evaluateWithObject:_userNameTextField.text];
    
    return [regextestmobile evaluateWithObject:_nameTextField.text];
}

//手势密码 回调代理
-(void)createLockSuccess:(NSString *)lockPwd {

}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if(textField == _pwsTextField)
    {
        if(_pwsTextField.text.length == 16)
        {
            if(string.length > 0)
            {
                [MBProgressHUD showMessag:@"密码最多16位" toView:self.view];
                return NO;
            }else
            {
                return YES;
            }
        }
        return YES;
    }else
    {
        //321敲删除键
        if ([string length]==0) {
            return YES;
        }
        //当输入框当前的字符个数大于11的时候，就不让更改了（不能等于11，因为如果等于11，在输入框字符个数等于11的情况下就不能进行粘贴替换内容了）
        
        int num;
        if ([textField isEqual:_phoneTextField]) {
            NSLog(@"手机");
            num = 11;
        }else if ([textField isEqual:_verificationTextField]){
            NSLog(@"验证码");
            num = 6;
        }else {
            NSLog(@"邀请码");
            num = 8;
        }
        
        if ([textField.text length]>num){
            return NO;
        }
        //获得当前输入框内的字符串
        NSMutableString *fieldText=[NSMutableString stringWithString:textField.text];
        //完成输入动作，包括输入字符，粘贴替换字符
        [fieldText replaceCharactersInRange:range withString:string];
        NSString *finalText=[fieldText copy];
        //如果字符个数大于11就要进行截取前边11个字符
        if ([finalText length]>num) {
            textField.text=[finalText substringToIndex:num];
            return NO;
        }
        return YES;
    }
   
}
/**
 * 当键盘隐藏的时候
 *  @param aNotification a
 */
- (void)keyboardWillBeHidden:(NSNotification*)aNotification
{
    NSLog(@"键盘隐藏le");
    [UIView animateWithDuration:.3 animations:^{
        [self.tableView scrollRectToVisible:CGRectMake(0, 0, 1, 1) animated:NO];
    }];
}

@end
