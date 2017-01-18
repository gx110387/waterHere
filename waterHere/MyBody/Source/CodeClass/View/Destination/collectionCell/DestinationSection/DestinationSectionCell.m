//
//  DestinationSectionCell.m
//  MyBody
//
//  Created by hua on 16/7/14.
//  Copyright © 2016年 gx110387. All rights reserved.
//

#import "DestinationSectionCell.h"

@implementation DestinationSectionCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self G_setupView];
    }
    return self;
}
-(void)G_setupView
{
    _headerImg = [[ UIImageView alloc] initWithFrame:CGRectMake(G_Iphone6(10),G_Iphone6(10) , G_Iphone6(90), G_Iphone6(72))];
    
    [self.contentView addSubview:_headerImg];
    
    _titleLable = [[ UILabel  alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_headerImg.frame)+G_Iphone6(36), 0, MainScreenWidth-CGRectGetMaxX(_headerImg.frame)-G_Iphone6(36), G_Iphone6(92))];
    [self.contentView addSubview:_titleLable];
    _titleLable.textColor = CustomerColorOfAlpha(51 ,51  ,51 , 1);
    _titleLable.font = [UIFont systemFontOfSize:G_Iphone6(18)];
    
    
}


@end
