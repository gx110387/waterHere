//
//  AboutUsViewController.m
//  ZouZou
//
//  Created by gx110387 on 15/10/27.
//  Copyright (c) 2015年 gx110387. All rights reserved.
//

#import "AboutUsViewController.h"

@interface AboutUsViewController ()

@end

@implementation AboutUsViewController

- (void)setNavBarAppearance:(BOOL)animated {
    [self.navigationController setNavigationBarHidden:NO animated:animated];
    UINavigationBar *navBar = self.navigationController.navigationBar;
    navBar.tintColor = [UIColor whiteColor];
    navBar.barTintColor = nil;
    navBar.shadowImage = nil;
    navBar.translucent = YES;
    navBar.barStyle = UIBarStyleBlackTranslucent;
    [navBar setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
    [navBar setBackgroundImage:nil forBarMetrics:UIBarMetricsLandscapePhone];
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
     
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    // Do any additional setup after loading the view.
    self.navigationItem.title =@"关于我们";

    NSString *s =[NSString stringWithFormat:@"\n\n关于我们\n \n  点滴旅行是一款查看其他人探索世界的轨迹，收获旅途中的点点滴滴,把世界景点收入手中的app应用。让你足不出门,就可以看到世界的精彩瞬间、旅行线路。通过查看附近景点,让你的出行轻松自由,把你喜欢的游记,景点收藏起来,时刻回温那梦想已久的目的地, 你还可以方便地通过新浪微博等社交网络将你看到的游记分享出去，和更多朋友分享你的喜悦,让你的生活充满色彩。\n\n 版本:V%@\n\n",XcodeAppVersion];
    
    UIImageView *img = [[UIImageView alloc]init];
    img.image = [UIImage imageNamed:@"PortolBackGround"];
    img.frame = CGRectMake(0, 0, MainScreenWidth, CGRectGetHeight(self.view.frame)-64);
    [self.view addSubview:img];
    
    UIScrollView *scroll = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, MainScreenWidth, CGRectGetHeight(self.view.frame)-64)];
    
    scroll.contentSize = CGSizeMake(MainScreenWidth, [GGxTools G_heightForString:s num:16 width:MainScreenWidth-20]);
    
    
    
    [self.view addSubview:scroll];
    
    UIImageView *backImage = [[UIImageView alloc] init];
    backImage.image = [UIImage imageNamed:@"portol"];
    [backImage sizeToFit];
    backImage.frame = CGRectMake(MainScreenWidth/2-backImage.width/2, G_Iphone6(23), backImage.width, backImage.height);
    [scroll addSubview:backImage];
    
    
    
    UILabel * laber = [[UILabel alloc] initWithFrame:CGRectMake(10,CGRectGetMaxY(backImage.frame),CGRectGetWidth(self.view.frame)-20, [GGxTools G_heightForString:s num:16 width:MainScreenWidth-20])];
    laber.backgroundColor = [UIColor clearColor];
    laber.numberOfLines = 0;
    laber.text = s;
    laber.textColor = CustomerColor(255, 255, 255);
    laber.font = [UIFont systemFontOfSize:15];
    laber.textAlignment = NSTextAlignmentCenter;
    [scroll addSubview:laber];
    

    
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
