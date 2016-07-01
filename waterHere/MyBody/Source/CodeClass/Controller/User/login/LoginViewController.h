//
//  LoginViewController.h
//  UI综合_豆瓣
//
//  Created by lanou3g on 15/9/18.
//  Copyright (c) 2015年 lanou3g. All rights reserved.
//

#import <UIKit/UIKit.h>
@class UserLoginModel;
typedef void(^myBlock)(UserLoginModel *u);
@interface LoginViewController : UIViewController
@property(nonatomic,copy)myBlock mblock;
@end
