//
//  Product.m
//  ZouZou
//
//  Created by NISIOISIN on 15/10/16.
//  Copyright © 2015年 lanou3g. All rights reserved.
//

#import "Product.h"

@implementation Product

-(void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    if ([key isEqualToString:@"id"]) {
        self.ID = value;
    }

}


@end