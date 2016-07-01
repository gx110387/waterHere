//
//  WebViewController.m
//  ZouZou
//
//  Created by hhuuqq on 15/10/20.
//  Copyright (c) 2015年 lanou3g. All rights reserved.
//

#import "WebViewController.h"

@interface WebViewController ()

@end

@implementation WebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.webView = [[UIWebView alloc]initWithFrame:self.view.frame];
    self.navigationController.navigationBar.tintColor=[UIColor whiteColor];

    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:self.urlStr]];
    [self.view addSubview:_webView];
    UIScrollView *scrollView = (UIScrollView *)[[self.webView subviews] objectAtIndex:0];
    scrollView.bounces = NO;
    [self.webView loadRequest:request];
    UIImageView *backImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 60)];
    // by hqx 1020 要给ImageView添加button点击事件,需要将其用户模式打开
    backImageView.userInteractionEnabled = YES;
    backImageView.image = [UIImage imageNamed:@"bg_nav.png"];
    
    [self.webView addSubview:backImageView];
    UIButton *leftButton = [UIButton buttonWithType:UIButtonTypeSystem];
    leftButton.frame = CGRectMake(20, 30, 30, 20);
    
    [backImageView addSubview:leftButton];
    [leftButton setTitle:@"返回" forState:UIControlStateNormal];
    leftButton.titleLabel.textColor = [UIColor whiteColor];
    [leftButton addTarget:self action:@selector(leftAction:) forControlEvents:UIControlEventTouchUpInside];
    
}

- (void)leftAction:(UIButton *)sender
{
    [self dismissViewControllerAnimated:YES completion:^{
        
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
