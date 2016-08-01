//
//  TourTravelViewController.m
//  ZouZou
//
//  Created by hhuuqq on 15/10/19.
//  Copyright (c) 2015年 lanou3g. All rights reserved.
//

#import "TourTravelViewController.h"
#import "MWPhotoBrowser.h"
@interface TourTravelViewController ()<UITableViewDataSource,UITableViewDelegate,MWPhotoBrowserDelegate>

@property (nonatomic,strong) TourTravelView *tour;

// by hqx 1020 定义一个字典用于存放cell里的数据
@property (nonatomic,strong) NSMutableDictionary *travelDict;

// by hqx 1020 定义一个数组用于存放时间
@property (nonatomic,strong) NSMutableArray *dayArr;

// by hqx 1027 定义一个数组用于存放所有图片
@property (nonatomic, strong) NSMutableArray *photos;
@end

@implementation TourTravelViewController

- (void)loadView
{
    self.tour = [[TourTravelView alloc]init];
    self.view = _tour;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor =  [UIColor whiteColor];
    self.tour.travelTableview.delegate = self;
    self.tour.travelTableview.dataSource = self;
    [self.tour.travelTableview registerClass:[TravelTableViewCell class] forCellReuseIdentifier:@"cell"];
    
    self.photos = [NSMutableArray array];
    [self H_data];
    self.tour.travelTableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tour.travelTableview.backgroundColor =  [UIColor whiteColor];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    NSLog(@"%ld",self.dayArr.count);
    return self.dayArr.count;
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    TravrlDayModel *day = self.dayArr[section];
    NSArray *arr = [self.travelDict objectForKey:day.day];
    return arr.count;
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TravelTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        cell = [[TravelTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    cell.backgroundColor = [UIColor whiteColor];
    TravrlDayModel *dayModel = self.dayArr[indexPath.section];
    NSArray *arr = [self.travelDict objectForKey:dayModel.day];
    WayPointsModel *model = arr[indexPath.row];
    cell.photo.frame = CGRectMake(0, 0, CGRectGetWidth(cell.backView.frame), (ScreenWidth - 40) *  model.photoHeight.doubleValue / model.photoWight.doubleValue);
    cell.text.frame = CGRectMake(CGRectGetMinX(cell.photo.frame) + 10, CGRectGetMaxY(cell.photo.frame) + 10, CGRectGetWidth(cell.photo.frame) - 20, [self heightForTextString:model.text.mutableCopy]);
    [cell getValueFromWays:model];
    
   
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}


// by hqx 1020 设置cell的高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TravrlDayModel *dayModel = self.dayArr[indexPath.section];
    NSArray *arr = [self.travelDict objectForKey:dayModel.day];
    WayPointsModel *model = arr[indexPath.row];
    return [self heightForTextString:model.text.mutableCopy] + (ScreenWidth - 40) *  model.photoHeight.doubleValue / model.photoWight.doubleValue + 70;
}

// by hqx 1020 页面数据处理
- (void) H_data
{
    self.travelDict = [NSMutableDictionary dictionary];
    self.dayArr = [NSMutableArray array];
        [[TourDataTool shareData]getSingleDictWithURL:[NSString stringWithFormat:@"http://api.breadtrip.com/trips/%@/waypoints/",self.model.ID] PassValue:^(NSDictionary *dict) {
        
        [self.model setValuesForKeysWithDictionary:dict];
        NSDictionary *childDict = [dict objectForKey:@"user"];
        self.model.model = [[UserModel alloc]init];
        [self.model.model setValuesForKeysWithDictionary:childDict];
        NSArray *arr = [dict objectForKey:@"days"];
        for (NSDictionary *dayDict in arr) {
            self.model.dayModel  = [[TravrlDayModel alloc]init];
            [self.model.dayModel setValuesForKeysWithDictionary:dayDict];
            [self.dayArr addObject:self.model.dayModel];
            NSMutableArray *travelArr = [NSMutableArray array];
            for (NSDictionary  *travelDict in [dayDict objectForKey:@"waypoints"]) {
                self.model.dayModel.wayModel = [[WayPointsModel alloc]init];
                [self.model.dayModel.wayModel setValuesForKeysWithDictionary:travelDict];
                self.model.dayModel.wayModel.positionModel = [[PositionModel alloc]init];
                NSDictionary *positionDict = [travelDict objectForKey:@"poi"];
                if ((NSNull *)positionDict == [NSNull null]) {
                    
                }
                else
                {
                    [self.model.dayModel.wayModel.positionModel setValuesForKeysWithDictionary:positionDict];
                }
                
                NSDictionary *photoInfoDict = [travelDict objectForKey:@"photo_info"];
                if ((NSNull *)photoInfoDict == [NSNull null]) {
                    self.model.dayModel.wayModel.photoWight = @"100";
                    self.model.dayModel.wayModel.photoHeight = @"0";
                }
                else
                {
                    self.model.dayModel.wayModel.photoWight = [NSString stringWithFormat:@"%@",[photoInfoDict objectForKey:@"w"]];
                    self.model.dayModel.wayModel.photoHeight = [NSString stringWithFormat:@"%@",[photoInfoDict objectForKey:@"h"]];
                }
                MWPhoto *photo;
                photo = [MWPhoto photoWithURL:[NSURL URLWithString:self.model.dayModel.wayModel.photo]];
                photo.caption = self.model.dayModel.wayModel.text;
                [self.photos addObject:photo];
                [travelArr addObject:self.model.dayModel.wayModel];
            }
            [self.travelDict setObject:travelArr forKey:self.model.dayModel.day];
        }
        [self.tour getValueFromTravel:self.model];
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tour.travelTableview reloadData];
        });
        
    }];
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    MWPhotoBrowser *browser = [[MWPhotoBrowser alloc] initWithDelegate:self];
    browser.displayActionButton = YES;
    browser.displayNavArrows = NO;
    browser.displaySelectionButtons = NO;
    browser.alwaysShowControls = YES;
    browser.zoomPhotosToFill = YES;
    browser.enableGrid = YES;
    browser.startOnGrid = YES;
    browser.enableSwipeToDismiss = NO;
    browser.autoPlayOnAppear = NO;
    int k = 0;
    for (int i = 0 ; i < indexPath.section; i++) {
        TravrlDayModel *day = self.dayArr[i];
        NSArray *arr = [self.travelDict objectForKey:day.day];
        k += arr.count;
        NSLog(@"%ld dd",arr.count);
        
    }
    k += indexPath.row;
    NSLog(@"%d",k);
    [browser setCurrentPhotoIndex:k];
    [self.tour.travelTableview deselectRowAtIndexPath:indexPath animated:YES];
    [self.navigationController pushViewController:browser animated:YES];
}

// by hqx 高度自使用函数
- (CGFloat)heightForTextString:(NSMutableString *)aString
{
    NSCharacterSet *doNotWant = [NSCharacterSet characterSetWithCharactersInString:@"⸍⚙̥ꇴ⚙̥⸌ʅ（´◔౪◔）ʃ(.。≧▽≦。.)҉҉✺◟❛ัᴗ❛ั◞✺❁◡`❁✲ﾟ"];
     aString = [[aString componentsSeparatedByCharactersInSet: doNotWant]componentsJoinedByString: @""];
    CGRect rect = [aString boundingRectWithSize:CGSizeMake(ScreenWidth - 40, 2000) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13]} context:nil];
    return rect.size.height;
}

#pragma mark - Browser的代理函数
- (NSUInteger)numberOfPhotosInPhotoBrowser:(MWPhotoBrowser *)photoBrowser {
    return _photos.count;
}

- (id <MWPhoto>)photoBrowser:(MWPhotoBrowser *)photoBrowser photoAtIndex:(NSUInteger)index {
    if (index < _photos.count)
        return [_photos objectAtIndex:index];
    return nil;
}

- (BOOL)photoBrowser:(MWPhotoBrowser *)photoBrowser isPhotoSelectedAtIndex:(NSUInteger)index {
    return [[self.photos objectAtIndex:index] boolValue];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
