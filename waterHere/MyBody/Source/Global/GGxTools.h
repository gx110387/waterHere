//
//  GGxTools.h
//  GaoHeng
//
//  Created by hua on 16/5/10.
//  Copyright © 2016年 heyudongfang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GGxTools : NSObject

//UIView截图
 +(UIImage*)captureView:(UIView *)theView;

//UIScrollview截图
+ (UIImage *)captureScrollView:(UIScrollView *)scrollView;

////合并多张图片
+(UIImage *)composeWithHeader:(UIImage *)header content:(UIImage *)content footer:(UIImage *)footer;

//合并2张图片
+(UIImage *)composeWithHeader:(UIImage *)content footer:(UIImage *)footer;

//流媒体 将音频、图片转成base64Binary
+(NSString *)loadingFile:(NSURL *)filepath;

//获得文件路径
+(NSString *)dataFilePath;

///得到字符串的高度
+(CGFloat)G_heightForString:(NSString *)aString num:(CGFloat)font width:(NSInteger)width;

///
+(NSInteger)arraytoint:(NSInteger)imgscount;


//我这里自定义了一个view
+(CGFloat)setTitleAry:(NSArray *)titleAry;




@end
