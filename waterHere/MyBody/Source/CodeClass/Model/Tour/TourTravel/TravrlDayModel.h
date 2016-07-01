//
//  TravrlDayModel.h
//  ZouZou
//
//  Created by hhuuqq on 15/10/19.
//  Copyright (c) 2015年 lanou3g. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TravrlDayModel : NSObject

@property (nonatomic,strong) NSString *date;            // 日期

@property (nonatomic,strong) NSString *day;             // 天数

@property (nonatomic,strong) WayPointsModel *wayModel;      // 路点类


@end
