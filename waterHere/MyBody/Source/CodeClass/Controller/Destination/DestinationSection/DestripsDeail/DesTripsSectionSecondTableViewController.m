//
//  DesTripsSectionSecondTableViewController.m
//  ZouZou
//
//  Created by lanou3g on 15/10/22.
//  Copyright (c) 2015年 lanou3g. All rights reserved.
//

#import "DesTripsSectionSecondTableViewController.h"

@interface DesTripsSectionSecondTableViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>
@property(nonatomic,strong)UICollectionView *collectionView;

@property(nonatomic,strong)NSMutableArray *G_getDataArr;
@property(nonatomic,strong)DestinationDailViewController *destinationDilVc;
@property (nonatomic,retain) MBProgressHUD * hud;
@end

@implementation DesTripsSectionSecondTableViewController
 
- (void)viewDidLoad {
    [super viewDidLoad];
    self.G_getDataArr = [NSMutableArray array];
   
    
    UICollectionViewFlowLayout *flow = [[UICollectionViewFlowLayout alloc] init];
    
    flow.itemSize = CGSizeMake(G_Iphone6(165),G_Iphone6(168+68));
    flow.minimumInteritemSpacing = 5;
    flow.minimumLineSpacing =7;
    flow.scrollDirection = UICollectionViewScrollDirectionVertical;
    flow.sectionInset = UIEdgeInsetsMake(10, 15, 10, 15);
    
    
    
    self.collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, MainScreenWidth, MainScreenHeight-44-64) collectionViewLayout:flow];
    self.collectionView.delegate =self;
    self.collectionView.dataSource = self;
    self.collectionView.backgroundColor = [UIColor whiteColor];
    [self.collectionView registerClass:[ActivityTableViewCell class] forCellWithReuseIdentifier:@"Cell"];
    [self.view addSubview:self.collectionView];

    
    [self setupRefresh];
    
  }
/**
 *  集成刷新控件
 */
- (void)setupRefresh
{
     [self.collectionView addLegendHeaderWithRefreshingTarget:self refreshingAction:@selector(headerRereshing) dateKey:@"table"];
     [self.collectionView.header beginRefreshing];
    
    [self.collectionView addLegendFooterWithRefreshingTarget:self refreshingAction:@selector(footerRereshing)];
  
}

#pragma mark 开始进入刷新状态
- (void)headerRereshing
{
    
    NSLog(@"%@",self.G_GountyName);
    
    [[G_getDestinaData shareGetDestinData ]G_getTripsPosition:self.G_GountyName type:self.G_type forwsrdNum:0 count:20 passValue:^(NSMutableArray *array) {
        self.G_getDataArr = array;
       // NSLog(@"-----%@------",array);
        [self.collectionView reloadData];
        [self.collectionView. header endRefreshing];

    }];
    
    
    
}

- (void)footerRereshing
{
    
    
    [[G_getDestinaData shareGetDestinData ]G_getTripsPosition:self.G_GountyName  type:self.G_type forwsrdNum:self.G_getDataArr.count count:20 passValue:^(NSMutableArray *array) {
        
        [self.G_getDataArr addObjectsFromArray: array];
        [self.collectionView reloadData];
        [self.collectionView.footer endRefreshing];
        
    }];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
 
#pragma mark - <UICollectionViewDataSource>

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.G_getDataArr.count;
    
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    ActivityTableViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"Cell" forIndexPath:indexPath];
    
    if (self.G_getDataArr.count == 0) {
        return cell;
    }
    NearModel *model = self.G_getDataArr[indexPath.row];
    [cell getValueFromNearModel:model];
    
    
    return cell;
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    NearModel *model = self.G_getDataArr[indexPath.row];
    self.destinationDilVc  = [[DestinationDailViewController alloc] init];
    
    [self p_setupProgressHud];
    self.destinationDilVc.G_imageURL = model.cover_route_map_cover;
    [self G_getMothData:model.type id:model.ID];
    NSLog(@"%@===%@",model.type,model.ID);
}





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
            
            NSLog(@"准备跳入下一页,游记页面");
            self.destinationDilVc.G_tripsArr =array;
            [_hud hide:YES];
            [self.navigationController pushViewController:self.destinationDilVc animated:YES];
        }];

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
