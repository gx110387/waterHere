//
//  RegiViewController.m
//  UI综合_豆瓣
//
//  Created by lanou3g on 15/9/18.
//  Copyright (c) 2015年 lanou3g. All rights reserved.
//

#import "RegiViewController.h"
#import "RegiView.h"

@interface RegiViewController ()<UITextFieldDelegate>
@property(nonatomic,strong)RegiView *rv;
@end

@implementation RegiViewController
-(void)loadView
{
    self.rv = [[RegiView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.view  = _rv;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"注册";
    // Do any additional setup after loading the view.
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"注册" style:UIBarButtonItemStylePlain target:self action:@selector(rightBarAction:)];
    
    [self.rv.mainButton addTarget:self action:@selector(mainButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self p_delegate];
    
}
-(void)mainButtonAction:(UIButton *)sender
{    ViewController *gaoxingVC = [[ViewController alloc] init];
    [self.navigationController pushViewController:gaoxingVC animated:YES];
    
}
-(void)p_delegate
{
    self.rv.nameTextField.delegate = self;
    self.rv.passTextField.delegate = self;
    self.rv.passaginTextField.delegate = self;
    self.rv.emilTextField.delegate = self;

    self.rv.teleTextField.delegate = self;


    
}
//-(BOOL)textFieldShouldReturn:(UITextField *)textField
//{
//    // 响应者 1 有返回值，返回yes， 2 ，释放第一响应者
//    [textField resignFirstResponder];
//    return YES;
//}


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
    [self.rv setFrame:frame];
    [UIView commitAnimations];
}


- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    // When the user presses return, take focus away from the text field so that the keyboard is dismissed.
    NSTimeInterval animationDuration = 0.30f;
    [UIView beginAnimations:@"ResizeForKeyboard" context:nil];
    [UIView setAnimationDuration:animationDuration];
    CGRect rect = CGRectMake(0.0f, 0.0f, self.rv.frame.size.width, self.rv.frame.size.height);
    self.rv.frame = rect;
    [UIView commitAnimations];
    [textField resignFirstResponder];
    return YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    CGRect frame = textField.frame;
    int offset = frame.origin.y + 32 - (self.rv.frame.size.height - 216.0);//键盘高度216
    NSTimeInterval animationDuration = 0.30f;
    [UIView beginAnimations:@"ResizeForKeyBoard" context:nil];
    [UIView setAnimationDuration:animationDuration];
    float width = self.rv.frame.size.width;
    float height = self.rv.frame.size.height;
    if(offset > 0)
    {
        CGRect rect = CGRectMake(0.0f, -offset,width,height);
        self.rv.frame = rect;
    }
    [UIView commitAnimations];
    
}

-(void)rightBarAction:(UIBarButtonItem *)sender
{
    
    if ([self.rv.nameTextField.text isEqualToString:@""] || [self.rv.passTextField.text isEqualToString:@""]) {
        
         [AlertShow alertShowWithContent:@"账号和密码为空：" Seconds:1.f];
        return;
    }
    else if ([self.rv.nameTextField.text isEqualToString:self.rv.passTextField.text ]) {
        
       [AlertShow alertShowWithContent:@"账号和密码相同：" Seconds:1.f];
        
        return;
    }else if (NO == [self.rv.passTextField.text  isEqualToString:self.rv.passaginTextField.text]) {
        //注册时，两次输入的密码必须一致      
        
        [AlertShow alertShowWithContent:@"两次输入密码不一致：" Seconds:1.f];

        return;
    }else
    {
        
      
        
        AVUser *user = [AVUser user];
        user.username = self.rv.nameTextField.text;
        user.password = [NSString stringWithFormat:@"%@",self.rv.passTextField.text];
        user.email = self.rv.emilTextField.text;
      
       
        [user setObject:self.rv.teleTextField.text forKey:@"phone"];
          NSLog(@"正在注册~");
        [user signUpInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
            if (succeeded) {
                NSLog(@"注册成功");
                
                [self.navigationController popViewControllerAnimated:YES];
            } else {
                NSLog(@"注册失败,%ld",error.code);
                if (error.code == 202) {
                    [AlertShow alertShowWithContent:@"此用户名已存在,换个再来~" Seconds:1.f];
                }
                [AlertShow alertShowWithContent:@"注册失败,请仔细检查邮箱后再注册" Seconds:1.f];
                
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
