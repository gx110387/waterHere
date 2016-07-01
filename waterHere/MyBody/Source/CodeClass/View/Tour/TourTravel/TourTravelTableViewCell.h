//
//  TourTravelTableViewCell.h
//  ZouZou
//
//  Created by hhuuqq on 15/10/15.
//  Copyright (c) 2015年 lanou3g. All rights reserved.
//

#import <UIKit/UIKit.h>
@class TravelNoteModel;
@interface TourTravelTableViewCell : UITableViewCell

@property (nonatomic,strong) UIImageView *backView;

@property (nonatomic,strong) UILabel *titleLabel;

@property (nonatomic,strong) UILabel *tagLabel;

@property (nonatomic,strong) UILabel *timeLabel;

@property (nonatomic,strong) UILabel *timeCountLabel;

@property (nonatomic,strong) UILabel *browseLabel;

@property (nonatomic,strong) UILabel *positionLabel;

@property (nonatomic,strong) UIImageView *userImage;

@property (nonatomic,strong) UILabel *userName;

@property (nonatomic,strong) UIView* fontView;

- (void) getValueFromTravelNote:(TravelNoteModel *)model;


@end
