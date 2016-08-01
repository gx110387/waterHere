//
//  StoryDetialViewController.m
//  ZouZou
//
//  Created by hhuuqq on 15/10/17.
//  Copyright (c) 2015年 lanou3g. All rights reserved.
//

#import "StoryDetialViewController.h"

@interface StoryDetialViewController ()<UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate>

@property (nonatomic,strong) StoryDitialView *sd;

// by hqx 1017 定义一个数组用于存放细节对象
@property (nonatomic,strong) NSMutableArray *detialArr;

// by hqx 1019 定义一个数组用于存放喜欢人的对象
@property (nonatomic,strong) NSMutableArray *loveArr;
@end

@implementation StoryDetialViewController

- (void)loadView
{
    self.sd = [[StoryDitialView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    self.view = _sd;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:self action:@selector(leftAction)];
    self.navigationItem.title = @"故事详情";
    [self H_data];
    [self.sd.detialTableView registerClass:[StoryDetialTableViewCell class] forCellReuseIdentifier:@"cell"];
    self.sd.detialTableView.delegate = self;
    self.sd.detialTableView.dataSource = self;
    self.sd.detialTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    self.sd.photoImage.image = [UIImage imageNamed:@""];
    self.sd.timeImage.image = [UIImage imageNamed:@""];
    
    self.sd.delegate = self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void) leftAction
{
    [self.navigationController popViewControllerAnimated:YES];
}


// by hqx 1018 数据处理
- (void) H_data
{
    [[TourDataTool shareData]getTourTravelDataWithURL:[NSString stringWithFormat:@"http://api.breadtrip.com/v2/new_trip/spot?spot_id=%@",self.model.spot_id] PassValue:^(NSDictionary *dict) {
       
        NSDictionary *spotDict = [dict objectForKey:@"spot"];
        [self.model setValuesForKeysWithDictionary:spotDict];
        NSArray *arr = [spotDict objectForKey:@"detail_list"];
        self.detialArr = [[NSMutableArray alloc]init];
        for (NSDictionary *detialDict in arr) {
            self.model.detail = [[Detail_listModel alloc]init];
            [self.model.detail setValuesForKeysWithDictionary:detialDict];
            [self.detialArr addObject:self.model.detail];
        }
        self.loveArr = [[NSMutableArray alloc]init];
        NSArray *loveArray = [spotDict objectForKey:@"recommendations"];
        for (NSDictionary *loveDict in loveArray) {
            self.model.loveUser = [[UserModel alloc]init];
            [self.model.loveUser setValuesForKeysWithDictionary:loveDict];
            [self.loveArr addObject:self.model.loveUser];
        }
        
        NSDictionary *tripDict = [dict objectForKey:@"trip"];
        self.model.trip = [[StoryTripModel alloc]init];
        [self.model.trip setValuesForKeysWithDictionary:tripDict];
        
        [self.sd getValueFromStoryModel:self.model];
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.sd.detialTableView reloadData];
        });
        self.sd.textLabel.frame = CGRectMake(self.sd.textLabel.frame.origin.x, self.sd.textLabel.frame.origin.y, self.sd.textLabel.frame.size.width, [self heightForTextString:self.model.text]);
        self.sd.topView.frame = CGRectMake(0, 0, ScreenWidth, [self heightForTextString:self.model.text] + 120);
        self.sd.detialTableView.tableHeaderView = self.sd.topView;
        
    }];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSLog(@"%ld",self.detialArr.count);
    return  self.detialArr.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    StoryDetialTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        cell = [[StoryDetialTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    Detail_listModel *model = self.detialArr[indexPath.row];
    cell.picture.frame = CGRectMake(cell.picture.frame.origin.x, cell.picture.frame.origin.y, cell.picture.frame.size.width, (ScreenWidth - 40) * model.photo_height / model.photo_width);
    [cell getValueFromDeitalModel:model];
    cell.text.frame = CGRectMake(CGRectGetMinX(cell.picture.frame), CGRectGetMaxY(cell.picture.frame) + 10, CGRectGetWidth(cell.picture.frame), [self heightForDetailString:model.text]);
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    Detail_listModel *model = self.detialArr[indexPath.row];
    return (ScreenWidth - 40) * model.photo_height / model.photo_width  + [self heightForDetailString:model.text] + 30;
}


// by hqx 1019 设置高度自适应函数(Text)
- (CGFloat)heightForTextString:(NSString *)aString
{
    CGRect rect = [aString boundingRectWithSize:CGSizeMake(ScreenWidth - 40, 2000) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:17]} context:nil];
    return rect.size.height;
}


// by hqx 1019 设置高度自适应函数(Detail)
- (CGFloat)heightForDetailString:(NSString *)aString
{
    CGRect rect = [aString boundingRectWithSize:CGSizeMake(ScreenWidth - 40, 2000) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13]} context:nil];
    return rect.size.height;
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
