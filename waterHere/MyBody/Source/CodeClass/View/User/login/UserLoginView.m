//
//  UserLoginView.m
//  MyBody
//
//  Created by hua on 16/7/18.
//  Copyright © 2016年 lanou3g. All rights reserved.
//

#import "UserLoginView.h"

@interface UserLoginView ()<UITextFieldDelegate>

@end

@implementation UserLoginView


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
//    self.backgroundColor  = [UIColor redColor];
    
    _userNameTextField = [ UITextField textFielWithFrame:CGRectMake(G_Iphone6(48), 9, MainScreenWidth-G_Iphone6(48*2), G_Iphone6(41)) leftImageView:[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 8, 0)]  titleOfPlaceholder:@"userName" font:12 textColor:[UIColor whiteColor] borderColor:CustomerColor(79, 79,79) borderWidth:0.5];
    _userNameTextField.layer.cornerRadius =6;
    _userNameTextField.layer.masksToBounds = YES;
 
    _userNameTextField.delegate = self;
    
    [self addSubview:_userNameTextField];
    
    //
    _passwordTextField = [ UITextField textFielWithFrame:CGRectMake(G_Iphone6(48), CGRectGetMaxY(_userNameTextField.frame)+G_Iphone6(13), CGRectGetWidth(_userNameTextField.frame), CGRectGetHeight(_userNameTextField.frame)) leftImageView:[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 8, 0)]  titleOfPlaceholder:@"password" font:12 textColor:[UIColor whiteColor] borderColor:CustomerColor(79, 79,79) borderWidth:0.5];
    _passwordTextField.layer.cornerRadius = 6;
    _passwordTextField.layer.masksToBounds = YES;
    _passwordTextField.delegate =self;
    
    [self addSubview:_passwordTextField];
    
    _submitButton = [ UIButton buttonWithFrame:CGRectMake(G_Iphone6(48), CGRectGetMaxY(_passwordTextField.frame)+10, CGRectGetWidth(_userNameTextField.frame), CGRectGetHeight(_userNameTextField.frame)  ) title:@"确认登陆" backgroundColor: CustomerColorOfAlpha(31, 75, 165, 1  ) type:UIButtonTypeCustom target:self action:@selector(submiteAction)];
    _submitButton.titleLabel.font = [UIFont systemFontOfSize:12];
    _submitButton.layer.cornerRadius = CGRectGetHeight(_userNameTextField.frame) /2;
    _submitButton.layer.masksToBounds = YES;
    [_submitButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    [self addSubview:_submitButton];
    UIColor *colora = [UIColor whiteColor];
    
    _userNameTextField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"用户名" attributes:@{NSForegroundColorAttributeName:colora}];
    
    _passwordTextField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"密码" attributes:@{NSForegroundColorAttributeName:colora}];

    [self stopKeyBoard:self];
}
-(void)submiteAction
{
    DDLog(@"");
    
    if ([self.userNameTextField.text isEqualToString:@""]) {
        
        [AlertShow alertShowWithContent:@"用户名不能为空" Seconds:2];
    }else if ([self.passwordTextField.text isEqualToString:@""])
    {
        [AlertShow alertShowWithContent:@"密码不能为空" Seconds:2];
        
    }
    else{
        [self resignFirst];
        if ([self.delegate respondsToSelector:@selector(loginAction:psd:)]) {
            [self.delegate loginAction:_userNameTextField.text psd:_passwordTextField.text];
        }
    }
}
-(void)stopKeyBoard:(UIView *)view
{
    
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(keyboardHide:)];
    //设置成NO表示当前控件响应后会传播到其他控件上，默认为YES。
    tapGestureRecognizer.cancelsTouchesInView = NO;
    //将触摸事件添加到当前view
    [view addGestureRecognizer:tapGestureRecognizer];
    
}

-(void)keyboardHide:(UITapGestureRecognizer*)tap{
    DoLog(@"d 00");
    [self resignFirst];
    
}
-(void)resignFirst
{
    [_userNameTextField resignFirstResponder];
    [_passwordTextField resignFirstResponder];

    
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    // 响应者 1 有返回值，返回yes， 2 ，释放第一响应者
    [textField resignFirstResponder];
    return YES;
}
@end
