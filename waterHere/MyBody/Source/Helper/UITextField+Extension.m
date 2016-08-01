//
//  UITextField+Extension.m
//  MyBody
//
//  Created by hua on 16/7/19.
//  Copyright © 2016年 lanou3g. All rights reserved.
//

#import "UITextField+Extension.h"

@implementation UITextField (Extension)
//文本框
+(UITextField *)textFielWithFrame:(CGRect)frame leftImageView:(UIImageView *)leftView titleOfPlaceholder:(NSString *)title font:(int)font    textColor:(UIColor *)textCorlor borderColor:(UIColor *)borderColor borderWidth:(CGFloat)borderWidth{
    UITextField *textFiled  = [[UITextField alloc]initWithFrame:frame];
    textFiled.leftView = leftView;
    textFiled.leftView.hidden = NO;
    textFiled.leftViewMode = UITextFieldViewModeAlways;
    textFiled.placeholder = title;
    textFiled.font = [UIFont systemFontOfSize:font];
    textFiled.textColor = textCorlor;
    textFiled.layer.borderColor = borderColor.CGColor;
    textFiled.layer.borderWidth = borderWidth;
    return textFiled;
    
}

@end
