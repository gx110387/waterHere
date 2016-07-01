//
//  NearModel.h
//  ZouZou
//
//  Created by hhuuqq on 15/10/23.
//  Copyright (c) 2015年 lanou3g. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NearModel : NSObject

@property (nonatomic,strong) NSString *cover_s;         // 背景图片

@property (nonatomic,strong) NSString *name;            // 名字

@property (nonatomic,assign) double rating;          // 星数

@property (nonatomic,strong) NSString *tips_count;      // 点评数

@property (nonatomic,strong) NSString *recommended_reason;// 细节

@property (nonatomic,assign) double distance;        // 距离

@property (nonatomic,strong) NSString *visited_count;   // 去过的人数

@property (nonatomic,assign) BOOL recommended;          // 是否推荐

@property (nonatomic,strong) NSString *type;            // 类型(传值用)

@property (nonatomic,strong) NSString *ID;              // 传值用

@property(nonatomic,strong)NSString *cover;// 网址 最大


@property(nonatomic,strong)NSString *cover_route_map_cover;//稍微大点

@end
