//
//  DestirpsSectionFirst.m
//  ZouZou
//
//  Created by lanou3g on 15/10/22.
//  Copyright (c) 2015年 lanou3g. All rights reserved.
//

#import "DestirpsSectionFirst.h"

@implementation DestirpsSectionFirst
-(void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    
    if ([key isEqualToString:@"description"]) {
        self.descript = value;
    }
    if ([key isEqualToString:@"id"]) {
        self.id1 = value;
    }
}
@end
