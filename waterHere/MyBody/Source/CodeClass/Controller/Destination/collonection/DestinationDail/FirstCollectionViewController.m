//
//  FirstCollectionViewController.m
//  UILesson21_conllection
//
//  Created by lanou3g on 15/9/24.
//  Copyright (c) 2015年 lanou3g. All rights reserved.
//

#import "FirstCollectionViewController.h"
#import <Photos/Photos.h>

@interface FirstCollectionViewController ()
@property(nonatomic)NSMutableArray *G_collecArr;
@end

@implementation FirstCollectionViewController

static NSString * const reuseIdentifier = @"Cell";

- (void)segmentChange {
    [self.collectionView reloadData];
}

/////////////////
-(instancetype)initWithCollectionViewLayout:(UICollectionViewLayout *)layout WithImageUrlArray:(NSArray *)imageUrlArray id1:(NSString *)id1
{
    if (self = [super initWithCollectionViewLayout:layout]) {
        self.G_tripsArr = imageUrlArray;
        
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.collectionView.  backgroundColor = [UIColor colorWithRed:251/255.0 green:247/255.0 blue:237/255.0 alpha:1];
    [self.collectionView registerClass:[MyCollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
    self.G_collecArr = [NSMutableArray array];
 
//    [[G_getDestinaData shareGetDestinData] G_getPhoto:self.id1 forwsrdNum:0 count:20 paddValue:^(NSMutableArray *array) {
//  
//        self.G_collecArr = array;
//        
//        NSLog(@"%@",self.id1);
//   }];

   
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
    return self.G_tripsArr.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    MyCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
     G_waypointsModel *s = self.G_tripsArr[indexPath.row];
    
    [cell.myImage sd_setImageWithURL:[NSURL URLWithString:s.photo] placeholderImage:[UIImage imageNamed:@"picholder"]];
    return cell;
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"%ld----%ld",indexPath.section ,indexPath.row);
    
    // Browser
    NSMutableArray *photos = [[NSMutableArray alloc] init];
    NSMutableArray *thumbs = [[NSMutableArray alloc] init];
   MWPhoto *photo, *thumb;
    BOOL displayActionButton = YES;
    BOOL displaySelectionButtons = NO;
    BOOL displayNavArrows = NO;
    BOOL enableGrid = YES;
    BOOL startOnGrid = NO;
    BOOL autoPlayOnAppear = NO;
 
    
    for (int i = 0; i <self.G_tripsArr.count; i++) {
      NSString * string = [NSString stringWithFormat:@"%@",[self.G_tripsArr[i] photo]];
     //  FirstCollectionModel * fc = self.G_tripsArr[i];
        
       // NSLog(@"%ld",self.G_tripsArr.count);
        
        
        
        // Photos
        photo = [MWPhoto  photoWithURL:[NSURL URLWithString:string]];
     //   photo.caption = [NSString stringWithFormat:@"%@",fc.text];
        [photos addObject:photo];
        photo = [MWPhoto  photoWithURL:[NSURL URLWithString:string]];
        [thumbs addObject:photo];
        [self.collectionView reloadData];
    }
    

    
    
//  NSString * string = [NSString stringWithFormat:@"%@",[self.G_tripsArr[indexPath.row] photo]];
               startOnGrid = YES;
            displayNavArrows = YES;
    
    self.photos = photos;
    self.thumbs = thumbs;
    
    // Create browser
    MWPhotoBrowser *browser = [[MWPhotoBrowser alloc] initWithDelegate:self];
    browser.displayActionButton = displayActionButton;
    browser.displayNavArrows = displayNavArrows;
    browser.displaySelectionButtons = displaySelectionButtons;
    browser.alwaysShowControls = displaySelectionButtons;
    browser.zoomPhotosToFill = YES;
    browser.enableGrid = enableGrid;
    browser.startOnGrid = startOnGrid;
    browser.enableSwipeToDismiss = NO;
    browser.autoPlayOnAppear = autoPlayOnAppear;
    [browser setCurrentPhotoIndex:0];
    
       if (displaySelectionButtons) {
        _selections = [NSMutableArray new];
        for (int i = 0; i < photos.count; i++) {
            [_selections addObject:[NSNumber numberWithBool:NO]];
        }
    }
     NSLog(@"ddd");
    UINavigationController *nc = [[UINavigationController alloc] initWithRootViewController:browser];
            nc.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
            [self presentViewController:nc animated:YES completion:nil];
  
}

#pragma mark <UICollectionViewDelegate>
#pragma mark - MWPhotoBrowserDelegate

- (NSUInteger)numberOfPhotosInPhotoBrowser:(MWPhotoBrowser *)photoBrowser {
    return _photos.count;
}

- (id <MWPhoto>)photoBrowser:(MWPhotoBrowser *)photoBrowser photoAtIndex:(NSUInteger)index {
    if (index < _photos.count)
        return [_photos objectAtIndex:index];
    return nil;
}

- (id <MWPhoto>)photoBrowser:(MWPhotoBrowser *)photoBrowser thumbPhotoAtIndex:(NSUInteger)index {
    if (index < _thumbs.count)
        return [_thumbs objectAtIndex:index];
    return nil;
}

- (void)photoBrowser:(MWPhotoBrowser *)photoBrowser didDisplayPhotoAtIndex:(NSUInteger)index {
    NSLog(@"Did start viewing photo at index %lu", (unsigned long)index);
}
@end
