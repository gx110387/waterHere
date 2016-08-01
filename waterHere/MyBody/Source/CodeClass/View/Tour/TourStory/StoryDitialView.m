//
//  StoryDitialView.m
//  ZouZou
//
//  Created by hhuuqq on 15/10/17.
//  Copyright (c) 2015年 lanou3g. All rights reserved.
//

#import "StoryDitialView.h"

@implementation StoryDitialView

- (UIView *)topView
{
    if (_topView == nil) {
        self.topView = [[UIView alloc]init];
        [self addSubview:_topView];
    }
    return _topView;
}



- (UIImageView *)userPicture
{
    if (_userPicture == nil) {
        self.userPicture = [[UIImageView alloc]initWithFrame:CGRectMake(20, 30, 50, 50)];
        [self.topView addSubview:_userPicture];
        self.userPicture.layer.cornerRadius = 25;
        self.userPicture.clipsToBounds = YES;
    }
    return _userPicture;
}


- (UILabel *)nameLabel
{
    if (_nameLabel == nil) {
        self.nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.userPicture.frame) + 20, CGRectGetMidY(self.userPicture.frame) - 10, CGRectGetWidth(self.frame) - CGRectGetMaxX(self.userPicture.frame) - 40, 20)];
        [self.topView addSubview:_nameLabel];
    }
    return _nameLabel;
}


- (UILabel *)topWireLabel
{
    if (_topWireLabel == nil) {
        self.topWireLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMinX(self.userPicture.frame), CGRectGetMaxY(self.userPicture.frame) + 15, CGRectGetWidth(self.frame) - 40,1 )];
        [self.topView addSubview:_topWireLabel];
    }
    return _topWireLabel;
}


- (UILabel *)textLabel
{
    if (_textLabel == nil) {
        self.textLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMinX(self.topWireLabel.frame), CGRectGetMaxY(self.topWireLabel.frame) + 20, CGRectGetWidth(self.topWireLabel.frame), 100)];
        self.textLabel.numberOfLines = 0;
        [self.topView addSubview:_textLabel];
        
    }
    return _textLabel;
}


- (UITableView *)detialTableView
{
    if (_detialTableView == nil) {
        self.detialTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, MainScreenHeight-64) style:UITableViewStylePlain];
        self.detialTableView.tableHeaderView = self.topView;
        self.detialTableView.tableFooterView = self.bottomView;
        [self addSubview:_detialTableView];
    }
    return _detialTableView;
}


- (UIView *)bottomView
{
    if (_bottomView == nil) {
        self.bottomView = [[UIView alloc]initWithFrame:CGRectMake(0, 0,ScreenWidth, 150)];
        [self addSubview:_bottomView];
    }
    return _bottomView;
}


- (UILabel *)bottomWireLabel
{
    if (_bottomWireLabel == nil) {
        self.bottomWireLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, 5,ScreenWidth - 40, 1)];
        [self.bottomView addSubview:_bottomWireLabel];
    }
    return _bottomWireLabel;
}

- (UIImageView *)photoImage
{
    if (_photoImage == nil) {
        self.photoImage = [[UIImageView alloc]initWithFrame:CGRectMake(CGRectGetMinX(self.bottomWireLabel.frame), CGRectGetMaxY(self.bottomWireLabel.frame) + 20, 20, 20)];
        [self.bottomView addSubview:_photoImage];
    }
    return _photoImage;
}


- (UIImageView *)timeImage
{
    if (_timeImage == nil) {
        self.timeImage = [[UIImageView alloc]initWithFrame:CGRectMake(CGRectGetMinX(self.photoImage.frame), CGRectGetMaxY(self.photoImage.frame) + 15, CGRectGetWidth(self.photoImage.frame), CGRectGetHeight(self.photoImage.frame))];
        [self.bottomView addSubview:_timeImage];
    }
    return _timeImage;
}


- (UILabel *)storyForm
{
    if (_storyForm == nil) {
        self.storyForm = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.photoImage.frame) + 10, CGRectGetMinY(self.photoImage.frame),ScreenWidth - CGRectGetMaxX(self.photoImage.frame) - 30 , 20)];
        [self.bottomView addSubview:_storyForm];
    }
    return _storyForm;
}


- (UILabel *)storyTime
{
    if (_storyTime == nil) {
        self.storyTime = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMinX(self.storyForm.frame), CGRectGetMinY(self.timeImage.frame), CGRectGetWidth(self.storyForm.frame), CGRectGetHeight(self.storyForm.frame))];
        [self.bottomView addSubview:_storyTime];
    }
    return _storyTime;
}


- (UILabel *)loveLabel
{
    if (_loveLabel == nil) {
        self.loveLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMinX(self.photoImage.frame), CGRectGetMaxY(self.timeImage.frame) + 30, 200, 30)];
        [self.bottomView addSubview:_loveLabel];
    }
    return _loveLabel;
}


- (void)getValueFromStoryModel:(StoryModel *)model
{
    self.photoImage.image = [UIImage imageNamed:@"camera_157.34806629834px_1194454_easyicon.net.png"];
    self.timeImage.image = [UIImage imageNamed:@"time_128px_1195264_easyicon.net.png"];
    [self.userPicture sd_setImageWithURL:[NSURL URLWithString:model.user.avatar_l] placeholderImage:[UIImage imageNamed:pich]];
    self.nameLabel.text = model.user.name;
    self.textLabel.text = model.text;
    self.storyForm.text = model.trip.name;
    NSMutableString *s = [NSMutableString string];
    s = model.date_tour.mutableCopy;
    self.storyTime.text = [NSString stringWithFormat:@"%@.%@.%@ %@",[s substringToIndex:4],[s substringWithRange:NSMakeRange(5, 2) ],[s substringWithRange:NSMakeRange(8, 2)],[s substringWithRange:NSMakeRange(11, 5)]];
    self.topWireLabel.backgroundColor = [UIColor blackColor];
    self.bottomWireLabel.backgroundColor = [UIColor blackColor];
    self.loveLabel.text = [NSString stringWithFormat:@"%@人喜欢",model.recommendations_count];
}


@end

