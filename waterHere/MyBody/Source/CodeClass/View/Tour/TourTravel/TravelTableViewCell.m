//
//  TravelTableViewCell.m
//  ZouZou
//
//  Created by hhuuqq on 15/10/19.
//  Copyright (c) 2015年 gx110387. All rights reserved.
//

#import "TravelTableViewCell.h"

@implementation TravelTableViewCell


- (UIView *)backView
{
    if (_backView == nil) {
        self.backView = [[UIView alloc]initWithFrame:CGRectMake(20, 10, ScreenWidth - 40, CGRectGetHeight(self.contentView.frame) - 20)];
        self.backView.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:_backView];
    }
    return _backView;
}


- (UIImageView *)photo
{
    if (_photo == nil) {
        self.photo = [[UIImageView alloc]init ]; 
        [self.backView addSubview:_photo];
    }
    return _photo;
}


- (UILabel *)text
{
    if (_text == nil) {
        self.text = [[UILabel alloc]init]; 
        self.text.numberOfLines = 0;
        [self.backView addSubview:_text];
        self.text.font = [UIFont systemFontOfSize:13];
    }
    return _text;
}


- (UIImageView *)timeImage
{
    if (_timeImage == nil) {
        self.timeImage = [[UIImageView alloc]initWithFrame:CGRectMake(CGRectGetMinX(self.text.frame), CGRectGetMaxY(self.text.frame) + 5, 20, 20)];
        self.timeImage.layer.cornerRadius = 10;
        self.timeImage.clipsToBounds = YES;
        self.timeImage.image = [UIImage imageNamed:@"time.png"];
        [self.backView addSubview:_timeImage];
    }
    return _timeImage;
}


- (UILabel *)timeLabel
{
    if (_timeImage == nil) {
        self.timeLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.timeImage.frame) + 5, CGRectGetMinY(self.timeImage.frame), 100, 20)];
        [self.backView addSubview:_timeLabel];
        self.timeLabel.font = [UIFont systemFontOfSize:13];
    }
    return _timeLabel;
}


- (UILabel *)positionLabel
{
    if (_positionLabel == nil) {
        self.positionLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.timeLabel.frame) + 10, CGRectGetMinY(self.timeLabel.frame), CGRectGetWidth(self.backView.frame) - CGRectGetMaxX(self.timeLabel.frame) - 20, 20)];
        [self.backView addSubview:_positionLabel];
        self.positionLabel.font = [UIFont systemFontOfSize:13];
        self.positionLabel.textAlignment = NSTextAlignmentRight;
        self.positionLabel.textColor = [UIColor cyanColor];
    }
    return _positionLabel;
}

- (void)layoutSubviews
{
    self.backView.backgroundColor = [UIColor whiteColor];
    self.backView.frame = CGRectMake(20, 10, ScreenWidth - 40, CGRectGetHeight(self.contentView.frame) - 20);
    self.timeImage.frame = CGRectMake(CGRectGetMinX(self.text.frame), CGRectGetMaxY(self.text.frame) + 5, 20, 20);
    self.timeLabel.frame = CGRectMake(CGRectGetMaxX(self.timeImage.frame) + 5, CGRectGetMinY(self.timeImage.frame), 100, 20);
    self.positionLabel.frame = CGRectMake(CGRectGetMaxX(self.timeLabel.frame) + 10, CGRectGetMinY(self.timeLabel.frame), CGRectGetWidth(self.backView.frame) - CGRectGetMaxX(self.timeLabel.frame) - 20, 20);
}

// by hqx 1019 通过model给cell赋值
- (void)getValueFromWays:(WayPointsModel *)model
{
    [self.photo sd_setImageWithURL:[NSURL URLWithString:model.photo_s] placeholderImage:[UIImage imageNamed:pich]];
    self.text.text = model.text;
    NSMutableString *s = model.local_time.mutableCopy;
    self.timeLabel.text = [s substringWithRange:NSMakeRange(5, 11)];
    self.positionLabel.text = model.positionModel.name;
    
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
