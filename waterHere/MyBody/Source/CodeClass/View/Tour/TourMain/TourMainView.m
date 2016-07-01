//
//  TourMainView.m
//  ZouZou
//
//  Created by hhuuqq on 15/10/15.
//  Copyright (c) 2015年 lanou3g. All rights reserved.
//

#import "TourMainView.h"

@implementation TourMainView


- (UIView *)backView
{
    if (_backView == nil) {
        _backView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.frame), ScreenHeight / 3.1)];
        [self addSubview:_backView];
    }
    return _backView;
}



- (SDCycleScrollView *)cycleScrollView
{
    if (_cycleScrollView == nil) {
        self.cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight / 3.3) imageURLStringsGroup:nil];
        [self.backView addSubview:_cycleScrollView];
        self.cycleScrollView.placeholderImage = [UIImage imageNamed:pich];
        self.cycleScrollView.autoScrollTimeInterval = 2;
       
    }
    return _cycleScrollView;
}


- (UITableView *)bottomView
{
    if (_bottomView == nil) {
        self.bottomView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame)) style:UITableViewStyleGrouped];
        [self addSubview:_bottomView];
        self.bottomView.tableHeaderView = self.backView;
    }
    return _bottomView;
}










@end
