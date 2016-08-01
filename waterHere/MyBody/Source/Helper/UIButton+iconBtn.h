//
//  UIButton+iconBtn.h
//  GaoHeng
//
//  Created by heyudongfang on 16/5/4.
//  Copyright © 2016年 heyudongfang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (iconBtn)

+ (UIButton *)buttonwithIconBtn:(CGRect )frame  font:(NSInteger)font image:(NSString  *)image title:(NSString *)title imageInteger:(NSInteger)imageInteger titleColor:(UIColor *)titleColor  backgroundColor:(UIColor *)backgroundColor ;

+ (UIButton *)buttonwithrightIconBtn:(CGRect )frame  font:(NSInteger)font image:(NSString  *)image title:(NSString *)title imageInteger:(NSInteger)imageInteger titleColor:(UIColor *)titleColor  backgroundColor:(UIColor *)backgroundColor ;
//按钮
+(UIButton *)buttonWithFrame:(CGRect)frame title:(NSString *)title backgroundColor:(UIColor *)backgroundColor font:(CGFloat)font type:(UIButtonType)type target:(id)target action:(SEL)sel;

+(UIButton *)buttonWithFrame:(CGRect)frame title:(NSString *)title backgroundColor:(UIColor *)backgroundColor type:(UIButtonType)type target:(id)target action:(SEL)sel;
@end
