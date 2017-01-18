//
//  CollectionViewCell.m
//  ZouZou
//
//  Created by gx110387 on 15/10/16.
//  Copyright (c) 2015年 gx110387. All rights reserved.
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
    
    UIImageView *collbgImg = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, G_Iphone6(164), G_Iphone6(202+10+43))];
    collbgImg.image = [ UIImage imageNamed:@"CollBgImg"];
    [self.contentView addSubview:collbgImg];
    
    // NSLog(@"%fddd",CGRectGetWidth([UIScreen mainScreen].bounds));
    self.myImage = [[UIImageView alloc] init];
    self .myImage.frame =CGRectMake(0, 10, G_Iphone6(164), G_Iphone6(202));
    //self.myImage.backgroundColor = [UIColor redColor];
    
    self.myImage.layer.cornerRadius = 7;
    self.myImage.layer.masksToBounds = YES;
    
    self.nameLabel = [[UILabel alloc] init];
    self.nameLabel.frame = CGRectMake(G_Iphone6(16)  , G_Iphone6(202)-40, CGRectGetWidth(self.myImage.frame)/3*2, 30);
    self.nameLabel.textAlignment = NSTextAlignmentLeft;
    self.nameLabel.textColor = [UIColor whiteColor];

    [self.myImage addSubview:self.nameLabel];
    //self.myImage .image = [UIImage imageNamed:@"1.jpg"];
    [self.contentView addSubview:_myImage];
    
    UIView *footerView = [[ UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.myImage.frame), G_Iphone6(164), G_Iphone6(43))];
    [self.contentView addSubview:footerView];
    footerView.backgroundColor = [ UIColor whiteColor];
    

    self.moreLabel = [[UILabel alloc] init];
    self.moreLabel.frame = CGRectMake(G_Iphone6(16)  , 0, CGRectGetWidth(self.myImage.frame)/3*2, G_Iphone6(43));
    self.moreLabel.textAlignment = NSTextAlignmentCenter;
    self.moreLabel.textColor = [UIColor colorWithHexString:@"#666666"];
    self.moreLabel.font = [UIFont systemFontOfSize:14];
    [footerView addSubview:_moreLabel];
    
    
    
    self.moreButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.moreButton.frame = CGRectMake( G_Iphone6(164)-G_Iphone6(53)  , G_Iphone6(3),G_Iphone6(43), G_Iphone6(43));
    [self.moreButton setImage:[UIImage imageNamed:@"moreButton"] forState:UIControlStateNormal];
    [footerView addSubview:self.moreButton];
    
    

}


@end
