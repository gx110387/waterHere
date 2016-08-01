//
//  UserLoginMainView.h
//  MyBody
//
//  Created by hua on 16/7/18.
//  Copyright © 2016年 lanou3g. All rights reserved.
//

#import <UIKit/UIKit.h>
@class UserLoginView;
@class UserRegisterView;
@interface UserLoginMainView : UIView
{
    UIButton *loginButton;
    UIButton *registerButton ;
}
@property(nonatomic,strong)UserLoginView *userLoginView;
@property(nonatomic,strong)UserRegisterView *registerView;
@end
