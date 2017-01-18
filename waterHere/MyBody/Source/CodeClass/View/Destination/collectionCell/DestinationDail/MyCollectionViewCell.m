//
//  MyCollectionViewCell.m
//  UILesson21_conllection
//
//  Created by gx110387 on 15/9/24.
//  Copyright (c) 2015年 gx110387. All rights reserved.
//

#import "MyCollectionViewCell.h"

@implementation MyCollectionViewCell
-(UIImageView *)myImage
{
    
    if (_myImage ==nil) {
        self.myImage = [[UIImageView alloc] initWithFrame:self.contentView. bounds];
       // self.myImage.backgroundColor = [UIColor cyanColor];
        [self.contentView addSubview:_myImage];
    }
    
    return  _myImage;
   }
@end
