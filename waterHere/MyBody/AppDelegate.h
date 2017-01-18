//
//  AppDelegate.h
//  MyBody
//
//  Created by gx110387 on 15/10/28.
//  Copyright © 2015年 gx110387. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Reachability;
@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) Reachability *reach;

@end

