//
//  TourStoryCollectionViewCell.m
//  ZouZou
//
//  Created by hhuuqq on 15/10/15.
//  Copyright (c) 2015年 gx110387. All rights reserved.
//

#import "TourStoryCollectionViewCell.h"

@implementation TourStoryCollectionViewCell

- (UIImageView *)picture
{
    if (_picture == nil) {
        self.picture = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.contentView.frame), G_Iphone6(91))];
        [self.contentView addSubview:_picture];
        self.picture.layer.cornerRadius = 7;
        self.picture.clipsToBounds = YES;
    }
    return _picture;
}


//- (UILabel *)pictureLabel
//{
//    if (_pictureLabel == nil) {
//        self.pictureLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(self.picture.frame) - 30, CGRectGetWidth(self.picture.frame) - 20, 20)];
//        [self.contentView addSubview:_pictureLabel];
//        self.pictureLabel.textColor = [UIColor whiteColor];
//        self.pictureLabel.font =  [UIFont fontWithName:@"AmericanTypewriter-Bold" size:13];
//    }
//    return _pictureLabel;
//}
//
//
//- (UILabel *)titleLabel
//{
//    if (_titleLabel == nil) {
//        self.titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(self.picture.frame) + 10, CGRectGetWidth(self.picture.frame) - 20, 40)];
//        [self.contentView addSubview:_titleLabel];
//        self.titleLabel.font =  [UIFont fontWithName:@"AmericanTypewriter-Bold" size:13];
//        self.titleLabel.numberOfLines = 0;
//    }
//    return _titleLabel;
//}
//

- (UIImageView *)smallPicture
{
    if (_smallPicture == nil) {
        self.smallPicture = [[UIImageView alloc]initWithFrame:CGRectMake(G_Iphone6(9), CGRectGetMaxY(self.contentView.frame) -G_Iphone6(35)+G_Iphone6(5), G_Iphone6(25), G_Iphone6(25))];
        [self.contentView addSubview:_smallPicture];
        self.smallPicture.layer.cornerRadius = G_Iphone6(25)/2;
        self.smallPicture.clipsToBounds = YES;
    }
    return _smallPicture;
}


- (UILabel *)nameLabel
{
    if (_nameLabel == nil) {
        if (_nameLabel == nil) {
            self.nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.smallPicture.frame)+G_Iphone6(9)  , CGRectGetMaxY(self.contentView.frame) -G_Iphone6(35) , CGRectGetWidth(self.contentView.frame) - CGRectGetMaxX(self.smallPicture.frame) - 25, G_Iphone6(35))];
            self.nameLabel.textColor = CustomerColor(51, 51, 51);
            [self.contentView addSubview:_nameLabel];
            self.nameLabel.font =  [UIFont systemFontOfSize:13];
        }
    }
    return _nameLabel;
}


- (void)getValueFromStoryModel:(StoryModel *)model
{
    [self.picture sd_setImageWithURL:[NSURL URLWithString:model.index_cover] placeholderImage:[UIImage imageNamed:pich]];
    [self.smallPicture sd_setImageWithURL:[NSURL URLWithString:model.user.avatar_l] placeholderImage:[UIImage imageNamed:model.user.name]];
    self.nameLabel.text = model.user.name;

}





@end
