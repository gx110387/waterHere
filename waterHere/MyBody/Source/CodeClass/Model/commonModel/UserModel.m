//
//  UserModel.m
//  ZouZou
//
//  Created by hhuuqq on 15/10/15.
//  Copyright (c) 2015年 gx110387. All rights reserved.
//

#import "UserModel.h"

@implementation UserModel


- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    if ([key isEqualToString:@"id"]) {
        self.id1 = value;
    }
}



@end
