//
//  User.h
//  leanCloud
//
//  Created by lanou3g on 15/10/10.
//  Copyright (c) 2015年 lanou3g. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserLoginModel : NSObject

@property(nonatomic,strong)NSString *username;
@property(nonatomic,strong)NSString *password;
@property(nonatomic,strong)NSString *email;
@property(nonatomic,strong)NSString *phone;
///
@property(nonatomic,strong)NSString *id1;
@property(nonatomic,strong)NSString *name;
@property(nonatomic,strong)NSString *reason;
@property(nonatomic,strong)NSString *type;
@property(nonatomic,strong)NSString *imageUrl;

@end
