//
//  RegisterView.m
//  MyBody
//
//  Created by hua on 16/7/18.
//  Copyright © 2016年 lanou3g. All rights reserved.
//

#import "UserRegisterView.h"

@interface UserRegisterView ()<UITextFieldDelegate>

@end

@implementation UserRegisterView
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
    CGFloat gap = G_Iphone6(48);
    CGFloat widthgap =MainScreenWidth-G_Iphone6(48*2);
    CGFloat heightgap = G_Iphone6(41);
 
    _userNameTextField = [ UITextField textFielWithFrame:CGRectMake(gap, 9, widthgap,heightgap) leftImageView:[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 8, 0)]  titleOfPlaceholder:@"userName" font:12 textColor:[UIColor whiteColor] borderColor:CustomerColor(79, 79,79) borderWidth:0.5];
    _userNameTextField.layer.cornerRadius =6;
    _userNameTextField.layer.masksToBounds = YES;
    
     [self addSubview:_userNameTextField];
    
    _emilTextField =   [ UITextField textFielWithFrame:CGRectMake(gap, CGRectGetMaxY(_userNameTextField.frame)+10, widthgap,heightgap) leftImageView:[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 8, 0)]  titleOfPlaceholder:@"userName" font:12 textColor:[UIColor whiteColor] borderColor:CustomerColor(79, 79,79) borderWidth:0.5];
    _emilTextField.layer.cornerRadius =6;
    _emilTextField.layer.masksToBounds = YES;
    
    [self addSubview:_emilTextField];
    
    _phoneTextField =   [ UITextField textFielWithFrame:CGRectMake(gap, CGRectGetMaxY(_emilTextField.frame)+10, widthgap,heightgap) leftImageView:[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 8, 0)]  titleOfPlaceholder:@"userName" font:12 textColor:[UIColor whiteColor] borderColor:CustomerColor(79, 79,79) borderWidth:0.5];
    _phoneTextField.layer.cornerRadius =6;
    _phoneTextField.layer.masksToBounds = YES;
    
    [self addSubview:_phoneTextField];
    
    
    _passwordTextField =   [ UITextField textFielWithFrame:CGRectMake(gap, CGRectGetMaxY(_phoneTextField.frame)+10, widthgap,heightgap) leftImageView:[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 8, 0)]  titleOfPlaceholder:@"userName" font:12 textColor:[UIColor whiteColor] borderColor:CustomerColor(79, 79,79) borderWidth:0.5];
    _passwordTextField.layer.cornerRadius =6;
    _passwordTextField.layer.masksToBounds = YES;
    
    [self addSubview:_passwordTextField];

    _againPsdTextField =   [ UITextField textFielWithFrame:CGRectMake(gap, CGRectGetMaxY(_passwordTextField.frame)+10, widthgap,heightgap) leftImageView:[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 8, 0)]  titleOfPlaceholder:@"userName" font:12 textColor:[UIColor whiteColor] borderColor:CustomerColor(79, 79,79) borderWidth:0.5];
    _againPsdTextField.layer.cornerRadius =6;
    _againPsdTextField.layer.masksToBounds = YES;
    
    [self addSubview:_againPsdTextField];
    
    
    _submitButton = [ UIButton buttonWithFrame:CGRectMake(gap, CGRectGetMaxY(_againPsdTextField.frame)+10,  widthgap,heightgap ) title:@"注册" backgroundColor: CustomerColorOfAlpha(31, 75, 165, 1  ) type:UIButtonTypeCustom target:self action:@selector(submiteAction)];
    _submitButton.layer.cornerRadius = CGRectGetHeight(_userNameTextField.frame) /2;
        _submitButton.titleLabel.font = [UIFont systemFontOfSize:12];
    _submitButton.layer.masksToBounds = YES;
    [_submitButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self addSubview:_submitButton];
    

    UIColor *colora = [UIColor whiteColor];
    
    _userNameTextField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"用户名" attributes:@{NSForegroundColorAttributeName:colora}];
     _emilTextField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"邮箱" attributes:@{NSForegroundColorAttributeName:colora}];
     _phoneTextField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"手机号" attributes:@{NSForegroundColorAttributeName:colora}];
     _passwordTextField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"密码" attributes:@{NSForegroundColorAttributeName:colora}];
     _againPsdTextField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"再次输入密码" attributes:@{NSForegroundColorAttributeName:colora}];
    
    _userNameTextField.delegate =self;
    _emilTextField.delegate = self;
    _phoneTextField.delegate = self;
    _passwordTextField.delegate = self;
    _againPsdTextField.delegate = self;
    
    
    [self stopKeyBoard:self];
}
-(void)submiteAction
{
    DDLog(@"");
    
    
    if ([_userNameTextField.text isEqualToString:@""] || [_passwordTextField.text isEqualToString:@""]) {
        
        [AlertShow alertShowWithContent:@"账号和密码为空：" Seconds:1.f];
        return;
    }
    else if ([_userNameTextField.text isEqualToString:_passwordTextField.text ]) {
        
        [AlertShow alertShowWithContent:@"账号和密码相同：" Seconds:1.f];
        
        return;
    }else if (NO == [_passwordTextField.text  isEqualToString:_againPsdTextField.text]) {
        //注册时，两次输入的密码必须一致
        
        [AlertShow alertShowWithContent:@"两次输入密码不一致：" Seconds:1.f];
        
        return;
    } 
    else if ([_emilTextField.text isEqualToString:@""]) {
        
        [AlertShow alertShowWithContent:@"邮箱不能为空：" Seconds:1.f];
        
        return;
    }
    else if ([ _phoneTextField.text isEqualToString:@""]) {
        
        [AlertShow alertShowWithContent:@"手机号不能为空：" Seconds:1.f];
        
        return;
    }
    else
    {
        if ([self.delegate respondsToSelector:@selector(RegisternAction:emil:phone:password:agapsd:)]) {
            [self.delegate  RegisternAction:_userNameTextField.text emil:_emilTextField.text phone:_phoneTextField.text password:_passwordTextField.text agapsd:_againPsdTextField.text];
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
    [_userNameTextField resignFirstResponder];
    [_emilTextField resignFirstResponder];
    [_phoneTextField resignFirstResponder];
    [_againPsdTextField resignFirstResponder];
    [_passwordTextField resignFirstResponder];
    
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    // 响应者 1 有返回值，返回yes， 2 ，释放第一响应者
    [textField resignFirstResponder];
    return YES;
}

@end
