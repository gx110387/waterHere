//
//  TourMainView.h
//  ZouZou
//
//  Created by hhuuqq on 15/10/15.
//  Copyright (c) 2015年 gx110387. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SDCycleScrollView.h"
@interface TourMainView : UIView

@property (nonatomic,strong) SDCycleScrollView *cycleScrollView;

@property (nonatomic,retain) UITableView *bottomView;

@property (nonatomic,retain) UIView *backView;





@end
