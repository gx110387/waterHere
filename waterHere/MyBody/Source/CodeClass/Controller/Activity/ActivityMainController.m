//
//  ActivityMainController.m
//  ZouZou
//
//  Created by lanou3g on 15/10/14.
//  Copyright (c) 2015年 lanou3g. All rights reserved.
//

#import "ActivityMainController.h"

@interface ActivityMainController ()

@end

@implementation ActivityMainController

//-(void)viewWillAppear:(BOOL)animated
//{
//    DDLog(@"%@",self.navigationController.viewControllers);
//    [super viewWillAppear:animated];
//   
//    [self.navigationController setNavigationBarHidden:YES animated:NO];
//    [[UINavigationBar appearance] setBackgroundImage:[UIImage imageNamed:@""] forBarMetrics:UIBarMetricsDefault];
//    [[[self.navigationController.navigationBar subviews] objectAtIndex:0] setAlpha:0];
//
//}
//-(void)viewWillDisappear:(BOOL)animated
//{
//    DDLog(@"");
//    [self.navigationController setNavigationBarHidden:NO animated:NO];
//    [[UINavigationBar appearance] setBackgroundImage:[UIImage imageNamed:@"NaviBarBg"] forBarMetrics:UIBarMetricsDefault];
//    
//}


- (void)viewDidLoad {
    [super viewDidLoad];
//      self.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage resizeImage:[UIImage imageNamed:@"NaviTitleImg"] withNewSize:CGSizeMake(G_Iphone6(120), G_Iphone6(26))]];
        self.navigationItem.titleView =  [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"NaviTitleImg"]];
    
     DDLog(@"");
    // Do any additional setup after loading the view.
        ActivityTableViewController *oneViewController = [[ActivityTableViewController alloc] init];
    oneViewController.title = @"全部";
   

    
    SecendTableViewController *twoViewController = [[SecendTableViewController alloc] init];
    twoViewController.title = @"景点";
    
    
    ThirdTableViewController *threeViewController = [[ThirdTableViewController alloc] init];
    threeViewController.title = @"住宿";
   
    
    FourTableViewController *fourViewController = [[FourTableViewController alloc] init];
    fourViewController.title = @"餐厅";
   
    
    FiveTableViewController *fiveViewController = [[FiveTableViewController alloc] init];
    fiveViewController.title = @"休闲娱乐";
    
    SixTableViewController *sixViewController = [[SixTableViewController alloc] init];
    sixViewController.title = @"购物";
    
    
  
    SCNavTabBarController *navTabBarController = [[SCNavTabBarController alloc] init];
    navTabBarController.subViewControllers = @[oneViewController, twoViewController, threeViewController, fourViewController, fiveViewController, sixViewController];
    navTabBarController.navTabBarColor = [ UIColor whiteColor];
    navTabBarController.navTabBarLineColor =[UIColor colorWithHexString:@"#009FE8"];
    [navTabBarController addParentController:self];
    

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
