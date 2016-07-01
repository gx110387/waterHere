//
//  UserView.h
//  ZouZou
//
//  Created by lanou3g on 15/10/23.
//  Copyright (c) 2015年 lanou3g. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol UserViewDelegate <NSObject>

-(void)loginButton;

@end

@interface UserView : UIView
@property(nonatomic,strong)UIImageView *G_UserImage;
@property(nonatomic,strong)UIImageView *G_backgroundImage;
@property(nonatomic,strong)UIButton *G_UserLoginOrRegistButton;

@property(nonatomic,strong)UILabel *G_UserStartLabel;
@property(nonatomic,weak)id<UserViewDelegate>delegate;



@end
