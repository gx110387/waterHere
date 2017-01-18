//
//  TourMainViewController.m
//  ZouZou
//
//  Created by gx110387 on 15/10/14.
//  Copyright (c) 2015年 gx110387. All rights reserved.
//

#import "TourMainViewController.h"

@interface TourMainViewController ()<UITableViewDataSource,UITableViewDelegate,UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,UIScrollViewDelegate,SDCycleScrollViewDelegate,UITextFieldDelegate>

@property (nonatomic,strong) TourMainView *tourmain;

@property(nonatomic,strong)NSMutableArray * travelDataArray;

@property (nonatomic,strong) NSMutableArray *titleArr;

// by hqx 1017 定义一个数组用于存放故事数据

@property (nonatomic,strong) NSMutableArray *storyArr;

// by hqx 1020 图片数组与字典
@property (nonatomic,strong) NSMutableArray *photoArr;

@property (nonatomic,strong) NSMutableDictionary *photoDict;

@property (nonatomic,strong) UIWebView *webView;

// by hqx 1024 定义一个字符串用于存放刷新ID
@property (nonatomic,strong) NSString *next_start;


@end

@implementation TourMainViewController

- (void)loadView
{
    self.tourmain = [[TourMainView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    self.view = _tourmain;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setupRefresh];
    
    [self H_setUpView];
    
    
 
}


// by hqx 15-1015 设置controller的视图
- (void) H_setUpView
{
    
//    self.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage resizeImage:[UIImage imageNamed:@"NaviTitleImg"] withNewSize:CGSizeMake(G_Iphone6(120), G_Iphone6(26))]];
  
    self.navigationItem.titleView =  [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"NaviTitleImg"]];

       // by hqx 1020 设置轮播图的属性
    self.tourmain.cycleScrollView.infiniteLoop = YES;
    self.tourmain.cycleScrollView.delegate = self;
    self.tourmain.cycleScrollView.pageControlStyle = SDCycleScrollViewPageContolStyleAnimated;
    
    
    self.tourmain.bottomView.backgroundColor = [UIColor colorWithHexString:@"#F5F8FA"];
    self.tourmain.bottomView.delegate = self;
    self.tourmain.bottomView.dataSource = self;
    [self.tourmain.bottomView registerClass:[TourStoryTableViewCell class] forCellReuseIdentifier:@"cell1"];
    [self.tourmain.bottomView registerClass:[TourTravelTableViewCell class] forCellReuseIdentifier:@"cell2"];
    
    self.tourmain.bottomView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
   
    
}




// by hqx 1016 数据处理
- (void) H_data
{
    self.next_start = [NSString string];
    self.travelDataArray = [NSMutableArray array];
    self.titleArr = [NSMutableArray array];
    self.storyArr = [NSMutableArray array];
    [[TourDataTool shareData] getTourTravelDataWithURL:TMURL PassValue:^(NSDictionary *dict) {
       
        self.next_start = [dict objectForKey:@"next_start"];
        NSArray *array = [dict objectForKey:@"elements"];
        for (NSDictionary *childDict in array) {
            if ([[childDict objectForKey:@"desc"] isEqualToString:@"热门游记"] ) {
                NSArray *arr = [childDict objectForKey:@"data"];
                NSDictionary *minDict = arr[0];
                TravelNoteModel *model = [[TravelNoteModel alloc]init];
                [model setValuesForKeysWithDictionary:minDict];
                model.model  = [[UserModel alloc]init];
                NSDictionary *userDict = [minDict objectForKey:@"user"];
                [model.model setValuesForKeysWithDictionary:userDict];
                [self.travelDataArray addObject:model];
            }
            if ([[NSString stringWithFormat:@"%@",[childDict objectForKey:@"type"] ] isEqualToString:@"11"] || [[NSString stringWithFormat:@"%@",[childDict objectForKey:@"type"]] isEqualToString:@"9"]) {
                NSArray *arr = [childDict objectForKey:@"data"];
                NSDictionary *minDict = arr[0];
                NSString *s = [minDict objectForKey:@"title"];
               
                [self.titleArr addObject:s];
            }
            if ([[NSString stringWithFormat:@"%@",[childDict objectForKey:@"type"] ] isEqualToString:@"10"] ) {
                NSArray *arr = [childDict objectForKey:@"data"];
                NSDictionary *minDict = arr[0];
                StoryModel *model = [[StoryModel alloc]init];
                [model setValuesForKeysWithDictionary:minDict];
                model.user = [[UserModel alloc]init];
                [model.user setValuesForKeysWithDictionary:[minDict objectForKey:@"user"]];
                model.position = [[PositionModel alloc]init];
                NSDictionary *dict =    [minDict valueForKey:@"poi"];
                if ([dict isEqual:@""]) {
                   //PositionModel * position = [[PositionModel alloc] init];
                }
                else
                {
                    
                    [model.position setValuesForKeysWithDictionary:dict];
                }
                
                [self.storyArr addObject:model];
                
            }
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tourmain.bottomView reloadData];
        });
        [self.tourmain.bottomView.header endRefreshing];
    }];
    self.photoArr = [NSMutableArray array];
    self.photoDict = [NSMutableDictionary dictionary];
    [[TourDataTool shareData]getSingleDictWithURL:@"http://m.springtour.com/home/apphome/index" PassValue:^(NSDictionary *dict) {
        NSDictionary *reDict = [dict objectForKey:@"Response"];
        NSArray *banArr = [reDict objectForKey:@"Banners"];
        for (NSDictionary *banDict in banArr) {
            BannersModel *model = [[BannersModel alloc]init];
            [model setValuesForKeysWithDictionary:banDict];
            [self.photoArr addObject:model.ImgSrc];
            [self.photoDict setObject:model.Link forKey:model.ImgSrc];
        }
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            self.tourmain.cycleScrollView.imageURLStringsGroup = self.photoArr;
        });
    }];
    
}



#pragma mark by hqx 15-1015 设置tableView的各个代理函数
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.titleArr.count;
}


- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 1;
    }
   
     return self.travelDataArray.count;
}

// by hqx 1016 设置tableView的头视图
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *topView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 44)];
 
    topView.backgroundColor = [UIColor whiteColor];
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(G_Iphone6(17), 0, 200, 44)];
    titleLabel.font = [UIFont systemFontOfSize:15];
    titleLabel.text = self.titleArr[section];
    titleLabel.textColor = [UIColor colorWithHexString:@"#333333"];
    [topView addSubview:titleLabel];
    if (section == 0) {
        UIButton *rightButton = [ UIButton buttonwithrightIconBtn:CGRectMake(MainScreenWidth - 80, 0, 80, 44) font:11 image:@"G_BreakGrayImg" title:@"查看全部" imageInteger:70 titleColor:[UIColor colorWithHexString:@"#9F9F9F"] backgroundColor:[UIColor whiteColor]];
 
      [topView addSubview:rightButton];
        [rightButton addTarget:self action:@selector(rightAction) forControlEvents:UIControlEventTouchUpInside];
 
            }
    
    
    return topView;
    
}
- (CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 44;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        TourStoryTableViewCell *cell1 = [tableView dequeueReusableCellWithIdentifier:@"cell1"];
        if (cell1 == nil) {
            cell1 = [[TourStoryTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell1"];
        }
        [cell1.collectionView registerClass:[TourStoryCollectionViewCell class] forCellWithReuseIdentifier:@"cell3"];
        cell1.collectionView.delegate = self;
        cell1.collectionView.dataSource = self;
        cell1.collectionView.backgroundColor = [UIColor whiteColor];
        return cell1;
    }
    else
    {
        TourTravelTableViewCell *cell2 = [tableView dequeueReusableCellWithIdentifier:@"cell2"];
        if (cell2 == nil) {
            cell2 = [[TourTravelTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell2"];
        }
        TravelNoteModel *model = self.travelDataArray[indexPath.row];
        [cell2 getValueFromTravelNote:model];
        cell2.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell2;
    }
}


- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return 252+10+10+10;
    }
    else
    {
        return G_Iphone6(176+10);
    }
}






// by hqx 1019 tableViewCell的点击事件
- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return ;
    }
    TourTravelViewController *tour = [[TourTravelViewController alloc]init];
    TravelNoteModel *model = self.travelDataArray[indexPath.row];
   
    tour.model = [[TravelNoteModel alloc]init];
    tour.title = model.name;
    tour.model = model;
   
    [self.navigationController pushViewController:tour animated:YES];
}
// by hqx 1017 button右按钮事件 进行页面的跳转
- (void) rightAction
{
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
   
    StoryCollectionViewController *story = [[StoryCollectionViewController alloc]initWithCollectionViewLayout:flowLayout];

    flowLayout.itemSize = CGSizeMake(G_Iphone6(164), G_Iphone6(202+10+43));
    flowLayout.sectionInset = UIEdgeInsetsMake(G_Iphone6(10), G_Iphone6(17),G_Iphone6(10), G_Iphone6(17));

    
    [self.navigationController pushViewController:story animated:YES];
}
#pragma mark by hqx 15-1015 设置UIControllerView的各个代理函数
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}


- (NSInteger) collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    NSLog(@"%ld",(unsigned long)self.storyArr.count);
    return self.storyArr.count;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    TourStoryCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell3" forIndexPath:indexPath];
    if (cell == nil) {
        cell = [[TourStoryCollectionViewCell alloc]init];
    }
    
    StoryModel *model = self.storyArr[indexPath.row];
//    cell.backgroundColor = [UIColor colorWithRed:0.855 green:1.000 blue:0.856 alpha:1.000];
    [cell getValueFromStoryModel:model];
    cell.layer.cornerRadius = 8;
    return cell;
}


- (void) collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    StoryDetialViewController *story = [[StoryDetialViewController alloc]init];
    StoryModel *model = self.storyArr[indexPath.row];
    story.model = [[StoryModel alloc]init];
    story.model = model;
   
    [self.navigationController pushViewController:story animated:YES];
}



#pragma mark - by hqx 1020 用轮播图实现无限循环
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index
{
    NSString *photoStr = self.photoArr[index];
    NSString *urlStr = [self.photoDict objectForKey:photoStr];
    
    WebViewController *webView = [[WebViewController alloc]init];
    HWNavigationController *nc = [[HWNavigationController alloc] initWithRootViewController:webView];
    webView.urlStr = urlStr;
    //NSLog(@"%@",self.photoDict);
    [self.navigationController presentViewController:nc animated:YES completion:^{
        
    }];
}





- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - 刷新操作
- (void)setupRefresh

{
    
    
    [self.tourmain.bottomView addLegendHeaderWithRefreshingTarget:self refreshingAction:@selector(headerRereshing) dateKey:@"table"];
    
    [self.tourmain.bottomView.header beginRefreshing];
    
    
    [self.tourmain.bottomView addLegendFooterWithRefreshingTarget:self refreshingAction:@selector(footerRereshing)];
    
}


// by hqx 1024 头部刷新与尾部刷新
- (void) headerRereshing
{
    [self H_data];
}

- (void) footerRereshing
{
    [[TourDataTool shareData] getTourMainDataWithStart:self.next_start passValue:^(NSDictionary *dict) {
       
            
            self.next_start = [dict objectForKey:@"next_start"];
            NSLog(@"%@",self.next_start);
            NSArray *array = [dict objectForKey:@"elements"];
            for (NSDictionary *childDict in array) {
                if ([[childDict objectForKey:@"desc"] isEqualToString:@"热门游记"] ) {
                    NSArray *arr = [childDict objectForKey:@"data"];
                    NSDictionary *minDict = arr[0];
                    TravelNoteModel *model = [[TravelNoteModel alloc]init];
                    [model setValuesForKeysWithDictionary:minDict];
                    model.model  = [[UserModel alloc]init];
                    NSDictionary *userDict = [minDict objectForKey:@"user"];
                    [model.model setValuesForKeysWithDictionary:userDict];
                    [self.travelDataArray addObject:model];
                }
            }
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.tourmain.bottomView reloadData];
            });
            [self.tourmain.bottomView.footer endRefreshing];
        
        
    }];
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
