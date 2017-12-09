//
//  PageWebViewController.m
//  WeiPublicFund
//
//  Created by liuyong on 16/6/30.
//  Copyright © 2016年 www.niuduz.com. All rights reserved.
//

#import "PageWebViewController.h"
@interface PageWebViewController ()<UIWebViewDelegate>

@property (nonatomic,strong)UIWebView *webView;
@property (nonatomic,strong)NSURL *url;

//@property (nonatomic,strong)NSURL *url;
@end

@implementation PageWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self backBarItem];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    //隐藏导航栏
    [self.navigationController setNavigationBarHidden:NO animated:NO];
    NSDictionary *mine = [NSDictionary dictionaryWithObject:[UIColor blackColor] forKey:NSForegroundColorAttributeName];
    self.navigationController.navigationBar.titleTextAttributes = mine;
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    [self setupBarButtomItemWithImageName:@"黑色返回按钮" highLightImageName:@"nav_back_select.png" selectedImageName:nil target:self action:@selector(backClick) leftOrRight:YES];
}

- (void)backClick {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)setUrlStr:(NSString *)urlStr {
    _urlStr = urlStr;
    NSString * urlStrr = [self.httpUtil requNewWebName:_urlStr parameters:nil];
    _url = [NSURL URLWithString:urlStrr];
    [self setWebViewInfo];
}


- (void)setWebViewInfo {
    _webView = [[UIWebView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-64)];
    _webView.scalesPageToFit = YES; //自动对页面进行缩放以适应屏幕
    [_webView setUserInteractionEnabled:YES];
    [_webView setBackgroundColor:[UIColor clearColor]];
    [_webView setDelegate:self];
    [_webView setOpaque:NO];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:_url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:3];
    [_webView loadRequest:request];
    [self.view addSubview:_webView];
}

#pragma mark - UIWebViewDelegate
- (void)webViewDidStartLoad:(UIWebView *)webView {
    [MBProgressHUD showStatus:nil toView:self.view];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    [MBProgressHUD dismissHUDForView:self.view];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    [MBProgressHUD dismissHUDForView:self.view];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
