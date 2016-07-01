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
-(void)viewWillAppear:(BOOL)animated
{
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    [self showTabBar];
    
}
- (void)showTabBar

{
    if (self.tabBarController.tabBar.hidden == NO)
    {
        return;
    }
    UIView *contentView;
    if ([[self.tabBarController.view.subviews objectAtIndex:0] isKindOfClass:[UITabBar class]])
        
        contentView = [self.tabBarController.view.subviews objectAtIndex:1];
    
    else
        
        contentView = [self.tabBarController.view.subviews objectAtIndex:0];
    contentView.frame = CGRectMake(contentView.bounds.origin.x, contentView.bounds.origin.y,  contentView.bounds.size.width, contentView.bounds.size.height - self.tabBarController.tabBar.frame.size.height);
    
    self.tabBarController.tabBar.hidden = NO;
    
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title =@"看看附近好玩哒~";
    ActivityTableViewController *oneViewController = [[ActivityTableViewController alloc] init];
    oneViewController.title = @"全部";
    oneViewController.tableView.backgroundColor = [UIColor colorWithRed:251/255.0 green:247/255.0 blue:237/255.0 alpha:1];

    
    SecendTableViewController *twoViewController = [[SecendTableViewController alloc] init];
    twoViewController.title = @"景点";
    twoViewController.tableView.backgroundColor = [UIColor colorWithRed:251/255.0 green:247/255.0 blue:237/255.0 alpha:1];

    
    ThirdTableViewController *threeViewController = [[ThirdTableViewController alloc] init];
    threeViewController.title = @"住宿";
    threeViewController.tableView.backgroundColor = [UIColor colorWithRed:251/255.0 green:247/255.0 blue:237/255.0 alpha:1];

    
    FourTableViewController *fourViewController = [[FourTableViewController alloc] init];
    fourViewController.title = @"餐厅";
    fourViewController.tableView.backgroundColor = [UIColor colorWithRed:251/255.0 green:247/255.0 blue:237/255.0 alpha:1];

    
    FiveTableViewController *fiveViewController = [[FiveTableViewController alloc] init];
    fiveViewController.title = @"休闲娱乐";
    fiveViewController.tableView.backgroundColor = [UIColor colorWithRed:251/255.0 green:247/255.0 blue:237/255.0 alpha:1];

    
    SixTableViewController *sixViewController = [[SixTableViewController alloc] init];
    sixViewController.title = @"购物";
    sixViewController.tableView.backgroundColor = [UIColor colorWithRed:251/255.0 green:247/255.0 blue:237/255.0 alpha:1];

    
    
    
    SCNavTabBarController *navTabBarController = [[SCNavTabBarController alloc] init];
    navTabBarController.subViewControllers = @[oneViewController, twoViewController, threeViewController, fourViewController, fiveViewController, sixViewController];
    
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
