//
//  G_getDestinaData.h
//  ZouZou
//
//  Created by lanou3g on 15/10/16.
//  Copyright (c) 2015年 lanou3g. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void(^G_PassValue)(NSMutableArray *array);

typedef void(^MothValue)(DestinationModel *destionModel);

@interface G_getDestinaData : NSObject


+(instancetype)shareGetDestinData;


#pragma mark 得到不同的数据by第一页  高星 10-16
-(void)G_getJsonData:(NSInteger)number passValue:(G_PassValue)value;
#pragma mark 本月去撒欢的数据 高星 10-17
-(void)g_getMonthData:(NSString *)type id:(NSString *)id1 passValue:(MothValue)value;
#pragma mark  更多印象的数据 高星 10-17
-(void)G_getInfoData:(NSInteger)forwardNum id:(NSString *)id1 count:(NSInteger)count passValue:(G_PassValue)value;

#pragma mark  更多评价的数据 高星 10-19
-(void)G_getInfoTripsData:(NSInteger)forwardNum id:(NSString *)id1 count:(NSInteger)count passValue:(G_PassValue)value;

#pragma mark   精品游记
-(void)G_getTripsTravels:(NSString*)countyName type:(NSString *)type forwsrdNum:(NSInteger)forwardNum count:(NSInteger)count passValue:(G_PassValue)value;

#pragma mark   旅行地点
-(void)G_getTripsPosition:(NSString*)countyName type:(NSString *)type forwsrdNum:(NSInteger)forwardNum count:(NSInteger)count passValue:(G_PassValue)value;

#pragma mark   图片

-(void)G_getPhoto:(NSString *)trip_id forwsrdNum:(NSInteger)forwardNum count:(NSInteger)count paddValue:(G_PassValue)value;


@end
