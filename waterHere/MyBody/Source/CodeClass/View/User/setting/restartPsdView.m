//
//  restartPsdView.m
//  ZouZou
//
//  Created by lanou3g on 15/10/24.
//  Copyright (c) 2015年 lanou3g. All rights reserved.
//

#import "restartPsdView.h"

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
    self.backgroundColor = [UIColor whiteColor];
    //
    self.nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 100, 80, 30)];
    // self.loginLabel.backgroundColor = [UIColor cyanColor];
    self.nameLabel.text = @"用户名:";
    [self addSubview:_nameLabel];
    //
    //
    self.nameTextField = [[UITextField alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.nameLabel.frame)+20, CGRectGetMinY(self.nameLabel.frame), CGRectGetWidth(self.frame)-CGRectGetWidth(self.nameLabel.frame)-60, CGRectGetHeight(self.nameLabel.frame))];
    self.nameTextField.placeholder =@"请输入用户名";
    self.nameTextField.clearsOnBeginEditing = YES;
    
    self.nameTextField.keyboardType =UIKeyboardTypeEmailAddress;
    self.nameTextField.borderStyle= UITextBorderStyleRoundedRect;
    self.nameTextField.returnKeyType = UIReturnKeyDone;
    [self addSubview:_nameTextField];
    //
    
    
    self.passLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMinX(self.nameLabel.frame), CGRectGetMaxY(self.nameLabel.frame)+20, CGRectGetWidth(self.nameLabel.frame), CGRectGetHeight(self.nameLabel.frame))];
    self.passLabel.text =@"旧密码:";
    // self.loginLabel.backgroundColor = [UIColor cyanColor];
    [self addSubview:_passLabel];
    //
    
    self.passTextField = [[UITextField alloc] initWithFrame:CGRectMake(CGRectGetMinX(self.nameTextField.frame), CGRectGetMinY(self.passLabel.frame), CGRectGetWidth(self.nameTextField.frame), CGRectGetHeight(self.passLabel.frame))];
    self.passTextField.placeholder =@"请输入密码";
    self.passTextField.clearsOnBeginEditing = YES;
    self.passTextField.keyboardType = UIKeyboardTypeNamePhonePad;
    self.passTextField.borderStyle = UITextBorderStyleRoundedRect;
    self.passTextField.returnKeyType = UIReturnKeyDone;
    [self addSubview:_passTextField];
    
    //
    
    self.passagainLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMinX(self.passLabel.frame), CGRectGetMaxY(self.passLabel.frame)+20, CGRectGetWidth(self.passLabel.frame), CGRectGetHeight(self.passLabel.frame))];
    self.passagainLabel.text =@"新密码:";
    // self.loginLabel.backgroundColor = [UIColor cyanColor];
    [self addSubview:_passagainLabel];
    //
    
    self.passaginTextField = [[UITextField alloc] initWithFrame:CGRectMake(CGRectGetMinX(self.passTextField.frame), CGRectGetMinY(self.passagainLabel.frame), CGRectGetWidth(self.passTextField.frame), CGRectGetHeight(self.passagainLabel.frame))];
    self.passaginTextField.placeholder =@"请输入密码";
    self.passaginTextField.clearsOnBeginEditing = YES;
    self.passaginTextField.keyboardType = UIKeyboardTypeNamePhonePad;
    self.passaginTextField.borderStyle = UITextBorderStyleRoundedRect;
    self.passaginTextField.returnKeyType = UIReturnKeyDone;
    [self addSubview:_passaginTextField];
    
    
    // 确认修改
    self.makeSubmit = [UIButton buttonWithType:UIButtonTypeSystem];
    self.makeSubmit.frame = CGRectMake(CGRectGetMinX(self.passaginTextField.frame), CGRectGetMaxY(self.passaginTextField.frame)+20, 100, 30);
    
    [self.makeSubmit setTitle:@"确认修改" forState:UIControlStateNormal];
    [self addSubview:_makeSubmit];
    
    [self.makeSubmit addTarget:self action:@selector(makeSubmitAction:) forControlEvents:UIControlEventTouchUpInside];
    
    
    
}
-(void)makeSubmitAction:(UIButton *)sender
{
    [self.delegate getData];
}


@end
