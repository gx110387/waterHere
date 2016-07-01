//
//  RootTabBarController.h
//  Douban
//
//  Created by y_小易 on 14-8-27.
//  Copyright (c) 2014年 lanou3g.com 蓝鸥科技. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RootTabBarController : UITabBarController


@property (strong, nonatomic) UINavigationController *TourBarController;
@property (strong, nonatomic) UINavigationController *TakeBarController;
@property (strong, nonatomic) UINavigationController *ActivityBarController;
@property (strong, nonatomic) UINavigationController *DestinationBarController;
@property (strong, nonatomic) UINavigationController *UserBarController;

@end
