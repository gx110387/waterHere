//
//  PositionModel.m
//  ZouZou
//
//  Created by hhuuqq on 15/10/17.
//  Copyright (c) 2015年 gx110387. All rights reserved.
//

#import "PositionModel.h"

@implementation PositionModel

-(void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    if ([key isEqualToString:@"id"]) {
        self.ID  = value;
    }
}

@end
