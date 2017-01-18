 //
//  DestinationMainController.m
//  ZouZou
//
//  Created by gx110387 on 15/10/15.
//  Copyright (c) 2015年 gx110387. All rights reserved.
//

#import "DestinationMainController.h"

@interface DestinationMainController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property(nonatomic,strong)NSMutableArray *G_dataArray;
@property(nonatomic,strong)NSMutableArray *G_breakArr;

@property(nonatomic,strong)NSMutableArray *G_tempArr;
 @property (nonatomic,retain) MBProgressHUD * hud;
@property(nonatomic,strong)UICollectionView *collectionView;

@property(nonatomic,strong)CollectionViewController * collectionVc;
@property(nonatomic,strong)DestinationDailViewController *destinationDilVc;
@property(nonatomic,strong)DestinationSectionViewController  *destinationSEVc;



@end

@implementation DestinationMainController

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage resizeImage:[UIImage imageNamed:@"TitleImage"] withNewSize:CGSizeMake(G_Iphone6(120), G_Iphone6(26))]];
        self.navigationItem.titleView =  [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"TitleImage"]];

    
    UICollectionViewFlowLayout *flow = [[UICollectionViewFlowLayout alloc] init];
    
        flow.itemSize = CGSizeMake(G_Iphone6(164),G_Iphone6(202+10+43));
        flow.minimumInteritemSpacing = 5;
        flow.minimumLineSpacing =10;
        flow.scrollDirection = UICollectionViewScrollDirectionVertical;
        flow.sectionInset = UIEdgeInsetsMake(10, 17, 10, 17);
    
    
    self.collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, MainScreenWidth, MainScreenHeight-64) collectionViewLayout:flow];
    self.collectionView.delegate =self;
    self.collectionView.dataSource = self;
 self.collectionView.backgroundColor = CustomerColor(240, 240, 240);
  [self.collectionView registerClass:[CollectionViewCell class] forCellWithReuseIdentifier:@"Cell"];
    [self.view addSubview:self.collectionView];
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
            NSLog(@"%@",self.G_dataArray);
            
            for (NSDictionary *dict in self.G_dataArray) {
                NSMutableArray *temp = [NSMutableArray array];
                
                for (NSDictionary *d in [dict valueForKey:@"data"]) {
                    if (temp.count ==1) {
                        //
                        continue;
                    }
                    DestinationModel *destin = [[DestinationModel alloc] init];
                    [destin setValuesForKeysWithDictionary:d];
                    [temp addObject:destin];
                    [self.G_breakArr addObject:destin];
                }
                NSMutableArray *tempArr = [NSMutableArray array];
                for (NSDictionary *d in [dict valueForKey:@"data"]) {
                    
                    DestinationModel *destin = [[DestinationModel alloc] init];
                    [destin setValuesForKeysWithDictionary:d];
                    [tempArr addObject:destin];
                }
                
                [self.G_tempArr addObject:tempArr];
                
                [self.collectionView reloadData];
                
                
            }
        }else
        {
            
        }
        
    }];
    
    
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
    
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

#pragma mark - <UICollectionViewDataSource>

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
        return self.G_breakArr.count;
    
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    CollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"Cell" forIndexPath:indexPath];
    cell.moreLabel.text = [NSString stringWithFormat:@"%@",[self.G_dataArray[indexPath.row] valueForKey:@"title"]];
    DestinationModel *d = self.G_breakArr[indexPath.row];
    
    [cell.myImage sd_setImageWithURL:[NSURL URLWithString:d.cover_route_map_cover] placeholderImage:[UIImage imageNamed:@"picholder"]];
    cell.nameLabel.text=d.name;
     cell.moreButton.tag = 100+indexPath.row;
    [cell.moreButton addTarget:self action:@selector(breakButtonAction:) forControlEvents:UIControlEventTouchUpInside];
//    if ([[self.G_dataArray[indexPath.row] valueForKey:@"more"] intValue]==1) {
//        cell.moreButton.hidden = NO;
//        
//    }else
//    {
//        cell.moreButton.hidden = YES;
//    }
    
    return cell;
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
        NSLog(@"教练%ld====%ld",(long)indexPath.section,(long)indexPath.row);
    if (self.G_breakArr.count != 0) {
        
                DestinationModel *d = self.G_breakArr[indexPath.row];
             //   NSLog(@"%@",[[self.G_breakArr[indexPath.section][indexPath.row] class] description] );
        if ([d.type intValue]== 5) {
            self.destinationDilVc  = [[DestinationDailViewController alloc] init];
            
            self.destinationDilVc.G_imageURL = d.cover_route_map_cover;
            self.destinationDilVc.id1 = d.id1;
            NSLog(@"%@",d.id1);
            [self G_getMothData:d.type id:d.id1];
            
        }
        else{
                    self.destinationSEVc  = [[DestinationSectionViewController alloc] init];
                    self.destinationSEVc.G_imageURL = d.cover_route_map_cover;
                    self.destinationSEVc.G_destinationmodel = d;
                 //   NSLog(@"%@",d.name);
                    [self.navigationController pushViewController:self.destinationSEVc animated:YES];
                }
                
            }
            NSLog(@"%ld====%ld", indexPath.section, indexPath.row);
            

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
    for (int i = 0; i <self.G_tempArr.count; i++) {
        if (sender.tag -100 == i) {
            // 如果有更多地数据,那么点击首先获取数据 --> 判断是否有
            if ([[self.G_dataArray[sender.tag-100] valueForKey:@"more"] intValue]==1) {
                NSLog(@"%@",[self.G_dataArray[sender.tag-100] valueForKey:@"title"]);
                
                // 通过遍历来查找与字典中index相对应的数字
                for (int j = 0; j <self.G_tempArr.count*2; j++) {
                    // 如果相同 那么就获取数据
                    if ([[self.G_dataArray[sender.tag-100] valueForKey:@"index"] intValue]== j) {
                        //  NSLog(@"%@----%d====%ld",[self.G_dataArray[sender.tag-100] valueForKey:@"index"],j,sender.tag-100);
                        
                        [self G_getJsonData:j];
                        
                        return;
                    }
                }
                
                
            }
            //  NSLog(@"你走了么1");
            self.collectionVc.G_dataArr = self.G_tempArr[sender.tag-100];
            
            [self.navigationController pushViewController:self.collectionVc animated:YES];
            
        }
    }
    
    
}
// 跳转到collection页面
-(void)G_getJsonData:(NSInteger)number
{
    /////
    [[G_getDestinaData shareGetDestinData] G_getJsonData:number passValue:^(NSMutableArray *array) {
        
       
        self.collectionVc.G_dataArr = array;
        [self.navigationController pushViewController:self.collectionVc animated:YES];
    }];
    
}
@end
