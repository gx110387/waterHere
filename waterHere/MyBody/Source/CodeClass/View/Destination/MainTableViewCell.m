//
//  MainTableViewCell.m
//  ZouZou
//
//  Created by lanou3g on 15/10/15.
//  Copyright (c) 2015年 lanou3g. All rights reserved.
//

#import "MainTableViewCell.h"

@interface MainTableViewCell ()

@end
@implementation MainTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self G_setupView];
    }
    return self;
}
-(void)G_setupView
{
   
    self.myImage = [[UIImageView alloc] init];
    self.myImage.frame = CGRectMake(20, 0, CGRectGetWidth(self.contentView.frame)-40, CGRectGetHeight(self.contentView.frame));
    self.myImage.backgroundColor = [UIColor clearColor];
    self.myImage.layer.cornerRadius = 10;
    self.myImage.layer.masksToBounds = YES;
    [self.contentView addSubview:self.myImage];
    
    self.nameLabel = [[UILabel alloc] init];
    self.nameLabel.frame = CGRectMake(0, CGRectGetHeight(self.myImage.frame)-50, CGRectGetWidth(self.myImage.frame)-40, 30);
    self.nameLabel.textAlignment = NSTextAlignmentLeft;
    self.nameLabel.textColor = [UIColor whiteColor];
 
    [self.myImage addSubview:_nameLabel];
    //[self.myImage addTarget:self action:@selector(myButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    
  }

-(void)layoutSubviews
{ [super layoutSubviews];
     self.myImage.frame = CGRectMake(20, 0, CGRectGetWidth(self.contentView.frame)-40, CGRectGetHeight(self.contentView.frame));
     self.nameLabel.frame = CGRectMake(20, CGRectGetHeight(self.contentView.frame)-50, CGRectGetWidth(self.contentView.frame)-40, 30);
}



@end
