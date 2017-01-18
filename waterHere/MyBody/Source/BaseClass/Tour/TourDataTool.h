//
//  TourDataTool.h
//  ZouZou
//
//  Created by hhuuqq on 15/10/15.
//  Copyright (c) 2015年 gx110387. All rights reserved.
//

#import <Foundation/Foundation.h>


typedef void(^PassValue)(NSDictionary *dict);

@interface TourDataTool : NSObject


@property (nonatomic,strong) NSMutableArray *TourTravelDataArr;

@property (nonatomic,strong) NSMutableDictionary *TourDataDict;

// by hqx 15-1015 单例初始化
+ (instancetype) shareData;




-(void)getTourTravelDataWithURL:(NSString *)URL PassValue:(PassValue)passValue;

- (void) getSingleDictWithURL:(NSString *)URL PassValue:(PassValue)passValue;

- (void) getTourMainDataWithStart:(NSString *)startID passValue:(PassValue)passValue;

- (void) getStoryDataWithStart:(NSInteger)startID passValue:(PassValue)passValue;

- (void) getNearDataWithStart:(NSInteger)startID category:(NSInteger)category latitude:(double)latitude longitude:(double)longitude passValue:(PassValue)passValue;

- (void) getSearchDataWithPlace:(NSString *)place passValue:(PassValue)passValue;


@end
