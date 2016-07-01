//
//  G_shareTools.m
//  ZouZou
//
//  Created by lanou3g on 15/10/23.
//  Copyright (c) 2015年 lanou3g. All rights reserved.
//

#import "G_shareTools.h"

@interface G_shareTools ()<UMSocialUIDelegate>
@property(nonatomic,strong)NSString *textDeail;
@property (nonatomic,strong)UIAlertView *alertView;
@property(nonatomic,strong)NSMutableArray *G_selectArr;


@end

static G_shareTools *st = nil;
@implementation G_shareTools

+(instancetype)shareTools
{
    if (st==nil) {
        static dispatch_once_t once_token;
        dispatch_once(&once_token, ^{
            st  = [[G_shareTools alloc] init];
        });
    }
    return st;
}

#pragma mark 设置用户名

-(void)setUserLogin:(UserLoginModel*)sender
{
    NSUserDefaults *user = [[NSUserDefaults alloc] init];
    [user setObject:sender.username forKey:@"Entity"];
    
    
}

#pragma mark 取出用户名
-(NSString *)getUserLogin
{
    NSUserDefaults *user =[[NSUserDefaults alloc] init];
    
    return  [user objectForKey:@"Entity" ];
}
#pragma mark 分享
-(void)G_shareText:(UIViewController *)view  shareName:(NSString *)text reason:(NSString*)reason imageurl:(NSString *)imageUrl
{
    
    NSString *td = [NSString stringWithFormat:@"#目的地推荐#刚在点滴旅行发现一个目的地《%@》，好像很不错啊，感兴趣的朋友一起吧\n分享理由:%@",text, reason];
    UIImageView *myiamge = [[UIImageView alloc] init];
    [myiamge sd_setImageWithURL:[NSURL URLWithString:imageUrl]];
    
    [UMSocialSnsService presentSnsIconSheetView:view
                                         appKey:@"5629ed3167e58e76f3000cc9"
                                      shareText:td
                                     shareImage:myiamge.image
                                shareToSnsNames:[NSArray arrayWithObjects:UMShareToSina,UMShareToTencent,UMShareToRenren,UMShareToDouban,UMShareToEmail,UMShareToSms,nil]
                                       delegate:self];
    
    self.textDeail = td;
}

-(void)didSelectSocialPlatform:(NSString *)platformName withSocialData:(UMSocialData *)socialData
{
    if (platformName == UMShareToSina) {
        socialData.shareText = [NSString stringWithFormat:@"分享到新浪微博的文字内容,%@",self.textDeail];
        
        
    }
    else{
        socialData.shareText = [NSString stringWithFormat:@"分享到其他平台的文字内容,%@",self.textDeail];
    }
}

-(void)didFinishGetUMSocialDataInViewController:(UMSocialResponseEntity *)response
{
        
    if (response.responseCode == UMSResponseCodeSuccess) {
        NSLog(@"success");
        NSLog(@"share to sns name is %@",[[response.data allKeys] objectAtIndex:0]);
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"分享成功" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alert show];
        
        
        
        
        // NSLog(@"success");
    }
    
}

#pragma mark  热门地点收藏 高星
-(void)G_setSaveStart:(NSString *)type id1:(NSString *)id1 name:(NSString *)name reason:(NSString *)reason imageUrl:(NSString *)imageUrl
{
    
     AVObject *testObject = [AVObject objectWithClassName:[self getUserLogin]];
     [testObject save];
    [testObject deleteInBackground];
    AVQuery *query = [AVQuery queryWithClassName:[self getUserLogin]];
    [query whereKey:@"id1" equalTo:id1];
    
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            // 检索成功
            NSLog(@"Successfully retrieved %lu posts.-------热门地点收藏", (unsigned long)objects.count);
            
            if(objects.count != 0){
                self.alertView = [[UIAlertView alloc]initWithTitle:@"提示"message:@"收藏已存在："delegate:nil cancelButtonTitle:nil otherButtonTitles:nil];
            
                [ self.alertView show];
                return ;
            }
            
            NSLog(@"%@",imageUrl);
             NSLog(@"%@",[self getUserLogin]);
            AVObject *testObject = [AVObject objectWithClassName:[self getUserLogin]];
            [testObject setObject:type  forKey:@"type"];
            [testObject setObject:id1  forKey:@"id1"];
            [testObject setObject:name  forKey:@"name"];
            [testObject setObject:reason  forKey:@"reason"];
            [testObject setObject:imageUrl  forKey:@"imageUrl"];
            [testObject setObject:@"地点" forKey:@"destion"];
            [testObject save];
            
            self.alertView = [[UIAlertView alloc]initWithTitle:@"提示"message:@"已收藏："delegate:nil cancelButtonTitle:nil otherButtonTitles:nil];
            [ self.alertView show];
            
        }
        
        else {
            // 输出错误信息
            NSLog(@"Error: %@ %@", error, [error userInfo]);
        }
    }];

     [NSTimer scheduledTimerWithTimeInterval:1.0f target:self selector:@selector(dismissAlertView) userInfo:nil repeats:YES];
    
    
    
    
}
#pragma mark  查询收藏 高星
-(void)G_selectStart:(NSNumber*)type   forwardNum:(NSInteger)forwardNum count:(NSInteger)count value:(G_Select)passValue
{
    ////[query whereKey:@"pubUser" notEqualTo:@"LeanCloud官方客服"];
    self.G_selectArr = [NSMutableArray array];
    AVQuery *query = [AVQuery queryWithClassName:[self getUserLogin]];
    [query whereKey:@"destion" equalTo:@"地点"];
    // 一次性只能取两条数据 count
   query.limit = count;
   
   // 跳过前 10 条结果 forword
    query.skip = forwardNum;
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            // 检索成功
            NSLog(@"Successfully retrieved %lu posts-----查询收藏", (unsigned long)objects.count);
            
            if(objects.count == 0){
               UIAlertView *alertv = [[UIAlertView alloc]initWithTitle:@"提示"message:@"没有数据："delegate:nil cancelButtonTitle:@"确定"otherButtonTitles:nil];
                [alertv show];
                
               // return ;
            }
 
            NSDictionary *dict = [objects valueForKey:@"localData"];
            
            for (NSDictionary   *s in dict) {
                UserLoginModel *user = [[UserLoginModel alloc] init];
                [user setValuesForKeysWithDictionary:s];
                
                [self.G_selectArr addObject:user];
              //  NSLog(@"%@===%@",[s valueForKey:@"name"],s);
               }

            passValue(self.G_selectArr);
            
            
        }
        else
        {
            // 输出错误信息
            NSLog(@"Error: %@ %@", error, [error userInfo]);
        }
    }];

    
    
    
}

- (void)dismissAlertView
{
    [ self.alertView dismissWithClickedButtonIndex:0 animated:YES];
}


#pragma mark 是否收藏 高星

-(void)G_isStrat:(NSString *)id1 isflag:(G_isStart)isflag
{
    
    AVQuery *query = [AVQuery queryWithClassName:[self getUserLogin]];
    [query whereKey:@"id1" equalTo:id1];
    //[query findObjectsInBackgroundWithTarget:self selector:@selector(callbackWithResult:error:)];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            // 检索成功
            NSLog(@"Successfully retrieved %lu posts.------是否收藏", (unsigned long)objects.count);
            
            if(objects.count != 0){
                self.isFlag = YES;
                isflag(self.isFlag);
            }else
            { self.isFlag = NO;
                isflag(self.isFlag);
                
            }
        }else {
            // 输出错误信息
            NSLog(@"Error: %@ %@", error, [error userInfo]);
            self.isFlag=NO;
        }
    }];
    
    
}

@end
