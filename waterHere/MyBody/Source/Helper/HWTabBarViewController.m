//
//  HWTabBarViewController.m
//  黑马微博2期
//
//  Created by apple on 14-10-7.
//  Copyright (c) 2014年 heima. All rights reserved.
//

#import "HWTabBarViewController.h"
#import "UserLoginVC.h"
@interface HWTabBarViewController ()<ABCIntroViewDelegate,UITabBarControllerDelegate>
@property ABCIntroView *introView;
@end

@implementation HWTabBarViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
//    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
//    if (![defaults objectForKey:@"intro_screen_viewed"]) {
        self.introView = [[ABCIntroView alloc] initWithFrame:self.view.frame];
        self.introView.delegate = self;
        self.introView.backgroundColor = [UIColor greenColor];
        [self.view addSubview:self.introView];
         self.delegate = self;
     [self p_setupControllers];
//    }else{
//   
//    
////    [self p_setupControllers];
//    
//    }
   
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
        
       
    }];
    
}

- (void)p_setupControllers
{
    
    // 1.初始化子控制器
    TourMainViewController *home = [[TourMainViewController alloc] init];
    [self addChildVc:home title:@"介绍" image:@"Main_noselet" selectedImage:@"Main_selet"];
    
    TakeMainViewController *messageCenter = [[TakeMainViewController alloc] initWithStyle:UITableViewStyleGrouped];
    [self addChildVc:messageCenter title:@"带你玩" image:@"discover_noselet" selectedImage:@"discover_selet"];
    
    ActivityMainController *discover = [[ActivityMainController alloc] init];
    [self addChildVc:discover title:@"附近" image:@"Near_noselet" selectedImage:@"Near_selet"];
    
    DestinationMainController *profile = [[DestinationMainController alloc] init];
    [self addChildVc:profile title:@"目的地" image:@"des_noselet" selectedImage:@"des_selet"];

    
    UserMainViewController *user = [[UserMainViewController alloc] init];
    [self addChildVc:user title:@"我的" image:@"User_noselet" selectedImage:@"User_selet"];
    

     self.selectedIndex = 0;
}
/**
 *  添加一个子控制器
 *
 *  @param childVc       子控制器
 *  @param title         标题
 *  @param image         图片
 *  @param selectedImage 选中的图片
 */
- (void)addChildVc:(UIViewController *)childVc title:(NSString *)title image:(NSString *)image selectedImage:(NSString *)selectedImage
{
    // 设置子控制器的文字
    childVc.title = title; // 同时设置tabbar和navigationBar的文字
//    childVc.tabBarItem.title = title; // 设置tabbar的文字
//    childVc.navigationItem.title = title; // 设置navigationBar的文字
    
    // 设置子控制器的图片
    childVc.tabBarItem.image = [UIImage imageNamed:image];
    childVc.tabBarItem.selectedImage = [[UIImage imageNamed:selectedImage]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    // 设置文字的样式
    NSMutableDictionary *textAttrs = [NSMutableDictionary dictionary];
    textAttrs[NSForegroundColorAttributeName] =CustomerColor(131,150,177);
    NSMutableDictionary *selectTextAttrs = [NSMutableDictionary dictionary];
    selectTextAttrs[NSForegroundColorAttributeName] =  CustomerColor(23,36,52);
    [childVc.tabBarItem setTitleTextAttributes:textAttrs forState:UIControlStateNormal];
    [childVc.tabBarItem setTitleTextAttributes:selectTextAttrs forState:UIControlStateSelected];
//    childVc.view.backgroundColor = HWRandomColor;
    
    // 先给外面传进来的小控制器 包装 一个导航控制器
    HWNavigationController *nav = [[HWNavigationController alloc] initWithRootViewController:childVc];
    // 添加为子控制器
    [self addChildViewController:nav];
}
-(BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController
{
    NSLog(@"%@",viewController.tabBarItem.title);
    if ([viewController.tabBarItem.title isEqualToString:@"我的"]) {
        AVUser *currentUser = [AVUser currentUser];
        if (currentUser != nil) {
            //登陆
            return YES;
        }else{
            UserLoginVC *loginVC = [[UserLoginVC alloc] init];
            [self presentViewController:loginVC animated:YES completion:nil];
            return NO;
        }
    }else{
        return YES;
    }
}

@end
