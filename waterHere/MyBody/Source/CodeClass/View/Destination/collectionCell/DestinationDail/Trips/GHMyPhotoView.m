//
//  GHMyPhotoView.m
//  GaoHeng
//
//  Created by hua on 16/6/14.
//  Copyright © 2016年 heyudongfang. All rights reserved.
//

#import "GHMyPhotoView.h"
#import "SDPhotoBrowser.h"
@interface GHMyPhotoView () <SDPhotoBrowserDelegate>

@property (nonatomic, strong) NSArray *imageViewsArray;

@end
@implementation GHMyPhotoView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupView];
    }
    return self;
}
-(void)setupView
{
    
    
}
-(void)setPhotoArray:(NSArray *)photoArray
{
    for (UIImageView *img in self.subviews) {
        [img removeFromSuperview];
    }
    _photoArray = photoArray;
    NSInteger count = photoArray.count;
   
    

    if (count == 1) {
        
        UIImageView* contentImgV = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, gwidth, gheight )];
   
         [contentImgV sd_setImageWithURL:[NSURL URLWithString:_photoArray[0]] placeholderImage:G_picholder];
        contentImgV.tag = 0;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapImageView:)];
        [contentImgV addGestureRecognizer:tap];
        
        contentImgV.userInteractionEnabled = YES;
        contentImgV.contentMode = UIViewContentModeScaleAspectFill;
        contentImgV.clipsToBounds = YES;//裁剪边缘
        contentImgV.backgroundColor = [UIColor redColor];
        [self  addSubview:contentImgV];
        
        
    }
    else if (count ==2) { //375
      
        
    
        for (int i = 0 ; i <count; i++) {
            CGRect rect;
            if (i == 0) {
                rect =  CGRectMake(0, 0, G_Iphone6(372/2), G_Iphone6(372/2) );
            }else if (i == 1)
            {
                rect =  CGRectMake(G_Iphone6(372/2)+3, 0, G_Iphone6(372/2) , G_Iphone6(372/2) );
                
            }
            
            
            UIImageView* contentImgV = [[UIImageView alloc]initWithFrame:rect];
            contentImgV.tag = i;
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapImageView:)];
            [contentImgV addGestureRecognizer:tap];
            [contentImgV sd_setImageWithURL:[NSURL URLWithString:_photoArray[i]] placeholderImage:G_picholder];
            
            contentImgV.userInteractionEnabled = YES;
            contentImgV.contentMode = UIViewContentModeScaleAspectFill;
            contentImgV.clipsToBounds = YES;//裁剪边缘
            contentImgV.backgroundColor = [UIColor redColor];
            [self addSubview:contentImgV];
        }

        
    }
    else if (count ==3){
        for (int i = 0 ; i <count; i++) {
            CGRect rect;
            if (i == 0) {
                rect =   CGRectMake(0, 0,G_Iphone6(500/2), G_Iphone6(500/2));
            }else if (i == 1)
            {
                rect =   CGRectMake(G_Iphone6(500/2)+3, 0,G_Iphone6(242/2), G_Iphone6(246/2));
                
            }else if (i == 2)
            {
                rect =   CGRectMake(G_Iphone6(500/2)+3, G_Iphone6(246/2)+4,G_Iphone6(242/2), G_Iphone6(246/2));
                
            }
            
            
            UIImageView* contentImgV = [[UIImageView alloc]initWithFrame:rect];
            contentImgV.tag = i;
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapImageView:)];
            [contentImgV addGestureRecognizer:tap];
            [contentImgV sd_setImageWithURL:[NSURL URLWithString:_photoArray[i]] placeholderImage:G_picholder];
            
            contentImgV.userInteractionEnabled = YES;
            contentImgV.contentMode = UIViewContentModeScaleAspectFill;
            contentImgV.clipsToBounds = YES;//裁剪边缘
            contentImgV.backgroundColor = [UIColor redColor];
            [self addSubview:contentImgV];
        }
    }
    else if (count == 4){
        for (int i = 0 ; i <count; i++) {
            CGRect rect;
            if (i == 0) {
                rect =   CGRectMake(0, 0,G_Iphone6(372/2), G_Iphone6(372/2));
            }else if (i == 1)
            {
                rect =   CGRectMake(G_Iphone6(372/2)+3, 0,G_Iphone6(372/2), G_Iphone6(372/2));

            }else if (i == 2)
            {
                rect =   CGRectMake(0, G_Iphone6(372/2)+3,G_Iphone6(372/2), G_Iphone6(372/2));

            }else if (i == 3)
            {
                rect =   CGRectMake(G_Iphone6(372/2)+3, G_Iphone6(372/2)+3,G_Iphone6(372/2), G_Iphone6(372/2));

            }
 
            
            UIImageView* contentImgV = [[UIImageView alloc]initWithFrame:rect];
            contentImgV.tag = i;
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapImageView:)];
            [contentImgV addGestureRecognizer:tap];
            [contentImgV sd_setImageWithURL:[NSURL URLWithString:_photoArray[i]] placeholderImage:G_picholder];
            
            contentImgV.userInteractionEnabled = YES;
            contentImgV.contentMode = UIViewContentModeScaleAspectFill;
            contentImgV.clipsToBounds = YES;//裁剪边缘
            contentImgV.backgroundColor = [UIColor redColor];
            [self addSubview:contentImgV];
        }
        
    }
    else if (count == 5)
    {    for (int i = 0 ; i <count; i++) {
        CGRect rect;
        if (i == 0) {
            rect =   CGRectMake(0, 0,G_Iphone6(372/2), G_Iphone6(372/2));
        }else if (i == 1)
        {
            rect =   CGRectMake(G_Iphone6(372/2)+3, 0,G_Iphone6(372/2), G_Iphone6(370/2));
            
        }else if (i >1)
        {
             rect =   CGRectMake(0+(i-2)*(G_Iphone6(246/2)+3), G_Iphone6(372/2)+3 ,G_Iphone6(246/2), G_Iphone6(246/2));
            
        }
        
        
        UIImageView* contentImgV = [[UIImageView alloc]initWithFrame:rect];
        contentImgV.tag = i;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapImageView:)];
        [contentImgV addGestureRecognizer:tap];
        [contentImgV sd_setImageWithURL:[NSURL URLWithString:_photoArray[i]] placeholderImage:G_picholder];
        
        contentImgV.userInteractionEnabled = YES;
        contentImgV.contentMode = UIViewContentModeScaleAspectFill;
        contentImgV.clipsToBounds = YES;//裁剪边缘
        contentImgV.backgroundColor = [UIColor redColor];
        [self addSubview:contentImgV];
    }
        
    }else if (count == 6)
    {
        for (int i = 0 ; i <count; i++) {
            CGRect rect;
            if (i <3) {
                rect =   CGRectMake(0+i*(G_Iphone6(246/2)+3), 0 ,G_Iphone6(246/2), G_Iphone6(246/2));
            }else
            {
                rect =   CGRectMake(0+(i-3)*(G_Iphone6(246/2)+3), G_Iphone6(246/2)+3 ,G_Iphone6(246/2), G_Iphone6(246/2));
                
            }
            
            UIImageView* contentImgV = [[UIImageView alloc]initWithFrame:rect];
            contentImgV.tag = i;
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapImageView:)];
            [contentImgV addGestureRecognizer:tap];
            [contentImgV sd_setImageWithURL:[NSURL URLWithString:_photoArray[i]] placeholderImage:G_picholder];
            
            contentImgV.userInteractionEnabled = YES;
            contentImgV.contentMode = UIViewContentModeScaleAspectFill;
            contentImgV.clipsToBounds = YES;//裁剪边缘
            contentImgV.backgroundColor = [UIColor redColor];
            [self addSubview:contentImgV];
        }
    }else  
    {
        for (int i = 0 ; i <count; i++) {
            CGRect rect;
            if (i <3) {
                rect =   CGRectMake(0+i*(G_Iphone6(246/2)+3), 0 ,G_Iphone6(246/2), G_Iphone6(246/2));
            }else if (i <6)
            {
                rect =   CGRectMake(0+(i-3)*(G_Iphone6(246/2)+3), G_Iphone6(246/2)+3 ,G_Iphone6(246/2), G_Iphone6(246/2));
                
            }else
            {
                rect =   CGRectMake(0+(i-6)*(G_Iphone6(246/2)+3),( G_Iphone6(246/2)+3)*2 ,G_Iphone6(246/2), G_Iphone6(246/2));
                
            }
            
            UIImageView* contentImgV = [[UIImageView alloc]initWithFrame:rect];
            contentImgV.tag = i;
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapImageView:)];
            [contentImgV addGestureRecognizer:tap];
            [contentImgV sd_setImageWithURL:[NSURL URLWithString:_photoArray[i]] placeholderImage:G_picholder];
            
            contentImgV.userInteractionEnabled = YES;
            contentImgV.contentMode = UIViewContentModeScaleAspectFill;
            contentImgV.clipsToBounds = YES;//裁剪边缘
            contentImgV.backgroundColor = [UIColor redColor];
            [self addSubview:contentImgV];
        }

    }
    
}

- (void)tapImageView:(UITapGestureRecognizer *)tap
{
    
    
    UIView *imageView = tap.view;
    SDPhotoBrowser *browser = [[SDPhotoBrowser alloc] init];
    browser.currentImageIndex = imageView.tag;
    browser.sourceImagesContainerView = self;
    browser.imageCount = _photoArray.count;
    browser.delegate = self;
    [browser show];
}
#pragma mark - SDPhotoBrowserDelegate

- (NSURL *)photoBrowser:(SDPhotoBrowser *)browser highQualityImageURLForIndex:(NSInteger)index
{
 
 
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@",_photoArray[index]]];
    return url;
}

- (UIImage *)photoBrowser:(SDPhotoBrowser *)browser placeholderImageForIndex:(NSInteger)index
{
    DoLog(@"gaoxing:%@==%ld",self.subviews,index);
    UIImageView *imageView  = self.subviews[index];
    return imageView.image;
}

@end
