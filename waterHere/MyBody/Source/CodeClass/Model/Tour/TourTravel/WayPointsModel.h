//
//  WayPointsModel.h
//  ZouZou
//
//  Created by hhuuqq on 15/10/19.
//  Copyright (c) 2015年 gx110387. All rights reserved.
//

#import <Foundation/Foundation.h>
@class PositionModel;
@interface WayPointsModel : NSObject

@property (nonatomic,strong) NSString *photo;                           // 图片

@property (nonatomic,strong) NSString *photo_s;

@property (nonatomic,strong) NSString *text;                            // 文本

@property (nonatomic,strong) NSString *local_time;                      // 当地时间

@property (nonatomic,strong) NSString *ID;                              // id值

@property (nonatomic,strong) PositionModel *positionModel; // 地点类

@property (nonatomic,strong) NSString *photoWight;                      // 图片宽度

@property (nonatomic,strong) NSString *photoHeight;                     // 图片高度
@end
