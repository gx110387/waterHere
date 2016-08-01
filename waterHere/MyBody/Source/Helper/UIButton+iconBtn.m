//
//  UIButton+iconBtn.m
//  GaoHeng
//
//  Created by heyudongfang on 16/5/4.
//  Copyright © 2016年 heyudongfang. All rights reserved.
//

#import "UIButton+iconBtn.h"

@implementation UIButton (iconBtn)
+ (UIButton *)buttonwithIconBtn:(CGRect )frame  font:(NSInteger)font image:(NSString  *)image title:(NSString *)title imageInteger:(NSInteger)imageInteger titleColor:(UIColor *)titleColor  backgroundColor:(UIColor *)backgroundColor
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:titleColor forState:UIControlStateNormal];
    button.backgroundColor = backgroundColor;
    button.frame = frame;
    button.titleLabel.font = [UIFont systemFontOfSize:font];
    [button setImage: [UIImage imageNamed:image] forState:UIControlStateNormal];
    button.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, imageInteger/2-10);
    button.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
    return button;
    }

+ (UIButton *)buttonwithrightIconBtn:(CGRect )frame  font:(NSInteger)font image:(NSString  *)image title:(NSString *)title imageInteger:(NSInteger)imageInteger titleColor:(UIColor *)titleColor  backgroundColor:(UIColor *)backgroundColor
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:titleColor forState:UIControlStateNormal];
    button.backgroundColor = backgroundColor;
    button.frame = frame;
    button.titleLabel.font = [UIFont systemFontOfSize:font];
    [button setImage: [UIImage imageNamed:image] forState:UIControlStateNormal];
    button.imageEdgeInsets = UIEdgeInsetsMake(0, imageInteger/2+10, 0, 0);
    button.titleEdgeInsets = UIEdgeInsetsMake(0, -(imageInteger/2+10), 0, 0);
    return button;
}

+(UIButton *)buttonWithFrame:(CGRect)frame title:(NSString *)title backgroundColor:(UIColor *)backgroundColor type:(UIButtonType)type target:(id)target action:(SEL)sel {
    UIButton *button = [UIButton buttonWithType:type];
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    button.backgroundColor = backgroundColor;
    button.frame = frame;
    [button addTarget:target action:sel forControlEvents:UIControlEventTouchUpInside];
    //    button.titleLabel.font = [UIFont systemFontOfSize:font];
    return button;
}
//按钮
+(UIButton *)buttonWithFrame:(CGRect)frame title:(NSString *)title backgroundColor:(UIColor *)backgroundColor font:(CGFloat)font type:(UIButtonType)type target:(id)target action:(SEL)sel {
    UIButton *button = [UIButton buttonWithType:type];
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    button.backgroundColor = backgroundColor;
    button.frame = frame;
    [button addTarget:target action:sel forControlEvents:UIControlEventTouchUpInside];
    button.titleLabel.font = [UIFont systemFontOfSize:font];
    return button;
}
@end
