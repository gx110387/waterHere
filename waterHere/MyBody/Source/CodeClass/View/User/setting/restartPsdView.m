//
//  restartPsdView.m
//  ZouZou
//
//  Created by lanou3g on 15/10/24.
//  Copyright (c) 2015年 lanou3g. All rights reserved.
//

#import "restartPsdView.h"


@interface restartPsdView ()<UITextFieldDelegate>

@end
@implementation restartPsdView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self p_setupView];
    }
    return self;
}

-(void)p_setupView
{
    UIImageView *img = [[UIImageView alloc]init];
    img.image = [UIImage imageNamed:@"UserLogin"];
    img.frame = CGRectMake(0, 0, MainScreenWidth, MainScreenHeight);
    [self addSubview:img];

    CGFloat gap = G_Iphone6(48);
    CGFloat widthgap =MainScreenWidth-G_Iphone6(48*2);
    CGFloat heightgap = G_Iphone6(41);

   
    _nameTextField = [ UITextField textFielWithFrame:CGRectMake(gap, 64, widthgap,heightgap) leftImageView:[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 8, 0)]  titleOfPlaceholder:@"userName" font:12 textColor:[UIColor whiteColor] borderColor:CustomerColor(79, 79,79) borderWidth:0.5];
    _nameTextField.layer.cornerRadius =6;
    _nameTextField.layer.masksToBounds = YES;
    
    [self addSubview:_nameTextField];
    //
    _passTextField =   [ UITextField textFielWithFrame:CGRectMake(gap, CGRectGetMaxY(_nameTextField.frame)+10, widthgap,heightgap) leftImageView:[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 8, 0)]  titleOfPlaceholder:@"userName" font:12 textColor:[UIColor whiteColor] borderColor:CustomerColor(79, 79,79) borderWidth:0.5];
    _passTextField.layer.cornerRadius =6;
    _passTextField.layer.masksToBounds = YES;
    
    [self addSubview:_passTextField];
    
    _passaginTextField =   [ UITextField textFielWithFrame:CGRectMake(gap, CGRectGetMaxY(_passTextField.frame)+10, widthgap,heightgap) leftImageView:[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 8, 0)]  titleOfPlaceholder:@"userName" font:12 textColor:[UIColor whiteColor] borderColor:CustomerColor(79, 79,79) borderWidth:0.5];
    _passaginTextField.layer.cornerRadius =6;
    _passaginTextField.layer.masksToBounds = YES;
    
    [self addSubview:_passaginTextField];
   
    
    _makeSubmit = [ UIButton buttonWithFrame:CGRectMake(gap, CGRectGetMaxY(_passaginTextField.frame)+10,  widthgap,heightgap ) title:@"确认修改" backgroundColor: CustomerColorOfAlpha(31, 75, 165, 1  ) type:UIButtonTypeCustom target:self action:@selector(makeSubmitAction)];
    _makeSubmit.layer.cornerRadius = heightgap /2;
    _makeSubmit.titleLabel.font = [UIFont systemFontOfSize:12];
    _makeSubmit.layer.masksToBounds = YES;
    [_makeSubmit setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self addSubview:_makeSubmit];

    
    
    
    UIColor *colora = [UIColor whiteColor];
    
    _nameTextField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"请输入用户名" attributes:@{NSForegroundColorAttributeName:colora}];
    _passTextField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"请输入旧密码" attributes:@{NSForegroundColorAttributeName:colora}];
    _passaginTextField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"请输入新密码" attributes:@{NSForegroundColorAttributeName:colora}];
    
    _nameTextField.delegate =self;
    _passTextField.delegate = self;
    _passaginTextField.delegate = self;
    
    
    
    [self stopKeyBoard:self];
    
}
-(void)makeSubmitAction
{
    [self.delegate getData];
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
    [_nameTextField resignFirstResponder];
    [_passTextField resignFirstResponder];
    [_passaginTextField resignFirstResponder];
    
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    // 响应者 1 有返回值，返回yes， 2 ，释放第一响应者
    [textField resignFirstResponder];
    return YES;
}

@end
