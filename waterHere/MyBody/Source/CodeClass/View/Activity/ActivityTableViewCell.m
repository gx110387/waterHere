//
//  ActivityTableViewCell.m
//  ZouZou
//
//  Created by hhuuqq on 15/10/23.
//  Copyright (c) 2015年 gx110387. All rights reserved.
//

#import "ActivityTableViewCell.h"

@implementation ActivityTableViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupView];
    }
    return self;
}
-(void)setupView
{
    _leftView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, G_Iphone6(165), G_Iphone6(168))];
    [self.contentView addSubview:_leftView];
    
    UIView *footerView = [[ UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_leftView.frame), G_Iphone6(165), G_Iphone6(68))];
    [self.contentView addSubview:footerView];
    
    Tools.cgkFontSize = 15;
    Tools.cgkStarWidthAndHeight = 15;
    self.starView =  [[AMRatingControl alloc] initWithLocation:CGPointMake(0, 11) emptyImage:[UIImage imageNamed:@"GHHome_Teacher_NoReserveRating"] solidImage:[UIImage imageNamed:@"GHHome_Teacher_ReserveRating"]  andMaxRating:5];
    [footerView addSubview:self.starView];
    
    _commentLabel =[[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.starView.frame)+5,CGRectGetMinY(_starView.frame), G_Iphone6(165)-CGRectGetMaxX(self.starView.frame)-5, 15)];
    _commentLabel.textColor = [UIColor colorWithHexString:@"#777777"];
    _commentLabel.font = [UIFont systemFontOfSize:10];
    [footerView addSubview:_commentLabel];
    
    _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_commentLabel.frame), G_Iphone6(165), G_Iphone6(22))];
    _titleLabel.textColor = [UIColor colorWithHexString:@"#171616"];
    _titleLabel.font = [UIFont systemFontOfSize:15];
    [footerView addSubview:_titleLabel];
    
    _distantLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_titleLabel.frame), G_Iphone6(165), G_Iphone6(68) -CGRectGetMaxY(_titleLabel.frame))];
    
    _distantLabel.textColor = [UIColor colorWithHexString:@"#171616"];
    _distantLabel.font = [UIFont systemFontOfSize:10];
    [footerView addSubview:_distantLabel];
    
    
}


// by hqx 2023 根据model给cell赋值

- (void)getValueFromNearModel:(NearModel *)model
{
    
//    self.contentView.backgroundColor = [UIColor colorWithRed:251/255.0 green:247/255.0 blue:237/255.0 alpha:1];
 [self.leftView sd_setImageWithURL:[NSURL URLWithString:model.cover_s] placeholderImage:[UIImage imageNamed:pich]];
    [_starView setRating:model.rating];
    self.titleLabel.text = model.name;
    
    
    self.commentLabel.text = [NSString stringWithFormat:@"%@点评",model.tips_count];
//    self.detailLabel.text = model.recommended_reason;
    if (model.distance < 1) {
        int distant = model.distance * 1000;
        self.distantLabel.text = [NSString stringWithFormat:@"距离%dm / %@人去过",distant,model.visited_count];
        return;
    }
    int distant = (int)model.distance;
    self.distantLabel.text = [NSString stringWithFormat:@"距离%dkm / %@人去过",distant,model.visited_count];
    
}

@end
