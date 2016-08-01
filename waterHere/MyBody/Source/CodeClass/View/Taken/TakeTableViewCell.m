//
//  TakeTableViewCell.m
//  ZouZou
//
//  Created by NISIOISIN on 15/10/16.
//  Copyright © 2015年 lanou3g. All rights reserved.
//

#import "TakeTableViewCell.h"

@implementation TakeTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self C_setupView];
    }
    return self;
}



-(void)C_setupView
{
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(G_Iphone6(7), 0, G_Iphone6(361), G_Iphone6(72))];
    _headImg = [[UIImageView alloc] initWithFrame:CGRectMake(G_Iphone6(10), G_Iphone6(14), G_Iphone6(44), G_Iphone6(44))];
    headerView.backgroundColor = [UIColor whiteColor];
    _headImg.layer.cornerRadius = G_Iphone6(44)/2;
    _headImg.layer.masksToBounds = YES;
    [headerView addSubview:_headImg];
    //
    _dataLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_headImg.frame)+ G_Iphone6(12), G_Iphone6(15), G_Iphone6(MainScreenWidth/2), G_Iphone6(18))];
    _dataLabel.font = [UIFont systemFontOfSize:G_Iphone6(13)];
    _dataLabel.textColor = [UIColor colorWithHexString:@"#A5A5A5"];
    [headerView addSubview:_dataLabel];
    //
    _addressAndLikelabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_headImg.frame)+G_Iphone6(12),G_Iphone6(39), G_Iphone6(MainScreenWidth/2), G_Iphone6(16))];
    _addressAndLikelabel.font = [UIFont systemFontOfSize:G_Iphone6(13)];
    _addressAndLikelabel.textColor = [UIColor colorWithHexString:@"#AAAAAA"];
    [headerView addSubview:_addressAndLikelabel];
    
    _priceLabel = [[UILabel alloc] initWithFrame:CGRectMake(MainScreenWidth -100, 0, 80, G_Iphone6(72))];
    _priceLabel.font = [UIFont systemFontOfSize:G_Iphone6(24)];
    _priceLabel.textColor = [UIColor colorWithHexString:@"#E67A1A"];
    _priceLabel.textAlignment = NSTextAlignmentRight;
    [headerView addSubview:_priceLabel];
    
    
    [self.contentView addSubview:headerView];
    
    _bigImg = [[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetMinX(headerView.frame), CGRectGetMaxY(headerView.frame), G_Iphone6(361), G_Iphone6(240))];
    [self.contentView addSubview:_bigImg];
    
    UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(CGRectGetMinX(headerView.frame), CGRectGetMaxY(_bigImg.frame), G_Iphone6(361), G_Iphone6(68))];
     footerView.backgroundColor = [UIColor whiteColor];
    _titleLable = [[ UILabel alloc] initWithFrame:CGRectMake(0, 0, G_Iphone6(361), G_Iphone6(68))];
    _titleLable.font = [UIFont systemFontOfSize:G_Iphone6(14)];
    _titleLable.textColor = [UIColor colorWithHexString:@"#545454"];
    _titleLable.numberOfLines = 2;
    [footerView addSubview:_titleLable];
    
    [self.contentView addSubview:footerView];
 
    
}


-(void)setModel:(Product *)Model
{
    [self.bigImg sd_setImageWithURL:[NSURL URLWithString:Model.title_page] placeholderImage:[UIImage imageNamed:pich]];
//    
   self.titleLable.text = Model.title;
    self.dataLabel.text = Model.date_str;
    self.addressAndLikelabel.text = [NSString stringWithFormat:@" %@  ·  %ld人喜欢",Model.address,Model.like_count];
//    
//    self.is_new.text = Model.is_new;
//    
//    
//    if ([self.is_new.text isEqualToString:@"New"]) {
//        _is_new.hidden=NO;
//    }else
//    {
//        _is_new.hidden=YES;
//    }
//    
    [self.headImg sd_setImageWithURL:[NSURL URLWithString:Model.avatar_l] placeholderImage:[UIImage imageNamed:@"0.png"]];
//    
//    if ([Model.address isEqualToString:@""]) {
//
//        self.date_add_count.text = [NSString stringWithFormat:@" %@  ·  %ld人喜欢",Model.date_str,Model.like_count];
//    }else if([Model.date_str isEqualToString:@""])
//    {
//        self.date_add_count.text = [NSString stringWithFormat:@" %@  ·  %ld人喜欢",Model.address,Model.like_count];
//
//    }else{
//        self.date_add_count.text = [NSString stringWithFormat:@" %@  ·  %@  ·  %ld人喜欢",Model.date_str,Model.address,Model.like_count];
//    }
//    
//    
//
//    
   self.priceLabel.text = [NSString stringWithFormat:@"%@ 元",Model.price];
}



- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
