//
//  UserView.m
//  ZouZou
//
//  Created by gx110387 on 15/10/23.
//  Copyright (c) 2015年 gx110387. All rights reserved.
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


 

-(UILabel *)G_UserStartLabel
{
    if (_G_UserStartLabel ==nil) {
        _G_UserStartLabel = [[UILabel alloc] init];
        _G_UserStartLabel.text = @"我的收藏";
        _G_UserStartLabel.textAlignment = NSTextAlignmentCenter;
        _G_UserStartLabel.layer.borderColor =[UIColor colorWithRed:251/255.0 green:247/255.0 blue:237/255.0 alpha:1].CGColor;
        _G_UserStartLabel.layer.borderWidth = 1;
        _G_UserStartLabel.textColor = [UIColor whiteColor];
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



@end
