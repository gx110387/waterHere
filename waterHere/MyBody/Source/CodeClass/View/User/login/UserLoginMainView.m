//
//  UserLoginMainView.m
//  MyBody
//
//  Created by hua on 16/7/18.
//  Copyright © 2016年 gx110387. All rights reserved.
//

#import "UserLoginMainView.h"
#import "UserLoginView.h"
#import "UserRegisterView.h"
@implementation UserLoginMainView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self createUI];
    }
    return self;
}
-(void)createUI
{
 
  
    loginButton = [UIButton buttonWithFrame:CGRectMake( G_Iphone6(98.8), G_Iphone6(118), G_Iphone6(58), G_Iphone6(65)) title:@"登陆" backgroundColor:[UIColor clearColor] type:UIButtonTypeCustom target:self action:@selector(UserLogin)];
    [loginButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    loginButton.titleLabel.font = [ UIFont systemFontOfSize:20];
    
      registerButton = [UIButton buttonWithFrame:CGRectMake( G_Iphone6(224), G_Iphone6(118), G_Iphone6(58), G_Iphone6(65)) title:@"注册" backgroundColor:[UIColor clearColor] type:UIButtonTypeCustom target:self action:@selector(UserRegister)];
    [registerButton setTitleColor:CustomerColorOfAlpha(181, 179, 179, 1 ) forState:UIControlStateNormal];
    registerButton.titleLabel.font = [ UIFont systemFontOfSize:20];
    
    [self addSubview:loginButton];
    [self addSubview:registerButton];
    
    _userLoginView = [[UserLoginView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(loginButton.frame), MainScreenWidth, MainScreenHeight - CGRectGetMaxY(loginButton.frame))];
    
    [self addSubview:_userLoginView];
    
    _registerView = [[UserRegisterView alloc] initWithFrame:_userLoginView.frame];
    
    
    
    
    
    
}
-(void)UserLogin
{
    DDLog(@"");
    [self addSubview:_userLoginView];
    [_registerView removeFromSuperview];
      [registerButton setTitleColor:CustomerColorOfAlpha(181, 179, 179, 1 ) forState:UIControlStateNormal];
     [loginButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
}
-(void)UserRegister
{
    DDLog(@"");
    [self addSubview:_registerView];
    [_userLoginView removeFromSuperview];
    
    [registerButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [loginButton setTitleColor:CustomerColorOfAlpha(181, 179, 179, 1 ) forState:UIControlStateNormal];
}

@end
