//
//  HeadtitleView.m
//  ZouZou
//
//  Created by gx110387 on 15/10/16.
//  Copyright (c) 2015年 gx110387. All rights reserved.
//

#import "HeadtitleView.h"

@implementation HeadtitleView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self G_setupView];
    }
    return self;
}


-(void)G_setupView
{
    
    
    self.headerImageLabel = [[UILabel alloc] init];
    _headerImageLabel.frame = CGRectMake(20, 5, 10, 30);
    _headerImageLabel.backgroundColor = [UIColor cyanColor];
    [self addSubview:_headerImageLabel];
    
    
    self.titleLabel = [UIButton buttonWithType:UIButtonTypeSystem];
    _titleLabel.frame = CGRectMake(CGRectGetMaxX(_headerImageLabel.frame)+5,CGRectGetMinY(_headerImageLabel.frame), CGRectGetWidth(self.frame)-80, CGRectGetHeight(_headerImageLabel.frame));
   
   
    [self addSubview:_titleLabel];
    
    
    self.breakButton = [UIButton buttonWithType:UIButtonTypeSystem];
    _breakButton.frame = CGRectMake(CGRectGetWidth(self. frame)-10-10-20, CGRectGetMinY(_titleLabel.frame)+10, 15, 20);
      [self addSubview:_breakButton];
  

    
    
}
-(void)layoutSubviews
{
     [super layoutSubviews];
    _headerImageLabel.frame = CGRectMake(20, 5, 10, 30);
    _titleLabel.frame = CGRectMake(CGRectGetMaxX(_headerImageLabel.frame)+5,CGRectGetMinY(_headerImageLabel.frame), CGRectGetWidth(self.frame)-80, CGRectGetHeight(_headerImageLabel.frame));
 _breakButton.frame = CGRectMake(CGRectGetWidth(self. frame)-10-10-20, CGRectGetMinY(_titleLabel.frame)+10, 15, 20);
    
}
@end
