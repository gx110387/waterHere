//
//  SectionZeroTableViewCell.h
//  ZouZou
//
//  Created by lanou3g on 15/10/16.
//  Copyright (c) 2015年 lanou3g. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SectionZeroTableViewCell : UITableViewCell
@property(nonatomic,strong)UILabel *G_nameLabel;
@property(nonatomic,strong)UILabel *G_rating_usersLabel;
@property(nonatomic,strong)UILabel *G_rating;// 评分
@property(nonatomic,strong)UILabel *G_recommended_reason;// 评分理由

@end
