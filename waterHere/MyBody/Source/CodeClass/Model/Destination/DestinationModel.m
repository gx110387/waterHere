//
//  DestinationModel.m
//  ZouZou
//
//  Created by lanou3g on 15/10/16.
//  Copyright (c) 2015年 lanou3g. All rights reserved.
//

#import "DestinationModel.h"

@implementation DestinationModel
-(void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    if ([key isEqualToString:@"description"]) {
        self.descript = value;
    }
    if ([key isEqualToString:@"id"]) {
//        NSLog(@"!!!!!!%@",[[value class] description]);
        self.id1 = [NSString stringWithFormat:@"%@",value];
//        self.id1  = value;
      //  NSLog(@"=====%@",[[self.id1 class] description]);
    }
}
@end
