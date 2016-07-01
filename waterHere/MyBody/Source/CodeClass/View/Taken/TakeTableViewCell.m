//
//  TakeTableViewCell.m
//  ZouZou
//
//  Created by NISIOISIN on 15/10/16.
//  Copyright © 2015年 lanou3g. All rights reserved.
//

#import "TakeTableViewCell.h"
#define user_width  (CGRectGetWidth([UIScreen mainScreen].applicationFrame)-20)
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
    self.title_page = [[UIImageView alloc]initWithFrame:CGRectMake(10, 10, CGRectGetWidth([UIScreen mainScreen].applicationFrame)-20, 200)];
    
    _title_page.backgroundColor = [UIColor redColor];
    
    _title_page.layer.cornerRadius = 5.0f;
    
    [[_title_page layer] setMasksToBounds:YES];
    
    [self.contentView addSubview:_title_page];
    
    self.is_new = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.title_page.frame)-70, 20, 50, 31)];
    
    self.is_new.backgroundColor = [UIColor orangeColor];
    
    //_is_new.adjustsFontSizeToFitWidth = YES;
    
    [_is_new setFont:[UIFont fontWithName:@"Helvetica-Bold" size:15]];
    
    _is_new.layer.cornerRadius = 5.0f;
    
    [[_is_new layer] setMasksToBounds:YES];
    
    _is_new.textAlignment = NSTextAlignmentCenter;
    
    [_is_new setTextColor:[UIColor whiteColor]];
    
    [self.contentView addSubview:_is_new];
    
    self.title = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMinX(_title_page.frame), CGRectGetMaxY(self.title_page.frame), CGRectGetWidth(self.title_page.frame)-160, 50)];
    
    self.title.backgroundColor = [UIColor clearColor];
    
    _title.font = [UIFont fontWithName:@"STHeiti-Medium.ttc" size:16];
    
    
    
    //_title.lineBreakMode = UILineBreakModeWordWrap;
    _title.numberOfLines = 0;
    
    [self.contentView addSubview:_title];
    
    self.user = [[UIImageView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.frame)-90, CGRectGetMaxY(_title_page.frame) - user_width/8, user_width/4, user_width/4)];
    
    
    
    _user.backgroundColor = [UIColor yellowColor];
    
    [_user.layer setCornerRadius:CGRectGetHeight([_user bounds]) / 2];
    
    _user.layer.masksToBounds = YES;
    
    _user.layer.borderWidth = 5;
    
    _user.layer.borderColor = [[UIColor whiteColor] CGColor];
    

    
    
    [self.contentView addSubview:_user];
    
    self.date_add_count = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMinX(_title_page.frame), CGRectGetMaxY(_title.frame), CGRectGetWidth(self.title_page.frame)-30, 40)];
    
    _date_add_count.backgroundColor = [UIColor clearColor];
    
    _date_add_count.font = [UIFont systemFontOfSize:13];
    
    _date_add_count.lineBreakMode = NSLineBreakByTruncatingMiddle;
    
    [_date_add_count setTextColor:[UIColor grayColor]];
    
    
    
    [self.contentView addSubview:_date_add_count];
    
    self.price = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMinX(_user.frame), CGRectGetMaxY(_date_add_count.frame)-10,80, 50)];
    
    _price.backgroundColor = [UIColor clearColor];
    
    _price.font = [UIFont systemFontOfSize:25];
    
    [_price setTextColor:[UIColor orangeColor]];
    
    [self.contentView addSubview:_price];
    
    
    
    
    
    
    
}


-(void)setModel:(Product *)Model
{
    [self.title_page sd_setImageWithURL:[NSURL URLWithString:Model.title_page] placeholderImage:[UIImage imageNamed:pich]];
    
    self.title.text = Model.title;
    
    self.is_new.text = Model.is_new;
    
    
    if ([self.is_new.text isEqualToString:@"New"]) {
        _is_new.hidden=NO;
    }else
    {
        _is_new.hidden=YES;
    }
    
    [self.user sd_setImageWithURL:[NSURL URLWithString:Model.avatar_l] placeholderImage:[UIImage imageNamed:@"0.png"]];
    
    if ([Model.address isEqualToString:@""]) {

        self.date_add_count.text = [NSString stringWithFormat:@" %@  ·  %ld人喜欢",Model.date_str,Model.like_count];
    }else if([Model.date_str isEqualToString:@""])
    {
        self.date_add_count.text = [NSString stringWithFormat:@" %@  ·  %ld人喜欢",Model.address,Model.like_count];

    }else{
        self.date_add_count.text = [NSString stringWithFormat:@" %@  ·  %@  ·  %ld人喜欢",Model.date_str,Model.address,Model.like_count];
    }
    
    

    
    self.price.text = [NSString stringWithFormat:@"￥ %@",Model.price];
}



- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
