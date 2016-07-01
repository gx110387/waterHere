//
//  TourStoryTableViewCell.m
//  ZouZou
//
//  Created by hhuuqq on 15/10/15.
//  Copyright (c) 2015年 lanou3g. All rights reserved.
//

#import "TourStoryTableViewCell.h"

@implementation TourStoryTableViewCell
- (UICollectionView *)collectionView
{
    if (_collectionView == nil) {
        _flowLayout = [[UICollectionViewFlowLayout alloc]init];
        self.collectionView = [[UICollectionView alloc]initWithFrame:self.bounds collectionViewLayout:_flowLayout];
        
        _flowLayout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
        [self.contentView addSubview:_collectionView];
        
        
    }
    return _collectionView;
}


// by hqx 1017 让控件适应屏幕高度
- (void)layoutSubviews
{
    [super layoutSubviews];
    self.collectionView.frame = self.bounds;
    _flowLayout.itemSize = CGSizeMake((self.frame.size.width - 40) / 2, 170);
}





- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
