//
//  DesTripsSectionFirstTableViewCell.m
//  ZouZou
//
//  Created by lanou3g on 15/10/22.
//  Copyright (c) 2015年 lanou3g. All rights reserved.
//

#import "DesTripsSectionFirstTableViewCell.h"

@implementation DesTripsSectionFirstTableViewCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self G_setupView];
    }
    return self;
}
-(void)G_setupView
{
        // 背景图片
    self.myBackgroundImage = [[UIImageView alloc] init];
    self.myBackgroundImage.frame = CGRectMake(G_Iphone6(10), 0, MainScreenWidth-G_Iphone6(20), G_Iphone6(176));
    self.myBackgroundImage.layer.cornerRadius = 3;
    self.myBackgroundImage.layer.masksToBounds = YES;
 
    [self addSubview:self.myBackgroundImage];
    
    UILabel *lineLabel = [[UILabel alloc] initWithFrame:CGRectMake(G_Iphone6(15), G_Iphone6(137), G_Iphone6(4), G_Iphone6(26))];
    lineLabel.backgroundColor = [UIColor colorWithHexString:@"#76B0FE"];
    lineLabel.layer.cornerRadius =3;
    lineLabel.layer.masksToBounds =YES;
    [self.myBackgroundImage addSubview:lineLabel];
    
    // 名字
    self.myNameLabel = [[UILabel alloc] init];
    self.myNameLabel.frame = CGRectMake(G_Iphone6(25), G_Iphone6(128), CGRectGetWidth(self.myBackgroundImage.frame)-40, 20);
    self.myNameLabel.textColor = [UIColor whiteColor];
    self.myNameLabel.text =@"岁月静好*东瀛";
    self.myNameLabel.font = [UIFont systemFontOfSize:16];
    
    [self.myBackgroundImage addSubview:self.myNameLabel];
    
    // 时间
    self.myDataLabel = [[UILabel alloc] init];
    self.myDataLabel.frame = CGRectMake(G_Iphone6(25), CGRectGetMaxY(self.myNameLabel.frame)+G_Iphone6(8), (MainScreenWidth-G_Iphone6(25*2-20))/4, 12);
    self.myDataLabel.textColor = [UIColor whiteColor];
    self.myDataLabel.text =@"2014.01.25";
    self.myDataLabel.font = [UIFont systemFontOfSize:10];
    [self.myBackgroundImage addSubview:self.myDataLabel];
    
    // 天数
    self.myDay_count = [[UILabel alloc] init];
    self.myDay_count.frame = CGRectMake(CGRectGetMaxX(self.myDataLabel.frame), CGRectGetMinY(self.myDataLabel.frame), CGRectGetWidth(self.myDataLabel.frame), CGRectGetHeight(self.myDataLabel.frame));
    self.myDay_count.textColor = [UIColor whiteColor];
    self.myDay_count.text =@"14天";
       self.myDay_count.font = [UIFont systemFontOfSize:10];
    [self.myBackgroundImage addSubview:self.myDay_count];
    
    // 足迹
    self.myWaypoints = [[UILabel alloc] init];
    self.myWaypoints.frame = CGRectMake(CGRectGetMinX(self.myDay_count.frame),CGRectGetMinY(self.myDataLabel.frame),  CGRectGetWidth(self.myDataLabel.frame),CGRectGetHeight(self.myDataLabel.frame));
    self.myWaypoints.textColor = [UIColor whiteColor];
    self.myWaypoints.text=@"1237足迹";
       self.myWaypoints.font = [UIFont systemFontOfSize:10];
    [self.myBackgroundImage addSubview:self.myWaypoints];
    
    // 喜欢
    self.myRecommendationsLabel = [[UILabel alloc] init];
    self.myRecommendationsLabel.frame = CGRectMake(CGRectGetMaxX(self.myWaypoints.frame), CGRectGetMinY(self.myDataLabel.frame), CGRectGetWidth(self.myWaypoints.frame), CGRectGetHeight(self.myWaypoints.frame));
    self.myRecommendationsLabel.textColor = [UIColor whiteColor];
    self.myRecommendationsLabel.text =@"1452喜欢";
       self.myRecommendationsLabel.font = [UIFont systemFontOfSize:10];
    [self.myBackgroundImage addSubview:self.myRecommendationsLabel];
    
    
      
}
//
//-(void)layoutSubviews{
//     [super layoutSubviews];
//        self.myBackgroundImage.frame = CGRectMake(20, 0, CGRectGetWidth(self.frame)-40, CGRectGetHeight(self.frame));
//    
//     self.myNameLabel.frame = CGRectMake(20, 10, CGRectGetWidth(self.myBackgroundImage.frame)-40, 30);
//    
//    self.myDataLabel.frame = CGRectMake(CGRectGetMinX(self.myNameLabel.frame), CGRectGetMaxY(self.myNameLabel.frame)+10, CGRectGetWidth(self.myNameLabel.frame)/2/1.5, 20);
//    
//    self.myDay_count.frame = CGRectMake(CGRectGetMaxX(self.myDataLabel.frame)+10, CGRectGetMinY(self.myDataLabel.frame), CGRectGetWidth(self.myDataLabel.frame), CGRectGetHeight(self.myDataLabel.frame));
//    
//     self.myWaypoints.frame = CGRectMake(CGRectGetMinX(self.myDataLabel.frame),CGRectGetHeight(self.myBackgroundImage.frame)-40,  CGRectGetWidth(self.myDataLabel.frame), 20);
//    
//    self.myRecommendationsLabel.frame = CGRectMake(CGRectGetMaxX(self.myWaypoints.frame)+10, CGRectGetMinY(self.myWaypoints.frame), CGRectGetWidth(self.myWaypoints.frame), CGRectGetHeight(self.myWaypoints.frame));
//    
//    
//    
//   }

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
