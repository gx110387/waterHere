//
//  UserView.m
//  ZouZou
//
//  Created by lanou3g on 15/10/23.
//  Copyright (c) 2015年 lanou3g. All rights reserved.
//

#import "UserView.h"

@implementation UserView

-(UIImageView*)G_UserImage
{
    if (_G_UserImage ==nil) {
        _G_UserImage = [[UIImageView alloc] init];
        _G_UserImage.image = [UIImage imageNamed:@"picholder"];
        [self addSubview:_G_UserImage];
       
    }
    return _G_UserImage;
}


-(UIButton *)G_UserLoginOrRegistButton
{
    if (_G_UserLoginOrRegistButton ==nil) {
        _G_UserLoginOrRegistButton = [[UIButton alloc] init];
        [self addSubview:_G_UserLoginOrRegistButton];
        [_G_UserLoginOrRegistButton setTitle:@"登陆//注册" forState:UIControlStateNormal];
        [_G_UserLoginOrRegistButton addTarget:self action:@selector(ButtonAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _G_UserLoginOrRegistButton;
    
}

-(UILabel *)G_UserStartLabel
{
    if (_G_UserStartLabel ==nil) {
        _G_UserStartLabel = [[UILabel alloc] init];
        _G_UserStartLabel.text = @"我的收藏";
        _G_UserStartLabel.textAlignment = NSTextAlignmentCenter;
        
        [self addSubview:_G_UserStartLabel];
    }
    
    return _G_UserStartLabel;
    
}

-(UIImageView *)G_backgroundImage
{
    if (_G_backgroundImage ==nil) {
        _G_backgroundImage = [[UIImageView alloc] init];
       // _G_backgroundImage.frame = CGRectMake(0, 0, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame));
        
        [self addSubview: _G_backgroundImage];
    }
    
    return _G_backgroundImage;
    
}
-(void)ButtonAction
{
    [self.delegate loginButton];
    
}


@end
