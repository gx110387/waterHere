//
//  Detail_listModel.h
//  ZouZou
//
//  Created by hhuuqq on 15/10/17.
//  Copyright (c) 2015年 lanou3g. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Detail_listModel : NSObject

@property (nonatomic,strong) NSString *photo;       // 照片

@property (nonatomic,assign) CGFloat photo_height;// 照片高度

@property (nonatomic,strong) NSString *text;        // 内容

@property (nonatomic,assign) CGFloat photo_width;

@end
