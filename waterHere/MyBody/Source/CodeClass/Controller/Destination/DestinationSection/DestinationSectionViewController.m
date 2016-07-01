//
//  DestinationSectionViewController.m
//  ZouZou
//
//  Created by lanou3g on 15/10/20.
//  Copyright (c) 2015年 lanou3g. All rights reserved.
//

#import "DestinationSectionViewController.h"



@interface DestinationSectionViewController ()<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,strong)UIImageView *zoomImageView;//变焦图片做底层
@property(nonatomic,strong)NSString *textDeail;
@property (nonatomic,strong)UIAlertView *alertView;
@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)UIButton *saveButton;
@property(nonatomic,strong) UIBarButtonItem *save;
@property(nonatomic,assign)BOOL isflog;

@end

@implementation DestinationSectionViewController
-(void)viewWillAppear:(BOOL)animated
{
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // self.view.backgroundColor = [UIColor colorWithRed:251.0 green:247.0 blue:237.0 alpha:1];
    self.view.backgroundColor = [UIColor redColor];
    self.navigationController.navigationBar.barTintColor = [UIColor orangeColor];//不能放init处
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    self.navigationItem.title = self.G_destinationmodel.name;
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"icon_nav_back_button"] style:UIBarButtonItemStyleDone target:self action:@selector(leftBarButtonItemAction)];
 
   
    
    [self G_data];
    
    [self G_creatUI];
    [self hideTabBar];
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
    
    self.tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    // self.tableView.backgroundColor = [UIColor colorWithRed:251/255.0 green:247/255.0 blue:237/255.0 alpha:1];
    self.tableView.contentInset = UIEdgeInsetsMake(ImageHight-20, 0, 0, 0);
    [self.view addSubview:self.tableView];
    
    
    
    self.tableView.tableFooterView = [[UIView alloc]init];
    
    _zoomImageView = [[UIImageView alloc]init ];
    
    [_zoomImageView sd_setImageWithURL:[NSURL URLWithString:self.G_imageURL] placeholderImage:[UIImage imageNamed:@"picholder"]];
    _zoomImageView.frame = CGRectMake(0, -ImageHight, self.view.frame.size.width, ImageHight);
    _zoomImageView.contentMode = UIViewContentModeScaleAspectFill;
    _zoomImageView.userInteractionEnabled = YES;
    [self.tableView addSubview:_zoomImageView];
    _zoomImageView.autoresizesSubviews = YES;
    
}
-(void)G_creatUI
{
    // 返回上一个页面
    UIButton *backView = [UIButton buttonWithType:UIButtonTypeSystem];
    backView.frame = CGRectMake(20, 30, 25, 25);
    [backView setBackgroundImage:[UIImage imageNamed:@"icon_nav_back_button"] forState:UIControlStateNormal];
    [backView addTarget:self action:@selector(leftBarButtonItemAction) forControlEvents:UIControlEventTouchUpInside];
    [_zoomImageView addSubview:backView];
    
//    // 收藏
//   _saveButton = [UIButton buttonWithType:UIButtonTypeSystem];
//    _saveButton.frame = CGRectMake(CGRectGetWidth(self.view.frame)-CGRectGetWidth(self.view.frame)/4, 30, 25, 25);
//    [_saveButton setBackgroundImage:[UIImage imageNamed:@"like_13x12_hl"] forState:UIControlStateNormal];
//    [_saveButton addTarget:self action:@selector(saveButtonAction) forControlEvents:UIControlEventTouchUpInside];
//    [ _zoomImageView addSubview:_saveButton];
    
    // 分享
    UIButton *shareButton = [UIButton buttonWithType:UIButtonTypeSystem];
    shareButton.frame = CGRectMake(CGRectGetWidth(self.view.frame)-CGRectGetWidth(self.view.frame)/4+30, 30, 25, 25);
    [shareButton setBackgroundImage:[UIImage imageNamed:@"share_button_image"] forState:UIControlStateNormal];
    [shareButton addTarget:self action:@selector(shareButtonAction) forControlEvents:UIControlEventTouchUpInside];
    [ _zoomImageView addSubview:shareButton];
    
    // 目的地
    UILabel *G_destionaLable = [[UILabel alloc] init];
    G_destionaLable.frame = CGRectMake(20,  ImageHight -60, 100, 40);
    G_destionaLable.font = [UIFont systemFontOfSize:24];
    // G_destionaLable.backgroundColor = [UIColor cyanColor];
    G_destionaLable.textColor = [UIColor whiteColor];
    //G_destionaLable.text = @"斯尔丽卡";
    G_destionaLable .autoresizingMask = UIViewAutoresizingFlexibleTopMargin;
    G_destionaLable.text = self.G_destinationmodel.name;
    [_zoomImageView addSubview:G_destionaLable];
    
    // 参过的数量
    UILabel *G_visitedLable = [[UILabel alloc] init];
    G_visitedLable.frame = CGRectMake(20, ImageHight-20, 200, 20);
    // G_visitedLable.font = [UIFont systemFontOfSize:24];
    //G_visitedLable.backgroundColor = [UIColor yellowColor];
    G_visitedLable.textColor = [UIColor whiteColor];
    G_visitedLable .autoresizingMask = UIViewAutoresizingFlexibleTopMargin;
    double visited = [self.G_destinationmodel.visited_count doubleValue]/10000;
    float wishto = [ self.G_destinationmodel.wish_to_go_count doubleValue]/10000;
    G_visitedLable.text = [NSString stringWithFormat:@"%.1f万 去过 / %.1f 万喜欢",visited,wishto] ;
    [_zoomImageView addSubview:G_visitedLable];
    
    
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
    
    
    [[G_shareTools shareTools]G_shareText:self shareName:self.G_destinationmodel.name reason:self.G_destinationmodel.recommended_reason imageurl:self.G_destinationmodel.cover_route_map_cover];
}


-(void)saveButtonAction
{
    NSLog(@"收藏");
    
   
}
- (void)dismissAlertView
{
    [self.alertView dismissWithClickedButtonIndex:0 animated:YES];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    CGFloat y = scrollView.contentOffset.y;//+NavigationBarHight;//根据实际选择加不加上NavigationBarHight（44、64 或者没有导航条）
    if (y < -ImageHight) {
        CGRect frame = _zoomImageView.frame;
        frame.origin.y = y;
        frame.size.height =  -y;//contentMode = UIViewContentModeScaleAspectFill时，高度改变宽度也跟着改变
        _zoomImageView.frame = frame;
    }
    // NSLog(@"%f",y);
    if (y >= 25) {
        
        //   [self.navigationController setNavigationBarHidden:NO animated:YES];
        
    }else{
        // [self.navigationController setNavigationBarHidden:YES animated:YES];
        
    }
    
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 5;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"cell"];
    if(cell==nil){
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.separatorInset=UIEdgeInsetsZero;
        cell.clipsToBounds = YES;
    }
    cell.backgroundColor =[UIColor colorWithRed:251/255.0 green:247/255.0 blue:237/255.0 alpha:1];
    if (indexPath.section == 0) {
        cell.imageView.image = [UIImage imageNamed:@"jingpin.jpeg"];
        cell.textLabel.text = [NSString stringWithFormat:@"精品游记J"];
        
    }
    if (indexPath.section == 1) {
        cell.imageView.image = [UIImage imageNamed:@"lvxing.jpeg"];
        cell.textLabel.text  = [NSString stringWithFormat:@"旅行地点L"];
    }
    
    if (indexPath.section == 2) {
        cell.imageView.image = [UIImage imageNamed:@"shiyong.jpg"];
        cell.textLabel.text =  [NSString stringWithFormat:@"实用须知S"];
    }
    
    if (indexPath.section == 3) {
        cell.imageView.image = [UIImage imageNamed:@"buke.jpg"];
        cell.textLabel.text =  [NSString stringWithFormat:@"不可错过B"];
    }
    if (indexPath.section == 4) {
        cell.imageView.image = [UIImage imageNamed:@"tuijian.jpg"];
        cell.textLabel.text =  [NSString stringWithFormat:@"推荐路线T"];
    }
    
    
    
    
    
    //  cell.textLabel.text = [NSString stringWithFormat:@"第 %ld 行",indexPath.row];
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    return 100;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"%ld====%ld",(long)indexPath.section,(long)indexPath.section);
    if (indexPath.section == 0) {
        // 精品游记
        DesTripsSectionFirstTableViewController *tripsSectionVC = [[DesTripsSectionFirstTableViewController alloc] initWithStyle:UITableViewStyleGrouped];
        
        
        tripsSectionVC.G_CountyName = self.G_destinationmodel.id1;
        tripsSectionVC.G_type = self.G_destinationmodel.type;
        NSLog(@"%@",self.G_destinationmodel.id1);
        [self.navigationController pushViewController:tripsSectionVC animated:YES];
        
        
        
    }
    if (indexPath.section == 1) {
        // 旅行地点
        DesTripsSectionSecondTableViewController *tripsSeSectionVC =[[DesTripsSectionSecondTableViewController alloc] initWithStyle:UITableViewStyleGrouped];
        tripsSeSectionVC.G_GountyName = self.G_destinationmodel.id1;
        tripsSeSectionVC.G_type = self.G_destinationmodel.type;
        [self.navigationController pushViewController: tripsSeSectionVC animated:YES];
        
        
    }
    
    if (indexPath.section == 2) {
        
        [self.navigationController setNavigationBarHidden:NO animated:YES];
        DesWebViewController *deswebVC = [[DesWebViewController alloc] init];
        deswebVC.typeString =@"S";
        NSString*s = [self.G_destinationmodel.url substringFromIndex:7];
        // NSLog(@"%@",s);
        deswebVC.shiyongString =s;
        
        [self.navigationController pushViewController:deswebVC animated:YES];
        
    }
    
    if (indexPath.section == 3) {
        
        DesWebViewController *deswebVC = [[DesWebViewController alloc] init];
        deswebVC.typeString =@"B";
        NSString*s = [self.G_destinationmodel.url substringFromIndex:7];
        //  NSLog(@"%@",s);
        deswebVC.shiyongString =s;
        [self.navigationController pushViewController:deswebVC animated:YES];
    }
    if (indexPath.section == 4) {
        
        DesWebViewController *deswebVC = [[DesWebViewController alloc] init];
        deswebVC.typeString =@"T";
        NSString*s = [self.G_destinationmodel.url substringFromIndex:7];
        // NSLog(@"%@",s);
        deswebVC.shiyongString =s;
        
        [self.navigationController pushViewController:deswebVC animated:YES];
    }
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 1;
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
