//
//  ActivityTableViewCell.h
//  ZouZou
//
//  Created by hhuuqq on 15/10/23.
//  Copyright (c) 2015年 gx110387. All rights reserved.
//

#import <UIKit/UIKit.h>
@class AMRatingControl;
@class NearModel;
@interface ActivityTableViewCell : UICollectionViewCell

 

@property (nonatomic,strong) UIImageView *leftView;

@property (nonatomic,strong) UILabel *titleLabel;

@property (nonatomic,strong) AMRatingControl  *starView;

@property (nonatomic,strong) UILabel *commentLabel;

@property (nonatomic,strong) UILabel *detailLabel;

@property (nonatomic,strong) UILabel *distantLabel;

- (void) getValueFromNearModel:(NearModel *)model;
@end
