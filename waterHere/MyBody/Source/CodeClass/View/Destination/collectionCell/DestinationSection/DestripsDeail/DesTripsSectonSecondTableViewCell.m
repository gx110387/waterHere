//
//  DesTripsSectonSecondTableViewCell.m
//  ZouZou
//
//  Created by lanou3g on 15/10/22.
//  Copyright (c) 2015年 lanou3g. All rights reserved.
//

#import "DesTripsSectonSecondTableViewCell.h"

@implementation DesTripsSectonSecondTableViewCell


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self G_setupView];
    }
    return self;
}
-(void)G_setupView
{
 
    
    // 白色背景
    self.myBackgroundView = [[UIView alloc] init];
    self.myBackgroundView.frame = CGRectMake(0, 0, MainScreenWidth, 150);
    self.myBackgroundView.layer.cornerRadius = 10;
    self.myBackgroundView.layer.masksToBounds = YES;
    self.myBackgroundView.backgroundColor = [UIColor whiteColor];
    [self addSubview:self.myBackgroundView];
    
    // 图片
    
    self.myImage = [[UIImageView alloc] init];
    self.myImage.frame = CGRectMake(10, 10, CGRectGetWidth(self.myBackgroundView.frame)/2-20, CGRectGetHeight(self.myBackgroundView.frame)-20);
    //self.myImage.backgroundColor = [UIColor cyanColor];
    
    
    [self.myBackgroundView addSubview:self.myImage];
    
    //名字
    
    self.myNameLabel = [[UILabel alloc] init];
    self.myNameLabel.frame = CGRectMake(CGRectGetMaxX(self.myImage.frame)+10, CGRectGetMinY(self.myImage.frame), CGRectGetWidth(self.myBackgroundView.frame)-CGRectGetWidth(self.myImage.frame)-20-5-5, 30);
  // self.myNameLabel.backgroundColor = [UIColor cyanColor];
    self.myNameLabel.font = [UIFont systemFontOfSize:22];
  //  self.myNameLabel.text =@"便宜坊(五彩城店)";
    
    [self.myBackgroundView addSubview:self.myNameLabel];
    // 评分
    self.myRatingLabel = [[UILabel alloc] init];
    
    self.myRatingLabel.frame = CGRectMake( (CGRectGetWidth(self.frame)-40)/2-10, CGRectGetMaxY(self.myNameLabel.frame)+5, CGRectGetWidth(self.myNameLabel.frame), 20);
    // self.myRatingLabel.text = @"评分:4.5~//7人点评";
    // self.myRatingLabel.backgroundColor = [UIColor yellowColor];
    
    [self.myBackgroundView addSubview:self.myRatingLabel];

    
    
    // 描述
    
    self.myDescriptionLabel = [[UILabel alloc] init];
    
    self.myDescriptionLabel.frame = CGRectMake(CGRectGetMinX(self.myNameLabel.frame), CGRectGetMaxY(self.myRatingLabel.frame)+5, CGRectGetWidth(self.myRatingLabel.frame), 60);
    self.myDescriptionLabel.numberOfLines = 3;
    
   // self.myDescriptionLabel.text = @"在皇后镇码头上可以静静地欣赏环绕小镇的湖光山色，是放松休闲的好地方。如果想寻求刺激，也可以从这里出发参加沙特欧瓦河的快艇之旅(Shotover Jet)，在水花四溅中感受最狂野的乐趣。";
  // self.myDescriptionLabel.backgroundColor = [UIColor yellowColor];
    [self.myBackgroundView addSubview:self.myDescriptionLabel];
    
    
    // 去过的数量
    
    self.myVisited_count = [[UILabel alloc] init];
    
    self.myVisited_count.frame = CGRectMake(CGRectGetMinX(self.myDescriptionLabel.frame), CGRectGetMaxY(self.myImage.frame)-20, CGRectGetWidth(self.myRatingLabel.frame), 20);
   // self.backgroundColor = [UIColor yellowColor];
    
    //self.myVisited_count.text=@"3455 人去过~";
    
    [self.myBackgroundView addSubview:self.myVisited_count];
    
}

 
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
