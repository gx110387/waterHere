//
//  WayPointsModel.m
//  ZouZou
//
//  Created by hhuuqq on 15/10/19.
//  Copyright (c) 2015年 gx110387. All rights reserved.
//

#import "WayPointsModel.h"

@implementation WayPointsModel

- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    if ([key isEqualToString:@"id"]) {
        self.ID  = value;
    }
}


@end
