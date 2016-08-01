//
//  TourStoryCollectionCell2.h
//  MyBody
//
//  Created by hua on 16/7/11.
//  Copyright © 2016年 lanou3g. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TourStoryCollectionCell2 : UICollectionViewCell

@property (nonatomic,strong) UIImageView *picture;

@property (nonatomic,strong) UIImageView *smallPicture;

@property (nonatomic,strong) UILabel *nameLabel;

- (void) getValueFromStoryModel:(StoryModel *)model;
@end
