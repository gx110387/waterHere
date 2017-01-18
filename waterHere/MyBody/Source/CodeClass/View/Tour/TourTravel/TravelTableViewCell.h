//
//  TravelTableViewCell.h
//  ZouZou
//
//  Created by hhuuqq on 15/10/19.
//  Copyright (c) 2015年 gx110387. All rights reserved.
//

#import <UIKit/UIKit.h>
@class WayPointsModel;
@interface TravelTableViewCell : UITableViewCell

@property (nonatomic,strong) UIView *backView;

@property (nonatomic,strong) UIImageView *photo;

@property (nonatomic,strong) UILabel *text;

@property (nonatomic,strong) UIImageView *timeImage;

@property (nonatomic,strong) UILabel *timeLabel;

@property (nonatomic,strong) UILabel *positionLabel;

- (void) getValueFromWays:(WayPointsModel *)model;

@end
