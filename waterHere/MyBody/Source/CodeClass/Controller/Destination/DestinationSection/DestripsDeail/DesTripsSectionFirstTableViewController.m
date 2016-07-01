//
//  DesTripsSectionFirstTableViewController.m
//  ZouZou
//
//  Created by lanou3g on 15/10/22.
//  Copyright (c) 2015年 lanou3g. All rights reserved.
//

#import "DesTripsSectionFirstTableViewController.h"


@interface DesTripsSectionFirstTableViewController ()
@property(nonatomic,strong)NSMutableArray *G_dataArr;
@end

@implementation DesTripsSectionFirstTableViewController
-(void)viewWillAppear:(BOOL)animated
{
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.G_dataArr = [NSMutableArray array];
    
    self.tableView.backgroundColor = [UIColor colorWithRed:251/255.0 green:247/255.0 blue:237/255.0 alpha:1];
    
    [self.tableView registerClass:[DesTripsSectionFirstTableViewCell class] forCellReuseIdentifier:@"cell"];
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
    [[G_getDestinaData shareGetDestinData]G_getTripsTravels:self.G_CountyName type:self.G_type   forwsrdNum:0 count:20 passValue:^(NSMutableArray *array) {
        
        self.G_dataArr = array;
        [self.tableView reloadData];
        [self.tableView. header endRefreshing];
        
    }];
    
    
    
}

- (void)footerRereshing
{
    
    [[G_getDestinaData shareGetDestinData]G_getTripsTravels:self.G_CountyName  type:self.G_type forwsrdNum:self.G_dataArr.count count:20 passValue:^(NSMutableArray *array) {
        
        [self.G_dataArr addObjectsFromArray: array];
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
    return self.G_dataArr.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    // Return the number of rows in the section.
    return 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    DesTripsSectionFirstTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    if (cell == nil) {
        cell = [[DesTripsSectionFirstTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    DestirpsSectionFirst *trips = self.G_dataArr[indexPath.section];
    
    [cell.myBackgroundImage sd_setImageWithURL:[NSURL URLWithString:trips.cover_image_1600] placeholderImage:[UIImage imageNamed:@"picholder"]];
     cell.selectionStyle = UITableViewCellSelectionStyleNone;
    //
    cell.myNameLabel.text = trips.name;
    //
    cell.myDataLabel.text = [NSString stringWithFormat:@"%@",[self setTimered:[trips.date_added floatValue]]];
    
    //
    cell.myDay_count.text = [NSString stringWithFormat:@"%@天",trips.day_count];
    //
    cell.myWaypoints.text = [NSString stringWithFormat:@"%@足迹",trips.waypoints];
    //
    cell.myRecommendationsLabel.text = [NSString stringWithFormat:@"%@喜欢",trips.recommendations];
    
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    TourTravelViewController *tour = [[TourTravelViewController alloc]init];
    tour.model = [[TravelNoteModel alloc]init];
    DestirpsSectionFirst *model = self.G_dataArr[indexPath.section];
    tour.model.ID = model.id1;
    NSLog(@"%@",model.id1);
    UINavigationController *tourN = [[UINavigationController alloc]initWithRootViewController:tour];
    [self.navigationController presentViewController:tourN animated:YES completion:^{
        
    }];
    
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return CGRectGetHeight(self.view.frame)/3.5;
}
-(NSString *)setTimered:(NSInteger)sender
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSDate*confromTimesp = [NSDate dateWithTimeIntervalSince1970:(NSTimeInterval)sender];
    NSString*confromTimespStr = [formatter stringFromDate:confromTimesp];
    // NSLog(@"%@",confromTimespStr);
    return confromTimespStr;
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
