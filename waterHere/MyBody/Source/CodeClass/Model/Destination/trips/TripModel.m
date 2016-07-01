//
//  TripModel.m
//  ZouZou
//
//  Created by lanou3g on 15/10/17.
//  Copyright (c) 2015年 lanou3g. All rights reserved.
//

#import "TripModel.h"

@implementation TripModel
-(void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    
    
    if ([key isEqualToString:@"id"]) {
        self.id1 = value;
    }
    
}
@end
