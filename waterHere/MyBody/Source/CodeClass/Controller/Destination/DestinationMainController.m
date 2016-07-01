 //
//  DestinationMainController.m
//  ZouZou
//
//  Created by lanou3g on 15/10/15.
//  Copyright (c) 2015年 lanou3g. All rights reserved.
//

#import "DestinationMainController.h"

@interface DestinationMainController ()
@property(nonatomic,strong)NSMutableArray *G_dataArray;
@property(nonatomic,strong)NSMutableArray *G_breakArr;
@property(nonatomic,strong)NSMutableArray *G_tempArr;
@property (nonatomic,strong)UIAlertView *alertView;
@property (nonatomic,retain) MBProgressHUD * hud;
@property(nonatomic,strong)CollectionViewController * collectionVc;
@property(nonatomic,strong)DestinationDailViewController *destinationDilVc;
@property(nonatomic,strong)DestinationSectionViewController  *destinationSEVc;



@end

@implementation DestinationMainController
-(void)viewWillAppear:(BOOL)animated
{
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    [self showTabBar];
    
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
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title=@"更多景点等你发现~";
    [self.tableView registerClass:[MainTableViewCell class] forCellReuseIdentifier:@"cell"];
    
    self.tableView .separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.delegate = self;
    self.tableView.backgroundColor =   [UIColor colorWithRed:251/255.0 green:247/255.0 blue:237/255.0 alpha:1];
    
   self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"刷新"   style:UIBarButtonItemStyleDone target:self action:@selector(leftBarButtonItemAction)];
    
    // by gaoxing 10-15 得到本页的数据,
    
    
   [self G_getData];
   
    
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

//   http://api.breadtrip.com/destination/v3/?last_modified_since=0

#pragma mark 获取数据并处理
-(void)G_getData
{
    self.G_dataArray = [NSMutableArray array];
    self.G_breakArr = [NSMutableArray array];
    self.G_tempArr = [NSMutableArray array];
    NSURL *url = [NSURL URLWithString:G_DestinationURL];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        if(data !=nil){
            NSMutableArray *array = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
            self.G_dataArray = [array valueForKey:@"elements"];
            
            
            for (NSDictionary *dict in self.G_dataArray) {
                NSMutableArray *temp = [NSMutableArray array];
                for (NSDictionary *d in [dict valueForKey:@"data"]) {
                    DestinationModel *destin = [[DestinationModel alloc] init];
                    [destin setValuesForKeysWithDictionary:d];
                    [temp addObject:destin];
                }
                [self.G_breakArr addObject:temp];
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self.tableView reloadData];
                });

            }
                  }else
        {
            
        }
        
    }];
    
    
    
}
#pragma mark 刷新
-(void)leftBarButtonItemAction
{
    if(self.G_breakArr.count == 0)
    {
        
    [self p_setupProgressHud];
    
     [self G_getData];
      [_hud hide:YES];
       
    }
    else
    {
        
        self.alertView = [[UIAlertView alloc]initWithTitle:@"提示"message:@"已是最新数据~" delegate:nil cancelButtonTitle:nil otherButtonTitles:nil];
        [self.alertView show];
        [NSTimer scheduledTimerWithTimeInterval:1.0f target:self selector:@selector(dismissAlertView) userInfo:nil repeats:YES];
    }
    
    
}
- (void)dismissAlertView
{
    [self.alertView dismissWithClickedButtonIndex:0 animated:YES];
}

///**
// *  集成刷新控件
// */
//- (void)setupRefresh
//{
////{     [self.tableView addLegendHeaderWithRefreshingTarget:self refreshingAction:@selector(headerRereshing) dateKey:@"table"];
////    
////    [self.tableView.header beginRefreshing];
//    
//    //1.添加刷新控件
//    UIRefreshControl *control=[[UIRefreshControl alloc]init];
//    [control addTarget:self action:@selector(refreshStateChange:) forControlEvents:UIControlEventValueChanged];
//    [self.tableView addSubview:control];
//       //2.马上进入刷新状态，并不会触发UIControlEventValueChanged事件
//    [control beginRefreshing];
//    
//    
//    
//    // 3.加载数据
//    [self refreshStateChange:control];
//
//}
//-(void)refreshStateChange:(UIRefreshControl *)control
//{
//    
//    [self G_getData];
//  
//   [control endRefreshing];
//    
//}
//#pragma mark 开始进入刷新状态
//- (void)headerRereshing
//{
//    [self G_getData];
//    [_hud hide:YES];
//    [self.tableView. header endRefreshing];
//}
//

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
    
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    // Return the number of sections.
    return self.G_breakArr.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    // Return the number of rows in the section.
    
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MainTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    if (cell ==nil) {
        cell = [[MainTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        
    }
    
    
    DestinationModel *d = self.G_breakArr[indexPath.section][indexPath.row];
    
    [cell.myImage sd_setImageWithURL:[NSURL URLWithString:d.cover_route_map_cover] placeholderImage:[UIImage imageNamed:@"picholder"]];
    cell.nameLabel.text=d.name;
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.backgroundColor =[UIColor colorWithRed:251/255.0 green:247/255.0 blue:237/255.0 alpha:1];
    
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return  CGRectGetHeight(self.tableView.frame)/3.5 ;
}
#pragma  mark 界面跳转
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    if (self.G_breakArr.count != 0) {
        
        DestinationModel *d = self.G_breakArr[indexPath.section][indexPath.row];
     //   NSLog(@"%@",[[self.G_breakArr[indexPath.section][indexPath.row] class] description] );
        if (indexPath.section == 0) {
            self.destinationDilVc  = [[DestinationDailViewController alloc] init];
            
            // [self p_setupProgressHud];
            self.destinationDilVc.G_imageURL = d.cover_route_map_cover;
            self.destinationDilVc.id1 = d.id1;
          //  NSLog(@"首页id==%@",d.id1);
            [self G_getMothData:d.type id:d.id1];
        }else
        {
            
            
            
            self.destinationSEVc  = [[DestinationSectionViewController alloc] init];
            self.destinationSEVc.G_imageURL = d.cover_route_map_cover;
            self.destinationSEVc.G_destinationmodel = d;
         //   NSLog(@"%@",d.name);
            [self.navigationController pushViewController:self.destinationSEVc animated:YES];
        }
        
    }
    NSLog(@"%ld====%ld", indexPath.section, indexPath.row);
    
    
}
//
//- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
//{
//    return [NSString stringWithFormat:@"%@",[self.G_dataArray[section] valueForKey:@"title"]] ;
//}
- (UIView *) tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    HeadtitleView *titleView = [[HeadtitleView alloc] init];
    
    titleView.backgroundColor =   [UIColor colorWithRed:251/255.0 green:247/255.0 blue:237/255.0 alpha:1];
   // titleView.titleLabel.backgroundColor = [UIColor redColor];
    [titleView.titleLabel setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
   // titleView.titleLabel.text =[NSString stringWithFormat:@"%@",[self.G_dataArray[section] valueForKey:@"title"]] ;
    [titleView.titleLabel setTitle:[NSString stringWithFormat:@"%@",[self.G_dataArray[section] valueForKey:@"title"]] forState:UIControlStateNormal];
  [ titleView.titleLabel addTarget:self action:@selector(breakButtonAction:) forControlEvents:UIControlEventTouchUpInside];
     titleView.titleLabel.tag = 100+section;

    
    titleView.breakButton.tag = 100+section;
    [ titleView.breakButton addTarget:self action:@selector(breakButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [ titleView.breakButton setBackgroundImage:[UIImage imageNamed:@"G_breakButton"] forState:UIControlStateNormal];
    // NSLog(@"%ld==== ",  section  );
    
    if ([[self.G_dataArray[section] valueForKey:@"more"] intValue]==1) {
        [ titleView.breakButton setBackgroundImage:[UIImage imageNamed:@"G_breakButton"] forState:UIControlStateNormal];
      //  NSLog(@"%@",[self.G_dataArray[titleView.breakButton.tag-100] valueForKey:@"title"]);
        
        
    }
    
    
    return titleView;
}
//by gaoxing ,10-16 界面跳转
-(void)breakButtonAction:(UIButton * )sender
{
    
    
    UICollectionViewFlowLayout *flow = [[UICollectionViewFlowLayout alloc] init];
    
    flow.itemSize = CGSizeMake(CGRectGetWidth([UIScreen mainScreen].bounds)/2.2, CGRectGetWidth([UIScreen mainScreen].bounds)/2.1);
    flow.minimumInteritemSpacing = 5;
    flow.minimumLineSpacing =10;
    flow.scrollDirection = UICollectionViewScrollDirectionVertical;
    flow.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
    
    
    
    self.collectionVc = [[CollectionViewController alloc] initWithCollectionViewLayout:flow];
    self.collectionVc.title =[self.G_dataArray[sender.tag-100] valueForKey:@"title"];
    for (int i = 0; i <self.G_breakArr.count; i++) {
        if (sender.tag -100 == i) {
            // 如果有更多地数据,那么点击首先获取数据 --> 判断是否有
            if ([[self.G_dataArray[sender.tag-100] valueForKey:@"more"] intValue]==1) {
                NSLog(@"%@",[self.G_dataArray[sender.tag-100] valueForKey:@"title"]);
                
                // 通过遍历来查找与字典中index相对应的数字
                for (int j = 0; j <self.G_breakArr.count*2; j++) {
                    // 如果相同 那么就获取数据
                    if ([[self.G_dataArray[sender.tag-100] valueForKey:@"index"] intValue]== j) {
                        //  NSLog(@"%@----%d====%ld",[self.G_dataArray[sender.tag-100] valueForKey:@"index"],j,sender.tag-100);
                        
                        [self G_getJsonData:j];
                        
                        return;
                    }
                }
                
                
            }
          //  NSLog(@"你走了么1");
            self.collectionVc.G_dataArr = self.G_breakArr[sender.tag-100];
            
            
            [self.navigationController pushViewController:self.collectionVc animated:YES];
            
        }
        
    }
    
    
    
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 40;
}
// 跳转到collection页面
-(void)G_getJsonData:(NSInteger)number
{
    
    
    
    /////
    [[G_getDestinaData shareGetDestinData] G_getJsonData:number passValue:^(NSMutableArray *array) {
        
        self.G_tempArr = array;
        self.collectionVc.G_dataArr = array;
        [self.navigationController pushViewController:self.collectionVc animated:YES];
    }];
    
}
// 调到详情页面
-(void)G_getMothData:(NSString *)type id:(NSString *)id1
{    [[G_getDestinaData shareGetDestinData] g_getMonthData:type id:id1 passValue:^(DestinationModel *destionModel) {
        self.destinationDilVc.G_destionModel = destionModel;
      //  NSLog(@"首页详情页destionModel.id==%@",destionModel.id1);
        [[G_getDestinaData shareGetDestinData] G_getInfoData:0 id:id1 count:5 passValue:^(NSMutableArray *array) {
           self.destinationDilVc.G_tripsArr =array;
            
        //    NSLog(@"准备跳入下一页,游记页面");
            [_hud hide:YES];
            [self.navigationController pushViewController:self.destinationDilVc animated:YES];
        }];
        
    }];
    
    
    
    
}
@end
