//
//  DestinationDailViewController.h
//  ZouZou
//
//  Created by gx110387 on 15/10/16.
//  Copyright (c) 2015年 gx110387. All rights reserved.
//

#import <UIKit/UIKit.h>



@class DestinationModel;
@interface DestinationDailViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong) UIImageView *G_zoomImageView;//变焦图片做底层

@property(nonatomic,strong) UIImageView *G_circleView;//类似头像的UIImageView
//类似昵称UILabel
@property(nonatomic,strong) UILabel *G_cmeraNumLabel;
@property(nonatomic,strong)DestinationModel *G_destionModel;
// 调转页面前一定要先赋值
@property(nonatomic,strong)NSString * G_imageURL;

@property(nonatomic,strong)NSMutableArray *G_tripsArr;

@property(nonatomic,strong)NSString *id1;



@end
