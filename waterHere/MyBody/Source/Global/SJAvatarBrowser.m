//
//  SJAvatarBrowser.m
//  zhitu
//
//  Created by 陈少杰 on 13-11-1.
//  Copyright (c) 2013年 聆创科技有限公司. All rights reserved.
//

#import "SJAvatarBrowser.h"
#define RGBA(r, g, b, a) [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:a]

static CGRect oldframe;
static UIImage *savephoto;
static UIButton*   _buttonSave;
@implementation SJAvatarBrowser

+(void)showImage:(UIImageView *)avatarImageView{
    UIImage *image=avatarImageView.image;
    savephoto = image;
   UIWindow *window=[UIApplication sharedApplication].keyWindow;
     UIScrollView *backgroundView=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
    oldframe=[avatarImageView convertRect:avatarImageView.bounds toView:window];
     backgroundView.backgroundColor=[UIColor blackColor];
     backgroundView.alpha=0;
    UIImageView *imageView=[[UIImageView alloc]initWithFrame:oldframe];
    imageView.userInteractionEnabled = YES;
     imageView.image=image;
    imageView.tag=1;
    [backgroundView addSubview:imageView];
    [window addSubview:backgroundView];
    
//
    imageView.contentMode = UIViewContentModeScaleAspectFit;
    
    CGFloat placeImageSizeW = imageView.image.size.width;
    CGFloat placeImageSizeH = imageView.image.size.height;

    CGRect targetTemp;
    CGFloat placeHolderH = (placeImageSizeH * [UIScreen mainScreen].bounds.size.width)/placeImageSizeW;
    if (placeHolderH <= [UIScreen mainScreen].bounds.size.height) {
        targetTemp = CGRectMake(0, ([UIScreen mainScreen].bounds.size.height - placeHolderH) * 0.5 , [UIScreen mainScreen].bounds.size.width, placeHolderH);
    } else {
        targetTemp = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, placeHolderH);
    }
    
    backgroundView.contentSize = targetTemp.size;
    backgroundView.showsVerticalScrollIndicator = NO;
        [UIView animateWithDuration:0.3 animations:^{
            imageView.frame = targetTemp;
            backgroundView.alpha=1;
        } completion:^(BOOL finished) {
    
        }];

    
    
    
    UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hideImage:)];
    
     [backgroundView addGestureRecognizer: tap];
//    
//    [UIView animateWithDuration:0.3 animations:^{
//        imageView.frame=CGRectMake(0,([UIScreen mainScreen].bounds.size.height-image.size.height*[UIScreen mainScreen].bounds.size.width/image.size.width)/2, [UIScreen mainScreen].bounds.size.width, image.size.height*[UIScreen mainScreen].bounds.size.width/image.size.width);
//        backgroundView.alpha=1;
//    } completion:^(BOOL finished) {
//        
//    }];
    
  _buttonSave = [[UIButton alloc]init];
    _buttonSave.frame = CGRectMake(20, [UIScreen mainScreen].bounds.size.height - 100, 50, 30);
    [_buttonSave setBackgroundColor:RGBA(0, 0, 0, 50.0/255)];
    [_buttonSave setTitle:@"保存" forState:UIControlStateNormal];
    [_buttonSave setTitleColor:[UIColor whiteColor]
                      forState:UIControlStateNormal];
    [_buttonSave.titleLabel setFont:[UIFont systemFontOfSize:14]];
    
    [_buttonSave setClipsToBounds:YES];
    [_buttonSave.layer setCornerRadius:2];
    [_buttonSave.layer setBorderWidth:0.5];
    [_buttonSave.layer setBorderColor:RGBA(255, 255, 255, 60.0/255).CGColor];
    [_buttonSave addTarget:self
                    action:@selector(saveImage)
          forControlEvents:UIControlEventTouchUpInside];
    [window addSubview:_buttonSave];
    
}

+(void)hideImage:(UITapGestureRecognizer*)tap{
    UIView *backgroundView=tap.view;
    UIImageView *imageView=(UIImageView*)[tap.view viewWithTag:1];
    [UIView animateWithDuration:0.3 animations:^{
        imageView.frame=oldframe;
        backgroundView.alpha=0;
    } completion:^(BOOL finished) {
        [backgroundView removeFromSuperview];
        [_buttonSave removeFromSuperview];
    }];
}
+(void)saveImage
{
   
    
    UIImageWriteToSavedPhotosAlbum(savephoto,
                                   self,
                                   @selector(savedPhotosAlbumWithImage:didFinishSavingWithError:contextInfo:),
                                   NULL);
   }



#pragma mark - 2.保存到相册
+(void)savedPhotosAlbumWithImage:(UIImage *)image
        didFinishSavingWithError:(NSError *)error
                     contextInfo:(void *)contextInfo
{
    if (error) {
        [SVProgressHUD showErrorWithStatus:@"保存图片失败" maskType:3];
    }else {
        [SVProgressHUD showSuccessWithStatus:@"保存图片成功" maskType:3];
        
    }
}



@end
