//
//  ProductViewController.m
//  ZouZou
//
//  Created by NISIOISIN on 15/10/16.
//  Copyright © 2015年 lanou3g. All rights reserved.
//

#import "ProductViewController.h"
#import "TakeMainViewController.h"
@interface ProductViewController ()
@property(nonatomic,strong)UIWebView *webview;
@end

@implementation ProductViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationItem.title=@"详情页面~";
    self.webview = [[UIWebView alloc]initWithFrame:self.view.frame];
    
    [self.view addSubview:_webview];
    UIScrollView *scrollView = (UIScrollView *)[[self.webview subviews] objectAtIndex:0];
    scrollView.bounces = NO;
    
    
    self.webview.backgroundColor = [UIColor clearColor];
    
    NSString *url = [NSString stringWithFormat:@"http://web.breadtrip.com/hunter/product/%@/",_pid];
    
    
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
    
    [self.webview loadRequest:request];
    
    

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
