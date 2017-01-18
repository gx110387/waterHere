//
//  StoryDitialView.h
//  ZouZou
//
//  Created by hhuuqq on 15/10/17.
//  Copyright (c) 2015年 gx110387. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface StoryDitialView : UIScrollView

@property (nonatomic,strong) UIImageView *userPicture;                                // 用户的图片

@property (nonatomic,strong) UILabel *nameLabel;                                      // 用户姓名

@property (nonatomic,strong) UILabel *topWireLabel;                                   // 水平线

@property (nonatomic,strong) UILabel *textLabel;                                      // 文本内容

@property (nonatomic,strong) UITableView *detialTableView;                            // 细节表视图

@property (nonatomic,strong) UILabel *bottomWireLabel;                                // 下方水平线

@property (nonatomic,strong) UIImageView *photoImage;                                 // 相机图片

@property (nonatomic,strong) UIImageView *timeImage;                                  // 时间图片

@property (nonatomic,strong) UILabel *storyForm;                                      // 故事收录于

@property (nonatomic,strong) UILabel *storyTime;                                      // 故事时间

@property (nonatomic,strong) UILabel *loveLabel;                                      // 喜欢人数

@property (nonatomic,strong) UIImageView *loveImage;                                  // 喜欢人的图片

@property (nonatomic,strong) UIView *topView;                                         // 头视图

@property (nonatomic,strong) UIView *bottomView;                                      // 尾视图

- (void) getValueFromStoryModel:(StoryModel *)model;


@end
