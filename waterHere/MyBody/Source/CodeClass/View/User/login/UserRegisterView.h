//
//  RegisterView.h
//  MyBody
//
//  Created by hua on 16/7/18.
//  Copyright © 2016年 gx110387. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol UserRegisterViewDelegate <NSObject>

-(void)RegisternAction:(NSString *)UserName emil:(NSString *)emil phone:(NSString *)phone password:(NSString *)password agapsd:(NSString *)agapsd;

@end

@interface UserRegisterView : UIView

@property(nonatomic,strong)UITextField *userNameTextField;
@property(nonatomic,strong)UITextField *emilTextField;
@property(nonatomic,strong)UITextField *phoneTextField;
@property(nonatomic,strong)UITextField *passwordTextField;
@property(nonatomic,strong)UITextField *againPsdTextField;
@property(nonatomic,strong)UIButton *submitButton;

@property(nonatomic,weak)id<UserRegisterViewDelegate>delegate;
@end
