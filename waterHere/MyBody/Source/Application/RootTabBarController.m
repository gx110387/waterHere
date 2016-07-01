//
//  RootTabBarController.m
//  Douban
//
//  Created by y_小易 on 14-8-27.
//  Copyright (c) 2014年 lanou3g.com 蓝鸥科技. All rights reserved.
//

#import "RootTabBarController.h"


@interface RootTabBarController () <ABCIntroViewDelegate>

//添加controller
- (void)p_setupControllers;
@property ABCIntroView *introView;
@end

@implementation RootTabBarController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    

    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    if (![defaults objectForKey:@"intro_screen_viewed"]) {
        self.introView = [[ABCIntroView alloc] initWithFrame:self.view.frame];
        self.introView.delegate = self;
        self.introView.backgroundColor = [UIColor greenColor];
        [self.view addSubview:self.introView];
    }
   
   // 添加视图控制器
    
}

#pragma mark - ABCIntroViewDelegate Methods

-(void)onDoneButtonPressed{
    
    //    Uncomment so that the IntroView does not show after the user clicks "DONE"
    //    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    //    [defaults setObject:@"YES"forKey:@"intro_screen_viewed"];
    //    [defaults synchronize];
    
    [UIView animateWithDuration:1.0 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.introView.alpha = 0;
    } completion:^(BOOL finished) {
        [self.introView removeFromSuperview];
        [self p_setupControllers];
    }];
}
//添加controller  // By 高星 2015-10-14
- (void)p_setupControllers
{
    if([[[UIDevice currentDevice] systemVersion] doubleValue] >= 7.0){
        [[UINavigationBar appearance] setTranslucent:NO];
    }
    [[UINavigationBar appearance] setBackgroundImage:[UIImage imageNamed:@"bg_nav.png"] forBarMetrics:UIBarMetricsDefault];
    [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
   // [[UINavigationBar appearance] setBackgroundColor:[UIColor whiteColor]];
   UIColor * color = [UIColor whiteColor];
    NSDictionary * dict=[NSDictionary dictionaryWithObject:color forKey:UITextAttributeTextColor];
//    //self.navigationController.navigationBar.titleTextAttributes = dict;
    [[UINavigationBar appearance] setTitleTextAttributes:dict];

    //设置字体颜色
    UIColor *titleNormalColor = [UIColor blackColor];
    UIColor *titleSelectedColor = [UIColor orangeColor];
    
    [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                                       titleNormalColor, NSForegroundColorAttributeName,
                                                       nil] forState:UIControlStateNormal];
    [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                                       titleSelectedColor, NSForegroundColorAttributeName,
                                                       nil] forState:UIControlStateSelected];
    
   ////五个模块：介绍:   带你玩:    附近:     目的地:    我的:
    
    //介绍
     TourMainViewController  *tourMainViewController= [[TourMainViewController alloc] init];
    
    UITabBarItem *item1 = [[UITabBarItem alloc] initWithTitle:@"介绍" image:nil tag:1];
    item1.image = [[UIImage imageNamed:@"Main_Black.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];//忽略tabBar.tintColor
    item1.selectedImage = [[UIImage imageNamed:@"Main_on.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    tourMainViewController.tabBarItem = item1;
    
    
    
    //带你玩:
    TakeMainViewController *takeMainViewController = [[TakeMainViewController alloc] init];
    UITabBarItem *item2 = [[UITabBarItem alloc] initWithTitle:@"带你玩" image:nil tag:2];
    item2.image = [[UIImage imageNamed:@"discover_black.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    item2.selectedImage = [[UIImage imageNamed:@"discover_on.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    takeMainViewController.tabBarItem = item2;
    
    
    //附近:
    
    ActivityMainController *activityMainController = [[ActivityMainController alloc] init];
    UITabBarItem *item3 = [[UITabBarItem alloc] initWithTitle:@"附近" image:nil tag:3];
    item3.image = [[UIImage imageNamed:@"VIP_black.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    item3.selectedImage = [[UIImage imageNamed:@"VIP_on.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    activityMainController.tabBarItem = item3;
    
    
    // 目的地:
    DestinationMainController *destinationMainController = [[DestinationMainController alloc] initWithStyle:UITableViewStyleGrouped];
    UITabBarItem *item4 = [[UITabBarItem alloc] initWithTitle:@"目的地" image:nil tag:4];
    item4.image = [[UIImage imageNamed:@"ding_b.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    item4.selectedImage = [[UIImage imageNamed:@"ding_o.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    destinationMainController.tabBarItem = item4;
    
    
    // 我的:
    UserMainViewController *userMainViewController = [[UserMainViewController alloc] init];
    UITabBarItem *item5 = [[UITabBarItem alloc] initWithTitle:@"我的" image:nil tag:4];
    item5.image = [[UIImage imageNamed:@"User_black.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    item5.selectedImage = [[UIImage imageNamed:@"User_on.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    userMainViewController.tabBarItem = item5;

    
    
    //导航栏
    self.TourBarController = [[UINavigationController alloc] initWithRootViewController:tourMainViewController];
    self.TakeBarController = [[UINavigationController alloc] initWithRootViewController:takeMainViewController];
    self.ActivityBarController = [[UINavigationController alloc] initWithRootViewController:activityMainController];
    self.DestinationBarController = [[UINavigationController alloc] initWithRootViewController:destinationMainController];
    
 self.UserBarController = [[UINavigationController alloc] initWithRootViewController:userMainViewController];

    
    NSArray *arr = [NSArray arrayWithObjects:_TourBarController,_TakeBarController,_ActivityBarController,_DestinationBarController,_UserBarController, nil];
    self.viewControllers =arr; //@[_TourBarController,_TakeBarController,_ActivityBarController,_DestinationBarController,_UserBarController];
    self.selectedIndex = 0;
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
