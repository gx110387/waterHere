//
//  DesTripsSectionSecondTableViewController.m
//  ZouZou
//
//  Created by lanou3g on 15/10/22.
//  Copyright (c) 2015年 lanou3g. All rights reserved.
//

#import "DesTripsSectionSecondTableViewController.h"

@interface DesTripsSectionSecondTableViewController ()
@property(nonatomic,strong)NSMutableArray *G_getDataArr;
@property(nonatomic,strong)DestinationDailViewController *destinationDilVc;
@property (nonatomic,retain) MBProgressHUD * hud;
@end

@implementation DesTripsSectionSecondTableViewController
-(void)viewWillAppear:(BOOL)animated
{
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.G_getDataArr = [NSMutableArray array];
    self.tableView.backgroundColor  = [UIColor colorWithRed:251/255.0 green:247/255.0 blue:237/255.0 alpha:1];
     //[self.tableView registerClass:[DesTripsSectonSecondTableViewCell class] forCellReuseIdentifier:@"cell"];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self setupRefresh];
    
  }
/**
 *  集成刷新控件
 */
- (void)setupRefresh

{
    
    
    [self.tableView addLegendHeaderWithRefreshingTarget:self refreshingAction:@selector(headerRereshing) dateKey:@"table"];
    
    [self.tableView.header beginRefreshing];
    
    
    [self.tableView addLegendFooterWithRefreshingTarget:self refreshingAction:@selector(footerRereshing)];
    
    
}

#pragma mark 开始进入刷新状态
- (void)headerRereshing
{
    
    NSLog(@"%@",self.G_GountyName);
    
    [[G_getDestinaData shareGetDestinData ]G_getTripsPosition:self.G_GountyName type:self.G_type forwsrdNum:0 count:20 passValue:^(NSMutableArray *array) {
        self.G_getDataArr = array;
       // NSLog(@"-----%@------",array);
        [self.tableView reloadData];
        [self.tableView. header endRefreshing];

    }];
    
    
    
}

- (void)footerRereshing
{
    
    
    [[G_getDestinaData shareGetDestinData ]G_getTripsPosition:self.G_GountyName  type:self.G_type forwsrdNum:self.G_getDataArr.count count:20 passValue:^(NSMutableArray *array) {
        
        [self.G_getDataArr addObjectsFromArray: array];
        [self.tableView reloadData];
        [self.tableView.footer endRefreshing];
        
    }];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    // Return the number of sections.
    return self.G_getDataArr.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    // Return the number of rows in the section.
    return 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    
    DesTripsSectonSecondTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" ];
    if (cell == nil) {
        cell = [[DesTripsSectonSecondTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        
            }
    DestinationModel *destin = self.G_getDataArr[indexPath.section];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.imageView.layer.masksToBounds = YES;
    [cell.myImage sd_setImageWithURL:[NSURL URLWithString:destin.cover_s] placeholderImage:[UIImage imageNamed:@"picholder"]];
    cell.myNameLabel.text = destin.name;
    cell.myRatingLabel.text = [NSString stringWithFormat:@"评分:%@~// %@点评",destin.rating,destin.rating_users];
    cell.myDescriptionLabel.text = destin.descript;
    cell.myVisited_count.text = [NSString stringWithFormat:@"%@ 人去过~",destin.visited_count];
    
    


    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
     DestinationModel *d = self.G_getDataArr[indexPath.section];
    self.destinationDilVc  = [[DestinationDailViewController alloc] init];
    
    [self p_setupProgressHud];
   
   //  self.destinationDilVc.id1 = d.id1;
    self.destinationDilVc.G_imageURL = d.cover_route_map_cover;
    NSLog(@"%@",d.id1);
    [self G_getMothData:d.type id:d.id1];

    NSLog(@"%ld ====%ld",indexPath.section,indexPath.row);
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
   
    if (CGRectGetHeight(self.view.bounds)/3.5 < 180) {
        return 180;
    }else
    {
        return CGRectGetHeight(self.view.bounds)/3.5;
    }
    
    
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
