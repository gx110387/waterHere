//
//  CollectionViewCell.h
//  ZouZou
//
//  Created by gx110387 on 15/10/16.
//  Copyright (c) 2015年 gx110387. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CollectionViewCell : UICollectionViewCell
@property(nonatomic,strong)UIImageView *myImage;
@property(nonatomic,strong) UILabel     *nameLabel;
@property(nonatomic,strong) UILabel     *moreLabel;
@property(nonatomic,strong) UIButton     *moreButton;
@end
