//
//  TripsModel.h
//  ZouZou
//
//  Created by lanou3g on 15/10/17.
//  Copyright (c) 2015年 lanou3g. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TripsModel : NSObject
@property(nonatomic,strong)NSDictionary *trip;
@property(nonatomic,strong)NSString * trip_text;
@property(nonatomic,strong)NSDictionary *waypoints;
@end
