//
//  CollectionViewCell.h
//  ZouZou
//
//  Created by lanou3g on 15/10/16.
//  Copyright (c) 2015年 lanou3g. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CollectionViewCell : UICollectionViewCell
@property(nonatomic,strong)UIImageView *myImage;
@property(nonatomic,strong) UILabel     *nameLabel;
@property(nonatomic,strong) UILabel     *moreLabel;
@property(nonatomic,strong) UIButton     *moreButton;
@end
