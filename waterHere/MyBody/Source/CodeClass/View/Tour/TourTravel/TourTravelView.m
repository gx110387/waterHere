//
//  TourTravelView.m
//  ZouZou
//
//  Created by hhuuqq on 15/10/19.
//  Copyright (c) 2015年 lanou3g. All rights reserved.
//

#import "TourTravelView.h"

@implementation TourTravelView


- (UIView *)topView
{
    if (_topView == nil) {
        self.topView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 360)];
        [self addSubview:_topView];
        self.topView.backgroundColor = [UIColor whiteColor];
    }
    return _topView;
}


- (UIImageView *)TopImage
{
    if (_TopImage == nil) {
        self.TopImage = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 200)];
        [self.topView addSubview:_TopImage];
        
    }
    return _TopImage;
}


- (UIImageView *)userPicture
{
    if (_userPicture == nil) {
        self.userPicture = [[UIImageView alloc]initWithFrame:CGRectMake(CGRectGetMidX(self.TopImage.frame) - 40, CGRectGetMaxY(self.TopImage.frame) - 40 , 80, 80)];
        [self.topView addSubview:_userPicture];
        self.userPicture.layer.cornerRadius = 40;
        self.userPicture.clipsToBounds = YES;
    }
    return _userPicture;
}


- (UILabel *)userName
{
    if (_userName == nil) {
        self.userName = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMidX(self.userPicture.frame) - 150, CGRectGetMaxY(self.userPicture.frame) + 15, 300, 20)];
        [self.topView addSubview:_userName];
        self.userName.textAlignment = NSTextAlignmentCenter;
        self.userName.font = [UIFont systemFontOfSize:13];
    }
    return _userName;
}

 
- (UILabel *)titleLabel
{
    if (_titleLabel == nil) {
        self.titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, CGRectGetMaxY(self.userName.frame) + 15, ScreenWidth - 40, 60)];
        self.titleLabel.numberOfLines = 0;
        [self.topView addSubview:_titleLabel ];
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _titleLabel;
}


- (UITableView *)travelTableview
{
    if (_travelTableview == nil) {
        self.travelTableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight - 30) style:UITableViewStyleGrouped];
        self.travelTableview.tableHeaderView = self.topView;
        [self addSubview:_travelTableview];
    }
    return _travelTableview;
}

- (void)getValueFromTravel:(TravelNoteModel *)model
{
    [self.TopImage sd_setImageWithURL:[NSURL URLWithString:model.trackpoints_thumbnail_image] placeholderImage:[UIImage imageNamed:pich]];
    [self.userPicture sd_setImageWithURL:[NSURL URLWithString:model.model.avatar_l] placeholderImage:[UIImage imageNamed:pich]];
    self.userName.text = [NSString stringWithFormat:@"by %@",model.model.name];
    self.titleLabel.text = model.name;
}


@end
