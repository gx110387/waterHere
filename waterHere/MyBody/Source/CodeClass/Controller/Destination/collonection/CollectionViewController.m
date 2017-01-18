//
//  CollectionViewController.m
//  ZouZou
//
//  Created by gx110387 on 15/10/16.
//  Copyright (c) 2015年 gx110387. All rights reserved.
//

#import "CollectionViewController.h"

@interface CollectionViewController ()
@property(nonatomic,strong)DestinationDailViewController *destinationDilVc;

@property(nonatomic,strong)DestinationSectionViewController  *destinationSEVc;
@end

@implementation CollectionViewController

static NSString * const reuseIdentifier = @"Cell";

- (void)viewDidLoad {
    [super viewDidLoad];
//     self.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage resizeImage:[UIImage imageNamed:@"NaviTitleImg"] withNewSize:CGSizeMake(G_Iphone6(120), G_Iphone6(26))]];
        self.navigationItem.titleView =  [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"NaviTitleImg"]];
    self.collectionView.backgroundColor = CustomerColor(240, 240, 240);
       [self.collectionView registerClass:[CollectionViewCell1 class] forCellWithReuseIdentifier:reuseIdentifier];
 
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

 

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {

    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {

    return self.G_dataArr.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    CollectionViewCell1 *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
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
            
            [self.navigationController pushViewController:self.destinationDilVc animated:YES];
            
        }];

         }];
    
  
}
#pragma mark <UICollectionViewDelegate>

 
@end
