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

@interface activityNViewController ()
@property (nonatomic ,strong) UIView *firstView;
@property (nonatomic ,strong) UILabel *announcementLab;
@property (nonatomic ,strong) UIButton *moreBtn;
@property (nonatomic ,strong) UIWebView *webView;
@property (nonatomic ,assign) NSArray  *arr;
@property (nonatomic ,strong) UIImageView *imgView;

@end

@implementation activityNViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"动态";
    self.view.backgroundColor = [UIColor whiteColor];
    [self firstView];
    [self announcementLab];
    [self moreBtn];
    [self webView];
    [self loadString:[__API_HEADER__ stringByAppendingString:@"v2/open/activity.jsp"]];
    [self lode];
    [self imgView];
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

-(UIWebView *)webView{
    if (_webView == nil) {
        _webView = [UIWebView new];
        [self.view addSubview:_webView];
        [_webView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.firstView.mas_bottom).offset(0);
            make.left.mas_equalTo(0);
            make.right.mas_equalTo(0);
            make.bottom.mas_equalTo(0);
        }];
    }
    return _webView;
}
- (void)loadString:(NSString *)str  {
    // 1. URL 定位资源,需要资源的地址
    NSURL *url = [NSURL URLWithString:str];
    
    // 2. 把URL告诉给服务器,请求,从m.baidu.com请求数据
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    // 3. 发送请求给服务器
    [self.webView loadRequest:request];
    
}
#pragma mark - 懒加载
-(UIView *)firstView{
    if (_firstView == nil) {
        _firstView = [UIView new];
        [self.view addSubview:_firstView];
        _firstView.backgroundColor = [UIColor whiteColor];
        //        _firstView.layer.cornerRadius = 1;
        _firstView.layer.masksToBounds = YES;
        _firstView.layer.borderWidth = 0.5;
        _firstView.layer.borderColor = [UIColor lightGrayColor].CGColor;
        [_firstView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(0);
            make.left.mas_equalTo(0);
            make.right.mas_equalTo(0);
            make.height.mas_equalTo(30);
        }];
    }
    return _firstView;
}

-(UILabel *)announcementLab{
    
    if (_announcementLab == nil) {
        _announcementLab = [UILabel new];
        [self.firstView addSubview:_announcementLab];
        UITapGestureRecognizer *labelTapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(labelClick)];
        // 2. 将点击事件添加到label上
        [_announcementLab addGestureRecognizer:labelTapGestureRecognizer];
        _announcementLab.userInteractionEnabled = YES;
        _announcementLab.font = [UIFont systemFontOfSize:12];
        //        _announcementLab.textColor = [UIColor blueColor];
        [_announcementLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(5);
            make.bottom.mas_equalTo(-5);
            make.left.mas_equalTo(25);
            make.right.mas_equalTo(-100);
        }];
    }
    return _announcementLab;
}
-(UIImageView *)imgView{
    if (_imgView == nil) {
        _imgView = [UIImageView new];
        _imgView.image = [UIImage imageNamed:@"bugle"];
        [self.firstView addSubview:_imgView];
        [_imgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(5);
            make.bottom.mas_equalTo(-5);
            make.left.mas_equalTo(5);
            make.width.mas_equalTo(20);
        }];
    }
    return _imgView;
}

-(UIButton *)moreBtn{
    if (_moreBtn == nil) {
        _moreBtn = [UIButton new];
        [self.firstView addSubview:_moreBtn];
        [_moreBtn setTitleColor:[UIColor lightGrayColor] forState:(UIControlStateNormal)];
        _moreBtn.titleLabel.font = [UIFont systemFontOfSize: 12];
        _moreBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
        [_moreBtn setTitle:@"更多 >" forState:UIControlStateNormal];
        [_moreBtn addTarget:self action:@selector(moreClick) forControlEvents:UIControlEventTouchDown];
        [_moreBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(-10);
            make.left.mas_equalTo(self.announcementLab.mas_right).offset(10);
            make.bottom.mas_equalTo(-5);
            make.top.mas_equalTo(5);
        }];
    }
    return _moreBtn;
}
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
