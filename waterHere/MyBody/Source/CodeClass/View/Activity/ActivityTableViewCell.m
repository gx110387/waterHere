//
//  ActivityTableViewCell.m
//  ZouZou
//
//  Created by hhuuqq on 15/10/23.
//  Copyright (c) 2015年 lanou3g. All rights reserved.
//

#import "ActivityTableViewCell.h"

@implementation ActivityTableViewCell

- (UIView *)backView
{
    if (_backView == nil) {
        self.backView = [[UIView alloc]initWithFrame:CGRectMake(20, 5, ScreenWidth - 40, ScreenHeight / 4 - 10)];
        [self.contentView addSubview:_backView];
        self.backView.backgroundColor = [UIColor whiteColor];
        self.backView.layer.cornerRadius = 8;
    }
    return _backView;
}


- (UIImageView *)leftView
{
    if (_leftView == nil) {
        self.leftView = [[UIImageView alloc]initWithFrame:CGRectMake(15, 15, CGRectGetWidth(self.backView.frame) / 3, CGRectGetHeight(self.backView.frame) - 30)];
        [self.backView addSubview:_leftView];
    }
    return _leftView;
}


- (UILabel *)titleLabel
{
    if (_titleLabel == nil) {
        self.titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.leftView.frame) + 10, CGRectGetMinY(self.leftView.frame), CGRectGetWidth(self.backView.frame) - CGRectGetMaxX(self.leftView.frame) - 20, 20)];
        [self.backView addSubview:_titleLabel];
        self.titleLabel.font = [UIFont systemFontOfSize:18];
    }
    return _titleLabel;
}


- (HCSStarRatingView *)starView
{
    if (_starView == nil) {
        self.starView = [[HCSStarRatingView alloc]initWithFrame:CGRectMake(CGRectGetMinX(self.titleLabel.frame), CGRectGetMaxY(self.titleLabel.frame) + 10, CGRectGetWidth(self.titleLabel.frame) - 60, 15)];
        [self.backView addSubview:_starView];
        self.starView.tintColor = [UIColor redColor];
    }
    return _starView;
}


- (UILabel *)commentLabel
{
    if (_commentLabel == nil) {
        self.commentLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.starView.frame) + 10, CGRectGetMinY(self.starView.frame) + 5, 50, 10)];
        [self.backView addSubview:_commentLabel];
        self.commentLabel.font = [UIFont systemFontOfSize:13];
    }
    return _commentLabel;
}


- (UILabel *)detailLabel
{
    if (_detailLabel == nil) {
        self.detailLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMinX(self.titleLabel.frame), CGRectGetMaxY(self.starView.frame) + 5, CGRectGetWidth(self.titleLabel.frame), 40)];
        self.detailLabel.numberOfLines = 0;
        [self.backView addSubview:_detailLabel];
        self.detailLabel.font = [UIFont systemFontOfSize:13];
    }
    return _detailLabel;
}


- (UILabel *)distantLabel
{
    if (_distantLabel == nil) {
        self.distantLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMinX(self.titleLabel.frame), CGRectGetMaxY(self.leftView.frame) - 20, CGRectGetWidth(self.detailLabel.frame), 20)];
        [self.backView addSubview:_distantLabel];
        self.distantLabel.font = [UIFont systemFontOfSize:13];
    }
    return _distantLabel;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)layoutSubviews
{
    if (ScreenHeight < 500) {
        self.titleLabel.font = [UIFont systemFontOfSize:15];
        self.titleLabel.frame = CGRectMake(CGRectGetMaxX(self.leftView.frame) + 10, CGRectGetMinY(self.leftView.frame), CGRectGetWidth(self.backView.frame) - CGRectGetMaxX(self.leftView.frame) - 20, 15);
        self.starView.frame = CGRectMake(CGRectGetMinX(self.titleLabel.frame), CGRectGetMaxY(self.titleLabel.frame) + 5, CGRectGetWidth(self.titleLabel.frame) - 60, 10);
        self.commentLabel.font = [UIFont systemFontOfSize:11];
        self.commentLabel.frame = CGRectMake(CGRectGetMaxX(self.starView.frame) + 10, CGRectGetMinY(self.starView.frame) , 50, 10);
        self.detailLabel.frame = CGRectMake(CGRectGetMinX(self.titleLabel.frame), CGRectGetMaxY(self.starView.frame) + 5, CGRectGetWidth(self.titleLabel.frame), 30);
        self.detailLabel.font = [UIFont systemFontOfSize:11];
        self.distantLabel.font = [UIFont systemFontOfSize:11];
    }
}


// by hqx 2023 根据model给cell赋值

- (void)getValueFromNearModel:(NearModel *)model
{
    self.contentView.backgroundColor = [UIColor colorWithRed:251/255.0 green:247/255.0 blue:237/255.0 alpha:1];
    [self.leftView sd_setImageWithURL:[NSURL URLWithString:model.cover_s] placeholderImage:[UIImage imageNamed:pich]];
    self.titleLabel.text = model.name;
    self.starView.value = model.rating;
    
    self.commentLabel.text = [NSString stringWithFormat:@"%@点评",model.tips_count];
    self.detailLabel.text = model.recommended_reason;
    if (model.distance < 1) {
        int distant = model.distance * 1000;
        self.distantLabel.text = [NSString stringWithFormat:@"距离%dm / %@人去过",distant,model.visited_count];
        return;
    }
    int distant = (int)model.distance;
    self.distantLabel.text = [NSString stringWithFormat:@"距离%dkm / %@人去过",distant,model.visited_count];
    
}

@end
