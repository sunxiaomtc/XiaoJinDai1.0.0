//
//  YinDaoViewController.m
//  NiuduFinance
//
//  Created by 小吊丝 on 2017/9/28.
//  Copyright © 2017年 liuyong. All rights reserved.
//

#import "YinDaoViewController.h"
#import "TabBarController.h"
#import "AppDelegate.h"
#import "GestureViewController.h"

@interface YinDaoViewController ()

@end

@implementation YinDaoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    [self.view addSubview:scrollView];
    scrollView.pagingEnabled = YES;
    scrollView.bounces = NO;
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.contentSize = CGSizeMake(SCREEN_WIDTH*3, SCREEN_HEIGHT);
    for (int i = 0; i < 3; i++) {
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH*i, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        [scrollView addSubview:imageView];
        imageView.image = [UIImage imageNamed:@"LaunchImage-1"];
        imageView.userInteractionEnabled = YES;
        if (i == 0) {
            imageView.backgroundColor = [UIColor redColor];
        }
        if (i == 1) {
            imageView.backgroundColor = [UIColor yellowColor];
        }
        if (i == 2) {
            imageView.backgroundColor = [UIColor greenColor];
            UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake((SCREEN_WIDTH-100)/2, SCREEN_HEIGHT-100, 100, 30)];
            [imageView addSubview:button];
            [button addTarget:self action:@selector(buttonAction) forControlEvents:(UIControlEventTouchUpInside)];
            button.backgroundColor = [UIColor purpleColor];
        }
    }
    
    GestureViewController *gestureVc = [[GestureViewController alloc] init];
    [gestureVc setType:GestureViewControllerTypeLogin];
    APPDELEGATE.window.rootViewController = gestureVc;
    
}

-(void)buttonAction
{
    [[NSUserDefaults standardUserDefaults] setObject:@"1" forKey:@"引导页"];
    //未登录状态
    AppDelegate *app = (AppDelegate *)[UIApplication sharedApplication].delegate;
    TabBarController *tabbarController = [[TabBarController alloc] init];
    app.window.rootViewController = tabbarController;
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    
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
