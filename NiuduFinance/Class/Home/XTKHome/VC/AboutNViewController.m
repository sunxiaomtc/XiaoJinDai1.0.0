//
//  AboutNViewController.m
//  NiuduFinance
//
//  Created by 沈益南 on 2017/10/23.
//  Copyright © 2017年 liuyong. All rights reserved.
//

#import "AboutNViewController.h"


@interface AboutNViewController ()
@property (nonatomic, strong)UIView *bgView;
@property (nonatomic, strong)UIButton *newbieBtn;
@property (nonatomic ,strong)UIButton *companyBtn;
@property (nonatomic ,strong)UIButton *securityBtn;
@property (nonatomic, strong)UIWebView *webView;
@property (nonatomic ,copy)NSString *str;
@end

@implementation AboutNViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"关于我们";
    UIButton *btn = [UIButton new];
  [self setupBarButtomItemWithImageName:@"黑色返回按钮" highLightImageName:@"nav_back_select.png" selectedImageName:nil target:self action:@selector(fanhui) leftOrRight:YES];
  [[UINavigationBar appearance] setTintColor:[UIColor blackColor]];
    [self bgView];
    [self newbieBtn];
    [self companyBtn];
    [self securityBtn];
    self.str = [__API_HEADER__ stringByAppendingString:@"v2/accept/new1"];
    [self loadString:self.str];
    
    // Do any additional setup after loading the view.
}

-(void)fanhui{
    
    [self.navigationController popViewControllerAnimated:YES];
    
}
#pragma mark - 懒加载
-(UIView *)bgView{
    if (_bgView == nil) {
        _bgView = [UIView new];
        _bgView.backgroundColor = [UIColor whiteColor];
        [self.view addSubview:_bgView];
        [_bgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(0);
            make.left.mas_equalTo(0);
            make.right.mas_equalTo(0);
            make.height.mas_equalTo(60);
        }];
    }
    return _bgView;
}

-(UIButton *)newbieBtn{
    if (_newbieBtn == nil) {
        _newbieBtn = [UIButton new];
        [self.bgView addSubview:_newbieBtn];
        [_newbieBtn addTarget:self action:@selector(newClick) forControlEvents:(UIControlEventTouchDown)];
        [_newbieBtn setImage:[UIImage imageNamed:@"新手指引"] forState:(UIControlStateNormal)];
        [_newbieBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(5);
            make.left.mas_equalTo(10);
            make.bottom.mas_equalTo(5);
            make.width.mas_equalTo((self.view.bounds.size.width-60)/3);
        }];
    }
    return _newbieBtn;
}



-(UIButton *)companyBtn{
    if (_companyBtn == nil) {
        _companyBtn = [UIButton new];
        [self.bgView addSubview:_companyBtn];
         [_companyBtn addTarget:self action:@selector(companyClick) forControlEvents:(UIControlEventTouchDown)];
        [_companyBtn setImage:[UIImage imageNamed:@"公司背景"] forState:(UIControlStateNormal)];
        [_companyBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(5);
            make.left.mas_equalTo(self.newbieBtn.mas_right).offset(20);
            make.bottom.mas_equalTo(5);
            make.width.mas_equalTo((self.view.bounds.size.width-60)/3);
        }];
    }
    return _companyBtn;
}


-(UIButton *)securityBtn{
    if (_securityBtn == nil) {
        _securityBtn = [UIButton new];
        [self.bgView addSubview:_securityBtn];
          [_securityBtn addTarget:self action:@selector(securityClick) forControlEvents:(UIControlEventTouchDown)];
        [_securityBtn setImage:[UIImage imageNamed:@"安全保障"] forState:(UIControlStateNormal)];
        [_securityBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(5);
            make.left.mas_equalTo(self.companyBtn.mas_right).offset(20);
            make.bottom.mas_equalTo(5);
            make.width.mas_equalTo((self.view.bounds.size.width-60)/3);
        }];
    }
    return _securityBtn;
}

-(UIWebView *)webView{
    if (_webView == nil) {
        _webView = [UIWebView new];
        [self.view addSubview:_webView];
        [_webView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.bgView.mas_bottom).offset(0);
            make.left.mas_equalTo(0);
            make.right.mas_equalTo(0);
            make.bottom.mas_equalTo(0);
        }];
    }
    return _webView;
}

#pragma mark - 点击事件
-(void)newClick{
    
    self.str = [__API_HEADER__ stringByAppendingString:@"v2/accept/new1"];
     [self loadString:self.str];
}


-(void)companyClick{
    
    self.str = [__API_HEADER__ stringByAppendingString:@"v2/accept/new3"];
      [self loadString:self.str];
}

-(void)securityClick{
    
   self.str = [__API_HEADER__ stringByAppendingString:@"v2/accept/new2"];
     [self loadString:self.str];
}

- (void)loadString:(NSString *)str  {
    // 1. URL 定位资源,需要资源的地址
    NSURL *url = [NSURL URLWithString:str];
    
    // 2. 把URL告诉给服务器,请求,从m.baidu.com请求数据
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    // 3. 发送请求给服务器
    [self.webView loadRequest:request];
    
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
