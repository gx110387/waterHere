//
//  AppDelegate.m
//  MyBody
//
//  Created by lanou3g on 15/10/28.
//  Copyright © 2015年 lanou3g. All rights reserved.
//

#import "AppDelegate.h"
#import "UMSocial.h"
#import <AVOSCloud/AVOSCloud.h>
#import "UIViewController+Swizzled.h"
@interface AppDelegate ()

@end

@implementation AppDelegate

//-(void)swizzIt
//{
//    
//    
//    
//}
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]] ;
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
   //SWIZZ_IT;
    //添加window的根视图控制器，UITabBarController
    HWTabBarViewController * tabBarVC = [[HWTabBarViewController alloc] init];
    self.window.rootViewController = tabBarVC;
    
    [UMSocialData setAppKey:@"5629ed3167e58e76f3000cc9"];
    
    [AVOSCloud setApplicationId:@"bwLt1XgNOqtXJlt6Oc6bUhF4"
                      clientKey:@"wDdtBUaldweDM1BwAj0elkvK"];
    
    [AVAnalytics trackAppOpenedWithLaunchOptions:launchOptions];
    
    
    
    ///开启网络状况的监听
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(reachabilityChanged:)
                                                 name:kReachabilityChangedNotification
                                               object:nil];
    
    //self.reach = [Reachability reachabilityWithHostName:@"www.baidu.com"];
    
    [self.reach startNotifier]; //开始监听，会启动一个run loop
    
    
    return YES;
    
}
//通知
-(void)reachabilityChanged:(NSNotification*)note
{
    Reachability * reach = [note object];
    NSParameterAssert([reach isKindOfClass: [Reachability class]]);
    NetworkStatus status = [reach currentReachabilityStatus];
    
    //    //用于检测是否是WIFI
    //    NSLog(@"%d",([[Reachability reachabilityForLocalWiFi] currentReachabilityStatus] != NotReachable));
    //    //用于检查是否是3G
    //    NSLog(@"%d",([[Reachability reachabilityForInternetConnection] currentReachabilityStatus] != NotReachable));
    
    if (status == NotReachable) {
        [AlertShow alertShowWithContent:@"当前网络已断开" Seconds:3];
        
    }else if(status == ReachableViaWWAN){
         [AlertShow alertShowWithContent:@"正在使用移动网络,是否允许观看视频" Seconds:3];
        
    }else if(status == ReachableViaWiFi){
        [AlertShow alertShowWithContent:@"正在使用Wifi网络" Seconds:3];

          }
   }


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
     //[[NSUserDefaults standardUserDefaults]setBool:NO forKey:[[G_shareTools shareTools] getUserLogin] ];
    //[[NSUserDefaults standardUserDefaults]setBool:NO forKey:[[G_shareTools shareTools] getUserLogin] ];
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    
}

@end
