//
//  DestinationTripsViewController.m
//  ZouZou
//
//  Created by lanou3g on 15/10/18.
//  Copyright (c) 2015年 lanou3g. All rights reserved.
//

#import "DestinationTripsViewController.h"

#import "UIView+Sizes.h"
#import "GHMyPhotoView.h"
#import "MJRefresh.h"

@interface DestinationTripsViewController ()<UITableViewDataSource,UITableViewDelegate>



@property(nonatomic,strong)UITableView *tableTrip;
@property(nonatomic,strong)UITableView *tableTrip2;
@property(nonatomic,strong)UISegmentedControl *segment;
@property(nonatomic,strong)NSMutableArray *tripsArr;
@end

@implementation DestinationTripsViewController
{
    BOOL isfirst;
}

-(void)viewWillAppear:(BOOL)animated
{
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.leftBarButtonItem =
    [UIBarButtonItem itemWithTarget:self action:@selector(leftBarButtonItemAction:) image:@"icon_nav_back_button" highImage:@"icon_nav_back_button"];
    self.tripsArr = [NSMutableArray array];
    [self.tableTrip2 registerClass:[Trips2TableViewCell class] forCellReuseIdentifier:@"trip2"];
    [self setSegmentView];
    self.view.  backgroundColor =   [UIColor whiteColor];
    
    [self setupRefresh];
    
}

/**
 *  集成刷新控件
 */
- (void)setupRefresh{
    
     if (self.view.tag == 0) {
        [self.tableTrip addLegendHeaderWithRefreshingTarget:self refreshingAction:@selector(headerRereshing) dateKey:@"table"];
        [self.tableTrip.header beginRefreshing];
         [self.tableTrip addLegendFooterWithRefreshingTarget:self refreshingAction:@selector(footerRereshing)];

    }else{
        [self.tableTrip2 addLegendHeaderWithRefreshingTarget:self refreshingAction:@selector(headerRereshing) dateKey:@"table"];
          [self.tableTrip2.header beginRefreshing];
         [self.tableTrip2 addLegendFooterWithRefreshingTarget:self refreshingAction:@selector(footerRereshing)];
    }
 }

#pragma mark 开始进入刷新状态
- (void)headerRereshing
{
    NSLog(@"%ld",self.view.tag);
    if (self.view.tag == 0 ) {
      // 异步加载数据
        [[G_getDestinaData shareGetDestinData] G_getInfoData:0 id:self.id1 count:5 passValue:^(NSMutableArray *array) {
           self.tripsArr  = array;
            [self.tableTrip reloadData];
             [self.tableTrip. header endRefreshing];
                    }];
    }
    if (self.view.tag == 1) {
        // 1.添加假数据
         [[G_getDestinaData shareGetDestinData] G_getInfoTripsData:0 id:self.id1 count:20 passValue:^(NSMutableArray *array) {
            self.G_recommended_reasonArr = array;
            [self.tableTrip2 reloadData];
              [self.tableTrip2.header endRefreshing];
        }];
    }
 }

- (void)footerRereshing
{
    if (self.view.tag == 0 ) {
  [[G_getDestinaData shareGetDestinData] G_getInfoData:self.tripsArr.count id:self.id1 count:5 passValue:^(NSMutableArray *array) {
              [self.tripsArr addObjectsFromArray:array];
             [self.tableTrip reloadData];
            [self.tableTrip.footer endRefreshing];
        }];
    }
    if (self.view.tag == 1) {
   [[G_getDestinaData shareGetDestinData] G_getInfoTripsData:self.G_recommended_reasonArr.count id:self.id1 count:20 passValue:^(NSMutableArray *array) {
             [self.G_recommended_reasonArr addObjectsFromArray:array];
            [self.tableTrip2 reloadData];
            [self.tableTrip2.footer endRefreshing];
        }];
    }
   }

-(void)setSegmentView
{
    
    NSArray *arr = [NSArray arrayWithObjects:@"游记",@"点评", nil];
    self.segment = [[UISegmentedControl alloc] initWithItems:arr];
    self.segment.frame = CGRectMake(100, 0, 150, 33);
  
   
    // 默认被选中的背景、
    self.navigationItem.titleView  = self. segment;
    
     self. segment.selectedSegmentIndex =0;
    self.view.tag = 0;
    // 边框和字体颜色
    self. segment.tintColor = [UIColor whiteColor];
    [self. segment addTarget:self action:@selector(segmentAction:) forControlEvents:UIControlEventValueChanged];
    
    self.tableTrip2 = [[UITableView alloc] initWithFrame:CGRectMake(10, 0, CGRectGetWidth(self.view.frame)-10, CGRectGetHeight(self.view.frame)-66) style:UITableViewStylePlain];
    self.tableTrip2.delegate = self;
    self.tableTrip2.dataSource = self;
    self.tableTrip2.backgroundColor =    [UIColor whiteColor];
   // self.tableTrip2.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.tableTrip2];
  //
    self.tableTrip = [[UITableView alloc] initWithFrame:CGRectMake(10,0, CGRectGetWidth(self.view.frame)-10, CGRectGetHeight(self.view.frame)-66) style:UITableViewStylePlain];
    self.tableTrip.delegate = self;
    self.tableTrip.dataSource = self;
    self.tableTrip.backgroundColor =     [UIColor whiteColor];
    // self.tableTrip.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.tableTrip];
 
    [self.tableTrip reloadData];
    
}
-(void)segmentAction:(UISegmentedControl *)sender
{
    NSInteger index = [sender selectedSegmentIndex];
    NSLog(@"text:%ld",index);
    switch ([sender selectedSegmentIndex]) {
            
        case 0:
            self.tableTrip.hidden=NO;
            self.tableTrip2.hidden=YES;
            self.segment.selectedSegmentIndex=0;
            self.view.tag=0;
            [self.tableTrip reloadData];
            // 2.集成刷新控件
//            [self setupRefresh];
            break;
            
        case 1:
            self.tableTrip .hidden=YES;
            self.tableTrip2.hidden=NO;
            self.segment.selectedSegmentIndex=1;
            self.view.tag=1;
            [self.tableTrip2 reloadData];
            // 2.集成刷新控件
            if (isfirst == NO) {
                isfirst = YES;
               [self setupRefresh];
            }
//
            break;
            
        default:
            NSLog(@"segmentActionDefault");
            break;
    }
}

-(void)leftBarButtonItemAction:(UIBarButtonItem *)sender
{
  
    NSLog(@"关闭页面,返回上一个");
 [self.navigationController popViewControllerAnimated:YES];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (self.view.tag == 0) {
        NSLog(@"行数%ld",self.tripsArr.count);
        return self.tripsArr.count;
    }
    if (self.view.tag == 1) {
        return self.G_recommended_reasonArr.count;
    }
   
        return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.tableTrip.frame = CGRectMake(10,0, CGRectGetWidth(self.view.frame)-20, CGRectGetHeight(self.view.frame));
    self.tableTrip2.frame = CGRectMake(10,0, CGRectGetWidth(self.view.frame)-20, CGRectGetHeight(self.view.frame));
    UITableViewCell *cell  = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
 cell.backgroundColor =    [UIColor colorWithRed:251/255.0 green:247/255.0 blue:237/255.0 alpha:1];
    Trips2TableViewCell *tripCell2 = [tableView dequeueReusableCellWithIdentifier:@"trip2"];
    tripCell2.backgroundColor =    [UIColor colorWithRed:251/255.0 green:247/255.0 blue:237/255.0 alpha:1];
    if (self.view.tag == 0) {
        

        
            NSMutableArray *trips = self.tripsArr[indexPath.row];
            
            TripsTableViewCell *tripCell = [tableView dequeueReusableCellWithIdentifier:@"trip"];
           // if (tripCell == nil) {
                tripCell  = [[TripsTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"trip" WithUrlArray:trips[2] id1:self.id1];
           // }
        tripCell.backgroundColor =   [UIColor whiteColor];
            tripCell.separatorInset=UIEdgeInsetsZero;
            tripCell.clipsToBounds = YES;
            tripCell.selectionStyle = UITableViewCellSelectionStyleNone;
       
       TripModel *trip  = trips[indexPath.section];
        tripCell.model = trip;
 
                // 自适应高度
       tripCell.myTrip_text.text = [NSString stringWithFormat:@"%@",trips[1]];
        if ([trips[1] isEqualToString:@""]) {
            tripCell.myTrip_text.frame = CGRectMake(0, CGRectGetMaxY(tripCell.myAvatar.frame)+10, CGRectGetWidth(self.view.frame)-20, 1);
        
        }else{
            tripCell.myTrip_text.frame = CGRectMake(0, CGRectGetMaxY(tripCell.myAvatar.frame)+10, CGRectGetWidth(self.view.frame)-20, [self G_heightForString:trips[1]]+30);
               }
        tripCell.PhotoView.y = CGRectGetMaxY(tripCell.myTrip_text.frame);
        return tripCell;
         }
    
    if (self.view.tag ==1) {
        if (tripCell2 ==nil) {
            tripCell2 = [[Trips2TableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"trip2"];
             tripCell2.selectionStyle = UITableViewCellSelectionStyleNone;
        }
          tripCell2.backgroundColor =    [UIColor whiteColor];
        recommendedModel *rc = self.G_recommended_reasonArr[indexPath.row];
        
        tripCell2.myTrip_datatime.text = rc.datetime;
       
         tripCell2.myTrip_text.text =rc.content;
        tripCell2.myTrip_text.frame = CGRectMake(0, CGRectGetMaxY(tripCell2.myAvatar.frame)+10, CGRectGetWidth(self.view.frame)-20,[self G_heightForString:rc.content]+30);
        tripCell2.myTrip_rating.text = [NSString stringWithFormat:@"评分:%@",rc.rating];
        UserModel *user = [[UserModel alloc] init];
         [user setValuesForKeysWithDictionary: rc.user];
        
        
        tripCell2.myUser_Name.text = user.name;
        [tripCell2.myAvatar sd_setImageWithURL:[NSURL URLWithString:user.avatar_l] placeholderImage:[UIImage imageNamed:@"picholder"]];
          tripCell2.myLevel_info_Value.text =[NSString stringWithFormat:@"Lv:%@",[[user.experience valueForKey:@"level_info"] valueForKey:@"value"]];
       
        
        
        return tripCell2;
    }
    return cell;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.view.tag == 0) {
 
        NSMutableArray *trips = self.tripsArr[indexPath.row];
        NSInteger imgscount = [trips[2] count];
        NSInteger discount = [GGxTools arraytoint:imgscount];
        if ([trips[1] isEqualToString:@""]) {
            return 86+discount;
        }else{
            
//            NSLog(@"%f",[self G_heightForString:trips[1]]);
////            if ([self G_heightForString:trips[1]]<50) {
////                return 136+  CGRectGetWidth(self.view.frame)/3;
////            }
            return 116+ [self G_heightForString:trips[1]]+discount;
        }
       
    }
    if (self.view.tag == 1) {
        recommendedModel *rc = self.G_recommended_reasonArr[indexPath.row];
        return [self G_heightForString:rc.content]+120;
    }
    
    
    return 1;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
     NSLog(@"%ld====%ld",(long)indexPath.section,(long)indexPath.row);
    
}

-(CGFloat)G_heightForString:(NSString *)aString
{
    NSDictionary *dict = @{NSFontAttributeName:[UIFont systemFontOfSize:17.2]};// 一定要大于等于实际的字体
    //将传进来的字符串放在一个矩形中
    CGRect rect = [aString boundingRectWithSize:CGSizeMake(CGRectGetWidth(self.view.frame)-40, 2000) options:NSStringDrawingUsesLineFragmentOrigin attributes:dict context:nil];
    return rect.size.height;
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
