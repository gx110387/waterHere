//
//  G_getDestinaData.m
//  ZouZou
//
//  Created by lanou3g on 15/10/16.
//  Copyright (c) 2015年 lanou3g. All rights reserved.
//

#import "G_getDestinaData.h"
static G_getDestinaData *DSource = nil;
@interface G_getDestinaData ()
// 返回不同的城市数组
@property(nonatomic,strong)NSMutableArray *G_dataArr;
// 得到每个月每个地点的详细数据
@property(nonatomic,strong)NSMutableArray *G_MonthArr;
@property(nonatomic,strong)NSMutableArray *G_InfoArr;
@property(nonatomic,strong)NSMutableArray *G_InfoTripsArr;
@property(nonatomic,strong)NSMutableArray *G_TripsTravle;
@property(nonatomic,strong)NSMutableArray *G_TripsPosition;
@property(nonatomic,strong)NSMutableArray *G_GetPhotoArr;
@end

@implementation G_getDestinaData

+(instancetype)shareGetDestinData
{
    
    
    if (DSource ==nil) {
        static dispatch_once_t once_token;
        
        dispatch_once(&once_token, ^{
        DSource = [[G_getDestinaData alloc] init];
           
   });
         }
    return DSource;
}
#pragma mark 得到不同的数据by第一页  高星 10-16
-(void)G_getJsonData:(NSInteger)number passValue:(G_PassValue)value
{
   self.G_dataArr = [NSMutableArray array];
        
        
        NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:G_getJData,number]];
        
        NSLog(@"%@",url);
        NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
        
        [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
            
            if (data != nil) {
            
                NSMutableArray *array  = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
                
                for (NSDictionary *d in [array valueForKey:@"data"]) {
                    NSLog(@"%@",d);
                    DestinationModel *dm = [[DestinationModel alloc] init];
                    [dm setValuesForKeysWithDictionary:d];
                    [self.G_dataArr addObject:dm];
                }
                
                value(self.G_dataArr);

            
            }else {
                
                value(nil);
            }

                    }];

   }

#pragma mark 本月去撒欢的数据 高星 10-17
-(void)g_getMonthData:(NSString *)type id:(NSString *)id1 passValue:(MothValue)value
{
    self.G_MonthArr = [NSMutableArray array];
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://api.breadtrip.com/destination/place/%@/%@/",type,id1]];
    
    NSLog(@"%@",url);
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
    
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        
         if (data != nil) {
        NSDictionary *array = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
       
//              NSLog(@"id详情页%@",array);
                DestinationModel *d = [[DestinationModel alloc] init];
            [d setValuesForKeysWithDictionary:array];
     // NSLog(@"%@",array);
            value(d);
        
        
    }else {
        
        value(nil);
    }

    }];
    
}


#pragma mark  更多印象的数据 高星 10-17  http://api.breadtrip.com/destination/place/5/2388364474/poi_trips/?start=0&count=5
-(void)G_getInfoData:(NSInteger)forwardNum id:(NSString *)id1 count:(NSInteger)count passValue:(G_PassValue)value
{
    
    self.G_InfoArr = [NSMutableArray array];
     NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:G_GetIData,id1,forwardNum,count]];
      NSLog(@"%@",url);
    
 //  NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:@"http://api.breadtrip.com/destination/place/5/2387234149/poi_trips/?start=0&count=5"]];
    
    
  NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
    
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        
        if (data != nil) {
            
       
        NSDictionary *array = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
        
      
        NSMutableArray *tripsArr = [NSMutableArray array];
        for (NSDictionary *dict in [array valueForKey:@"trips"]) {
             NSMutableArray *array3 = [NSMutableArray array];
            TripsModel *trips = [[TripsModel alloc] init];
            TripModel *trip = [[TripModel alloc] init];
          
          
            [trips setValuesForKeysWithDictionary:dict];
         
            [trip setValuesForKeysWithDictionary:trips.trip];
                       NSMutableArray *waypointsArr = [NSMutableArray array];

            for (NSDictionary *dic in trips.waypoints) {
              G_waypointsModel *waypoints = [[G_waypointsModel alloc] init];
              [waypoints setValuesForKeysWithDictionary:dic];
                 // waypoints2 把类添加到数组里面
           [waypointsArr addObject:waypoints];

           }
          ///-------------------------------------
            [array3 addObject:trip];
           [array3 addObject:trips.trip_text];
         //  [array3 setValue:trips.trip_text forKey:@"trip_text"];
            [array3 addObject:waypointsArr];
            [tripsArr addObject:array3];
           }
     
            //NSLog(@"%@",array);
        
        value(tripsArr);
            
            }else {
        
        value(nil);
        }
           }];

    
}


#pragma mark  更多评价的数据 高星 10-19   http://api.breadtrip.com/destination/place/5/2388364474/tips/?start=0&count=5
-(void)G_getInfoTripsData:(NSInteger)forwardNum id:(NSString *)id1 count:(NSInteger)count passValue:(G_PassValue)value
{
     self.G_InfoTripsArr = [NSMutableArray array];
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:G_GetITripsData,id1,forwardNum,count]];
    NSLog(@"%@",url);
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
    
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        
         if (data != nil) {
        NSDictionary *array = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
        
       // NSLog(@"%@",array);
        
        for (NSDictionary *dict in [array valueForKey:@"tips"]) {
            recommendedModel *rc = [[recommendedModel alloc] init];
            [rc setValuesForKeysWithDictionary:dict];
            [self.G_InfoTripsArr addObject:rc];
                  }
        value(self.G_InfoTripsArr);
        
    }else {
        
        value(nil);
    }

                }];
    }

#pragma mark   精品游记
-(void)G_getTripsTravels:(NSString*)countyName type:(NSString *)type forwsrdNum:(NSInteger)forwardNum count:(NSInteger)count passValue:(G_PassValue)value
{
    self.G_TripsTravle = [NSMutableArray array];
    
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:G_GetTripTravle,type,countyName,forwardNum,count]];
    NSLog(@"%@",url);
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
    
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        
         if (data != nil) {
        NSDictionary *array = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
        
        for (NSDictionary *dict in [array valueForKey:@"items"]) {
            
            DestirpsSectionFirst *trips = [[DestirpsSectionFirst alloc] init];
            [trips setValuesForKeysWithDictionary:dict];
            [self.G_TripsTravle addObject:trips];
            
        }
        value(self.G_TripsTravle);
       // NSLog(@"%ld",self.G_TripsTravle.count);
        
    }else {
        
        value(nil);
    }

     
    }];
 
}

#pragma mark   旅行地点
-(void)G_getTripsPosition:(NSString*)countyName type:(NSString *)type forwsrdNum:(NSInteger)forwardNum count:(NSInteger)count passValue:(G_PassValue)value
{
    self.G_TripsPosition = [NSMutableArray array];
    
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:G_GetTripsPosition,type,countyName,forwardNum,count]];
    NSLog(@"%@",url);
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
    
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        
         if (data != nil) {
        NSDictionary *array = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
        
        for (NSDictionary *dict in [array valueForKey:@"items"]) {
          //  NSLog(@"%@",dict);
//            DestinationModel *trips = [[DestinationModel alloc] init];
//            [trips setValuesForKeysWithDictionary:dict];
//            NSLog(@"%@",trips.id1);
//            [self.G_TripsPosition addObject:trips];
//            
//            
            NearModel *model = [[NearModel alloc]init];
            [model setValuesForKeysWithDictionary:dict];
            [self.G_TripsPosition addObject:model];

            
        }
        value(self.G_TripsPosition);
       // NSLog(@"%ld",self.G_TripsPosition.count);
        
    }else {
        
        value(nil);
    }

     
    }];
 }

#pragma mark   图片

-(void)G_getPhoto:(NSString *)trip_id forwsrdNum:(NSInteger)forwardNum count:(NSInteger)count paddValue:(G_PassValue)value
{
    
    
    self.G_GetPhotoArr = [NSMutableArray array];
  NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://api.breadtrip.com/destination/place/5/%@/photos/?start=%ld&count=%ld&gallery_mode=true",trip_id,forwardNum,count]];
    
    
  //  NSURL *url = [NSURL URLWithString:@"http://api.breadtrip.com/destination/place/5/2388364474/photos/?start=0&count=21&gallery_mode=true"];
    NSLog(@"%@",url);
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
    
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        
        if (data != nil) {
            NSDictionary *array = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
            
           
            
            
            for (NSDictionary *dict in [array valueForKey:@"items"]) {
                
                FirstCollectionModel *trips = [[FirstCollectionModel alloc] init];
                [trips setValuesForKeysWithDictionary:dict];
                [self.G_GetPhotoArr addObject:trips];
                
            }
            value(self.G_GetPhotoArr);
           
            
            
            
            
            
            
        }else {
            
            value(nil);
        }
        
    }];
}




@end
