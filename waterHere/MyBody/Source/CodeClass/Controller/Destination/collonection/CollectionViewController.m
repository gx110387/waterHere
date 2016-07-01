//
//  CollectionViewController.m
//  ZouZou
//
//  Created by lanou3g on 15/10/16.
//  Copyright (c) 2015年 lanou3g. All rights reserved.
//

#import "CollectionViewController.h"

@interface CollectionViewController ()
@property(nonatomic,strong)DestinationDailViewController *destinationDilVc;
@property(nonatomic,strong)FirstCollectionViewController *firstCollectionVC;
@property(nonatomic,strong)DestinationSectionViewController  *destinationSEVc;
@end

@implementation CollectionViewController

static NSString * const reuseIdentifier = @"Cell";
-(void)viewWillAppear:(BOOL)animated
{
     [self.navigationController setNavigationBarHidden:NO animated:YES];
}
- (void)viewDidLoad {
    [super viewDidLoad];
     self.collectionView.backgroundColor = [UIColor colorWithRed:251/255.0 green:247/255.0 blue:237/255.0 alpha:1];
  
       [self.collectionView registerClass:[CollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"icon_nav_back_button"] style:UIBarButtonItemStyleDone target:self action:@selector(leftBarButtonItemAction:)];
    self.navigationItem.leftBarButtonItem.tintColor = [UIColor whiteColor];
    [self hideTabBar];

   // self.navigationItem.leftBarButtonItem.b
    // Do any additional setup after loading the view.
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
-(void)leftBarButtonItemAction:(UIBarButtonItem *)sender
{
    
    NSLog(@"关闭页面,返回上一个");
    
      [self.navigationController popToRootViewControllerAnimated:YES];
    
    
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

    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {

    return self.G_dataArr.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    CollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    DestinationModel *d = self.G_dataArr[indexPath.row];
     [cell.myImage sd_setImageWithURL:[NSURL URLWithString:d.cover_s] placeholderImage:[UIImage imageNamed:@"picholder"]];
    cell.nameLabel.text = d.name;
    cell.backgroundColor = [UIColor colorWithRed:251/255.0 green:247/255.0 blue:237/255.0 alpha:1];
    return cell;
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
     DestinationModel *d = self.G_dataArr[indexPath.row];
    if ([d.type intValue]== 5) {
        self.destinationDilVc  = [[DestinationDailViewController alloc] init];
         self.firstCollectionVC = [[FirstCollectionViewController alloc] init];
        
        self.destinationDilVc.G_imageURL = d.cover_route_map_cover;
         self.destinationDilVc.id1 = d.id1;
        NSLog(@"%@",d.id1);  
        [self G_getMothData:d.type id:d.id1];

    }
    else
    {
        
        
        self.destinationSEVc  = [[DestinationSectionViewController alloc] init];
        self.destinationSEVc.G_imageURL = d.cover_route_map_cover;
        self.destinationSEVc.G_destinationmodel = d;
        NSLog(@"%@",d.name);
        [self.navigationController pushViewController:self.destinationSEVc animated:YES];

    }
    
    NSLog(@"%@",d.name);
    
    NSLog(@"%ld====%ld",(long)indexPath.section,(long)indexPath.row);
}
-(void)G_getMothData:(NSString *)type id:(NSString *)id1
{
    [[G_getDestinaData shareGetDestinData] g_getMonthData:type id:id1 passValue:^(DestinationModel *destionModel) {
        self.destinationDilVc.G_destionModel = destionModel;
        
        [[G_getDestinaData shareGetDestinData] G_getInfoData:0 id:id1 count:5 passValue:^(NSMutableArray *array) {
            NSLog(@"准备跳入下一页,游记页面");
            
            self.destinationDilVc.G_tripsArr =array;
            self.firstCollectionVC.G_tripsArr = array;
            [self.navigationController pushViewController:self.destinationDilVc animated:YES];
            
        }];

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
