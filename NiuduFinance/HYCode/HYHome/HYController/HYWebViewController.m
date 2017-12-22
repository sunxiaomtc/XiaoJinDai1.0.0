//
//  HYWebViewController.m
//  NiuduFinance
//
//  Created by Apple on 2017/12/11.
//  Copyright © 2017年 liuyong. All rights reserved.
//

#import "HYWebViewController.h"
#import <WebKit/WebKit.h>
#import "PSBarButtonItem.h"
#import "WKDelegateController.h"
#import "InvitationFriendsController.h"
#import <WebViewJavascriptBridge.h>
#import <WKWebViewJavascriptBridge.h>
#import "AppDelegate.h"
#import "LoginViewController.h"
#import "XProjectDetailsController.h"
@interface HYWebViewController ()<WKNavigationDelegate,WKUIDelegate>
@property (nonatomic, weak) WKWebView *webView;

@property (nonatomic, strong) UIProgressView *progressView;

@property WKWebViewJavascriptBridge * bridge;

@end

@implementation HYWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view.
    WKWebViewConfiguration *config = [[WKWebViewConfiguration alloc] init];
    // 根据需要去设置对应的属性
    WKWebView *webView = [[WKWebView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 64) configuration:config];
    
    webView.UIDelegate = self;
    webView.navigationDelegate = self;
    self.webView = webView;
    [self.view addSubview:webView];
    
    [self setupjindutiao];
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.urlStr]]];
    
//    NSError *error;
//    NSURL *baseURL = [NSURL fileURLWithPath:[[NSBundle mainBundle] bundlePath]];
//    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"bannerpppp1"
//                                                         ofType:@"html"];
//    NSString *html = [NSString stringWithContentsOfFile:filePath
//                                               encoding:NSUTF8StringEncoding
//                                                  error:&error];
//    [webView loadHTMLString:html baseURL:baseURL];
    
}

//第三方
-(void)setupDSFKJ
{
    // 开启WebViewJavascriptBridge 默认日志显示，例如打印的 “WVJB SEND:” 之类的
    [WKWebViewJavascriptBridge enableLogging];
    [_bridge disableJavscriptAlertBoxSafetyTimeout];
    // 初始化WebViewJavascriptBridge 对象
    _bridge = [WKWebViewJavascriptBridge bridgeForWebView:self.webView];
    
    // 设置WebViewJavascriptBridge 对象的代理
    [_bridge setWebViewDelegate:self];
    
    // 注册 JS端向OC端发送数据的方法  回调 handler:^(id 数据, WVJBResponseCallback 向JS端的回调)   -------------------------------> testObjcCallback 回调的标识符，与JS端保持一致才能通信
    [_bridge registerHandler:@"activity" handler:^(id data, WVJBResponseCallback responseCallback) {
        NSLog(@"testObjcCallback called: %@", data);
        // JS端提供的回调方法
        responseCallback(@"Response from testObjcCallback");
    }];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
//    PSBarButtonItem *backItem = [PSBarButtonItem itemWithTitle:nil barStyle:PSNavItemStyleBack target:self action:@selector(backAction)];
//    self.navigationItem.leftBarButtonItem = backItem;
    
    UIImage *image = [[UIImage imageNamed:@"黑色返回按钮"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:image style:UIBarButtonItemStylePlain  target:self action:@selector(backAction)];
}

//开始加载
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation {
    NSLog(@"开始加载网页 :%@",webView.URL);
    //开始加载网页时展示出progressView
    self.progressView.hidden = NO;
    //开始加载网页的时候将progressView的Height恢复为1.5倍
    self.progressView.transform = CGAffineTransformMakeScale(1.0f, 1.5f);
    //防止progressView被网页挡住
    [self.view bringSubviewToFront:self.progressView];
    //截取URL 判断
    if([webView.URL.absoluteString isEqualToString:@"http://www.xiaojindai888.com/fff/fffReg.html"]) //跳注册
    {
        [self gotoRegiset];
        
    }else if ([webView.URL.absoluteString isEqualToString:@"http://www.xiaojindai888.com/fff/fffVesL.html"]) //跳投资
    {
        [self gotoTouZi];
    }else if ([webView.URL.absoluteString isEqualToString:@"http://www.xiaojindai888.com/fff/fffVes.html"])//跳投资详情
    {
        [self gotoTouZiDetails];
    }else if ([webView.URL.absoluteString isEqualToString:@"http://www.xiaojindai888.com/fff/fffInv.html"]) //跳邀请
    {
        if (![[User shareUser] checkIsLogin]) {
            [MBProgressHUD showMessag:@"未登录" toView:self.view];
            [self performSelector:@selector(loginMethod) withObject:nil/*可传任意类型参数*/ afterDelay:2.0];
        }else {
            InvitationFriendsController * invitationVC = [InvitationFriendsController new];
            invitationVC.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:invitationVC animated:YES];
        }
    }
    
    
}

//加载完成
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation {
    NSLog(@"加载完成");
    //加载完成后隐藏progressView
    //self.progressView.hidden = YES;
    if([webView.URL.absoluteString isEqualToString:@"http://www.xiaojindai888.com/fff/fffReg.html"]) //跳注册
    {
        [self.webView goBack];
        
    }else if ([webView.URL.absoluteString isEqualToString:@"http://www.xiaojindai888.com/fff/fffVesL.html"]) //跳投资
    {
        [self.webView goBack];
    }else if ([webView.URL.absoluteString isEqualToString:@"http://www.xiaojindai888.com/fff/fffVes.html"]) //跳邀请
    {
        [self.webView goBack];
    }else if ([webView.URL.absoluteString isEqualToString:@"http://www.xiaojindai888.com/fff/fffInv.html"])
    {
        [self.webView goBack];
    }
}

//加载失败
- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation withError:(NSError *)error {
    NSLog(@"加载失败");
    //加载失败同样需要隐藏progressView
    //self.progressView.hidden = YES;
    if([webView.URL.absoluteString isEqualToString:@"http://www.xiaojindai888.com/fff/fffReg.html"]) //跳注册
    {
        [self.webView goBack];
        
    }else if ([webView.URL.absoluteString isEqualToString:@"http://www.xiaojindai888.com/fff/fffVesL.html"]) //跳投资
    {
        [self.webView goBack];
    }else if ([webView.URL.absoluteString isEqualToString:@"http://www.xiaojindai888.com/fff/fffVes.html"]) //跳邀请
    {
        [self.webView goBack];
    }else if ([webView.URL.absoluteString isEqualToString:@"http://www.xiaojindai888.com/fff/fffInv.html"])
    {
        [self.webView goBack];
    }
}

#pragma mark - GOTO
-(void)gotoRegiset
{
    if (![[User shareUser] checkIsLogin]) {
        [self loginMethod];
    }else
    {
        //跳投资页
        [MBProgressHUD showMessag:@"已注册，即将前往投资" toView:self.view];
        //[NSThread sleepForTimeInterval:2.0];
        [self touziMethod];
        //[self performSelector:@selector(touziMethod) withObject:nil/*可传任意类型参数*/ afterDelay:2.0];
    }
}

-(void)touziMethod
{
    [self.navigationController popViewControllerAnimated:YES];
    [AppDelegate backToTouZi];
}

-(void)gotoTouZi
{
    if (![[User shareUser] checkIsLogin]) {
        
        [MBProgressHUD showMessag:@"未登录" toView:self.view];
        [self loginMethod];
        //[self performSelector:@selector(loginMethod) withObject:nil/*可传任意类型参数*/ afterDelay:2.0];
    }else
    {
        [self touziMethod];
    }
}

-(void)loginMethod
{
    LoginViewController *login = [LoginViewController new];
    [self presentViewController:login animated:YES completion:nil];
}

-(void)gotoTouZiDetails
{
    XProjectDetailsController * projectDetailsVC = [XProjectDetailsController new];
    projectDetailsVC.addrate = self.addrate;
    if (self.recProductArr.count > 0) {
        SNProjectListItem * projectItem = self.recProductArr[0];
        projectDetailsVC.projectId = [projectItem.projectId intValue];
        projectDetailsVC.projectItem = projectItem;
        projectDetailsVC.resultsRate = [self.resultsRatess floatValue];
    }
    projectDetailsVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:projectDetailsVC animated:YES];
}

- (void)backAction {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)dealloc{
    [self.webView removeObserver:self forKeyPath:@"estimatedProgress"];
}

#pragma mark - jindutiao
-(void)setupjindutiao
{
    //进度条
    self.progressView = [[UIProgressView alloc] initWithFrame:CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width, 2)];
    self.progressView.backgroundColor = [UIColor whiteColor];
    self.progressView.progressTintColor = qianhui(254, 159, 2);
    //设置进度条的高度，下面这句代码表示进度条的宽度变为原来的1倍，高度变为原来的1.5倍.
    self.progressView.transform = CGAffineTransformMakeScale(1.0f, 1.5f);
    [self.view addSubview:self.progressView];
    
    [self.webView addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionNew context:nil];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context {
    if ([keyPath isEqualToString:@"estimatedProgress"]) {
        self.progressView.progress = self.webView.estimatedProgress;
        if (self.progressView.progress == 1) {
            /*
             *添加一个简单的动画，将progressView的Height变为1.4倍，在开始加载网页的代理中会恢复为1.5倍
             *动画时长0.25s，延时0.3s后开始动画
             *动画结束后将progressView隐藏
             */
            __weak typeof (self)weakSelf = self;
            [UIView animateWithDuration:0.25f delay:0.3f options:UIViewAnimationOptionCurveEaseOut animations:^{
                weakSelf.progressView.transform = CGAffineTransformMakeScale(1.0f, 1.4f);
            } completion:^(BOOL finished) {
                weakSelf.progressView.hidden = YES;
            }];
        }
    }else{
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
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
