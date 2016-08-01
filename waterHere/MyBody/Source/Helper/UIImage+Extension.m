//
//  UIButton+Common.h
//  shuaidanbao
//
//  Created by apple on 16/1/6.
//  Copyright © 2016年 sdb. All rights reserved.
//

#import "UIImage+Extension.h"
#import "UIImageView+WebCache.h"
@implementation UIImage (Extension)

+ (UIImage*)resizableImage:(NSString *)name
{
    UIImage *normal = [UIImage imageNamed:name];
    
    CGFloat imageW = normal.size.width * 0.5;
    CGFloat imageH = normal.size.height * 0.5;
    return [normal resizableImageWithCapInsets:UIEdgeInsetsMake(imageH, imageW, imageH, imageW)];
}


+ (NSData *) compressImage:(UIImage *)image toMaxLength:(NSInteger) maxLength{
    
    CGSize newSize = [self scaleImage:image withLength:300];
    UIImage *newImage = [self resizeImage:image withNewSize:newSize];
    
    CGFloat compress = 0.9f;
    NSData *data = UIImageJPEGRepresentation(newImage, compress);
    
    while (data.length > maxLength && compress > 0.01) {
        compress -= 0.02f;
        
        data = UIImageJPEGRepresentation(newImage, compress);
    }
    
    return data;
}

+ (UIImage *) resizeImage:(UIImage *) image withNewSize:(CGSize) newSize{
    
    UIGraphicsBeginImageContext(newSize);
    [image drawInRect:CGRectMake(0, 0, newSize.width, newSize.height)];
    
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return newImage;
}

+ (CGSize) scaleImage:(UIImage *) image withLength:(CGFloat) imageLength{
    
    CGFloat newWidth = 0.0f;
    CGFloat newHeight = 0.0f;
    CGFloat width = image.size.width;
    CGFloat height = image.size.height;
    
    if (width > imageLength || height > imageLength){
        
        if (width > height) {
            
            newWidth = imageLength;
            newHeight = newWidth * height / width;
            
        }else if(height > width){
            
            newHeight = imageLength;
            newWidth = newHeight * width / height;
            
        }else{
            
            newWidth = imageLength;
            newHeight = imageLength;
        }
        
    }
    
    return CGSizeMake(newWidth, newHeight);
}
+ (CGSize) scaleImage:(UIImage *) image withWidth:(CGFloat) imageWidth{
    
    CGFloat newWidth = 0.0f;
    CGFloat newHeight = 0.0f;
    CGFloat width = image.size.width;
    CGFloat height = image.size.height;
    
    if (width > imageWidth || height > imageWidth){
            newWidth = imageWidth;
            newHeight = newWidth * height / width;
       
        
    }else
    {
        newWidth = width;
        newHeight = newWidth * height / width;
    }
    
    return CGSizeMake(newWidth, newHeight);
}
+ (CGSize) scaleImageSize:(CGSize )imageSize withWidth:(CGFloat) imageWidth{
    
    CGFloat newWidth = 0.0f;
    CGFloat newHeight = 0.0f;
    CGFloat width = imageSize.width;
    CGFloat height = imageSize.height;
    
    if (width > imageWidth || height > imageWidth){
        newWidth = imageWidth;
        newHeight = newWidth * height / width;
        
        
    }else
    {
        newWidth = width;
        newHeight = newWidth * height / width;
    }
    
    return CGSizeMake(newWidth, newHeight);
}
+ (CGSize)neededSizeForPhoto:(CGSize)bubbleSize {
    //bubbleSize  原尺寸
    CGFloat maxWidth = MainScreenWidth * 0.46;
    //限制最大宽度或高度
    CGFloat imageViewW = bubbleSize.width/2;
    CGFloat imageViewH = bubbleSize.height/2;
    CGFloat factor = 1.0f;
    if(imageViewW > imageViewH){
        if(imageViewW > maxWidth){
            factor = maxWidth/imageViewW;
            imageViewW = imageViewW*factor;
            imageViewH = imageViewH*factor;
        }else{
            if(imageViewH > maxWidth){
                factor = maxWidth/imageViewH;
                imageViewW = MAX(imageViewW*factor,46.0);
                //限制宽度不能超过46.0
                imageViewH = imageViewH*factor;
            }
        }
    }
    bubbleSize = CGSizeMake(imageViewW, imageViewH);
    return bubbleSize;
}
///**
// *  设置imageView显示的图片
// *
// *  @param OriginalImageURL  原图链接
// *  @param thumbnailImageURL 小图链接
// *  @param placeholderImage  占位图片
// *  @param completedBlock    获取图片完成之后的回调block
// */
//- (void)lxn_setImageWithOriginalImageURL:(NSString *)OriginalImageURL thumbnailImageURL:(NSString *)thumbnailImageURL placeholderImage:(UIImage *)placeholderImage completed:(SDWebImageCompletionBlock)completedBlock
//{
//    // 判断下缓存中有没有高清的大图
//    UIImage *originalImage = [[SDImageCache sharedImageCache] imageFromDiskCacheForKey:OriginalImageURL];
//    if (originalImage) {    // 缓存中有高清大图
//        // 为什么要用这个方法设置图片呢?  因为这个方法设置图片会先取消这个对象的上一次网络请求, 防止因为图片下载慢的时候用户又滑动了屏幕而图片错位.  这个方法会先去缓存中找,没有找到才会继续下载
//  
//        [self sd_setImageWithURL:[NSURL URLWithString:OriginalImageURL] placeholderImage:placeholderImage completed:completedBlock];
//    } else {    // 缓存中没有大图
//        AFNetworkReachabilityManager *manager = [AFNetworkReachabilityManager sharedManager];
//        if (manager.isReachableViaWiFi) { // WIFI下, 下载大图
//            [self sd_setImageWithURL:[NSURL URLWithString:OriginalImageURL] placeholderImage:placeholderImage completed:completedBlock];
//        } else if(manager.isReachableViaWWAN) {   // 3G/4G
//            
//            BOOL alwaysDownloadOrinigalImage = [[NSUserDefaults standardUserDefaults] boolForKey:@"alwaysDownloadOrinigalImage"];
//            if (alwaysDownloadOrinigalImage) { // 设置了3G/4G环境下任然显示大图
//                [self sd_setImageWithURL:[NSURL URLWithString:OriginalImageURL] placeholderImage:placeholderImage completed:completedBlock];
//            } else {    // 下载小图
//                [self sd_setImageWithURL:[NSURL URLWithString:thumbnailImageURL] placeholderImage:placeholderImage completed:completedBlock];
//            }
//        } else {    // 没有网络
//            // 判断小图有没有缓存
//            UIImage *thumbnailImage = [[SDImageCache sharedImageCache] imageFromDiskCacheForKey:OriginalImageURL];
//            if (thumbnailImage) { // 显示小图
//                [self sd_setImageWithURL:[NSURL URLWithString:thumbnailImageURL] placeholderImage:placeholderImage completed:completedBlock];
//            } else { // 显示占位图片
//                [self sd_setImageWithURL:nil placeholderImage:placeholderImage completed:completedBlock];
//            }
//        }
//    }
//    
//}
+(UIImage *)imageFromColor:(UIColor *)color{
    CGRect rect = CGRectMake(0, 0, 1, 1);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context   = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, color.CGColor);
    CGContextFillRect(context, rect);
    UIImage * image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}
@end
