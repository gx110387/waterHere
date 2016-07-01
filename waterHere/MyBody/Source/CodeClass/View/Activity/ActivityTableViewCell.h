//
//  ActivityTableViewCell.h
//  ZouZou
//
//  Created by hhuuqq on 15/10/23.
//  Copyright (c) 2015年 lanou3g. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HCSStarRatingView.h"
@class NearModel;
@interface ActivityTableViewCell : UITableViewCell

@property (nonatomic,strong) UIView *backView;

@property (nonatomic,strong) UIImageView *leftView;

@property (nonatomic,strong) UILabel *titleLabel;

@property (nonatomic,strong) HCSStarRatingView  *starView;

@property (nonatomic,strong) UILabel *commentLabel;

@property (nonatomic,strong) UILabel *detailLabel;

@property (nonatomic,strong) UILabel *distantLabel;

- (void) getValueFromNearModel:(NearModel *)model;
@end
