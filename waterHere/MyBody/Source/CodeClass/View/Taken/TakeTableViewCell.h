//
//  TakeTableViewCell.h
//  ZouZou
//
//  Created by NISIOISIN on 15/10/16.
//  Copyright © 2015年 lanou3g. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Product.h"
@interface TakeTableViewCell : UITableViewCell
@property(nonatomic,strong)UIImageView *title_page;
@property(nonatomic,strong)UILabel *is_new;
@property(nonatomic,strong)UILabel *title;
@property(nonatomic,strong)UILabel *date_add_count;
@property(nonatomic,strong)UIImageView *user;

@property(nonatomic,strong)UILabel *price;

@property(nonatomic,strong)Product *Model;


@end
