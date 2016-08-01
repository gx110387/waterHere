//
//  SixTableViewController.m
//  ZouZou
//
//  Created by hhuuqq on 15/10/23.
//  Copyright (c) 2015年 lanou3g. All rights reserved.
//

#import "SixTableViewController.h"
#import <CoreLocation/CoreLocation.h>
@interface SixTableViewController ()<CLLocationManagerDelegate,UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>

@property(nonatomic,strong)UICollectionView *collectionView;


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

@implementation SixTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    UICollectionViewFlowLayout *flow = [[UICollectionViewFlowLayout alloc] init];
    
    flow.itemSize = CGSizeMake(G_Iphone6(165),G_Iphone6(168+68));
    flow.scrollDirection = UICollectionViewScrollDirectionVertical;
    flow.minimumInteritemSpacing = 5;
    flow.minimumLineSpacing =7;
    flow.sectionInset = UIEdgeInsetsMake(10, 15, 10, 15);
    
    
    
    self.collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, MainScreenWidth, MainScreenHeight-44-64) collectionViewLayout:flow];
    self.collectionView.delegate =self;
    self.collectionView.dataSource = self;
    self.collectionView.backgroundColor = [UIColor whiteColor];
    [self.collectionView registerClass:[ActivityTableViewCell class] forCellWithReuseIdentifier:@"Cell"];
    [self.view addSubview:self.collectionView];
    
    [self H_distant];
    
    [self H_setupRefresh];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (void)H_setupRefresh
{
    [self.collectionView addLegendHeaderWithRefreshingTarget:self refreshingAction:@selector(headerRereshing) dateKey:@"table"];
    [self.collectionView.header beginRefreshing];
    [self.collectionView addLegendFooterWithRefreshingTarget:self refreshingAction:@selector(footerRereshing)];
    
    
}

#pragma mark 开始进入刷新状态
- (void)headerRereshing
{
    [self H_data];
    
}

- (void)footerRereshing
{
    
    [[TourDataTool shareData] getNearDataWithStart:self.dataArr.count category:6 latitude:self.latitude longitude:self.longitude passValue:^(NSDictionary *dict) {
        
        NSArray *arr = [dict objectForKey:@"items"];
        for (NSDictionary *childDict in arr) {
            NearModel *model = [[NearModel alloc]init];
            [model setValuesForKeysWithDictionary:childDict];
            [self.dataArr addObject:model];
            
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.collectionView reloadData];
        });
        [self.collectionView.footer endRefreshing];
    }];
    
}
// by hqx 1023 数据处理
- (void) H_data
{
    self.dataArr = [NSMutableArray array];
    [[TourDataTool shareData] getSingleDictWithURL:[NSString stringWithFormat:@"http://api.breadtrip.com/place/pois/nearby/?category=6&start=0&count=20&latitude=%f&longitude=%f",self.latitude,self.longitude] PassValue:^(NSDictionary *dict) {
        
        NSArray *arr = [dict objectForKey:@"items"];
        for (NSDictionary *childDict in arr) {
            NearModel *model = [[NearModel alloc]init];
            [model setValuesForKeysWithDictionary:childDict];
            [self.dataArr addObject:model];
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.collectionView reloadData];
        });
        [self.collectionView.header endRefreshing];
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

#pragma mark - <UICollectionViewDataSource>

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.dataArr.count;
    
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    ActivityTableViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"Cell" forIndexPath:indexPath];
    
    if (self.dataArr.count == 0) {
        return cell;
    }
    NearModel *model = self.dataArr[indexPath.row];
    [cell getValueFromNearModel:model];
    
    
    return cell;
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    NSLog(@"%ld====%ld", indexPath.section, indexPath.row);
    
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



@end
