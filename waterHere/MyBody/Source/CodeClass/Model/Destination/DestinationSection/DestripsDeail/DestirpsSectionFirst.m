//
//  DestirpsSectionFirst.m
//  ZouZou
//
//  Created by gx110387 on 15/10/22.
//  Copyright (c) 2015年 gx110387. All rights reserved.
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
