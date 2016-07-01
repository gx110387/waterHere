//
//  UserModel.h
//  ZouZou
//
//  Created by hhuuqq on 15/10/15.
//  Copyright (c) 2015年 lanou3g. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserModel : NSObject

@property (nonatomic,strong) NSString *name;            // 用户名

@property (nonatomic,strong) NSString *avatar_l;        // 用户图片

@property (nonatomic,strong) NSString *id1;    // id

@property (nonatomic,strong) NSString * avatar_m;
@property (nonatomic,strong) NSString * avatar_s;
@property (nonatomic,strong) NSDictionary *experience;



@end
