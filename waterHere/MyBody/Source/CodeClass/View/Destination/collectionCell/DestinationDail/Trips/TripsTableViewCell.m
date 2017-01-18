//
//  TripsTableViewCell.m
//  ZouZou
//
//  Created by gx110387 on 15/10/18.
//  Copyright (c) 2015年 gx110387. All rights reserved.
//

#import "TripsTableViewCell.h"
#import "GHMyPhotoView.h"
#import "UIView+Sizes.h"
@implementation TripsTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier WithUrlArray  :(NSArray *)imageUrlArray id1:(NSString *)id1
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.imageUrlArray = imageUrlArray;
        self.id1 = id1;
      //  NSLog(@"%@",self.imageUrlArray);
        [self G_setupView];
        
    }
    return  self;
}

-(void)G_setupView
{
    //头像
    self.myAvatar =[[UIImageView alloc] init];
    self.myAvatar.frame = CGRectMake(10, 10, 60, 60);
   // self.myAvatar.backgroundColor = [UIColor cyanColor];
    self.myAvatar.layer.cornerRadius = 30;
    self.myAvatar.layer.masksToBounds = YES;
    self.myAvatar.layer.borderWidth = 0.1;
    // self.myAvatar.layer.backgroundColor = [UIColor cyanColor].CGColor;
    [self.contentView addSubview:_myAvatar];
    
    //用户名
    self.myUser_Name = [[UILabel alloc] init];
    self.myUser_Name.frame = CGRectMake(CGRectGetMaxX(self.myAvatar.frame)+5, CGRectGetMinY(self.myAvatar.frame), 100, 20);
    self.myUser_Name.text = @"meteor0428";
    // self.myUser_Name.backgroundColor = [UIColor cyanColor];
    [self.contentView addSubview:_myUser_Name];
    
    // 等级
    self.myLevel_info_Value = [[UILabel alloc] init];
    self.myLevel_info_Value.frame = CGRectMake(CGRectGetMaxX(self.myUser_Name.frame),CGRectGetMinY(self.myUser_Name.frame) , 40, CGRectGetHeight(self.myUser_Name.frame));
    self.myLevel_info_Value.text =@"lv.2";
    //self.myLevel_info_Value.backgroundColor = [UIColor cyanColor];
    [self.contentView addSubview:_myLevel_info_Value];
    
    
    // 时间
    self.myTrip_datatime = [[UILabel alloc] init];
    self.myTrip_datatime.frame = CGRectMake(CGRectGetWidth(self.frame)-CGRectGetWidth(self.myUser_Name.frame)+10, CGRectGetMinY(self.myUser_Name.frame), CGRectGetWidth(self.myUser_Name.frame)-10 , CGRectGetHeight(self.myUser_Name.frame));
    // self.myTrip_datatime.backgroundColor = [UIColor yellowColor];
    self.myTrip_datatime.text =@"2015.10.02";
    [self.contentView addSubview:_myTrip_datatime];
    
    // 地点
    self.myTrip_name = [[UILabel alloc] init];
    self.myTrip_name.frame = CGRectMake(CGRectGetMinX(self.myUser_Name.frame) , CGRectGetMaxY(self.myUser_Name.frame)+10, CGRectGetWidth(self.frame)-CGRectGetWidth(self.myAvatar.frame)-5, CGRectGetHeight(self.myUser_Name.frame));
    self.myTrip_name.text =@"Hello Singapore";
    // self.myTrip_name.backgroundColor = [UIColor cyanColor];
    [self.contentView addSubview:_myTrip_name];
    
  
    _PhotoView = [[GHMyPhotoView  alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.myTrip_text.frame), MainScreenWidth, G_Iphone6(500/2))];
    //
    [self.contentView addSubview:_PhotoView];
}

-(UILabel *)myTrip_text
{
    
    if (_myTrip_text ==nil) {
        
        self.myTrip_text = [[UILabel alloc] init];
        self.myTrip_text.frame = CGRectMake(10, CGRectGetMaxY(self.myAvatar.frame)+10, CGRectGetWidth(self.frame)-20, 60);
        self.myTrip_text.text = @"天气好热啊位于圣淘沙的鱼尾狮圣淘沙也很美，只是天实在太热，走不动去找沙滩了";
        self.myTrip_text.numberOfLines = 0;
        //  self.myTrip_text.backgroundColor =[UIColor yellowColor];
        
        [self addSubview:_myTrip_text];
        
    }
    return _myTrip_text;
}
-(void)layoutSubviews
{ [super layoutSubviews];
    
    self.myAvatar.frame = CGRectMake(10, 10, 60, 60);
    
    self.myUser_Name.frame = CGRectMake(CGRectGetMaxX(self.myAvatar.frame)+5, CGRectGetMinY(self.myAvatar.frame), 100, 20);
    
    self.myLevel_info_Value.frame = CGRectMake(CGRectGetMaxX(self.myUser_Name.frame),CGRectGetMinY(self.myUser_Name.frame) , 40, CGRectGetHeight(self.myUser_Name.frame));
    
    self.myTrip_datatime.frame = CGRectMake(CGRectGetWidth(self.frame)-CGRectGetWidth(self.myUser_Name.frame)+10, CGRectGetMinY(self.myUser_Name.frame), CGRectGetWidth(self.myUser_Name.frame) , CGRectGetHeight(self.myUser_Name.frame));
    
    self.myTrip_name.frame = CGRectMake(CGRectGetMinX(self.myUser_Name.frame) , CGRectGetMaxY(self.myUser_Name.frame)+10, CGRectGetWidth(self.frame)-CGRectGetWidth(self.myAvatar.frame)-5, CGRectGetHeight(self.myUser_Name.frame));
//    self.firstCollectionVC.view.frame =CGRectMake(0, 0, CGRectGetWidth(self.frame), CGRectGetWidth(self.frame)/3);
//    
//    self.myFirstCollectionView.frame =CGRectMake(0, CGRectGetMaxY(self.myTrip_text.frame), CGRectGetWidth(self.frame), CGRectGetWidth(self.frame)/3);
    
    ;
}
-(void)setModel:(TripModel *)model
{
    _model = model;
    NSInteger imgscount = self.imageUrlArray.count;
   NSLog(@"url:%@",self.imageUrlArray);
    NSInteger discount = [GGxTools arraytoint:imgscount];
    
    
    _PhotoView.size = CGSizeMake(MainScreenWidth, discount);
    
     NSMutableArray *array = [NSMutableArray array];
    for ( G_waypointsModel *s in self.imageUrlArray) {
        [array addObject:s.photo ];
        
    }
    _PhotoView.photoArray = array;
    
    
   self.myTrip_name.text = _model.name;
    self.myTrip_datatime.text = _model.datetime;
    
    UserModel *user =[[UserModel alloc] init];
    [user setValuesForKeysWithDictionary: _model.user];
    self.myUser_Name.text =user.name;
    [self.myAvatar sd_setImageWithURL:[NSURL URLWithString:user.avatar_l] placeholderImage:[UIImage imageNamed:@"picholder"]];
    
    
    self.myLevel_info_Value.text =[NSString stringWithFormat:@"Lv:%@",[[user.experience valueForKey:@"level_info"] valueForKey:@"value"]];
    // 自适应高度
  
    
}

@end
