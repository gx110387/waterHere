//
//  TourStoryCollectionViewCell.h
//  ZouZou
//
//  Created by hhuuqq on 15/10/15.
//  Copyright (c) 2015年 lanou3g. All rights reserved.
//

#import <UIKit/UIKit.h>
@class StoryModel;
@interface TourStoryCollectionViewCell : UICollectionViewCell

@property (nonatomic,strong) UIImageView *picture;

 

@property (nonatomic,strong) UIImageView *smallPicture;

@property (nonatomic,strong) UILabel *nameLabel;

- (void) getValueFromStoryModel:(StoryModel *)model;



@end
