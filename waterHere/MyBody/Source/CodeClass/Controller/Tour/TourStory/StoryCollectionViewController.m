//
//  StoryCollectionViewController.m
//  ZouZou
//
//  Created by hhuuqq on 15/10/17.
//  Copyright (c) 2015年 lanou3g. All rights reserved.
//

#import "StoryCollectionViewController.h"

@interface StoryCollectionViewController ()

@property (nonatomic,strong) NSMutableArray *storyArr;

@end

@implementation StoryCollectionViewController

static NSString * const reuseIdentifier = @"Cell";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Register cell classes
    [self.collectionView registerClass:[TourStoryCollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
    
    self.collectionView.backgroundColor = [UIColor whiteColor];
    
    self.navigationItem.title = @"精选故事";
    [self H_setupRefresh];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:self action:@selector(leftAction)];
    
    
    
//    UIScrollView *scrollView = (UIScrollView *)[[self.view subviews] objectAtIndex:0];
//    scrollView.bounces = NO;
}

- (void) leftAction
{
    [self.navigationController dismissViewControllerAnimated:YES completion:^{
        
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
#warning Incomplete method implementation -- Return the number of sections
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
#warning Incomplete method implementation -- Return the number of items in the section
    return self.storyArr.count;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    TourStoryCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    if (cell == nil) {
        cell = [[TourStoryCollectionViewCell alloc]init];
    }
    StoryModel *model = self.storyArr[indexPath.row];
    [cell getValueFromStoryModel:model];
    cell.backgroundColor = [UIColor colorWithRed:0.855 green:1.000 blue:0.856 alpha:1.000];
    
    return cell;
}


// by hqx 1017 数据处理
- (void) H_data
{
    self.storyArr = [NSMutableArray array];
    [[TourDataTool shareData]getTourTravelDataWithURL:TSURL PassValue:^(NSDictionary *dict) {
        NSDictionary *allDict = dict;
        NSArray *allArr = [allDict objectForKey:@"hot_spot_list"];
        for (NSDictionary *dict in allArr) {
            StoryModel *model = [[StoryModel alloc]init];
            [model setValuesForKeysWithDictionary:dict];
            model.user = [[UserModel alloc]init];
            [model.user setValuesForKeysWithDictionary:[dict objectForKey:@"user"]];
            model.position = [[PositionModel alloc]init];
            NSDictionary *mindict =  [dict valueForKey:@"poi"];
            if ([mindict isEqual:@""]) {
                //PositionModel * position = [[PositionModel alloc] init];
            }
            else
            {
                [model.position setValuesForKeysWithDictionary:mindict];
            }
            [self.storyArr addObject:model];
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.collectionView reloadData];
        });
        [self.collectionView.header endRefreshing];
    }];
}


// by hqx 1019 设置点击事件
- (void) collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    StoryDetialViewController *sd = [[StoryDetialViewController alloc]init];
    UINavigationController *sdN = [[UINavigationController alloc]initWithRootViewController:sd];
    StoryModel *model = self.storyArr[indexPath.row];
    sd.model = [[StoryModel alloc]init];
    sd.model = model;
    [self.navigationController presentViewController:sdN animated:YES completion:^{
        
    }];
}



#pragma mark - by hqx 1024 进行刷新处理
- (void)H_setupRefresh

{
    
    [self.collectionView addLegendHeaderWithRefreshingTarget:self refreshingAction:@selector(headerRereshing) dateKey:@"table"];
    
    [self.collectionView.header beginRefreshing];
    
    [self.collectionView addLegendFooterWithRefreshingTarget:self refreshingAction:@selector(footerRereshing)];
    
}


- (void)headerRereshing
{
    [self H_data];
}

- (void)footerRereshing
{
    [[TourDataTool shareData]getStoryDataWithStart:self.storyArr.count passValue:^(NSDictionary *dict) {
        
            NSDictionary *allDict = dict;
            NSArray *allArr = [allDict objectForKey:@"hot_spot_list"];
            for (NSDictionary *dict in allArr) {
                StoryModel *model = [[StoryModel alloc]init];
                [model setValuesForKeysWithDictionary:dict];
                model.user = [[UserModel alloc]init];
                [model.user setValuesForKeysWithDictionary:[dict objectForKey:@"user"]];
                model.position = [[PositionModel alloc]init];
                NSDictionary *mindict =  [dict valueForKey:@"poi"];
                if ([mindict isEqual:@""]) {
                    //PositionModel * position = [[PositionModel alloc] init];
                }
                else
                {
                    [model.position setValuesForKeysWithDictionary:mindict];
                }
                [self.storyArr addObject:model];
            }
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.collectionView reloadData];
            });
        [self.collectionView.footer endRefreshing];
        }];
    
    
}


#pragma mark <UICollectionViewDelegate>

/*
// Uncomment this method to specify if the specified item should be highlighted during tracking
- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
	return YES;
}
*/

/*
// Uncomment this method to specify if the specified item should be selected
- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
*/

/*
// Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
- (BOOL)collectionView:(UICollectionView *)collectionView shouldShowMenuForItemAtIndexPath:(NSIndexPath *)indexPath {
	return NO;
}

- (BOOL)collectionView:(UICollectionView *)collectionView canPerformAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	return NO;
}

- (void)collectionView:(UICollectionView *)collectionView performAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	
}
*/

@end
