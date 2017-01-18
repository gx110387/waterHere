//
//  TravelNoteModel.h
//  ZouZou
//
//  Created by hhuuqq on 15/10/15.
//  Copyright (c) 2015年 gx110387. All rights reserved.
//

#import <Foundation/Foundation.h>
@class UserModel;
@class TravrlDayModel;
@class WayPointsModel;
@interface TravelNoteModel : NSObject

@property (nonatomic,strong) NSString *ID;              // 下一个界面接口

@property (nonatomic,strong) NSString *cover_image;     // 背景图片

@property (nonatomic,strong) NSString *name;            // 标题

@property (nonatomic,strong) NSString *first_day;       // 时间

@property (nonatomic,strong) NSString *day_count;       // 天数

@property (nonatomic,strong) NSString *view_count;      // 浏览次数

@property (nonatomic,strong) NSString *popular_place_str;// 地点

@property (nonatomic,strong) UserModel *model;          // 个人信息类

@property (nonatomic,strong) NSString *trackpoints_thumbnail_image; // 最上面的图片

@property (nonatomic,strong) NSString *mileage;         // 里程数

@property (nonatomic,strong) NSString *waypoints;       // 路点

@property (nonatomic,strong) NSString *recommendationsl;// 喜欢的人数



@property (nonatomic,strong) TravrlDayModel *dayModel;      // 日程类



@end
