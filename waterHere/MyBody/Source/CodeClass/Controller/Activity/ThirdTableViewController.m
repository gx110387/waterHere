//
//  ThirdTableViewController.m
//  ZouZou
//
//  Created by hhuuqq on 15/10/23.
//  Copyright (c) 2015年 lanou3g. All rights reserved.
//

#import "ThirdTableViewController.h"
#import <CoreLocation/CoreLocation.h>
@interface ThirdTableViewController ()<CLLocationManagerDelegate>

@property (nonatomic,retain) MBProgressHUD * hud;
// 定位管理类
@property (nonatomic,strong) CLLocationManager *manger;

// by hqx 1023 定义两个变量 分别是精度和纬度
@property (nonatomic,assign) double latitude;           // 纬度

@property (nonatomic,assign) double longitude;

// by hqx 1023 定义一个数组用于存放所有数据
@property (nonatomic,strong) NSMutableArray *dataArr;

@property(nonatomic,strong)DestinationDailViewController *destinationDilVc;
@end

@implementation ThirdTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.tableView registerClass:[ActivityTableViewCell class] forCellReuseIdentifier:@"cell"];
    [self H_distant];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self H_setupRefresh];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return self.dataArr.count;
}

// by hqx 1023 数据处理
- (void) H_data
{
    self.dataArr = [NSMutableArray array];
    [[TourDataTool shareData] getSingleDictWithURL:[NSString stringWithFormat:@"http://api.breadtrip.com/place/pois/nearby/?category=10&start=0&count=20&latitude=%f&longitude=%f",self.latitude,self.longitude] PassValue:^(NSDictionary *dict) {
        
        NSArray *arr = [dict objectForKey:@"items"];
        for (NSDictionary *childDict in arr) {
            NearModel *model = [[NearModel alloc]init];
            [model setValuesForKeysWithDictionary:childDict];
            [self.dataArr addObject:model];
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
        });
        [self.tableView.header endRefreshing];
    }];
}


// by hqx 1023 定位处理
- (void) H_distant
{
    if ([CLLocationManager locationServicesEnabled]) {
        NSLog(@"定位成功");
    }
    else
    {
        NSLog(@"定位失败");
    }
    
    // by hqx 1023 定义定位管理类
    // 新建一个定位管理类
    self.manger = [[CLLocationManager alloc]init];
    self.manger.delegate = self;
    
    // 向设备请求授权
    if ([CLLocationManager authorizationStatus] != kCLAuthorizationStatusAuthorizedWhenInUse) {
        // 向设备申请"程序使用中时,使用定位功能"
        [self.manger requestWhenInUseAuthorization];
    }
    self.manger.distanceFilter = 10;
    // 定位的精度(效果)
    self.manger.desiredAccuracy = kCLLocationAccuracyHundredMeters;
    [self.manger startUpdatingLocation];
    
}

// 发生一次定位后走的方法
- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    CLLocation *location = [locations lastObject];
    if (self.longitude == location.coordinate.longitude && self.latitude == location.coordinate.latitude) {
        return;
    }
    self.longitude = location.coordinate.longitude;
    self.latitude = location.coordinate.latitude;
    [self H_data];
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return ScreenHeight / 4;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ActivityTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        cell = [[ActivityTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    if (self.dataArr.count == 0) {
        return cell;
    }
    NearModel *model = self.dataArr[indexPath.row];
    [cell getValueFromNearModel:model];
    
    
    return cell;
}


// 点击事件
- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NearModel *model = self.dataArr[indexPath.row];
    self.destinationDilVc  = [[DestinationDailViewController alloc] init];
    [self p_setupProgressHud];
    self.destinationDilVc.G_imageURL = model.cover_route_map_cover;
    [self G_getMothData:model.type id:model.ID];
    NSLog(@"%@===%@",model.type,model.ID);
}

#pragma mark 小菊花
- (void)p_setupProgressHud
{
    self.hud = [[MBProgressHUD alloc] initWithView:self.view] ;
    _hud.frame = self.view.bounds;
    _hud.minSize = CGSizeMake(100, 100);
    _hud.mode = MBProgressHUDModeIndeterminate;
    [self.view addSubview:_hud];
    
    [_hud show:YES];
}

-(void)G_getMothData:(NSString *)type id:(NSString *)id1
{
    
    [[G_getDestinaData shareGetDestinData] g_getMonthData:type id:id1 passValue:^(DestinationModel *destionModel) {
        self.destinationDilVc.G_destionModel = destionModel;
        
        
        [[G_getDestinaData shareGetDestinData] G_getInfoData:0 id:id1 count:5 passValue:^(NSMutableArray *array) {
            
            
            self.destinationDilVc.G_tripsArr =array;
            NSLog(@"准备跳入下一页,游记页面");
            [_hud hide:YES];
            [self.navigationController pushViewController:self.destinationDilVc animated:YES];
        }];
        
    }];
    
    
    
}
- (void)showTabBar

{
    if (self.tabBarController.tabBar.hidden == NO)
    {
        return;
    }
    UIView *contentView;
    if ([[self.tabBarController.view.subviews objectAtIndex:0] isKindOfClass:[UITabBar class]])
        
        contentView = [self.tabBarController.view.subviews objectAtIndex:1];
    
    else
        
        contentView = [self.tabBarController.view.subviews objectAtIndex:0];
    contentView.frame = CGRectMake(contentView.bounds.origin.x, contentView.bounds.origin.y,  contentView.bounds.size.width, contentView.bounds.size.height - self.tabBarController.tabBar.frame.size.height);
    
    self.tabBarController.tabBar.hidden = NO;
    
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    [self showTabBar];
}


- (void)H_setupRefresh

{
    
    
    [self.tableView addLegendHeaderWithRefreshingTarget:self refreshingAction:@selector(headerRereshing) dateKey:@"table"];
    
    [self.tableView.header beginRefreshing];
    
    
    [self.tableView addLegendFooterWithRefreshingTarget:self refreshingAction:@selector(footerRereshing)];
    
    
}

#pragma mark 开始进入刷新状态
- (void)headerRereshing
{
    [self H_data];
    
}

- (void)footerRereshing
{
    
    [[TourDataTool shareData] getNearDataWithStart:self.dataArr.count category:10 latitude:self.latitude longitude:self.longitude passValue:^(NSDictionary *dict) {
        
        NSArray *arr = [dict objectForKey:@"items"];
        for (NSDictionary *childDict in arr) {
            NearModel *model = [[NearModel alloc]init];
            [model setValuesForKeysWithDictionary:childDict];
            [self.dataArr addObject:model];
            
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
        });
        [self.tableView.footer endRefreshing];
    }];
    
}
/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
