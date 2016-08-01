//
//  Trips2TableViewCell.m
//  ZouZou
//
//  Created by lanou3g on 15/10/18.
//  Copyright (c) 2015年 lanou3g. All rights reserved.
//

#import "Trips2TableViewCell.h"

@implementation Trips2TableViewCell




-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self G_setupView];
    }
    return  self;
}


-(void)G_setupView
{
    //头像
    self.myAvatar =[[UIImageView alloc] init];
    self.myAvatar.frame = CGRectMake(0, 10, 60, 60);
    self.myAvatar.backgroundColor = [UIColor cyanColor];
    self.myAvatar.layer.cornerRadius = 30;
    self.myAvatar.layer.masksToBounds = YES;
    self.myAvatar.layer.borderWidth = 0.1;
    // self.myAvatar.layer.backgroundColor = [UIColor cyanColor].CGColor;
    [self addSubview:_myAvatar];
    
    //用户名
    
    self.myUser_Name = [[UILabel alloc] init];
    self.myUser_Name.frame = CGRectMake(CGRectGetMaxX(self.myAvatar.frame)+5, CGRectGetMinY(self.myAvatar.frame), 100, 20);
    self.myUser_Name.text = @"meteor0428";
    // self.myUser_Name.backgroundColor = [UIColor cyanColor];
    [self addSubview:_myUser_Name];
    
    // 等级
    self.myLevel_info_Value = [[UILabel alloc] init];
    self.myLevel_info_Value.frame = CGRectMake(CGRectGetMaxX(self.myUser_Name.frame),CGRectGetMinY(self.myUser_Name.frame) , 40, CGRectGetHeight(self.myUser_Name.frame));
    self.myLevel_info_Value.text =@"lv.2";
    //self.myLevel_info_Value.backgroundColor = [UIColor cyanColor];
    [self addSubview:_myLevel_info_Value];
    
    
    // 时间
    self.myTrip_datatime = [[UILabel alloc] init];
    self.myTrip_datatime.frame = CGRectMake(CGRectGetWidth(self.frame)-CGRectGetWidth(self.myUser_Name.frame), CGRectGetMinY(self.myUser_Name.frame), CGRectGetWidth(self.myUser_Name.frame)-10 , CGRectGetHeight(self.myUser_Name.frame));
    // self.myTrip_datatime.backgroundColor = [UIColor yellowColor];
    self.myTrip_datatime.text =@"2015.10.02";
    [self addSubview:_myTrip_datatime];
    
    // 评分
    self.myTrip_rating = [[UILabel alloc] init];
    self.myTrip_rating.frame = CGRectMake(CGRectGetMinX(self.myUser_Name.frame) , CGRectGetMaxY(self.myUser_Name.frame)+10, CGRectGetWidth(self.frame)-CGRectGetWidth(self.myAvatar.frame)-5, CGRectGetHeight(self.myUser_Name.frame));
    self.myTrip_rating.text =@"评分:4~";
    // self.myTrip_name.backgroundColor = [UIColor cyanColor];
    [self addSubview:_myTrip_rating];
    
    
}

-(UILabel *)myTrip_text
{
    
    if (_myTrip_text ==nil) {
        
        self.myTrip_text = [[UILabel alloc] init];
        self.myTrip_text.frame = CGRectMake(0, CGRectGetMaxY(self.myAvatar.frame)+10, CGRectGetWidth(self.frame), 60);
        self.myTrip_text.text = @"天气好热啊位于圣淘沙的鱼尾狮圣淘沙也很美，只是天实在太热，走不动去找沙滩了";
        self.myTrip_text.numberOfLines = 0;
         //self.myTrip_text.backgroundColor =[UIColor yellowColor];
        
        [self addSubview:_myTrip_text];
        
    }
    return _myTrip_text;
}
-(void)layoutSubviews
{
     [super layoutSubviews];
    self.myAvatar.frame = CGRectMake(0, 10, 60, 60);
    
    self.myUser_Name.frame = CGRectMake(CGRectGetMaxX(self.myAvatar.frame)+5, CGRectGetMinY(self.myAvatar.frame), 100, 20);
    
    self.myLevel_info_Value.frame = CGRectMake(CGRectGetMaxX(self.myUser_Name.frame),CGRectGetMinY(self.myUser_Name.frame) , 40, CGRectGetHeight(self.myUser_Name.frame));
    
    self.myTrip_datatime.frame = CGRectMake(CGRectGetWidth(self.frame)-CGRectGetWidth(self.myUser_Name.frame)-10, CGRectGetMinY(self.myUser_Name.frame), CGRectGetWidth(self.myUser_Name.frame) , CGRectGetHeight(self.myUser_Name.frame));
    
    self.myTrip_rating.frame = CGRectMake(CGRectGetMinX(self.myUser_Name.frame) , CGRectGetMaxY(self.myUser_Name.frame)+10, CGRectGetWidth(self.frame)-CGRectGetWidth(self.myAvatar.frame)-5, CGRectGetHeight(self.myUser_Name.frame));
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
