//
//  activityNViewController.m
//  NiuduFinance
//
//  Created by 沈益南 on 2017/10/23.
//  Copyright © 2017年 liuyong. All rights reserved.
//

#import "activityNViewController.h"
#import "PageWebViewController.h"
#import "AnnouncementViewController.h"
#import <WebKit/WebKit.h>

@interface activityNViewController ()<WKNavigationDelegate,WKUIDelegate>
@property (nonatomic ,strong) UIView *firstView;
@property (nonatomic ,strong) UILabel *announcementLab;
@property (nonatomic ,strong) UIButton *moreBtn;
//@property (nonatomic ,strong) UIWebView *webView;
@property (nonatomic ,assign) NSArray  *arr;
@property (nonatomic ,strong) UIImageView *imgView;

@property (nonatomic, weak) WKWebView *webView;

@property (nonatomic, strong) UIProgressView *progressView;

@end

@implementation activityNViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"动态";
    self.view.backgroundColor = [UIColor whiteColor];
    //[self firstView];
//    [self announcementLab];
//    [self moreBtn];
    [self setTwebView];
    [self lode];
    //[self imgView];
}

-(void)lode{
    
    NSString *titleUrl = [__API_HEADER__ stringByAppendingString:@"v2/open/affiche/findAll"];
    NSDictionary *dic = @{
                          @"start":@(0),
                          @"limit":@(1)
                          };
    [NSObject POST:titleUrl parameters:dic progress:^(NSProgress *downloadProgress) {
        
    } completionHandler:^(id responseObject, NSError *error) {
        if (error) {
        }else {
            NSArray *array = responseObject[@"data"];
            self.arr = array;
            
            if([self.arr count] == 0){
//                [MBProgressHUD showMessag:@"暂无数据" toView:self.view];
            }else{
                 self.announcementLab.text = [self.arr[0] valueForKey:@"title"];
            }
        }
        
    }];
    
}

-(void)setTwebView
{
    WKWebViewConfiguration *config = [[WKWebViewConfiguration alloc] init];
    // 根据需要去设置对应的属性
    WKWebView *webView = [[WKWebView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 64) configuration:config];
    
    webView.UIDelegate = self;
    webView.navigationDelegate = self;
    self.webView = webView;
    [self.view addSubview:webView];
    
    [self setupjindutiao];
    
    [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[__API_HEADER__ stringByAppendingString:@"v2/open/activity.jsp"]]]];
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
}

//加载完成
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation {
    NSLog(@"加载完成");
    //加载完成后隐藏progressView
    //self.progressView.hidden = YES;
    if([self.webView canGoBack])
    {
        UIImage *image = [[UIImage imageNamed:@"黑色返回按钮"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:image style:UIBarButtonItemStylePlain  target:self action:@selector(backAction)];
    }else
    {
        self.navigationItem.leftBarButtonItem = nil;
    }
}

- (void)dealloc{
    [self.webView removeObserver:self forKeyPath:@"estimatedProgress"];
}

//加载失败
- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation withError:(NSError *)error {
    NSLog(@"加载失败");
    //加载失败同样需要隐藏progressView
    //self.progressView.hidden = YES;
    if([self.webView canGoBack])
    {
        UIImage *image = [[UIImage imageNamed:@"黑色返回按钮"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:image style:UIBarButtonItemStylePlain  target:self action:@selector(backAction)];
    }else
    {
        self.navigationItem.leftBarButtonItem = nil;
    }
    
}

-(void)backAction
{
    [self.webView goBack];
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

#pragma mark - 懒加载
//-(UIView *)firstView{
//    if (_firstView == nil) {
//        _firstView = [UIView new];
//        [self.view addSubview:_firstView];
//        _firstView.backgroundColor = [UIColor whiteColor];
//        //        _firstView.layer.cornerRadius = 1;
//        _firstView.layer.masksToBounds = YES;
//        _firstView.layer.borderWidth = 0.5;
//        _firstView.layer.borderColor = [UIColor lightGrayColor].CGColor;
//        [_firstView mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.top.mas_equalTo(0);
//            make.left.mas_equalTo(0);
//            make.right.mas_equalTo(0);
//            make.height.mas_equalTo(30);
//        }];
//    }
//    return _firstView;
//}
//
//-(UILabel *)announcementLab{
//    
//    if (_announcementLab == nil) {
//        _announcementLab = [UILabel new];
//        [self.firstView addSubview:_announcementLab];
//        UITapGestureRecognizer *labelTapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(labelClick)];
//        // 2. 将点击事件添加到label上
//        [_announcementLab addGestureRecognizer:labelTapGestureRecognizer];
//        _announcementLab.userInteractionEnabled = YES;
//        _announcementLab.font = [UIFont systemFontOfSize:12];
//        //        _announcementLab.textColor = [UIColor blueColor];
//        [_announcementLab mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.top.mas_equalTo(5);
//            make.bottom.mas_equalTo(-5);
//            make.left.mas_equalTo(25);
//            make.right.mas_equalTo(-100);
//        }];
//    }
//    return _announcementLab;
//}
//-(UIImageView *)imgView{
//    if (_imgView == nil) {
//        _imgView = [UIImageView new];
//        _imgView.image = [UIImage imageNamed:@"bugle"];
//        [self.firstView addSubview:_imgView];
//        [_imgView mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.top.mas_equalTo(5);
//            make.bottom.mas_equalTo(-5);
//            make.left.mas_equalTo(5);
//            make.width.mas_equalTo(20);
//        }];
//    }
//    return _imgView;
//}
//
//-(UIButton *)moreBtn{
//    if (_moreBtn == nil) {
//        _moreBtn = [UIButton new];
//        [self.firstView addSubview:_moreBtn];
//        [_moreBtn setTitleColor:[UIColor lightGrayColor] forState:(UIControlStateNormal)];
//        _moreBtn.titleLabel.font = [UIFont systemFontOfSize: 12];
//        _moreBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
//        [_moreBtn setTitle:@"更多 >" forState:UIControlStateNormal];
//        [_moreBtn addTarget:self action:@selector(moreClick) forControlEvents:UIControlEventTouchDown];
//        [_moreBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.right.mas_equalTo(-10);
//            make.left.mas_equalTo(self.announcementLab.mas_right).offset(10);
//            make.bottom.mas_equalTo(-5);
//            make.top.mas_equalTo(5);
//        }];
//    }
//    return _moreBtn;
//}
-(void)labelClick{
    
    //    PageWebViewController *pageWebVC = [PageWebViewController new];
    //    pageWebVC.urlStr = [NSString stringWithFormat:@"%@v2/open/appAfficheDetail.jsp?id=%@",__API_HEADER__,titleID];
    //    pageWebVC.title = @"最新公告";
    //    self.hidesBottomBarWhenPushed = YES;
    //    [self.navigationController pushViewController:pageWebVC animated:YES];
    //    self.hidesBottomBarWhenPushed = NO;
    
}
-(void)moreClick{
    
    AnnouncementViewController *vc = [[AnnouncementViewController alloc]init];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
    
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
