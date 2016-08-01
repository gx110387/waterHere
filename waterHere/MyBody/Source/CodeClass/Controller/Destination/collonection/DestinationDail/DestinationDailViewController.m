//
//  DestinationDailViewController.m
//  ZouZou
//
//  Created by lanou3g on 15/10/16.
//  Copyright (c) 2015年 lanou3g. All rights reserved.
//

#import "DestinationDailViewController.h"
#import "UIView+Sizes.h"
#import "GHMyPhotoView.h"
#define NavigationBarHight 64.0f

#define ImageHight 200.0f
@interface DestinationDailViewController ()
@property(nonatomic,strong)DestinationTripsViewController *DestinationTripsVC;
@property (nonatomic,strong)UIAlertView *alertView;

@property(nonatomic,strong) UIBarButtonItem *save;
@property(nonatomic,assign)BOOL isflog;
//@property(nonatomic,strong)NSString *id1;
@end

@implementation DestinationDailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    self.tableView.backgroundColor = [UIColor whiteColor];
    [self G_ctreatTable];
    [self.tableView registerClass:[SectionZeroTableViewCell class] forCellReuseIdentifier:@"Zero"];
    [self G_data];
    [self G_navitiaon];
    self.title =[NSString stringWithFormat:@"%@",self.G_destionModel.name];
    //
    _save=[[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"like_13x12_hl"] style:UIBarButtonItemStyleDone target:self action:@selector(saveButtonAction)];
    UIBarButtonItem *share=[[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"Ble_share"] style:UIBarButtonItemStyleDone target:self action:@selector(shareButtonAction)];
    self.navigationItem.rightBarButtonItems=@[share,_save ];
 
}
-(void)G_navitiaon
{
    AVUser *currentUser = [AVUser currentUser];
    if (currentUser != nil) {
      [[G_shareTools shareTools]G_isStrat:self.G_destionModel.id1 isflag:^(BOOL isflag) {
        self.isflog = isflag ;
        if(self.isflog == YES) {
          //  NSLog(@"已收藏");
          self.save.tintColor = [UIColor redColor];
        }
    }];
    } else {
        NSLog(@"未登录");
     }
    
}
-(void)G_ctreatTable{
    self.tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.contentInset = UIEdgeInsetsMake(ImageHight-20, 0, 0, 0);
    [self.view addSubview:self.tableView];   
}


-(void)G_data
{
     _G_zoomImageView = [[UIImageView alloc]init];
    [_G_zoomImageView sd_setImageWithURL:[NSURL URLWithString:self.G_imageURL] placeholderImage:[UIImage imageNamed:@"picholder"]];
    _G_zoomImageView.frame = CGRectMake(0, -ImageHight, self.view.frame.size.width, ImageHight-CGRectGetWidth(self.tableView.frame)/8);
    _G_zoomImageView.contentMode = UIViewContentModeScaleAspectFill;//重点（不设置那将只会被纵向拉伸）
    [self.tableView addSubview:_G_zoomImageView];
    _G_zoomImageView.userInteractionEnabled=YES;
    //设置autoresizesSubviews让子类自动布局
    _G_zoomImageView.autoresizesSubviews = YES;
    
}


// 分享
-(void)shareButtonAction
{
    [[G_shareTools shareTools]G_shareText:self shareName:self.G_destionModel.name reason:self.G_destionModel.recommended_reason imageurl:self.G_destionModel.cover_route_map_cover];
 
}
// 收藏

-(void)saveButtonAction
{
    NSLog(@"收藏");
     AVUser *currentUser = [AVUser currentUser];
    if (currentUser != nil) {
        NSLog(@"已登录");
        // 可以收藏
        [[G_shareTools shareTools] G_setSaveStart:self.G_destionModel.type id1:self.G_destionModel.id1 name:self.G_destionModel.name reason:self.G_destionModel.recommended_reason imageUrl:self.G_imageURL];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)( 1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self G_navitiaon];
            
        });
        
        
    } else {
        NSLog(@"未登录");
        self.alertView = [[UIAlertView alloc]initWithTitle:@"提示"message:@"请先登录" delegate:nil cancelButtonTitle:nil otherButtonTitles:nil];
        [self.alertView show];
        [NSTimer scheduledTimerWithTimeInterval:1.0f target:self selector:@selector(dismissAlertView) userInfo:nil repeats:YES];
    }
    
    
}
- (void)dismissAlertView
{
    [self.alertView dismissWithClickedButtonIndex:0 animated:YES];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    CGFloat y = scrollView.contentOffset.y;//+NavigationBarHight;//根据实际选择加不加上NavigationBarHight（44、64 或者没有导航条）
    if (y < -ImageHight) {
        CGRect frame = _G_zoomImageView.frame;
        frame.origin.y = y;
        frame.size.height =  -y-CGRectGetWidth(self.tableView.frame)/8;//contentMode = UIViewContentModeScaleAspectFill时，高度改变宽度也跟着改变
        _G_zoomImageView.frame = frame;
    }
    // NSLog(@"%f",y);
    if (y >= -100) {
        
   }else{
    
         
        
    }
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
//    if (section == 0) {
//        return 1;
//    }
    if (section ==0) {
        
        if (self.G_tripsArr.count != 0) {
            
            if (self.G_tripsArr.count > 2||self.G_tripsArr.count == 2) {
                return 3;
            }
            if (self.G_tripsArr.count == 1) {
                return 2;
            }
        }
        return 1;
        
    }
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
//    SectionZeroTableViewCell *cell1=[tableView dequeueReusableCellWithIdentifier:@"Zero"];
    //TripsTableViewCell *TripsCell = [tableView dequeueReusableCellWithIdentifier:@"trips"];
    UITableViewCell *cell2=[tableView dequeueReusableCellWithIdentifier:@"cell2"];
    
    
    if(cell2==nil){
        cell2=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell2"];
        cell2.separatorInset=UIEdgeInsetsZero;
        cell2.clipsToBounds = YES;
    }
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    self.tableView.frame = CGRectMake( 0,0, CGRectGetWidth(self.view.frame) , CGRectGetHeight(self.view.frame));
    cell2.backgroundColor =[UIColor whiteColor];    
//    if (indexPath.section == 0) {
//        if (cell1 == nil) {
//            
//            cell1 = [[SectionZeroTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Zero"];
//            cell1.separatorInset=UIEdgeInsetsZero;
//            cell1.clipsToBounds = YES;
//        }
//        // NSLog(@"%@",self.G_destionModel.rating);
//        self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
//        cell1.backgroundColor =[UIColor whiteColor];
//        
//        cell1.G_nameLabel.text = self.G_destionModel.name;
//        cell1.G_rating.text= [NSString stringWithFormat:@"评分:%@~",self.G_destionModel.rating ];
//        cell1.G_rating_usersLabel .text= [NSString stringWithFormat:@"%@ 位用户点评~",self.G_destionModel.rating_users ];
//        cell1.G_recommended_reason.text = self.G_destionModel.recommended_reason;
//        // 分享要用的文本
//        
//        cell1.selectionStyle = UITableViewCellSelectionStyleNone;
//        return cell1;
//    }
    
    if (indexPath.section == 0) {
        if (self.G_tripsArr.count != 0) {
            TripsTableViewCell *TripsCell = [tableView dequeueReusableCellWithIdentifier:@"trips"];
            NSMutableArray *trips = [NSMutableArray array];
            if (self.G_tripsArr.count == 1) {
                trips = self.G_tripsArr[0];
            }else  {
                if (indexPath.row ==2) {
                    [cell2 addSubview:[self addButton]];
                    return cell2;
                }
                trips = self.G_tripsArr[indexPath.row];
            }
            
            // if (TripsCell == nil) {
            TripsCell  = [[TripsTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"trips" WithUrlArray:trips[2] id1:self.G_destionModel.id1];
            // }
            TripsCell.backgroundColor = [UIColor whiteColor];
            TripsCell.separatorInset=UIEdgeInsetsZero;
            TripsCell.clipsToBounds = YES;
            TripsCell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            TripModel *trip  = trips[0];
            // self.id1 = trip.id1;
            TripsCell.model = trip;
            
            TripsCell.myTrip_text.text = [NSString stringWithFormat:@"%@",trips[1]];
            TripsCell.myTrip_text.font = [UIFont systemFontOfSize:18];
            if ([trips[1] isEqualToString:@""]) {
                TripsCell.myTrip_text.frame = CGRectMake(10, CGRectGetMaxY(TripsCell.myAvatar.frame)+10, CGRectGetWidth(self.view.frame)-20, 1);
              }else{
                TripsCell.myTrip_text.frame = CGRectMake(10, CGRectGetMaxY(TripsCell.myAvatar.frame)+10, CGRectGetWidth(self.view.frame)-20, [self G_heightForString:trips[1]]+30);
            }
 
            TripsCell.PhotoView.y = CGRectGetMaxY(TripsCell.myTrip_text.frame);
 
            if (self.G_tripsArr.count == 1) {
                // return 2;
                if (indexPath.row ==1) {
                    [cell2 addSubview:[self addButton]];
                    return cell2;
                }
            }
            return TripsCell;
        }
        return cell2;
    }
    
    
    if (indexPath.section == 1) {
        
        
        UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"cell"];
        
        if(cell==nil){
            cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell"];
            cell.separatorInset=UIEdgeInsetsZero;
            cell.clipsToBounds = YES;
            
        }
        
        cell.detailTextLabel.font = [UIFont systemFontOfSize:14];
        self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        cell.backgroundColor = [UIColor whiteColor];
        cell.detailTextLabel.numberOfLines = 0;
        cell.textLabel.numberOfLines = 0;
        cell.detailTextLabel.font = [ UIFont systemFontOfSize:14];
        cell.detailTextLabel.tintColor = CustomerColor(51, 51, 51);
        if (indexPath.row ==0) {
            cell.textLabel.text= @"- 基本信息 -";
            cell.textLabel.textAlignment = NSTextAlignmentCenter;
            
            cell.textLabel.font =[UIFont systemFontOfSize:18];
            cell.detailTextLabel.text = [NSString stringWithFormat:@"概况:%@",self.G_destionModel.descript];
        }
        if (indexPath.row == 1) {
            cell.detailTextLabel.text = [NSString stringWithFormat:@"地址:%@",self.G_destionModel.address];
            
        }
        if (indexPath.row == 2) {
            cell.detailTextLabel.text = [NSString stringWithFormat:@"到达方式:%@",self.G_destionModel.arrival_type];
            
        }
        if (indexPath.row == 3) {
            cell.detailTextLabel.text = [NSString stringWithFormat:@"开放时间:%@",self.G_destionModel.opening_time];
            
        }
        if (indexPath.row == 4) {
            cell.detailTextLabel.text =[NSString stringWithFormat:@"联系方式:%@",self.G_destionModel.tel];
            
        }
        
        return cell;
    }
    
    
    return cell2;
    
}

-(UIButton *)addButton
{
    self.DestinationTripsVC = [[DestinationTripsViewController alloc] init];
    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
    button.frame = CGRectMake((CGRectGetWidth(self.view.frame))/2-75, 5, 150, 40);
    //  button.backgroundColor = [UIColor yellowColor];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    button.layer.borderWidth = 0.5;
    button.layer.borderColor = [UIColor blackColor].CGColor;
    
    [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    button.layer.cornerRadius = 3;
    [button setTitle:@"MORE IN" forState:UIControlStateNormal];
    button .titleLabel.font = [UIFont systemFontOfSize:20];
    [button setTintColor:CustomerColor(216, 216, 216)];
    return button;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"%ld====%ld",(long)indexPath.section,(long)indexPath.row);
    
}
// 行高度
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
 
    if (indexPath.section == 0) {
        
        if (self.G_tripsArr.count != 0) {
             NSMutableArray *trips = [NSMutableArray array];
            if (self.G_tripsArr.count == 1) {
                trips = self.G_tripsArr[0];
            }else  {
                trips = self.G_tripsArr[indexPath.row];
            }
            NSInteger imgscount = [trips[2] count];
            NSInteger discount = [GGxTools arraytoint:imgscount];
            
            if (self.G_tripsArr.count == 1) {
                
                if (indexPath.row == 0) {
                    
                     if ([trips[1] isEqualToString:@""]) {
                        return 86+discount;
                    }else{
                        return 116+ [self G_heightForString:trips[1]]+discount;
                    }
                }
                if (indexPath.row == 1) {
                    return 50;
                }
            }
            else {
                if (indexPath.row == 2) {
                    return 50;
                }
                NSMutableArray *trips = self.G_tripsArr[indexPath.row];
                if ([trips[1] isEqualToString:@""]) {
                    return 86+discount;
                }else{
                    return 116+ [self G_heightForString:trips[1]]+discount;
                }
            }
        }
        return 50;
    }
    else if (indexPath.section == 1) {
        
        if (indexPath.row ==0) {
            return [self G_heightForString:self.G_destionModel.descript]+20;
        }
        if (indexPath.row == 1) {
            return [self G_heightForString:self.G_destionModel.address]+20;
        }
        if (indexPath.row == 2) {
            return [self G_heightForString:self.G_destionModel.arrival_type]+20;
        }
        if (indexPath.row == 3) {
            return [self G_heightForString:self.G_destionModel.opening_time]+20;
        }
        if (indexPath.row == 4) {
            return [self G_heightForString:self.G_destionModel.tel]+20;
        }else
        {
            return 1;
        }
        
        
        
    }else
    {
        return 1;
    }
    
}


// 头标题
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *firstView = [[UIView alloc] init];
   firstView.backgroundColor = CustomerColor(247,247, 247);
    firstView.frame = [UIScreen mainScreen].bounds;
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.frame = CGRectMake(15, 0,MainScreenWidth-30 , CGRectGetWidth(self.tableView.frame)/8);
    
    titleLabel.tintColor = CustomerColor(51, 51, 51);
    titleLabel.font = [UIFont systemFontOfSize:18];
    // titleLabel.backgroundColor = [UIColor yellowColor];
    
    if (section == 0 ) {
        titleLabel.text =[NSString stringWithFormat:@"喜物由心 融入生活  %@",self.G_destionModel.name ];
        [firstView addSubview:titleLabel];
        return firstView;
        
    }
         return nil;
    
}
// 头高度
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
 
    if (section == 0) {
        return CGRectGetWidth(self.tableView.frame)/8;
    }
    
    return 0.001;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 1;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(CGFloat)G_heightForString:(NSString *)aString
{
    NSDictionary *dict = @{NSFontAttributeName:[UIFont systemFontOfSize:17.2]};// 一定要大于等于实际的字体
    //将传进来的字符串放在一个矩形中
    CGRect rect = [aString boundingRectWithSize:CGSizeMake(CGRectGetWidth(self.view.frame)-20, 2000) options:NSStringDrawingUsesLineFragmentOrigin attributes:dict context:nil];
    return rect.size.height;
}

-(void)buttonAction:(UIButton *)sender
{
    NSLog(@"更多印象");
    self.DestinationTripsVC.id1 = self.G_destionModel.id1;
   // NSLog(@"更多印象%@",self.G_destionModel.id1);
    [self.navigationController pushViewController:self.DestinationTripsVC animated:YES];
}


@end
