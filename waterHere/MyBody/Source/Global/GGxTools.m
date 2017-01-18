//
//  GGxTools.m
//  GaoHeng
//
//  Created by hua on 16/5/10.
//  Copyright © 2016年 heyudongfang. All rights reserved.
//

#import "GGxTools.h"
 

@implementation GGxTools
///UIView截图
+(UIImage*)captureView:(UIView *)theView{
    CGRect rect = theView.frame;
    if ([theView isKindOfClass:[UIScrollView class]]) {
        rect.size = ((UIScrollView *)theView).contentSize;
    }
    
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    [theView.layer renderInContext:context];
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return img;
}

///UIScrollview截图

+ (UIImage *)captureScrollView:(UIScrollView *)scrollView{
    UIImage* image = nil;
    UIGraphicsBeginImageContext(scrollView.contentSize);
    {
        CGPoint savedContentOffset = scrollView.contentOffset;
        CGRect savedFrame = scrollView.frame;
        scrollView.contentOffset = CGPointZero;
        scrollView.frame = CGRectMake(0, 0, scrollView.contentSize.width, scrollView.contentSize.height);
        
        [scrollView.layer renderInContext: UIGraphicsGetCurrentContext()];
        image = UIGraphicsGetImageFromCurrentImageContext();
        
        scrollView.contentOffset = savedContentOffset;
        scrollView.frame = savedFrame;
    }
    UIGraphicsEndImageContext();
    
    if (image != nil) {
        return image;
    }
    return nil;
}
///合并多张图片

+(UIImage *)composeWithHeader:(UIImage *)header content:(UIImage *)content footer:(UIImage *)footer{
    CGSize size = CGSizeMake(content.size.width, header.size.height +content.size.height +footer.size.height);
//    UIGraphicsBeginImageContext(size);
     UIGraphicsBeginImageContextWithOptions(size, YES, 0);
    [header drawInRect:CGRectMake(0,
                                  0,
                                  header.size.width,
                                  header.size.height)];
    [content drawInRect:CGRectMake(0,
                                   header.size.height,
                                   content.size.width,
                                   content.size.height)];
    [footer drawInRect:CGRectMake(0,
                                  header.size.height+content.size.height,
                                  footer.size.width,
                                  footer.size.height)];
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}
///合并2张图片

+(UIImage *)composeWithHeader:(UIImage *)content footer:(UIImage *)footer{
    CGSize size = CGSizeMake(content.size.width, content.size.height +footer.size.height);
   // UIGraphicsBeginImageContext(size);
 UIGraphicsBeginImageContextWithOptions(size, YES, 0);
    [content drawInRect:CGRectMake(0,
                                   0,
                                   content.size.width,
                                   content.size.height)];
    [footer drawInRect:CGRectMake(0,
                                 content.size.height,
                                  footer.size.width,
                                  footer.size.height)];
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}
///流媒体 将音频、图片转成base64Binary
+(NSData *)base64Encoded:(NSData *)data
{
    //base64binary(流媒体)
    
    static char encodingTable[64] = {
        'A','B','C','D','E','F','G','H','I','J','K','L','M','N','O','P',
        'Q','R','S','T','U','V','W','X','Y','Z','a','b','c','d','e','f',
        'g','h','i','j','k','l','m','n','o','p','q','r','s','t','u','v',
        'w','x','y','z','0','1','2','3','4','5','6','7','8','9','+','/' };
    
    
    const unsigned char *bytes = [data bytes];
    NSMutableString *result = [NSMutableString stringWithCapacity:[data length]];
    unsigned long ixtext = 0;
    unsigned long lentext = [data length];
    long ctremaining = 0;
    unsigned char inbuf[3], outbuf[4];
    unsigned short i = 0;
    unsigned short charsonline = 0, ctcopy = 0;
    unsigned long ix = 0;
    
    while( YES )
    {
        ctremaining = lentext - ixtext;
        if( ctremaining <= 0 ) break;
        
        for( i = 0; i < 3; i++ ) {
            ix = ixtext + i;
            if( ix < lentext ) inbuf[i] = bytes[ix];
            else inbuf [i] = 0;
        }
        
        outbuf [0] = (inbuf [0] & 0xFC) >> 2;
        outbuf [1] = ((inbuf [0] & 0x03) << 4) | ((inbuf [1] & 0xF0) >> 4);
        outbuf [2] = ((inbuf [1] & 0x0F) << 2) | ((inbuf [2] & 0xC0) >> 6);
        outbuf [3] = inbuf [2] & 0x3F;
        ctcopy = 4;
        
        switch( ctremaining )
        {
            case 1:
                ctcopy = 2;
                break;
            case 2:
                ctcopy = 3;
                break;
        }
        
        for( i = 0; i < ctcopy; i++ )
            [result appendFormat:@"%c", encodingTable[outbuf[i]]];
        
        for( i = ctcopy; i < 4; i++ )
            [result appendString:@"="];
        
        ixtext += 3;
        charsonline += 4;
    }
    
    return [result dataUsingEncoding:NSUTF8StringEncoding];
}
+(NSString *)loadingFile:(NSURL *)filepath
{
    NSData * data = [[NSData alloc]initWithContentsOfURL:filepath];
    NSData * base64Data = [self base64Encoded:data];
    NSString * strBase64 = [[NSString alloc]initWithData:base64Data encoding:NSASCIIStringEncoding];
    return strBase64;
    //you can upload this base64Data to server now
}

///获得文件路径
+(NSString *)dataFilePath{
    //检索Documents目录
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask,YES);//备注1
    NSString *documentsDirectory = [paths objectAtIndex:0];//备注2
    return documentsDirectory;
}

///得到字符串的高度
+(CGFloat)G_heightForString:(NSString *)aString num:(CGFloat)font width:(NSInteger)width
{
    NSDictionary *dict = @{NSFontAttributeName:[UIFont systemFontOfSize:font]};// 一定要大于等于实际的字体
    //将传进来的字符串放在一个矩形中
    CGRect rect = [aString boundingRectWithSize:CGSizeMake(width, 16000) options:NSStringDrawingUsesLineFragmentOrigin attributes:dict context:nil];
    return rect.size.height;
}
+(NSInteger)arraytoint:(NSInteger)imgscount
{
    if (imgscount == 0) {return  0;
    }else  if (imgscount == 1) {return G_Iphone6(375);
    }else  if (imgscount == 2){return  G_Iphone6(372/2);
    }else  if (imgscount == 3){return G_Iphone6(500/2);
    }else  if (imgscount == 4){return G_Iphone6(750/2);
    }else  if (imgscount == 5){ return G_Iphone6(624/2);
    }else  if (imgscount == 6){ return G_Iphone6(498/2) ;
    }else{return G_Iphone6(750/2);    }
}

//我这里自定义了一个view
+(CGFloat)setTitleAry:(NSArray *)titleAry
{
    
    CGFloat pointX = 15.0;
    CGFloat pointY = 10.0;
       CGFloat allWidth = MainScreenWidth-G_Iphone6(60);
    UIFont *titleFont = [UIFont systemFontOfSize:15];
    for (int i = 0; i < titleAry.count; i++) {
        CGRect rect = [titleAry[i] boundingRectWithSize:CGSizeMake(MAXFLOAT, 25) options:NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName : titleFont} context:nil];
        CGFloat  width = rect.size.width + 30;
        
        if (pointX + width > allWidth) {//换行
            pointX = 15;//X从新开始
            pointY += 35;//换行后Y+
        }
        
        pointX += (width + 10);//每次X都加上button宽和间距5
        
        
    }
    
    return pointY + 35;
}
@end
