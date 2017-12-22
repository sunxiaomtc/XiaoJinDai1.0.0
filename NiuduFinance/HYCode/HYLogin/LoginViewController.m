//
//  LoginViewController.m
//  NiuduFinance
//
//  Created by liuyong on 16/3/1.
//  Copyright © 2016年 liuyong. All rights reserved.
//

#import "LoginViewController.h"
#import "FindPsdViewController.h"
#import "User.h"
#import "AppDelegate.h"
#import "PCCircleViewConst.h"
#import "TabBarController.h"
#import "GestureViewController.h"
#import "IOSmd5.h"
#import "BaseNavigationController.h"
#import "RegisterFirsViewController.h"

@interface LoginViewController ()<GestureViewControllerDelegate, UITextFieldDelegate>

@property(nonatomic, strong)UITableView *tableView;

@property(nonatomic, strong)UITextField *accountTextField;  //账号输入框
@property(nonatomic, strong)UITextField *passwordTextField;  //密码输入框
@property(nonatomic, strong)UIButton *passwordShowButton; // 可见密码图片
@property(nonatomic, strong)UIButton *loginBtn;  //  登陆按钮

@property (nonatomic,strong)User *user;
@end

@implementation LoginViewController


-(void)zuCeChengGongAction
{
    NSLog(@"zuCeChengGongAction--------------------------------------");
    NSMutableArray *arr = [NSMutableArray array];
    [arr objectAtIndex:3];
    
    [self dismissViewControllerAnimated:YES completion:^{
        
        
    }];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIScrollView *scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    scrollView.contentSize = CGSizeMake(SCREEN_WIDTH, SCREEN_HEIGHT);
    scrollView.scrollEnabled = NO;
    scrollView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:scrollView];
    
    
    UIView *headerView = [[UIView alloc] init];
    headerView.backgroundColor = [UIColor whiteColor];
    if(isIPhoneX)
    {
        headerView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 280);
    }else
    {
        headerView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 250);
    }    [scrollView addSubview:headerView];
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
    
    //导航左右按钮
    UIButton *quit = [UIButton new];
    [headerView addSubview:quit];
    [quit setImage:[UIImage imageNamed:@"OX"] forState:UIControlStateNormal];
    [quit addTarget:self action:@selector(backClick) forControlEvents:UIControlEventTouchDown];
    [quit mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(30);
        make.left.mas_equalTo(10);
        make.width.mas_equalTo(40);
        make.height.mas_equalTo(40);
    }];
    
    
    
    UIView *middleView = [[UIView alloc]initWithFrame:CGRectMake(0, 250, SCREEN_WIDTH, 230)];
    [scrollView addSubview:middleView];
    
    //   user 框
    
    UIView *userView = [[UIView alloc]init];
    [middleView addSubview:userView];
    userView.layer.masksToBounds = YES;
    userView.layer.borderWidth = 0.5;
    userView.layer.borderColor = [[UIColor colorWithRed:0.70 green:0.70 blue:0.70 alpha:1.00]CGColor];
    userView.layer.cornerRadius = 22;
    [userView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(20);
        make.right.mas_equalTo(-20);
        make.height.mas_equalTo(45);
        make.top.mas_equalTo(0);
    }];
    
    UIImageView *imgView = [UIImageView new];
    [userView addSubview:imgView];
    imgView.image = [UIImage imageNamed:@"用户"];
    [imgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(20);
        make.width.mas_equalTo(20);
        make.height.mas_equalTo(20);
        make.centerY.mas_equalTo(0);
    }];
    
    _accountTextField = [[UITextField alloc] init];
    _accountTextField.placeholder = @"手机号码";
    [_accountTextField setValue:[UIFont systemFontOfSize:16] forKeyPath:@"_placeholderLabel.font"];
    [_accountTextField addTarget:self action:@selector(textFieldChange:) forControlEvents:UIControlEventEditingChanged];
    [userView addSubview:_accountTextField];
    [_accountTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.mas_equalTo(50);
        make.centerY.mas_equalTo(0);
        make.height.mas_equalTo(30);
        make.right.mas_equalTo(-50);
    }];
    
    //    密码框
    UIView *passwordView = [[UIView alloc]init];
    [middleView addSubview:passwordView];
    passwordView.layer.masksToBounds = YES;
    passwordView.layer.borderWidth = 0.5;
    passwordView.layer.borderColor = [[UIColor colorWithRed:0.70 green:0.70 blue:0.70 alpha:1.00]CGColor];
    passwordView.layer.cornerRadius = 22;
    [passwordView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(20);
        make.right.mas_equalTo(-20);
        make.height.mas_equalTo(45);
        make.top.mas_equalTo(userView.mas_bottom).offset(25);
    }];
    
    UIImageView *pwdimgView = [UIImageView new];
    [passwordView addSubview:pwdimgView];
    pwdimgView.image = [UIImage imageNamed:@"密码"];
    [pwdimgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(20);
        make.width.mas_equalTo(20);
        make.height.mas_equalTo(20);
        make.centerY.mas_equalTo(0);
    }];
    
    _passwordShowButton = [[UIButton alloc]init];
    _passwordShowButton.userInteractionEnabled = YES;
    [_passwordShowButton setImage:[UIImage imageNamed:@"闭眼"] forState: UIControlStateNormal];
    [_passwordShowButton addTarget:self action:@selector(passwordShowImageViewButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [passwordView addSubview:_passwordShowButton];
    [_passwordShowButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(0);
        make.right.mas_equalTo(-40);
        make.width.mas_equalTo(30);
        make.height.mas_equalTo(30);
    }];
    
    _passwordTextField = [[UITextField alloc] init];
    _passwordTextField.placeholder = @"密码";
    [_passwordTextField setValue:[UIFont systemFontOfSize:16] forKeyPath:@"_placeholderLabel.font"];
    [_passwordTextField addTarget:self action:@selector(textFieldChange:) forControlEvents:UIControlEventEditingChanged];
    // 输入右侧删除按钮
    _passwordTextField.clearButtonMode = UITextFieldViewModeAlways;
    _passwordTextField.secureTextEntry = YES;
    [passwordView addSubview:_passwordTextField];
    _passwordTextField.keyboardType = UIKeyboardTypeASCIICapable;
    [_passwordTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.mas_equalTo(60);
        make.centerY.mas_equalTo(0);
        make.height.mas_equalTo(30);
        make.right.mas_equalTo(_passwordShowButton.mas_left).offset(-2);
    }];
    
    UIButton *zhuceButton = [[UIButton alloc] init];
    [middleView addSubview:zhuceButton];
    [zhuceButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(passwordView.mas_bottom).offset(20);
        make.left.mas_equalTo(45);
        make.height.mas_equalTo(20);
    }];
    [zhuceButton setTitle:@"新用户注册" forState:UIControlStateNormal];
    zhuceButton.titleLabel.font = [UIFont systemFontOfSize:14];
    [zhuceButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [zhuceButton addTarget:self action:@selector(zhuCeButtonAction) forControlEvents:UIControlEventTouchUpInside];
    zhuceButton.backgroundColor = [UIColor clearColor];
    [zhuceButton setTitleColor:UIcolors forState:UIControlStateNormal];
    
    
    UIButton *button1 = [[UIButton alloc] init];
    [middleView addSubview:button1];
    [button1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(passwordView.mas_bottom).offset(20);
        make.right.mas_equalTo(-45);
        make.height.mas_equalTo(20);
    }];
    [button1 setTitle:@"忘记密码?" forState:(UIControlStateNormal)];
    button1.titleLabel.font = [UIFont systemFontOfSize:14];
    [button1 setTitleColor:UIcolors forState:(UIControlStateNormal)];
    [button1 addTarget:self action:@selector(wangJiMiMaButtonAction) forControlEvents:(UIControlEventTouchUpInside)];
//    [button1 addTarget:self action:@selector(wangJiMiMaButtonAction) forControlEvents:UIControlEventTouchDown];
    
    
    _loginBtn = [[UIButton alloc] init];
    [_loginBtn setTitle:@"登     录" forState:(UIControlStateNormal)];
    _loginBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    [_loginBtn setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
    [_loginBtn addTarget:self action:@selector(dengLuButtonAction) forControlEvents:(UIControlEventTouchUpInside)];
    _loginBtn.backgroundColor = UIcolors;
    _loginBtn.layer.cornerRadius = 45/2;
    _loginBtn.layer.masksToBounds = YES;
    _loginBtn.userInteractionEnabled = NO;
    [middleView addSubview:_loginBtn];
    [_loginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(passwordView.mas_bottom).offset(65);
        make.right.mas_equalTo(-40);
        make.height.mas_equalTo(45);
        make.left.mas_equalTo(40);
    }];
    
    
}

-(NSAttributedString *)changeTextColcrWithTitleStr:(NSString *)title Str:(NSString *)str
{
    // 设置标签文字
    NSMutableAttributedString *attrituteString = [[NSMutableAttributedString alloc] initWithString: title];
    // 获取标红的位置和长度
    NSRange range = [title rangeOfString:str]; //获取需要变量文字的文字
    // 设置标签文字的属性
    [attrituteString setAttributes:@{NSForegroundColorAttributeName : [UIColor colorWithHexString:@"#0096ff"],   NSFontAttributeName : [UIFont systemFontOfSize:12.0]} range:range];
    return attrituteString;
}



-(void)passwordShowImageViewButtonAction:(UIButton *)button
{
    button.selected = !button.selected;
    if (button.selected) {
        _passwordTextField.secureTextEntry = NO;
        [_passwordShowButton setImage:[UIImage imageNamed:@"眼睛"] forState: UIControlStateNormal];
    }else{
        _passwordTextField.secureTextEntry = YES;
        [_passwordShowButton setImage:[UIImage imageNamed:@"闭眼"] forState: UIControlStateNormal];
    }
}

- (void)textFieldChange:(UITextField *)textField
{
    
    if (IsStrEmpty(_accountTextField.text)) {
        _loginBtn.userInteractionEnabled = NO;
        _loginBtn.backgroundColor = [UIColor colorWithHexString:@"#CDCDCD"];
    }else if (IsStrEmpty(_passwordTextField.text)){
        _loginBtn.userInteractionEnabled = NO;
        _loginBtn.backgroundColor = [UIColor colorWithHexString:@"#CDCDCD"];
    }else if (!IsStrEmpty(_accountTextField.text) && !IsStrEmpty(_passwordTextField.text)){
        _loginBtn.userInteractionEnabled = YES;
        _loginBtn.backgroundColor = UIcolors;
    }
}
//////////
#pragma mark 自定义NaviBack
- (void)setNaviBack
{
    [self setupBarButtomItemWithImageName:@"关闭" highLightImageName:@"关闭" selectedImageName:nil target:self action:@selector(backClick) leftOrRight:YES];
}

//返回按钮
- (void)backClick
{
    [_accountTextField resignFirstResponder];
    [_passwordTextField resignFirstResponder];
    if ([_typeStr isEqual:@"exit"] || [_typeStr isEqual:@"tabbar"] || [_typeStr isEqualToString:@"tabbarpush"]){
        AppDelegate *app = (AppDelegate *)[UIApplication sharedApplication].delegate;
        TabBarController *tabbarController = [[TabBarController alloc] init];
        tabbarController.selectedIndex = 0;
        app.window.rootViewController = tabbarController;
    }else{
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}


-(void)dengLuButtonAction
{
    [_accountTextField resignFirstResponder];
    [_passwordTextField resignFirstResponder];
    
    MBProgressHUD *hud = [MBProgressHUD showStatus:nil toView:self.view];
    
    
    [self.httpUtil requestObj4MethodName:@"user/login" parameters:@{@"UserName":_accountTextField.text,@"Password":_passwordTextField.text} result:^(id obj, int status, NSString *msg) {
        NSLog(@"--------------%@",self.httpUtil);
        
        if (status == 1 || status == 2) {
            NSDictionary *objS = (NSDictionary *)obj;
            _user = (User *)objS;
            _user.password = _passwordTextField.text;
            
            [_user saveUser];
            
            [_user saveLogin];
            
            User *user = [User userFromFile];
            NSLog(@"登录成功======%@----%@====%ld",user.userName,user.password,(long)user.userId);
            //登陆之后跳转那个界面
            //            [AppDelegate backToMe];
            //解锁
//            [self performSelector:@selector(delayMethod) withObject:nil afterDelay:0.5f];
            [hud hide:YES];
            if ([_typeStr isEqual:@"forget"]) {
                //未登录状态
                TabBarController *tabbarController = [[TabBarController alloc] init];
                APPDELEGATE.window.rootViewController = tabbarController;
            }else{
                [self dismissViewControllerAnimated:YES completion:^{
                    
                    
                }];
            }
            
            
        }else{
            
            [hud dismissErrorStatusString:msg hideAfterDelay:1.0];
        }
        
    }
                        convertClassName:@"User" key:nil];
    NSLog(@"--------------%@",self.httpUtil);
}

- (void)delayMethod
{
    if (_user.gestureStatus == YES) {
        [PCCircleViewConst saveGesture:_user.gesture Key:gestureFinalSaveKey];
        if ([_typeStr isEqual:@"exit"] || [_typeStr isEqual:@"forget"]){
            [AppDelegate loginMain];
        }else{
            [self dismissViewControllerAnimated:YES completion:nil];
        }
    }else{
        GestureViewController *gestureVc = [[GestureViewController alloc] init];
        gestureVc.type = GestureViewControllerTypeSetting;
        gestureVc.delegate = self;
        [self.navigationController pushViewController:gestureVc animated:YES];
    }
}

#pragma mark GestureViewControllerDelegate  手势密码
- (void)createLockSuccess:(NSString *)lockPwd
{
    MBProgressHUD *hud = [MBProgressHUD showStatus:nil toView:nil];
    NetWorkingUtil *util = [NetWorkingUtil netWorkingUtil];
    [util requestDic4MethodName:@"user/gesture" parameters:@{@"Gesture":lockPwd} result:^(NSDictionary *dic, int status, NSString *msg) {
        if (status == 1 || status == 2) {
            _user.gesture = [IOSmd5 md5:lockPwd];
            [PCCircleViewConst saveGesture:[IOSmd5 md5:lockPwd] Key:gestureFinalSaveKey];
            [hud hide:YES];
            [self performSelector:@selector(delayMethodLogin) withObject:nil afterDelay:0.5f];
        }else{
            [hud dismissErrorStatusString:msg hideAfterDelay:1.0];
        }
    }];
}

- (void)delayMethodLogin
{
    [AppDelegate loginMain];
}

//忘记密码

-(void)wangJiMiMaButtonAction
{
    NSLog(@"忘记密码");
    if ([_accountTextField.text isEqualToString:@""] || _accountTextField.text.length == 11) {
        FindPsdViewController *findPsdVC = [[FindPsdViewController alloc]init];
        findPsdVC.accountStr = _accountTextField.text;
        NSLog(@"忘记密码%@",_accountTextField.text);
        [findPsdVC setAccountStrWithStr:_accountTextField.text];
        //        [self.navigationController pushViewController:findPsdVC animated:YES];
        BaseNavigationController *baseNav = [[BaseNavigationController alloc] initWithRootViewController:findPsdVC];
        //            [baseNav.navigationBar setBackgroundImage:[UIImage imageNamed:@""] forBarPosition:UIBarPositionAny barMetrics:UIBarMetricsDefault];
        //            [baseNav.navigationBar setShadowImage:[UIImage new]];
        baseNav.navigationBar.barTintColor = [UIColor whiteColor];//Nav019BFF;
        baseNav.navigationBar.barStyle = UIBarStyleDefault;//UIBarStyleBlackOpaque;
        baseNav.navigationBar.shadowImage = [self qqimageWithColor:[UIColor clearColor] sizeq:CGSizeMake(SCREEN_WIDTH, 1)];
        [self presentViewController:baseNav animated:YES completion:^{
            
        }];
    }else{
        [MBProgressHUD showMessag:@"请填写正确的手机号码" toView:self.view];
        return;
    }
}


//注册
-(void)zhuCeButtonAction
{
    RegisterFirsViewController *findPsdVC = [RegisterFirsViewController new];
    BaseNavigationController *baseNav = [[BaseNavigationController alloc] initWithRootViewController:findPsdVC];
    baseNav.navigationBar.barTintColor = [UIColor whiteColor];//Nav019BFF;
    baseNav.navigationBar.barStyle = UIBarStyleDefault;//UIBarStyleBlackOpaque;
    baseNav.navigationBar.shadowImage = [self qqimageWithColor:[UIColor clearColor] sizeq:CGSizeMake(SCREEN_WIDTH, 1)];
    [self presentViewController:baseNav animated:YES completion:^{
        
    }];
}

-(UIImage *)qqimageWithColor:(UIColor *)color sizeq:(CGSize)size
{
    CGRect rect = CGRectMake(0, 0, size.width, size.height);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self registerForKeyboardNotifications];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(zuCeChengGongAction) name:@"zuCeChengGongAction" object:nil];
}


- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    //321敲删除键
    if ([string length]==0) {
        return YES;
    }
    //当输入框当前的字符个数大于11的时候，就不让更改了（不能等于11，因为如果等于11，在输入框字符个数等于11的情况下就不能进行粘贴替换内容了）
    if ([textField.text length]>11)
        return NO;
    //获得当前输入框内的字符串
    NSMutableString *fieldText=[NSMutableString stringWithString:textField.text];
    //完成输入动作，包括输入字符，粘贴替换字符
    [fieldText replaceCharactersInRange:range withString:string];
    NSString *finalText=[fieldText copy];
    //如果字符个数大于11就要进行截取前边11个字符
    if ([finalText length]>11) {
        textField.text=[finalText substringToIndex:11];
        return NO;
    }
    return YES;
    
}



/**
 * 注册通知
 */
- (void)registerForKeyboardNotifications
{
    //使用NSNotificationCenter 键盘出現时
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWasShown:) name:UIKeyboardWillShowNotification object:nil];
    
    //使用NSNotificationCenter 键盘隐藏时
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillBeHidden:) name:UIKeyboardWillHideNotification object:nil];
}

//实现当键盘出现的时候计算键盘的高度大小。用于输入框显示位置
/**
 * 键盘显示的时候
 *  @param aNotification a
 */
//- (void)keyboardWasShown:(NSNotification*)aNotification
//{
//    NSDictionary* info = [aNotification userInfo];
//    //kbSize即為鍵盤尺寸 (有width, height)
//    CGSize kbSize = [[info objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue].size;//得到鍵盤的高度
//    NSLog(@"hight_hitht:%f",kbSize.height);
//    [UIView animateWithDuration:.3 animations:^{
//        self.tableView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-kbSize.height);
//    }];
//}

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
