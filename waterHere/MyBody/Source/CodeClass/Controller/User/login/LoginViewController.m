//
//  LoginViewController.m
//  UI综合_豆瓣
//
//  Created by lanou3g on 15/9/18.
//  Copyright (c) 2015年 lanou3g. All rights reserved.
//

#import "LoginViewController.h"
#import "LoginView.h"
#import "RegiViewController.h"
#import <AVOSCloud/AVOSCloud.h>
#import "UIViewController+Swizzled.h"
@interface LoginViewController ()<UITextFieldDelegate>
@property(nonatomic,strong)LoginView *lv;
@end

@implementation LoginViewController
-(void)loadView
{
    self.lv = [[LoginView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.view = _lv;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.lv.loginTextField.delegate = self;
    self.lv.passTextField.delegate = self;
    // Do any additional setup after loading the view.
  self.navigationItem.title =@"用户登陆";
    
    
   
     [self.lv.loginButton addTarget:self action:@selector(loginButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.lv.regiBUtton addTarget:self action:@selector(regiBUttonAction:) forControlEvents:UIControlEventTouchUpInside];
    
    
      self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:self action:@selector(leftBarButtonAction:)];
}
-(void)leftBarButtonAction:(UIBarButtonItem *)sender
{
    
   
    
    
    
   [self.navigationController  dismissViewControllerAnimated:YES completion:nil];
    
    
    
}
-(void)regiBUttonAction:(UIButton *)sender
{
    RegiViewController *regiVC = [[RegiViewController alloc] init];
  
    [self.navigationController pushViewController:regiVC animated:YES];
    
    
}



- (void)keyboardWillShow:(NSNotification *)noti
{
    //键盘输入的界面调整
    //键盘的高度
    float height = 216.0;
    CGRect frame = self.view.frame;
    frame.size = CGSizeMake(frame.size.width, frame.size.height - height);
    [UIView beginAnimations:@"Curl"context:nil];//动画开始
    [UIView setAnimationDuration:0.30];
    [UIView setAnimationDelegate:self];
    [self.lv setFrame:frame];
    [UIView commitAnimations];
}


- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    // When the user presses return, take focus away from the text field so that the keyboard is dismissed.
    NSTimeInterval animationDuration = 0.30f;
    [UIView beginAnimations:@"ResizeForKeyboard" context:nil];
    [UIView setAnimationDuration:animationDuration];
    CGRect rect = CGRectMake(0.0f, 0.0f, self.lv.frame.size.width, self.lv.frame.size.height);
    self.lv.frame = rect;
    [UIView commitAnimations];
    [textField resignFirstResponder];
    return YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    CGRect frame = textField.frame;
    int offset = frame.origin.y + 32 - (self.lv.frame.size.height - 216.0);//键盘高度216
    NSTimeInterval animationDuration = 0.30f;
    [UIView beginAnimations:@"ResizeForKeyBoard" context:nil];
    [UIView setAnimationDuration:animationDuration];
    float width = self.lv.frame.size.width;
    float height = self.lv.frame.size.height;
    if(offset > 0)
    {
        CGRect rect = CGRectMake(0.0f, -offset,width,height);
        self.lv.frame = rect;
    }
    [UIView commitAnimations];
    
}
//-(BOOL)textFieldShouldReturn:(UITextField *)textField
//{
//    // 响应者 1 有返回值，返回yes， 2 ，释放第一响应者
//    [textField resignFirstResponder];
//    return YES;
//}

-(void)loginButtonAction:(UIButton *)sender
{
    
    if ([self.lv.loginTextField.text isEqualToString:@""] )
    {
        [AlertShow alertShowWithContent:@"请输入用户名" Seconds:0.5f];
        
        
    }
    else if([self.lv.passTextField.text isEqualToString:@""])
    {
        [AlertShow alertShowWithContent:@"请输入密码" Seconds:0.5f];
    }
    else
    {
        NSString *password = [NSString stringWithFormat:@"%@",self.lv.passTextField.text];
        
        [AVUser logInWithUsernameInBackground:self.lv.loginTextField.text password:password block:^(AVUser *user, NSError *error) {
            if (user != nil) {
                //  NSString *name = self.lv.loginTextField.text;
                UserLoginModel *u = [[UserLoginModel alloc] init];
                u.username = self.lv.loginTextField.text;
                u.password = self.lv.passTextField.text;
                
                [[G_shareTools shareTools]setUserLogin:u];
                self.mblock(u);
                [AlertShow alertShowWithContent:@"登陆成功:" Seconds:0.5f];
               
                
                [self.navigationController dismissViewControllerAnimated:YES completion:nil];
            } else {
                
                // 登录失败
                
                NSLog(@"登陆失败");
                  [AlertShow alertShowWithContent:@"用户名或密码错误:" Seconds:1.0f];
            }
        }];
        
        
        
        
        
        
        
        
        

        
            }
   
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
