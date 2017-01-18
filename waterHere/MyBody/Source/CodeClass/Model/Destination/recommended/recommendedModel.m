//
//  recommendedModel.m
//  ZouZou
//
//  Created by gx110387 on 15/10/19.
//  Copyright (c) 2015年 gx110387. All rights reserved.
//

#import "recommendedModel.h"

@implementation recommendedModel
-(void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    if ([key isEqualToString:@"id"]) {
        self.id1 = value;
    }
    
    
}
@end
