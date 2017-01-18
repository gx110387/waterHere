//
//  UITextField+Extension.h
//  MyBody
//
//  Created by hua on 16/7/19.
//  Copyright © 2016年 gx110387. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITextField (Extension)
//文本框
+(UITextField *)textFielWithFrame:(CGRect)frame leftImageView:(UIImageView *)leftView titleOfPlaceholder:(NSString *)title font:(int)font    textColor:(UIColor *)textCorlor borderColor:(UIColor *)borderColor borderWidth:(CGFloat)borderWidth;
@end
