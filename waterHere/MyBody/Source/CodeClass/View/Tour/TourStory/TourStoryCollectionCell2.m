//
//  TourStoryCollectionCell2.m
//  MyBody
//
//  Created by hua on 16/7/11.
//  Copyright © 2016年 gx110387. All rights reserved.
//

#import "TourStoryCollectionCell2.h"

@implementation TourStoryCollectionCell2

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
    
    UIImageView *collbgImg = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, G_Iphone6(164), G_Iphone6(202+10+43))];
 
    collbgImg.image = [ UIImage imageNamed:@"CollBgImg"];
    
    [self.contentView addSubview:collbgImg];
    self.picture = [[UIImageView alloc]initWithFrame:CGRectMake(0, 10, G_Iphone6(164), G_Iphone6(202))];
    [self.contentView addSubview:_picture];
    self.picture.layer.cornerRadius = 7;
    self.picture.clipsToBounds = YES;
    
    UIView *footerView = [[ UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.picture.frame), G_Iphone6(164), G_Iphone6(43))];
    [self.contentView addSubview:footerView];
    footerView.backgroundColor = [ UIColor whiteColor];

    self.smallPicture = [[UIImageView alloc]initWithFrame:CGRectMake(G_Iphone6(16), -G_Iphone6(30), G_Iphone6(36), G_Iphone6(36))];
    [footerView addSubview:_smallPicture];
    self.smallPicture.layer.cornerRadius = G_Iphone6(36)/2;
    self.smallPicture.clipsToBounds = YES;
 
    self.nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(G_Iphone6(16)  , 0 , G_Iphone6(164-16), G_Iphone6(43))];
    self.nameLabel.textColor = CustomerColor(51, 51, 51);
    [footerView addSubview:_nameLabel];
    self.nameLabel.font =  [UIFont systemFontOfSize:13];

    
    
}
- (void)getValueFromStoryModel:(StoryModel *)model
{
    [self.picture sd_setImageWithURL:[NSURL URLWithString:model.index_cover] placeholderImage:[UIImage imageNamed:pich]];
    [self.smallPicture sd_setImageWithURL:[NSURL URLWithString:model.user.avatar_l] placeholderImage:[UIImage imageNamed:model.user.name]];
    self.nameLabel.text = model.user.name;
    
}
@end
