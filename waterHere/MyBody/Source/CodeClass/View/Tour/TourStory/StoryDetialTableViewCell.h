//
//  StoryDetialTableViewCell.h
//  ZouZou
//
//  Created by hhuuqq on 15/10/18.
//  Copyright (c) 2015年 lanou3g. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Detail_listModel;
@interface StoryDetialTableViewCell : UITableViewCell

@property (nonatomic,strong) UIImageView *picture;

@property (nonatomic,strong) UILabel *text;

- (void) getValueFromDeitalModel:(Detail_listModel *)model;

@end
