//
//  CollectionViewCell.m
//  ZouZou
//
//  Created by gx110387 on 15/10/16.
//  Copyright (c) 2015年 gx110387. All rights reserved.
//

#import "CollectionViewCell1.h"

@implementation CollectionViewCell1
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
    
    self.myImage.layer.cornerRadius = 7;
    self.myImage.layer.masksToBounds = YES;
    
    self.nameLabel = [[UILabel alloc] init];
    self.nameLabel.frame =  CGRectMake(10, CGRectGetHeight(self.myImage.frame)-40, CGRectGetWidth(self.myImage.frame), 30);    self.nameLabel.textAlignment = NSTextAlignmentLeft;
    self.nameLabel.textColor = [UIColor whiteColor];
    
    [self.myImage addSubview:self.nameLabel];
    //self.myImage .image = [UIImage imageNamed:@"1.jpg"];
    [self.contentView addSubview:_myImage];
    
    
}


@end
