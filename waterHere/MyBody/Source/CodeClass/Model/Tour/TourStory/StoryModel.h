//
//  StoryModel.h
//  ZouZou
//
//  Created by hhuuqq on 15/10/15.
//  Copyright (c) 2015年 lanou3g. All rights reserved.
//

#import <UIKit/UIKit.h>
@class UserModel;
@class PositionModel;
@class Detail_listModel;
@class StoryTripModel;
@interface StoryModel : UIView

@property (nonatomic,strong) NSString *index_cover;                     // 精选故事图片

@property (nonatomic,strong) NSString *index_title;                     // 标题

@property (nonatomic,strong) UserModel *user;                           // 用户信息

@property (nonatomic,strong) PositionModel *position;                   // 地点信息

@property (nonatomic,strong) NSString *spot_id;                         // 下一界面

@property (nonatomic,strong) NSString *text;                            // 文章内容

@property (nonatomic,strong) NSString *date_tour;                       // 旅游时间

@property (nonatomic,strong) Detail_listModel *detail;                  // 细节列表

@property (nonatomic,strong) StoryTripModel *trip;                      // 故事旅行

@property (nonatomic,strong) UserModel *loveUser;                       // 喜欢的人
                           
@property (nonatomic,strong) NSString *recommendations_count;           // 喜欢的人数
@end
