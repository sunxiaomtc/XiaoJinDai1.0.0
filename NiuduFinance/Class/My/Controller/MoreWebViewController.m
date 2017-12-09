//
//  MoreWebViewController.m
//  NiuduFinance
//
//  Created by liuyong on 16/3/16.
//  Copyright © 2016年 liuyong. All rights reserved.
//

#import "MoreWebViewController.h"

@interface MoreWebViewController ()<UIWebViewDelegate>

@property (nonatomic,strong)UIWebView *webView;
@property (nonatomic,strong)NSURL *url;
@property (nonatomic,weak)MBProgressHUD *hud;
@end

@implementation MoreWebViewController

- (void)setTitleStr:(NSString *)titleStr {
    _titleStr = titleStr;
    self.title = _titleStr;
}

- (void)setWebStr:(NSString *)webStr {
    _webStr = webStr;
    NSString *urlStr = [self.httpUtil requWebName:_webStr parameters:nil];
    _url = [NSURL URLWithString:urlStr];
    [self setWebViewInfo];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self backBarItem];
}

- (void)setWebViewInfo {
    if ([_webStr isEqualToString:@"/aboutus.jsp"]) {
        _webView = [[UIWebView alloc]initWithFrame:CGRectMake(0, -43, SCREEN_WIDTH, SCREEN_HEIGHT - 43)];
    }else {
        _webView = [[UIWebView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-64)];
        UIScrollView *tempView = (UIScrollView *)[_webView.subviews objectAtIndex:0];
         tempView.scrollEnabled = YES;
    }
    _webView.scalesPageToFit = YES; //自动对页面进行缩放以适应屏幕
    
    [_webView setUserInteractionEnabled:YES];
    [_webView setBackgroundColor:[UIColor clearColor]];
    [_webView setDelegate:self];
    [_webView setOpaque:NO];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:_url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:2];
    [_webView loadRequest:request];
    [self.view addSubview:_webView];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
//    根本原因
//    出现NSURLErrorDomain Code=-999的根本原因是什么呢？其实就是因为webview在之前的请求还没有加载完成，下一个请求发起了，此时webview会取消掉之前的请求，因此会回调到失败这里。
    if([error code] == NSURLErrorCancelled)  {
        return;
    }
    [_hud dismissErrorStatusString:[error description] hideAfterDelay:1.3];
}

- (void)webViewDidStartLoad:(UIWebView *)webView {
    _hud = [MBProgressHUD showStatus:nil toView:self.view ];
    [_hud hide:YES afterDelay:1.0];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    [_hud hide:YES];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
