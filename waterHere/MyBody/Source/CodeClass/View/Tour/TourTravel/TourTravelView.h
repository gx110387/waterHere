//
//  TourTravelView.h
//  ZouZou
//
//  Created by hhuuqq on 15/10/19.
//  Copyright (c) 2015年 gx110387. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TourTravelView : UIView

@property (nonatomic,strong) UIView *topView;

@property (nonatomic,strong) UIImageView *TopImage;

@property (nonatomic,strong) UIImageView *userPicture;

@property (nonatomic,strong) UILabel *userName;

@property (nonatomic,strong) UILabel *titleLabel;

@property (nonatomic,strong) UILabel *lineLabel;

@property (nonatomic,strong) UITableView *travelTableview;

- (void) getValueFromTravel:(TravelNoteModel *)model;
@end
