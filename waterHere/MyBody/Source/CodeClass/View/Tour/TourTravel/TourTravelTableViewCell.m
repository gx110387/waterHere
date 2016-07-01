//
//  TourTravelTableViewCell.m
//  ZouZou
//
//  Created by hhuuqq on 15/10/15.
//  Copyright (c) 2015年 lanou3g. All rights reserved.
//

#import "TourTravelTableViewCell.h"

@implementation TourTravelTableViewCell

- (UIView *)fontView
{
    if (_fontView == nil) {
        self.fontView = [[UIImageView alloc]initWithFrame:CGRectMake(10, 5, CGRectGetWidth(self.contentView.frame) - 20, CGRectGetHeight(self.contentView.frame) - 10)];
        NSLog(@"%f",self.frame.size.height);
        [self.backView addSubview:_fontView];
        self.fontView.layer.cornerRadius = 10;
        self.fontView.backgroundColor = [UIColor colorWithRed:251/255.0 green:247/255.0 blue:237/255.0 alpha:1];
        self.fontView.clipsToBounds = YES;
    }
    return _fontView;
}

- (UIImageView *)backView
{
    if (_backView == nil) {
        self.backView = [[UIImageView alloc]initWithFrame:CGRectMake(10, 5, CGRectGetWidth(self.contentView.frame) - 20, CGRectGetHeight(self.contentView.frame) - 10)];
        [self.contentView addSubview:_backView];
        self.backView.layer.cornerRadius = 10;
        self.backView.clipsToBounds = YES;
        UIGraphicsBeginImageContextWithOptions(self.backView.image.size, NO, [UIScreen mainScreen].scale);
        
    }
    return _backView;
}


- (UILabel *)titleLabel
{
    if (_titleLabel == nil) {
        self.titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 10, CGRectGetWidth(self.backView.frame) - 20, 30)];
        [self.backView addSubview:_titleLabel];
        self.titleLabel.textColor = [UIColor whiteColor];
        self.titleLabel.font = [UIFont fontWithName:@"AmericanTypewriter-Bold" size:20];
    }
    return _titleLabel;
}


- (UILabel *)tagLabel
{
    if (_tagLabel == nil) {
        self.tagLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMinX(self.titleLabel.frame), CGRectGetMaxY(self.titleLabel.frame) + 5, 5, 40)];
        [self.backView addSubview:_tagLabel];
        self.tagLabel.backgroundColor = [UIColor colorWithRed:0.171 green:0.604 blue:1.000 alpha:1.000];
        
    }
    return _tagLabel;
}


- (UILabel *)timeLabel
{
    if (_timeLabel == nil) {
        self.timeLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.tagLabel.frame) + 10, CGRectGetMinY(self.tagLabel.frame), 100, 15)];
        [self.backView addSubview:_timeLabel];
        self.timeLabel.textColor = [UIColor whiteColor];
        self.timeLabel.font = [UIFont fontWithName:@"AmericanTypewriter-Bold" size:13];
    }
    return _timeLabel;
}


- (UILabel *)timeCountLabel
{
    if (_timeCountLabel == nil) {
        self.timeCountLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.timeLabel.frame) + 10, CGRectGetMinY(self.tagLabel.frame), 20, CGRectGetHeight(self.timeLabel.frame))];
        [self.backView addSubview:_timeCountLabel];
        self.timeCountLabel.textColor = [UIColor whiteColor];
        self.timeCountLabel.font = [UIFont fontWithName:@"AmericanTypewriter-Bold" size:13];
    }
    return _timeCountLabel;
}


- (UILabel *)browseLabel
{
    if (_browseLabel == nil) {
        self.browseLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.timeCountLabel.frame) + 10, CGRectGetMinY(self.tagLabel.frame), 100, CGRectGetHeight(self.tagLabel.frame))];
        [self.backView addSubview:_browseLabel];
        self.browseLabel.textColor = [UIColor whiteColor];
        self.browseLabel.font = [UIFont fontWithName:@"AmericanTypewriter-Bold" size:13];
    }
    return _browseLabel;
}


- (UILabel *)positionLabel
{
    if (_positionLabel == nil) {
        self.positionLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMinX(self.timeLabel.frame), CGRectGetMaxY(self.timeLabel.frame) + 10, 200, 15)];
        [self.backView addSubview:_positionLabel];
        self.positionLabel.textColor = [UIColor whiteColor];
        self.positionLabel.font = [UIFont fontWithName:@"AmericanTypewriter-Bold" size:13];
    }
    return _positionLabel;
}


- (UIImageView *)userImage
{
    if (_userImage == nil) {
        self.userImage = [[UIImageView alloc]initWithFrame:CGRectMake(CGRectGetMinX(self.tagLabel.frame), CGRectGetMaxY(self.backView.frame) - 50, 30, 30)];
        [self.backView addSubview:_userImage];
        self.userImage.layer.cornerRadius = 15;
        self.userImage.clipsToBounds = YES;
    }
    return _userImage;
}


- (UILabel *)userName
{
    if (_userName == nil) {
        self.userName = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.userImage.frame) + 20, CGRectGetMidY(self.userImage.frame) - 8, 150, 16)];
        [self.backView addSubview:_userName];
        self.userName.textColor = [UIColor whiteColor];
        self.userName.font = [UIFont fontWithName:@"AmericanTypewriter-Bold" size:15];
    }
    return _userName;
}


- (void)getValueFromTravelNote:(TravelNoteModel *)model
{
    [self.backView sd_setImageWithURL:[NSURL URLWithString:model.cover_image] placeholderImage:[UIImage imageNamed:pich]];
    UIImage *image = self.backView.image;
    UIGraphicsBeginImageContextWithOptions(image.size, NO, [UIScreen mainScreen].scale);
    [image drawInRect:CGRectMake(0, 0, image.size.width, image.size.height)
            blendMode:kCGBlendModeOverlay
                alpha:1];
    UIImage *highlighted = UIGraphicsGetImageFromCurrentImageContext();
    self.backView.image = highlighted;
    UIGraphicsEndImageContext();
    self.titleLabel.text = [NSString stringWithFormat:@"%@",model.name];
    self.timeLabel.text = [NSString stringWithFormat:@"%@",model.first_day];
    self.timeCountLabel.text = [NSString stringWithFormat:@"%@天",model.day_count];
    self.browseLabel.text = [NSString stringWithFormat:@"%@次浏览",model.view_count];
    self.positionLabel.text = model.popular_place_str;
    [self.userImage sd_setImageWithURL:[NSURL URLWithString:model.model.avatar_l] placeholderImage:[UIImage imageNamed:pich]];
    self.userName.text = [NSString stringWithFormat:@"by %@",model.model.name];
}


// by hqx 1016 当屏幕大小变化时,相应控件大小也会随之变化
-(void)layoutSubviews
{
    [super layoutSubviews];
    self.backView.frame = CGRectMake(10, 5, CGRectGetWidth(self.contentView.frame) - 20, CGRectGetHeight(self.contentView.frame) - 10);
    
    self.titleLabel.frame = CGRectMake(10, 10, CGRectGetWidth(self.backView.frame) - 20, 30);
    self.tagLabel.frame = CGRectMake(CGRectGetMinX(self.titleLabel.frame), CGRectGetMaxY(self.titleLabel.frame) + 5, 5, 40);
    self.timeLabel.frame = CGRectMake(CGRectGetMaxX(self.tagLabel.frame) + 10, CGRectGetMinY(self.tagLabel.frame), 100, 15);
    self.timeCountLabel.frame = CGRectMake(CGRectGetMaxX(self.timeLabel.frame) + 10, CGRectGetMinY(self.tagLabel.frame), 40, CGRectGetHeight(self.timeLabel.frame));
    self.browseLabel.frame = CGRectMake(CGRectGetMaxX(self.timeCountLabel.frame) + 10, CGRectGetMinY(self.tagLabel.frame), 100, CGRectGetHeight(self.timeLabel.frame));
    self.positionLabel.frame = CGRectMake(CGRectGetMinX(self.timeLabel.frame), CGRectGetMaxY(self.timeLabel.frame) + 10, 200, 15);
    self.userImage.frame = CGRectMake(CGRectGetMinX(self.tagLabel.frame), CGRectGetMaxY(self.backView.frame) - 50, 30, 30);
    self.userName.frame = CGRectMake(CGRectGetMaxX(self.userImage.frame) + 20, CGRectGetMidY(self.userImage.frame) - 8, 150, 16);
}


- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
