//
//  SectionZeroTableViewCell.m
//  ZouZou
//
//  Created by gx110387 on 15/10/16.
//  Copyright (c) 2015年 gx110387. All rights reserved.
//

#import "SectionZeroTableViewCell.h"

@implementation SectionZeroTableViewCell



//- (instancetype)initWithFrame:(CGRect)frame
//{
//    self = [super initWithFrame:frame];
//    if (self) {
//        [self G_setupView];
//    }
//    return self;
//}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self G_setupView];
    }
    return self;
}
-(void)G_setupView
{
   // self.contentView.backgroundColor = [UIColor yellowColor];
    self.G_nameLabel = [[UILabel alloc] init];
    self.G_nameLabel.frame = CGRectMake(CGRectGetWidth(self.frame)/6, 50,CGRectGetWidth(self.frame)- CGRectGetWidth(self.frame)/6 *2, 30);
   // self.G_nameLabel.backgroundColor = [UIColor cyanColor];
    self.G_nameLabel.textAlignment = NSTextAlignmentCenter;
    self.G_nameLabel.font = [UIFont  systemFontOfSize:30];
    [self.contentView addSubview:_G_nameLabel];
    
    
    
    self.G_rating = [[UILabel alloc] init];
    self.G_rating.frame = CGRectMake(CGRectGetMinX(self.G_nameLabel.frame), CGRectGetMaxY(self.G_nameLabel.frame)+10, CGRectGetWidth(self.frame)- CGRectGetMinX(self.G_nameLabel.frame) *2, 30);
  //  self.G_rating.backgroundColor = [UIColor cyanColor];
      self.G_rating.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:_G_rating];
    
    
    
    
    self.G_rating_usersLabel = [[UILabel alloc] init];
    self.G_rating_usersLabel.frame = CGRectMake(CGRectGetMaxX(self.G_rating.frame)+10,CGRectGetMinY(self.G_rating.frame), CGRectGetWidth(self.G_rating.frame)*2 , 30);
 // self.G_rating_usersLabel.backgroundColor = [UIColor cyanColor];
    [self.contentView addSubview:_G_rating_usersLabel];
    
    
    
    self.G_recommended_reason = [[UILabel alloc] init];
    self.G_recommended_reason.frame = CGRectMake(CGRectGetMinX(self.G_rating.frame),CGRectGetMaxY(self.G_rating.frame)+10, (CGRectGetWidth(self.frame)- CGRectGetMinX(self.G_nameLabel.frame) *2)/2, 60);
  //  self.G_recommended_reason.backgroundColor = [UIColor cyanColor];
       self.G_recommended_reason.textAlignment = NSTextAlignmentCenter;
         self.G_recommended_reason.numberOfLines  = 0 ;
    [self.contentView addSubview:_G_recommended_reason];
    
    
    
    
    
}

-(void)layoutSubviews
{
     [super layoutSubviews];
     self.G_nameLabel.frame = CGRectMake(CGRectGetWidth(self.frame)/6, 30,CGRectGetWidth(self.frame)- CGRectGetWidth(self.frame)/6 *2, 50);
    self.G_rating.frame = CGRectMake(CGRectGetMinX(self.G_nameLabel.frame), CGRectGetMaxY(self.G_nameLabel.frame)+10, (CGRectGetWidth(self.frame)- CGRectGetMinX(self.G_nameLabel.frame) *2)/2, 30);
    
        self.G_rating_usersLabel.frame = CGRectMake(CGRectGetMaxX(self.G_rating.frame)+10,CGRectGetMinY(self.G_rating.frame), CGRectGetWidth(self.G_rating.frame)*2 , 30);
    
    self.G_recommended_reason.frame = CGRectMake(CGRectGetMinX(self.G_rating.frame),CGRectGetMaxY(self.G_rating.frame)+10, CGRectGetWidth(self.frame)- CGRectGetMinX(self.G_nameLabel.frame) *2, 60);

}
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
