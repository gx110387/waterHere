//
//  CollectionViewCell.m
//  ZouZou
//
//  Created by lanou3g on 15/10/16.
//  Copyright (c) 2015年 lanou3g. All rights reserved.
//

#import "CollectionViewCell.h"

@implementation CollectionViewCell
-(instancetype)initWithFrame:(CGRect)frame
{
    if (self == [super initWithFrame:self.bounds]) {
        [self gett];
    }
    return self;
}

-(void)gett
{
    // NSLog(@"%fddd",CGRectGetWidth([UIScreen mainScreen].bounds));
    self.myImage = [[UIImageView alloc] init];
    self .myImage.frame =CGRectMake(0, 0, CGRectGetWidth([UIScreen mainScreen].bounds)/2.2, CGRectGetWidth([UIScreen mainScreen].bounds)/2.1);
    //self.myImage.backgroundColor = [UIColor redColor];
    
    self.myImage.layer.cornerRadius = 5;
    self.myImage.layer.masksToBounds = YES;
    //self.myImage .image = [UIImage imageNamed:@"1.jpg"];
    [self.contentView addSubview:_myImage];
    
    
    self.nameLabel = [[UILabel alloc] init];
    self.nameLabel.frame = CGRectMake(10, CGRectGetHeight(self.myImage.frame)-40, CGRectGetWidth(self.myImage.frame), 30);
    self.nameLabel.textAlignment = NSTextAlignmentLeft;
    self.nameLabel.textColor = [UIColor whiteColor];
    
    [self.myImage addSubview:_nameLabel];

}
-(void)layoutSubviews
{
     [super layoutSubviews];
    self .myImage.frame =CGRectMake(0, 0, CGRectGetWidth([UIScreen mainScreen].bounds)/2.2,CGRectGetWidth([UIScreen mainScreen].bounds)/2.1);
    self.nameLabel.frame = CGRectMake(10, CGRectGetHeight(self.myImage.frame)-40, CGRectGetWidth(self.myImage.frame), 30);

}

@end
