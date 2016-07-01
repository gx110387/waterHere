//
//  DesWebViewController.m
//  ZouZou
//
//  Created by lanou3g on 15/10/21.
//  Copyright (c) 2015年 lanou3g. All rights reserved.
//

#import "DesWebViewController.h"

@interface DesWebViewController ()<UIWebViewDelegate>
@property(nonatomic,strong)UIWebView *webview;
@end

@implementation DesWebViewController
-(void)viewWillAppear:(BOOL)animated
{
   [self.navigationController setNavigationBarHidden:NO animated:YES];
    
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor cyanColor];
    self.webview = [[UIWebView alloc]initWithFrame:CGRectMake(0, -44, self.view.frame.size.width, self.view.frame.size.height+66)];
    self.webview.backgroundColor = [UIColor yellowColor];
    self.webview.dataDetectorTypes = UIWebViewNavigationTypeLinkClicked;
    self.webview.delegate = self;
    UIScrollView *scrollView = (UIScrollView *)[[self.webview subviews] objectAtIndex:0];
    scrollView.bounces = NO;
    [self.view addSubview:self.webview];
 //-------/1/3808/
    if ([self.typeString isEqualToString:@"S"]) {
        // 实用须知
        NSString *s =[NSString stringWithFormat:@"http://web.breadtrip.com/mobile/destination%@overview/",self.shiyongString];
        [self loadString:s];
        
    }
    if ([self.typeString isEqualToString:@"B"]) {
        // 不可错过
        NSString *s = [NSString stringWithFormat:@"http://web.breadtrip.com/mobile/destination%@intro/",self.shiyongString];
        [self loadString:s];
        
    }
    if ([self.typeString isEqualToString:@"T"]) {
        // 推荐路线
        NSString *s = [NSString stringWithFormat:@"http://web.breadtrip.com/mobile/destination%@routes/",self.shiyongString];
        [self loadString:s];
    }

//    if ([self.typeString isEqualToString:@"Z"]) {
//        // 主题榜单
//        NSString *s =@"http://web.breadtrip.com/mobile/destination/1/3673/top10_list/";//[NSString stringWithFormat:@"http://web.breadtrip.com/mobile/destination/1/%@/overview/",self.shiyongString];
//        [self loadString:s];
//    }
   }

-(void)webViewDidFinishLoad:(UIWebView *)webView
{
    NSString *currentURL = [webView stringByEvaluatingJavaScriptFromString:@"window.history"];
    NSLog(@"%@====",currentURL);
}
- (BOOL)webView:(UIWebView*)webView shouldStartLoadWithRequest:(NSURLRequest*)request navigationType:(UIWebViewNavigationType)navigationType {
        if (navigationType == UIWebViewNavigationTypeLinkClicked) {
               NSLog(@"cururl1............... " );
    }
    if (navigationType == UIWebViewNavigationTypeFormSubmitted) {
        NSLog(@"cururl2............... " );
    }
    if (navigationType == UIWebViewNavigationTypeBackForward) {
        NSLog(@"cururl.3.............. " );
    }
    if (navigationType == UIWebViewNavigationTypeReload) {
        NSLog(@"cururl4............... " );
    }
    if (navigationType == UIWebViewNavigationTypeFormResubmitted) {
        NSLog(@"cururl5............... " );
    }
    if (navigationType == UIWebViewNavigationTypeOther) {
        NSLog(@"cururl6............... " );
       NSURL *url = [request URL];
        NSLog(@"%@",url);
//        if([[UIApplication sharedApplication]canOpenURL:url])//
//        {//
//            [[UIApplication sharedApplication]openURL:url];//
//        }//
//        return NO;
    }
     return YES;
}


- (void)loadString:(NSString *)str
{
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:str]];
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
