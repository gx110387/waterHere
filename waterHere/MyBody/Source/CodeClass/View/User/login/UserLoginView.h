//
//  UserLoginView.h
//  MyBody
//
//  Created by hua on 16/7/18.
//  Copyright © 2016年 lanou3g. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol UserLoginViewDelegate <NSObject>

-(void)loginAction:(NSString *)UserName psd:(NSString *)psd;

@end

@interface UserLoginView : UIView

@property(nonatomic,strong)UITextField *userNameTextField;
@property(nonatomic,strong)UITextField *passwordTextField;
@property(nonatomic,strong)UIButton *submitButton;
@property(nonatomic,weak)id<UserLoginViewDelegate>delegate;

@end
