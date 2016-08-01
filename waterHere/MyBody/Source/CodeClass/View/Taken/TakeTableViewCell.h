//
//  TakeTableViewCell.h
//  ZouZou
//
//  Created by NISIOISIN on 15/10/16.
//  Copyright © 2015年 lanou3g. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Product.h"
@interface TakeTableViewCell : UITableViewCell

@property(nonatomic,strong)UIImageView *headImg; // 头像
@property(nonatomic,strong)UILabel  *dataLabel; // 日期
@property(nonatomic,strong)UILabel  *addressAndLikelabel; //地点和喜欢人数
@property(nonatomic,strong)UILabel  *priceLabel; // 价格

@property(nonatomic,strong)UIImageView  *bigImg; //大图;
@property(nonatomic,strong)UILabel  *titleLable; //介绍

@property(nonatomic,strong)Product *Model;


@end
