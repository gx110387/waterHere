//
//  WebViewController.m
//  ZouZou
//
//  Created by hhuuqq on 15/10/20.
//  Copyright (c) 2015年 gx110387. All rights reserved.
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
 
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"返回"   style:UIBarButtonItemStyleDone target:self action:@selector(leftAction)];
    self.navigationItem.titleView =  [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"NaviTitleImg"]];

}

- (void)leftAction 
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
