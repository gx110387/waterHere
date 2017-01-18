//
//  DestinationModel.h
//  ZouZou
//
//  Created by gx110387 on 15/10/16.
//  Copyright (c) 2015年 gx110387. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DestinationModel : NSObject
@property(nonatomic,strong)NSString *address; //地址
@property(nonatomic,strong)NSString *arrival_type; //类型
@property(nonatomic,strong)NSString *category;// 数字
@property(nonatomic,strong)NSString *cover;// 网址 最大
@property(nonatomic,strong)NSString *cover_route_map_cover;//稍微大点
@property(nonatomic,strong)NSString *cover_s;//方格图片
@property(nonatomic,strong)NSString *currency;
@property(nonatomic,strong)NSString *date_added;
@property(nonatomic,strong)NSString *descript;// 描述
@property(nonatomic,strong)NSString *extra1;
@property(nonatomic,strong)NSString *fee;
@property(nonatomic,strong)NSString *has_experience;
@property(nonatomic,strong)NSString *has_route_maps;
@property(nonatomic,strong)NSString *icon;//头像吧
@property(nonatomic,strong)NSString *id1;
@property(nonatomic,strong)NSString *is_nearby;
@property(nonatomic,strong)NSDictionary *location;// 注意这里可能会蹦;
@property(nonatomic,strong)NSDictionary *city;
@property(nonatomic,strong)NSString *name;
@property(nonatomic,strong)NSString *name_en;
@property(nonatomic,strong)NSString *opening_time;// 开发时间
@property(nonatomic,strong)NSString *popularity;// 流行
@property(nonatomic,strong)NSString *rating;
@property(nonatomic,strong)NSString *rating_users;
@property(nonatomic,strong)NSString *recommended;// 评论
@property(nonatomic,strong)NSString *recommended_reason;// 评论原因
@property(nonatomic,strong)NSString *slug_url; //
@property(nonatomic,strong)NSString *spot_region;// 地点
@property(nonatomic,strong)NSString *tel;//电话
@property(nonatomic,strong)NSString *time_consuming;
@property(nonatomic,strong)NSString *time_consuming_max;
@property(nonatomic,strong)NSString *time_consuming_min;
@property(nonatomic,strong)NSString *timezone;
@property(nonatomic,strong)NSString *type;
@property(nonatomic,strong)NSString *url;
@property(nonatomic,strong)NSString *verified;
@property(nonatomic,strong)NSString *visited_count;
@property(nonatomic,strong)NSString *website;
@property(nonatomic,strong)NSString *wish_to_go_count;

@end
