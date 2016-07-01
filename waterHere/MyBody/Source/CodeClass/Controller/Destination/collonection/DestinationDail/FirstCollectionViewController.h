//
//  FirstCollectionViewController.h
//  UILesson21_conllection
//
//  Created by lanou3g on 15/9/24.
//  Copyright (c) 2015年 lanou3g. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MWPhotoBrowser.h"
#import <AssetsLibrary/AssetsLibrary.h>

@interface FirstCollectionViewController : UICollectionViewController<MWPhotoBrowserDelegate> {
    //    UISegmentedControl *_segmentedControl;
    NSMutableArray *_selections;
}

@property (nonatomic, strong) NSMutableArray *photos;
@property (nonatomic, strong) NSMutableArray *thumbs;
@property (nonatomic, strong) NSMutableArray *assets;

@property (nonatomic, strong) ALAssetsLibrary *ALAssetsLibrary;

@property(nonatomic,strong)NSArray *G_tripsArr;
@property(nonatomic,strong)NSString *id1;

-(instancetype)initWithCollectionViewLayout:(UICollectionViewLayout *)layout WithImageUrlArray:(NSArray *)imageUrlArray id1:(NSString *)id1;



