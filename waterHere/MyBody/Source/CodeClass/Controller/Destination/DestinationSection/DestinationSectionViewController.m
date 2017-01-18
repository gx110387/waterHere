//
//  DestinationSectionViewController.m
//  ZouZou
//
//  Created by gx110387 on 15/10/20.
//  Copyright (c) 2015年 gx110387. All rights reserved.
//

#import "DestinationSectionViewController.h"

#import "DestinationSectionCell.h"


@interface DestinationSectionViewController ()<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,strong)UIImageView *zoomImageView;//变焦图片做底层
@property(nonatomic,strong)NSString *textDeail;

@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)UIButton *saveButton;
@property(nonatomic,strong) UIBarButtonItem *save;
@property(nonatomic,assign)BOOL isflog;

@end

@implementation DestinationSectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
 
    self.view.backgroundColor = [UIColor redColor];
     self.navigationItem.title = self.G_destinationmodel.name;
    self.navigationItem.rightBarButtonItem =[UIBarButtonItem itemWithTarget:self action:@selector(shareButtonAction) image:@"Ble_share" highImage:@"Ble_share"];
       [self G_data];
     [self G_creatUI];
    
}


-(void)G_data
{
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, MainScreenWidth, MainScreenHeight-64) style:UITableViewStyleGrouped];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    // self.tableView.backgroundColor = [UIColor colorWithRed:251/255.0 green:247/255.0 blue:237/255.0 alpha:1];
    self.tableView.contentInset = UIEdgeInsetsMake(ImageHight, 0, 0, 0);
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
 
    
    // 目的地
    UILabel *G_destionaLable = [[UILabel alloc] init];
    G_destionaLable.frame = CGRectMake(20,  ImageHight -80, MainScreenWidth-40, 40);
    G_destionaLable.font = [UIFont systemFontOfSize:24];
    // G_destionaLable.backgroundColor = [UIColor cyanColor];
    G_destionaLable.textColor = [UIColor whiteColor];
    //G_destionaLable.text = @"斯尔丽卡";
    G_destionaLable .autoresizingMask = UIViewAutoresizingFlexibleTopMargin;
    G_destionaLable.text = self.G_destinationmodel.name;
    [_zoomImageView addSubview:G_destionaLable];
    
    // 参过的数量
    UILabel *G_visitedLable = [[UILabel alloc] init];
    G_visitedLable.frame = CGRectMake(20, ImageHight-40, 200, 20);
    G_visitedLable.backgroundColor = [UIColor colorWithRed:251/255.0 green:247/255.0 blue:237/255.0 alpha:1];
 
   
    G_visitedLable.textColor = CustomerColorOfAlpha(85, 85, 85, 1);
    G_visitedLable .autoresizingMask = UIViewAutoresizingFlexibleTopMargin;
    double visited = [self.G_destinationmodel.visited_count doubleValue]/10000;
    float wishto = [ self.G_destinationmodel.wish_to_go_count doubleValue]/10000;
    G_visitedLable.text = [NSString stringWithFormat:@"%.1f万 去过 / %.1f 万喜欢",visited,wishto] ;
    [G_visitedLable sizeToFit];
    [_zoomImageView addSubview:G_visitedLable];
    
    
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

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    CGFloat y = scrollView.contentOffset.y;//根据实际选择加不加上NavigationBarHight（44、64 或者没有导航条）
    DDLog(@"%f",y);
    if (y < -ImageHight) {
        CGRect frame = _zoomImageView.frame;
        frame.origin.y = y;
//        frame.size.width = (-y/ImageHight)*MainScreenWidth;
      
        
        frame.size.height =  -y;//contentMode = UIViewContentModeScaleAspectFill时，高度改变宽度也跟着改变
        _zoomImageView.frame = frame;
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
    DestinationSectionCell *cell=[tableView dequeueReusableCellWithIdentifier:@"cell"];
    if(cell==nil){
        cell=[[DestinationSectionCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.separatorInset=UIEdgeInsetsZero;
        cell.clipsToBounds = YES;
    }
    NSArray *photoArr = @[@"jingpin.jpeg",@"lvxing.jpeg",@"shiyong.jpg",@"buke.jpg",@"tuijian.jpg"];
    NSArray *titleArr = @[@"精品游记",@"旅行地点",@"实用须知",@"不可错过",@"推荐路线"];
    cell.headerImg.image = [UIImage imageNamed:photoArr[indexPath.section]];
      cell.titleLable.text = titleArr[indexPath.section];
    
    
    //  cell.textLabel.text = [NSString stringWithFormat:@"第 %ld 行",indexPath.row];
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    return G_Iphone6(92);
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
         tripsSectionVC.title =@" 精品游记";
        
        tripsSectionVC.G_CountyName = self.G_destinationmodel.id1;
        tripsSectionVC.G_type = self.G_destinationmodel.type;
        NSLog(@"%@",self.G_destinationmodel.id1);
        [self.navigationController pushViewController:tripsSectionVC animated:YES];
        
        
        
    }
    if (indexPath.section == 1) {
        // 旅行地点
        DesTripsSectionSecondTableViewController *tripsSeSectionVC =[[DesTripsSectionSecondTableViewController alloc] init];
        tripsSeSectionVC.G_GountyName = self.G_destinationmodel.id1;
        tripsSeSectionVC.G_type = self.G_destinationmodel.type;
        tripsSeSectionVC.title =@" 旅行地点";
        [self.navigationController pushViewController: tripsSeSectionVC animated:YES];
        
        
    }
    
    if (indexPath.section == 2) {
        
        [self.navigationController setNavigationBarHidden:NO animated:YES];
        DesWebViewController *deswebVC = [[DesWebViewController alloc] init];
        deswebVC.typeString =@"S";
        NSString*s = [self.G_destinationmodel.url substringFromIndex:7];
        // NSLog(@"%@",s);
        deswebVC.title=@"实用须知";
        deswebVC.shiyongString =s;
        
        [self.navigationController pushViewController:deswebVC animated:YES];
        
    }
    
    if (indexPath.section == 3) {
        
        DesWebViewController *deswebVC = [[DesWebViewController alloc] init];
        deswebVC.typeString =@"B";
        NSString*s = [self.G_destinationmodel.url substringFromIndex:7];
        //  NSLog(@"%@",s);
        deswebVC.shiyongString =s;
        deswebVC.title=@"不可错过";
        [self.navigationController pushViewController:deswebVC animated:YES];
    }
    if (indexPath.section == 4) {
        
        DesWebViewController *deswebVC = [[DesWebViewController alloc] init];
        deswebVC.typeString =@"T";
        NSString*s = [self.G_destinationmodel.url substringFromIndex:7];
        // NSLog(@"%@",s);
        deswebVC.shiyongString =s;
         deswebVC.title=@"推荐路线";
        [self.navigationController pushViewController:deswebVC animated:YES];
    }
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.01;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return 10;
    }else
    {
        return 0.01;
    }
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
