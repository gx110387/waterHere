//
//  TourDataTool.m
//  ZouZou
//
//  Created by hhuuqq on 15/10/15.
//  Copyright (c) 2015年 lanou3g. All rights reserved.
//

#import "TourDataTool.h"
static TourDataTool *tour = nil;
@implementation TourDataTool

+(instancetype)shareData
{
    static dispatch_once_t once_token;
    dispatch_once(&once_token, ^{
        if (tour == nil) {
            tour = [[TourDataTool alloc]init];
        }
    });
    return tour;
}


// by hqx 1016 根据url值 或取tour数据
- (void)getTourTravelDataWithURL:(NSString *)URL PassValue:(PassValue)passValue
{
        // 请求数据
        NSURL *url = [NSURL URLWithString:URL];
        NSURLRequest *request = [[NSURLRequest alloc]initWithURL:url];
        [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
            
            if(data != nil)
            {
                NSDictionary *allDict = [NSJSONSerialization JSONObjectWithData:data  options:NSJSONReadingAllowFragments error:nil];
            
                self.TourDataDict = [allDict valueForKey:@"data"];
      
                passValue(self.TourDataDict);
            }
            else
            {
                passValue(nil);
            }
        }];
        
        
        // 重点!!!
        // 这个Block是外界传入的(外界的代码放到这里来执行), 但是我们的self.dataArray可以作为参数,传递给外界的代码块中.这样,外界就能拿到我们的这个数组.
}




// by hqx 1020 根据url 获取相应字典
- (void)getSingleDictWithURL:(NSString *)URL PassValue:(PassValue)passValue
{
    NSURL *url = [NSURL URLWithString:URL];
    NSURLRequest *request = [[NSURLRequest alloc]initWithURL:url];
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        if (data != nil) {
            NSDictionary *allDict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
        passValue(allDict);

        }        
        else
            passValue(nil);
        
    }];
}


// by hqx 1024 根据传来的start值进行页面刷新
- (void) getTourMainDataWithStart:(NSString *)startID passValue:(PassValue)passValue
{
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://api.breadtrip.com/v2/index/?next_start=%@",startID]];
    NSURLRequest *request = [[NSURLRequest alloc]initWithURL:url];
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        
        if (data != nil) {
           NSDictionary *allDict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
        
            self.TourDataDict = [allDict valueForKey:@"data"];
            passValue(self.TourDataDict);
        }
        else
            passValue(nil);
    }];
}


// by hqx 1024 根据传来的start值 对全部故事界面进行更新
- (void)getStoryDataWithStart:(NSInteger)startID passValue:(PassValue)passValue
{
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://api.breadtrip.com/v2/new_trip/spot/hot/list/?start=%ld",startID]] ;
    NSURLRequest *request = [[NSURLRequest alloc]initWithURL:url];
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        
        if (data != nil) {
            NSDictionary *allDict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
        
        self.TourDataDict = [allDict valueForKey:@"data"];
        
        passValue(self.TourDataDict);
        }
        else
            passValue(nil);
        
    }];
}


// by hqx 1024 根据startID使附近数据更新
- (void)getNearDataWithStart:(NSInteger)startID category:(NSInteger)category latitude:(double)latitude longitude:(double)longitude passValue:(PassValue)passValue
{
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://api.breadtrip.com/place/pois/nearby/?category=%ld&start=%ld&count=20&latitude=%f&longitude=%f",category,startID,latitude,longitude]];
    NSLog(@"%@",[NSString stringWithFormat:@"http://api.breadtrip.com/place/pois/nearby/?category=%ld&start=%ld&count=20&latitude=%f&longitude=%f",startID,category,latitude,longitude]);
    NSURLRequest *request = [[NSURLRequest alloc]initWithURL:url];
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        if (data != nil) {
            NSDictionary *allDict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
        passValue(allDict);
        }
        
        
    }];
}



- (NSMutableDictionary *)TourDataDict
{
    if (_TourDataDict == nil) {
        _TourDataDict = [NSMutableDictionary dictionary];
    }
    return _TourDataDict;
}


// by hqx 1016 这里必须对tourTravelDateArr进行初始化
- (NSMutableArray *)TourTravelDataArr
{
    if (_TourTravelDataArr == nil) {
        _TourTravelDataArr = [NSMutableArray array];
    }
    return _TourTravelDataArr;
}

-(void)getSearchDataWithPlace:(NSString *)place passValue:(PassValue)passValue
{
    
}



@end
