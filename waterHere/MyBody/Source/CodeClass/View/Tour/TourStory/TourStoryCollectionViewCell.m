//
//  TourStoryCollectionViewCell.m
//  ZouZou
//
//  Created by hhuuqq on 15/10/15.
//  Copyright (c) 2015年 lanou3g. All rights reserved.
//

#import "TourStoryCollectionViewCell.h"

@implementation TourStoryCollectionViewCell

- (UIImageView *)picture
{
    if (_picture == nil) {
        self.picture = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.contentView.frame), CGRectGetHeight(self.contentView.frame) / 2 + 10)];
        [self.contentView addSubview:_picture];
        self.picture.layer.cornerRadius = 7;
        self.picture.clipsToBounds = YES;
    }
    return _picture;
}


- (UILabel *)pictureLabel
{
    if (_pictureLabel == nil) {
        self.pictureLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(self.picture.frame) - 30, CGRectGetWidth(self.picture.frame) - 20, 20)];
        [self.contentView addSubview:_pictureLabel];
        self.pictureLabel.textColor = [UIColor whiteColor];
        self.pictureLabel.font =  [UIFont fontWithName:@"AmericanTypewriter-Bold" size:13];
    }
    return _pictureLabel;
}


- (UILabel *)titleLabel
{
    if (_titleLabel == nil) {
        self.titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(self.picture.frame) + 10, CGRectGetWidth(self.picture.frame) - 20, 40)];
        [self.contentView addSubview:_titleLabel];
        self.titleLabel.font =  [UIFont fontWithName:@"AmericanTypewriter-Bold" size:13];
        self.titleLabel.numberOfLines = 0;
    }
    return _titleLabel;
}


- (UIImageView *)smallPicture
{
    if (_smallPicture == nil) {
        self.smallPicture = [[UIImageView alloc]initWithFrame:CGRectMake(CGRectGetMinX(self.titleLabel.frame), CGRectGetMaxY(self.picture.frame)+5, 30, 30)];
        [self.contentView addSubview:_smallPicture];
        self.smallPicture.layer.cornerRadius = 15;
        self.smallPicture.clipsToBounds = YES;
    }
    return _smallPicture;
}


- (UILabel *)nameLabel
{
    if (_nameLabel == nil) {
        if (_nameLabel == nil) {
            self.nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.smallPicture.frame) + 15, CGRectGetMidY(self.smallPicture.frame) - 10, CGRectGetWidth(self.contentView.frame) - CGRectGetMaxX(self.smallPicture.frame) - 25, 20)];
            [self.contentView addSubview:_nameLabel];
            self.nameLabel.font =  [UIFont systemFontOfSize:14];
        }
    }
    return _nameLabel;
}


- (void)getValueFromStoryModel:(StoryModel *)model
{
    [self.picture sd_setImageWithURL:[NSURL URLWithString:model.index_cover] placeholderImage:[UIImage imageNamed:pich]];
    self.pictureLabel.text = model.position.name;
  // self.titleLabel.text = model.index_title;
  [self.smallPicture sd_setImageWithURL:[NSURL URLWithString:model.user.avatar_l] placeholderImage:[UIImage imageNamed:model.user.name]];
   self.nameLabel.text = model.user.name;

}





@end
