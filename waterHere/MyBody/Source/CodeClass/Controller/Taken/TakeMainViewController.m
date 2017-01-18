//
//  TakeTableViewController.m
//  ZouZou
//
//  Created by NISIOISIN on 15/10/16.
//  Copyright © 2015年 gx110387. All rights reserved.
//

#import "TakeMainViewController.h"
#import "ProductViewController.h"
#import "KxMenu.h"
@interface TakeMainViewController ()
@property (nonatomic,strong) NSMutableArray *C_dataArray;
@property (nonatomic,strong) ProductViewController *PVC;
@property (nonatomic,strong) NSString *c_city;
@property (nonatomic,assign) BOOL closed;
@property (nonatomic,strong) UIButton *menuBtn;
//@property(nonatomic,strong)NSString *dataUTF8;

@end

@implementation TakeMainViewController
-(void)viewWillAppear:(BOOL)animated
{
     
}
- (void)viewDidLoad {
    [super viewDidLoad];
//     self.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage resizeImage:[UIImage imageNamed:@"NaviTitleImg"] withNewSize:CGSizeMake(G_Iphone6(120), G_Iphone6(26))]];
        self.navigationItem.titleView =  [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"NaviTitleImg"]];
    _menuBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _menuBtn.frame = CGRectMake(0, 0, 40, 24);
    //[menuBtn setBackgroundImage:[UIImage imageNamed:@"menu"] forState:UIControlStateNormal];
    [_menuBtn setTitle:@"北京" forState:UIControlStateNormal];
    [_menuBtn addTarget:self action:@selector(open:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem =[[UIBarButtonItem alloc] initWithCustomView:_menuBtn];
    
    [self.tableView registerClass:[TakeTableViewCell class] forCellReuseIdentifier:@"cell"];
    self.tableView.backgroundColor = GHbgWhiteColor;
    
    self.C_dataArray = [[NSMutableArray alloc]init];
    
    self.c_city = @"%E5%8C%97%E4%BA%AC";
    
    self.tableView.separatorStyle = UITableViewCellSelectionStyleNone;
   
    
    [self C_setupRefresh];
    [self reloadInputViews];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}



- (void)open:(UIButton *)sender
{
    NSArray *menuItems =
    @[
      
      [KxMenuItem menuItem:@"全部城市"
                     image:nil
                    target:nil
                    action:NULL],
      
      [KxMenuItem menuItem:@"北京"
                     image:nil
                    target:self
                    action:@selector(pushMenuItem:)],
      
      [KxMenuItem menuItem:@"上海"
                     image:nil
                    target:self
                    action:@selector(pushMenuItem:)],
      
      
      [KxMenuItem menuItem:@"深圳"
                     image:nil
                    target:self
                    action:@selector(pushMenuItem:)],
      
      [KxMenuItem menuItem:@"巴黎"
                     image:nil
                    target:self
                    action:@selector(pushMenuItem:)],
      
      [KxMenuItem menuItem:@"东京"
                     image:nil
                    target:self
                    action:@selector(pushMenuItem:)],
      
      [KxMenuItem menuItem:@"广州"
                     image:nil
                    target:self
                    action:@selector(pushMenuItem:)],
      
      [KxMenuItem menuItem:@"赫尔辛基"
                     image:nil
                    target:self
                    action:@selector(pushMenuItem:)],
      
      [KxMenuItem menuItem:@"天津"
                     image:nil
                    target:self
                    action:@selector(pushMenuItem:)],
      
      [KxMenuItem menuItem:@"武汉"
                     image:nil
                    target:self
                    action:@selector(pushMenuItem:)],
      
      [KxMenuItem menuItem:@"香港"
                     image:nil
                    target:self
                    action:@selector(pushMenuItem:)],
      
      [KxMenuItem menuItem:@"悉尼"
                     image:nil
                    target:self
                    action:@selector(pushMenuItem:)],
      ];
    
    KxMenuItem *first = menuItems[0];
    first.foreColor = [UIColor colorWithRed:104/255.0f green:155/255.0f blue:173/255.0f alpha:1.0];
    first.alignment = NSTextAlignmentCenter;
    
    [KxMenu showMenuInView:self.view
                  fromRect:sender.frame
                 menuItems:menuItems];
    
}

- (void) pushMenuItem:(KxMenuItem *)sender
{
    
    
    
   // NSLog(@"%@",sender.title);
        if ([sender.title isEqualToString:@"北京"]) {
            self.c_city = @"%E5%8C%97%E4%BA%AC";
            
            [_menuBtn setTitle:@"北京" forState:UIControlStateNormal];
    
        } else if ([sender.title isEqualToString:@"巴黎"]) {
            self.c_city = @"%E5%B7%B4%E9%BB%8E";
            [_menuBtn setTitle:@"巴黎" forState:UIControlStateNormal];
    
        } else if ([sender.title isEqualToString:@"东京"]) {
            self.c_city = @"%E4%B8%9C%E4%BA%AC";
             [_menuBtn setTitle:@"东京" forState:UIControlStateNormal];
    
        } else if ([sender.title isEqualToString:@"赫尔辛基"]) {
            self.c_city = @"%E8%B5%AB%E5%B0%94%E8%BE%9B%E5%9F%BA";
             [_menuBtn setTitle:@"赫尔辛基" forState:UIControlStateNormal];
    
        } else if ([sender.title isEqualToString:@"上海"]) {
            self.c_city = @"%E4%B8%8A%E6%B5%B7";
             [_menuBtn setTitle:@"上海" forState:UIControlStateNormal];
    
        } else if ([sender.title isEqualToString:@"深圳"]) {
           self.c_city = @"%E6%B7%B1%E5%9C%B3";
             [_menuBtn setTitle:@"深圳" forState:UIControlStateNormal];
    
        } else if ([sender.title isEqualToString:@"武汉"]) {
           self.c_city = @"%E6%AD%A6%E6%B1%89";
             [_menuBtn setTitle:@"武汉" forState:UIControlStateNormal];
    
        } else if ([sender.title isEqualToString:@"香港"]) {
           self.c_city = @"%E9%A6%99%E6%B8%AF";
             [_menuBtn setTitle:@"香港" forState:UIControlStateNormal];
    
        } else if ([sender.title isEqualToString:@"悉尼"]) {
            self.c_city = @"%E6%82%89%E5%B0%BC";
             [_menuBtn setTitle:@"悉尼" forState:UIControlStateNormal];
        
        } else if ([sender.title isEqualToString:@"广州"]) {
            self.c_city = @"%E5%B9%BF%E5%B7%9E";
             [_menuBtn setTitle:@"广州" forState:UIControlStateNormal];
        
        } else if ([sender.title isEqualToString:@"天津"]) {
            self.c_city = @"%E5%A4%A9%E6%B4%A5";
             [_menuBtn setTitle:@"天津" forState:UIControlStateNormal];
    
        }//NSLog(@"%@",_c_city);
    
    [self.tableView reloadData];
    
    [self C_getData];
 


}

-(void)C_getData
{

    self.C_dataArray = [NSMutableArray array];
    
    NSString *c_url = [NSString stringWithFormat:@"http://api.breadtrip.com/hunter/products/more/?city_name=%@&start=0",_c_city];
    
    //NSLog(@"%@",c_url);
    NSURL *url = [NSURL URLWithString:c_url];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        
        
            NSMutableDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
            NSArray *arr = [dict valueForKey:@"product_list"];
        
        
        //NSInteger Pd = [arr setValue:self forKey:@"product_"];
        
        
        
            for (NSDictionary *dict in arr) {
            Product *taken = [[Product alloc] init];
            [taken setValuesForKeysWithDictionary:dict];
            NSDictionary *d = [dict objectForKey:@"user"];
            [taken setValuesForKeysWithDictionary:d];
            
            
            
            _PVC.pid = [dict objectForKey:@"product_id"];
            
            
            [self.C_dataArray addObject:taken];
           
            
        }
        [self.tableView.header endRefreshing];
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
        });
    }];
    
    

}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
 
    return self.C_dataArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
 
    
   // NSLog(@"%ld",self.C_dataArray.count);
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cell_id = @"cell";
    
    TakeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cell_id forIndexPath:indexPath];
    
    // Configure the cell...
    
    
    if (cell == nil) {
        cell = [[TakeTableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cell_id];
    }
    if (self.C_dataArray.count == 0) {
        return cell;
    }
    cell.Model = self.C_dataArray[indexPath.section];
    cell.backgroundColor = [UIColor clearColor];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
   
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return G_Iphone6(72+241+68);
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ProductViewController *productVC = [[ProductViewController alloc]init];
    Product *pd = self.C_dataArray[indexPath.section];
    productVC.pid = pd.product_id;
    //进入下一个controller
    
    [self.navigationController pushViewController:productVC animated:YES];
    
    
    
    //self.hidesBottomBarWhenPushed = YES;
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 5;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 5;
}
 
- (void)C_setupRefresh

{
    
    
    [self.tableView addLegendHeaderWithRefreshingTarget:self refreshingAction:@selector(headerRereshing) dateKey:@"table"];
    
    [self.tableView.header beginRefreshing];
    
    
    [self.tableView addLegendFooterWithRefreshingTarget:self refreshingAction:@selector(footerRereshing)];
    
    
}

#pragma mark 开始进入刷新状态
- (void)headerRereshing
{
    [self C_getData];
    
}

- (void)footerRereshing
{
    
    NSString *c_url = [NSString stringWithFormat:@"http://api.breadtrip.com/hunter/products/more/?city_name=%@&start=%ld",_c_city,self.C_dataArray.count];
    
    //NSLog(@"%@",c_url);
    NSURL *url = [NSURL URLWithString:c_url];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        
        NSMutableDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
        NSArray *arr = [dict valueForKey:@"product_list"];
        
        
        //NSInteger Pd = [arr setValue:self forKey:@"product_"];
        
        
        
        for (NSDictionary *dict in arr) {
            Product *taken = [[Product alloc] init];
            [taken setValuesForKeysWithDictionary:dict];
            NSDictionary *d = [dict objectForKey:@"user"];
            [taken setValuesForKeysWithDictionary:d];
            
            
            
            _PVC.pid = [dict objectForKey:@"product_id"];
            
            
            [self.C_dataArray addObject:taken];
           
            
        }
        [self.tableView.footer endRefreshing];
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
        });
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
