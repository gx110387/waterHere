//
//  DestinationDailViewController.m
//  ZouZou
//
//  Created by lanou3g on 15/10/16.
//  Copyright (c) 2015年 lanou3g. All rights reserved.
//

#import "DestinationDailViewController.h"
#define NavigationBarHight 64.0f

#define ImageHight 200.0f
@interface DestinationDailViewController ()
@property(nonatomic,strong)DestinationTripsViewController *DestinationTripsVC;
@property (nonatomic,strong)UIAlertView *alertView;
@property(nonatomic,strong)UIButton *saveButton;
@property(nonatomic,strong) UIBarButtonItem *save;
@property(nonatomic,assign)BOOL isflog;
//@property(nonatomic,strong)NSString *id1;
@end

@implementation DestinationDailViewController
-(void)viewWillAppear:(BOOL)animated
{
    [self hideTabBar];
    
    
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    //NSLog(@"%d",self.G_tripsArr.count);
   
  //  NSLog(@"id详情页%@",self.G_destionModel.id1);
   //NSLog(@"id详情页----%@",self.G_destionModel.id1);
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    //    self.navigationController.navigationBar. alpha =0 ;
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"icon_nav_back_button"] style:UIBarButtonItemStyleDone target:self action:@selector(leftBarButtonItemAction)];
    
    self.tableView.backgroundColor = [UIColor colorWithRed:251/255.0 green:247/255.0 blue:237/255.0 alpha:1];
    
    [self G_ctreatTable];
    
    [self.tableView registerClass:[SectionZeroTableViewCell class] forCellReuseIdentifier:@"Zero"];
    //[self.tableView registerClass:[TripsTableViewCell class] forCellReuseIdentifier:@"trips"];
    
    [self G_data];
    
    [self G_navitiaon];
    
    _save=[[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"like_13x12_hl"] style:UIBarButtonItemStyleDone target:self action:@selector(saveButtonAction)];
    UIBarButtonItem *share=[[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"share_button_image"] style:UIBarButtonItemStyleDone target:self action:@selector(shareButtonAction)];
    self.navigationItem.rightBarButtonItems=@[share,_save ];
    
    // 分享
   // NSLog(@"fdfdfdfdd");
  
    
}
-(void)G_navitiaon
{
    AVUser *currentUser = [AVUser currentUser];
    if (currentUser != nil) {
      [[G_shareTools shareTools]G_isStrat:self.G_destionModel.id1 isflag:^(BOOL isflag) {
        self.isflog = isflag ;
        
        if(self.isflog == YES)
        {
          //  NSLog(@"已收藏");
            [self.saveButton setBackgroundImage:[UIImage imageNamed:@"like_13x12_sl"] forState:UIControlStateNormal];
            self.save.tintColor = [UIColor redColor];
            //[self.tableView reloadData];
        }
    }];
    }
    else
    {
        NSLog(@"未登录");
       
        
    }
    
}
-(void)G_ctreatTable
{
    self.tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    self.tableView.contentInset = UIEdgeInsetsMake(ImageHight-20, 0, 0, 0);
    [self.view addSubview:self.tableView];
    
    
    
}
- (void)hideTabBar {
    if (self.tabBarController.tabBar.hidden == YES) {
        return;
    }
    UIView *contentView;
    if ( [[self.tabBarController.view.subviews objectAtIndex:0] isKindOfClass:[UITabBar class]] )
        contentView = [self.tabBarController.view.subviews objectAtIndex:1];
    else
        contentView = [self.tabBarController.view.subviews objectAtIndex:0];
    contentView.frame = CGRectMake(contentView.bounds.origin.x,  contentView.bounds.origin.y,  contentView.bounds.size.width, contentView.bounds.size.height + self.tabBarController.tabBar.frame.size.height);
    self.tabBarController.tabBar.hidden = YES;
    
}

-(void)G_data
{
    
    _G_zoomImageView = [[UIImageView alloc]init];
    
    [_G_zoomImageView sd_setImageWithURL:[NSURL URLWithString:self.G_imageURL] placeholderImage:[UIImage imageNamed:@"picholder"]];
    _G_zoomImageView.frame = CGRectMake(0, -ImageHight, self.view.frame.size.width, ImageHight);
    
    //contentMode = UIViewContentModeScaleAspectFill时，高度改变宽度也跟着改变
    _G_zoomImageView.contentMode = UIViewContentModeScaleAspectFill;//重点（不设置那将只会被纵向拉伸）
    
    [self.tableView addSubview:_G_zoomImageView];
    _G_zoomImageView.userInteractionEnabled=YES;
    //设置autoresizesSubviews让子类自动布局
    _G_zoomImageView.autoresizesSubviews = YES;
    
    [self G_creatNavgationControllerButton];
}
-(void)G_creatNavgationControllerButton
{
    // 返回上一个页面
    UIButton *backView = [UIButton buttonWithType:UIButtonTypeSystem];
    backView.frame = CGRectMake(20, 30, 25, 25);
    [backView setBackgroundImage:[UIImage imageNamed:@"icon_nav_back_button"] forState:UIControlStateNormal];
    [backView addTarget:self action:@selector(leftBarButtonItemAction) forControlEvents:UIControlEventTouchUpInside];
    [_G_zoomImageView addSubview:backView];
    
    
    // 收藏
    self.saveButton = [UIButton buttonWithType:UIButtonTypeSystem];
    self.saveButton.frame = CGRectMake(CGRectGetWidth(self.view.frame)-CGRectGetWidth(self.view.frame)/4, 30, 25, 25);
    [self.saveButton setBackgroundImage:[UIImage imageNamed:@"like_13x12_hl"] forState:UIControlStateNormal];
    [self.saveButton addTarget:self action:@selector(saveButtonAction) forControlEvents:UIControlEventTouchUpInside];
    [_G_zoomImageView addSubview:self.saveButton];
    
    // 分享
    UIButton *shareButton = [UIButton buttonWithType:UIButtonTypeSystem];
    shareButton.frame = CGRectMake(CGRectGetMaxX(self.saveButton.frame)+20, 30, 20, 25);
    shareButton.tintColor = [UIColor whiteColor];
    [shareButton setBackgroundImage:[UIImage imageNamed:@"share_button_image"] forState:UIControlStateNormal];
    [shareButton addTarget:self action:@selector(shareButtonAction) forControlEvents:UIControlEventTouchUpInside];
    [_G_zoomImageView addSubview:shareButton];
    
    
       
}
// 跳转到上一个页面
-(void)leftBarButtonItemAction
{
    // NSLog(@"ZOULEME ");
    
    NSLog(@"关闭页面,返回上一个");
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"bg_nav"]forBarMetrics:UIBarMetricsDefault];
    
    
    [self.navigationController popViewControllerAnimated:YES];
}
// 分享
-(void)shareButtonAction
{
    NSLog(@"分享");
    
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
        frame.size.height =  -y;//contentMode = UIViewContentModeScaleAspectFill时，高度改变宽度也跟着改变
        _G_zoomImageView.frame = frame;
    }
    
    
    
    // NSLog(@"%f",y);
    if (y >= -100) {
        
    [self.navigationController setNavigationBarHidden:NO animated:YES];
     [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"bg_nav"]forBarMetrics:UIBarMetricsDefault];
    }else{
     [self.navigationController setNavigationBarHidden:YES animated:NO];
         
        
    }
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    if (section == 0) {
        return 1;
    }
    if (section ==1) {
        
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
    SectionZeroTableViewCell *cell1=[tableView dequeueReusableCellWithIdentifier:@"Zero"];
    //TripsTableViewCell *TripsCell = [tableView dequeueReusableCellWithIdentifier:@"trips"];
    UITableViewCell *cell2=[tableView dequeueReusableCellWithIdentifier:@"cell2"];
    
    
    if(cell2==nil){
        cell2=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell2"];
        cell2.separatorInset=UIEdgeInsetsZero;
        cell2.clipsToBounds = YES;
    }
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    self.tableView.frame = CGRectMake( 0,0, CGRectGetWidth(self.view.frame) , CGRectGetHeight(self.view.frame));
    cell2.backgroundColor =[UIColor colorWithRed:251/255.0 green:247/255.0 blue:237/255.0 alpha:1];;
    
    
    if (indexPath.section == 0) {
        if (cell1 == nil) {
            
            cell1 = [[SectionZeroTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Zero"];
            cell1.separatorInset=UIEdgeInsetsZero;
            cell1.clipsToBounds = YES;
        }
        // NSLog(@"%@",self.G_destionModel.rating);
        self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        cell1.backgroundColor =[UIColor colorWithRed:251/255.0 green:247/255.0 blue:237/255.0 alpha:1];
        
        cell1.G_nameLabel.text = self.G_destionModel.name;
        cell1.G_rating.text= [NSString stringWithFormat:@"评分:%@~",self.G_destionModel.rating ];
        cell1.G_rating_usersLabel .text= [NSString stringWithFormat:@"%@ 位用户点评~",self.G_destionModel.rating_users ];
        cell1.G_recommended_reason.text = self.G_destionModel.recommended_reason;
        // 分享要用的文本
        
        cell1.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell1;
    }
    
    if (indexPath.section == 1) {
        
        if (self.G_tripsArr.count != 0) {
            
            
            TripsTableViewCell *TripsCell = [tableView dequeueReusableCellWithIdentifier:@"trips"];
            NSMutableArray *trips = [NSMutableArray array];
            if (self.G_tripsArr.count == 1) {
                
                trips = self.G_tripsArr[0];
                
            }else
            {
                if (indexPath.row ==2) {
                    self.DestinationTripsVC = [[DestinationTripsViewController alloc] init];
                    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
                    button.frame = CGRectMake((CGRectGetWidth(self.view.frame))/2-75, 5, 150, 40);
                  //  button.backgroundColor = [UIColor yellowColor];
                    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
                    button.layer.borderWidth = 0.5;
                    button.layer.borderColor = [UIColor blackColor].CGColor;
                    [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
                    button.layer.cornerRadius = 20;
                    [button setTitle:@"更多印象~" forState:UIControlStateNormal];
                    button .titleLabel.font = [UIFont systemFontOfSize:20];
                    [cell2 addSubview:button];
                    return cell2;
                }
                trips = self.G_tripsArr[indexPath.row];
            }
            
            // if (TripsCell == nil) {
            TripsCell  = [[TripsTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"trips" WithUrlArray:trips[2] id1:self.G_destionModel.id1];
            // }
            TripsCell.backgroundColor = [UIColor colorWithRed:251/255.0 green:247/255.0 blue:237/255.0 alpha:1];
            TripsCell.separatorInset=UIEdgeInsetsZero;
            TripsCell.clipsToBounds = YES;
            TripsCell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            TripModel *trip  = trips[0];
            // self.id1 = trip.id1;
            
            TripsCell.myTrip_name.text = trip.name;
            TripsCell.myTrip_datatime.text = trip.datetime;
            
            UserModel *user =[[UserModel alloc] init];
            [user setValuesForKeysWithDictionary: trip.user];
            TripsCell.myUser_Name.text =user.name;
            [TripsCell.myAvatar sd_setImageWithURL:[NSURL URLWithString:user.avatar_l] placeholderImage:[UIImage imageNamed:@"picholder"]];
            
            
            TripsCell.myLevel_info_Value.text =[NSString stringWithFormat:@"Lv:%@",[[user.experience valueForKey:@"level_info"] valueForKey:@"value"]];
            // 自适应高度
            TripsCell.myTrip_text.text = [NSString stringWithFormat:@"%@",trips[1]];
            TripsCell.myTrip_text.font = [UIFont systemFontOfSize:18];
            if ([trips[1] isEqualToString:@""]) {
                TripsCell.myTrip_text.frame = CGRectMake(10, CGRectGetMaxY(TripsCell.myAvatar.frame)+10, CGRectGetWidth(self.view.frame)-20, 1);
                
            }else{
                TripsCell.myTrip_text.frame = CGRectMake(10, CGRectGetMaxY(TripsCell.myAvatar.frame)+10, CGRectGetWidth(self.view.frame)-20, [self G_heightForString:trips[1]]+30);
            }
            
            if (self.G_tripsArr.count == 1) {
                // return 2;
                if (indexPath.row ==1) {
                    self.DestinationTripsVC = [[DestinationTripsViewController alloc] init];
                    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
                    button.frame = CGRectMake((CGRectGetWidth(self.view.frame))/2-75, 5, 150, 40);
                    //  button.backgroundColor = [UIColor yellowColor];
                    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
                    button.layer.borderWidth = 0.5;
                    button.layer.borderColor = [UIColor blackColor].CGColor;

                    [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
                    button.layer.cornerRadius = 20;
                    [button setTitle:@"更多印象~" forState:UIControlStateNormal];
                    button .titleLabel.font = [UIFont systemFontOfSize:20];
                    [cell2 addSubview:button];
                    return cell2;
                    
                    
                }
                
            }
            return TripsCell;
            //return cell2;
            
        }
        
        return cell2;
    }
    
    
    
    
    
    if (indexPath.section == 2) {
        
        
        UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"cell"];
        
        if(cell==nil){
            cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell"];
            cell.separatorInset=UIEdgeInsetsZero;
            cell.clipsToBounds = YES;
            
        }
        
        cell.detailTextLabel.font = [UIFont systemFontOfSize:14];
        self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        cell.backgroundColor = [UIColor colorWithRed:251/255.0 green:247/255.0 blue:237/255.0 alpha:1];
        if (indexPath.row ==0) {
            cell.textLabel.text = @"概况";
            
            cell.detailTextLabel.text =self.G_destionModel.descript;
            cell.detailTextLabel.numberOfLines = 0;
            cell.textLabel.numberOfLines = 0;
            
            
            
        }
        if (indexPath.row == 1) {
            cell.textLabel.text = @"地址";
            cell.detailTextLabel.text =self.G_destionModel.address;
            cell.detailTextLabel.numberOfLines = 0;
            cell.textLabel.numberOfLines = 0;
        }
        if (indexPath.row == 2) {
            cell.textLabel.text = @"到达方式";
            cell.detailTextLabel.text =self.G_destionModel.arrival_type;
            cell.detailTextLabel.numberOfLines = 0;
            cell.textLabel.numberOfLines = 0;
            
        }
        if (indexPath.row == 3) {
            cell.textLabel.text = @"开放时间";
            cell.detailTextLabel.text =self.G_destionModel.opening_time;
            cell.detailTextLabel.numberOfLines = 0;
            cell.textLabel.numberOfLines = 0;
        }
        if (indexPath.row == 4) {
            cell.textLabel.text = @"联系方式";
            cell.detailTextLabel.text =self.G_destionModel.tel;
            cell.detailTextLabel.numberOfLines = 0;
            cell.textLabel.numberOfLines = 0;
        }
        
        return cell;
    }
    
    
    return cell2;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"%ld====%ld",(long)indexPath.section,(long)indexPath.row);
    
}
// 行高度
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section== 0) {
        return CGRectGetWidth(self.tableView.frame)-140;
    }
    if (indexPath.section == 1) {
        
        if (self.G_tripsArr.count != 0) {
            
            if (self.G_tripsArr.count == 1) {
                
                if (indexPath.row == 0) {
                    NSMutableArray *trips = self.G_tripsArr[indexPath.row];
                    
                    if ([trips[1] isEqualToString:@""]) {
                        return 86+CGRectGetWidth(self.view.frame)/3;
                    }else{
                        return 116+ [self G_heightForString:trips[1]]+CGRectGetWidth(self.view.frame)/3;
                    }
                }
                
                if (indexPath.row == 1) {
                    return 50;
                }
            }
            else //if(self.G_tripsArr.count == 2)
            {
                if (indexPath.row == 2) {
                    return 50;
                }
                NSMutableArray *trips = self.G_tripsArr[indexPath.row];
                if ([trips[1] isEqualToString:@""]) {
                    return 86+CGRectGetWidth(self.view.frame)/3;
                }else{
                    return 116+ [self G_heightForString:trips[1]]+CGRectGetWidth(self.view.frame)/3;
                }
            }
        }
        return 50;
    }
    if (indexPath.section == 2) {
        
        if (indexPath.row ==0) {
            return [self G_heightForString:self.G_destionModel.descript]+20;
        }
        if (indexPath.row == 1) {
            return [self G_heightForString:self.G_destionModel.address]+40;
        }
        if (indexPath.row == 2) {
            return [self G_heightForString:self.G_destionModel.arrival_type]+40;
        }
        if (indexPath.row == 3) {
            return [self G_heightForString:self.G_destionModel.opening_time]+40;
        }
        if (indexPath.row == 4) {
            return [self G_heightForString:self.G_destionModel.tel]+40;
        }
        
        
        
    }
    
    return 100;
}


// 头标题
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *firstView = [[UIView alloc] init];
    //firstView.backgroundColor = [UIColor cyanColor];
    firstView.frame = [UIScreen mainScreen].bounds;
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.frame = CGRectMake( CGRectGetWidth(firstView.frame)/6, 0,CGRectGetWidth(firstView.frame )- CGRectGetWidth(firstView.frame)/6 *2, CGRectGetWidth(self.tableView.frame)/8);
    
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.font = [UIFont systemFontOfSize:20];
    // titleLabel.backgroundColor = [UIColor yellowColor];
    
    if (section == 1 ) {
        titleLabel.text =@"走走印象~";
        [firstView addSubview:titleLabel];
        return firstView;
        
    }
    if (section == 2) {
        titleLabel.text =@"基本信息~";
        [firstView addSubview:titleLabel];
        return firstView;
    }
    return nil;
    
}
// 头高度
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return 1;
    }
    if (section == 1) {
        return CGRectGetWidth(self.tableView.frame)/8;
    }
    if (section == 2) {
        return CGRectGetWidth(self.tableView.frame)/8;
    }
    return 40;
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
/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
