//
//  TripsModel.h
//  ZouZou
//
//  Created by gx110387 on 15/10/17.
//  Copyright (c) 2015年 gx110387. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TripsModel : NSObject
@property(nonatomic,strong)NSDictionary *trip;
@property(nonatomic,strong)NSString * trip_text;
@property(nonatomic,strong)NSDictionary *waypoints;
@end
