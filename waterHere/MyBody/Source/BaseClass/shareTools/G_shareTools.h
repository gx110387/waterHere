//
//  G_shareTools.h
//  ZouZou
//
//  Created by gx110387 on 15/10/23.
//  Copyright (c) 2015年 gx110387. All rights reserved.
//

#import <Foundation/Foundation.h>
@class MBProgressHUD;


typedef void(^G_Select)(NSMutableArray *array);
typedef void(^G_isStart)(BOOL isflag);
@interface G_shareTools : NSObject
@property(nonatomic,assign)BOOL isFlag;
@property (strong, nonatomic) NSString *loginCode;
@property (nonatomic,retain) MBProgressHUD * hud;

+(instancetype)shareTools;


- (BOOL)isLogined;
- (void)logout;


- (void)resetLoginCode:(NSString *)loginCode;
#pragma mark 分享

-(void)G_shareText:(UIViewController *)view  shareName:(NSString *)text reason:(NSString*)reason imageurl:(NSString *)imageUrl;


#pragma mark 设置用户名
-(void)setUserLogin:(UserLoginModel*)sender;

#pragma mark 取出用户名
-(NSString *)getUserLogin;
#pragma mark 小菊花
- (void)g_setupProgressHud:(UIViewController *)sender;


#pragma mark  热门地点收藏 高星 1类型 2 id 3 名字 4 原因 5 图片网址
-(void)G_setSaveStart:(NSString *)type id1:(NSString *)id1 name:(NSString *)name reason:(NSString *)reason imageUrl:(NSString *)imageUrl;

#pragma mark  查询收藏 高星
-(void)G_selectStart:(NSNumber*)type  forwardNum:(NSInteger)forwardNum count:(NSInteger)count value:(G_Select)passValue;

#pragma mark 是否收藏 高星 

-(void)G_isStrat:(NSString *)id1 isflag:(G_isStart)isflag;

@end
