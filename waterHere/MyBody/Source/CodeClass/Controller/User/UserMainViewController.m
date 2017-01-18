//
//  UserMainViewController.m
//  ZouZou
//
//  Created by gx110387 on 15/10/14.
//  Copyright (c) 2015年 gx110387. All rights reserved.
//

#import "UserMainViewController.h"
#import "UserLoginVC.h"

@interface UserMainViewController ()<UITableViewDataSource,UITableViewDelegate,UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>
@property(nonatomic,strong)UserView *userView;
@property(nonatomic,strong)UITableView *tableView;
@property (nonatomic,retain) MBProgressHUD * hud;

@property(nonatomic,strong)UIImage *G_myImage;
@property(nonatomic,assign)BOOL issavePhoto;
// 用来处理收藏的数据
@property(nonatomic,strong)NSMutableArray *G_UserArr;
@property(nonatomic,strong)DestinationDailViewController *destinationDilVc;

@property(nonatomic,assign)BOOL scrollFlag;


@end

@implementation UserMainViewController
#pragma mark  页面初始化 用来判断用户是否登录
-(void)viewWillAppear:(BOOL)animated{
      [super viewWillAppear:animated];
     self.scrollFlag = YES;
     [self isLogin];
}

-(void)isLogin
{
    if ([Toolshares isLogined] == YES) {
     
    }else{
        self.tabBarController.selectedIndex = 0;
    }
    AVUser *currentUser = [AVUser currentUser];
    if (currentUser != nil) {
        
        NSLog(@"有");
//        self.navigationItem.title = [[G_shareTools shareTools]getUserLogin];
        NSLog(@"%d",self.issavePhoto);
        if (self.issavePhoto ==YES) {
            [self G_setImageOnline:self.G_myImage];
            self.issavePhoto = NO;
        }
        AVFile *file =   [currentUser objectForKey:@"photo"];
//        if ([[[NSUserDefaults standardUserDefaults] valueForKey:[[G_shareTools shareTools] getUserLogin]] intValue]!=1) {
//            NSLog(@">>>>>>>>>%@",[file valueForKey:@"url"]);
            [self.userView.G_UserImage sd_setImageWithURL:[NSURL URLWithString:[file valueForKey:@"url"]] placeholderImage:[UIImage imageNamed:@"picholder"]];
           // [[NSUserDefaults standardUserDefaults]setBool:YES forKey:[[G_shareTools shareTools] getUserLogin] ];
        //}
        
    } else {
        
    }
    
}

#pragma mark 显示UI
-(void)G_data
{
    
    self.tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    self.tableView.height = MainScreenHeight - 64;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor =[UIColor colorWithHexString:@"fbf7ed"];// CustomerColor(245, 248, 250);
    // self.tableView.backgroundColor = [UIColor colorWithRed:251/255.0 green:247/255.0 blue:237/255.0 alpha:1];
    self.tableView.contentInset = UIEdgeInsetsMake(ImageHight-0, 0, 0, 0);
    [self.view addSubview:self.tableView];
    self.tableView.tableFooterView = [[UIView alloc]init];
    
    
    // 视图~
    self.userView = [[UserView alloc] init];
    self.userView.frame = CGRectMake(0,-ImageHight, self.view.frame.size.width, ImageHight );
    self.userView.G_backgroundImage.frame =CGRectMake(0,0, CGRectGetWidth(self.userView.frame), CGRectGetHeight(self.userView.frame));
    self.userView.G_backgroundImage.image = [UIImage imageNamed:@"bg"];
    self.userView.G_backgroundImage.contentMode = UIViewContentModeScaleAspectFill;
    // self.userView.backgroundColor = [UIColor yellowColor];
    //    self.tableView.tableHeaderView = self.userView;
    [self.tableView addSubview:self.userView];
    
    
    
    
    self.userView.G_UserImage.frame = CGRectMake( CGRectGetWidth(self.userView.frame)/2-50, CGRectGetHeight(self.userView.frame)/2-70, 100, 100);
    self.userView.G_UserImage.layer.cornerRadius = CGRectGetHeight(self.userView.G_UserImage.frame)/2;
    self.userView.G_UserImage.layer.masksToBounds = YES;
    self.userView.G_UserImage.backgroundColor = [UIColor cyanColor];
    self.userView.G_UserImage.autoresizingMask = UIViewAutoresizingFlexibleTopMargin;
    
    
    
    //我的收藏
    self.userView.G_UserStartLabel.frame = CGRectMake(CGRectGetMinX(self.userView.G_UserImage.frame), CGRectGetMaxY(self.userView.G_UserImage.frame)+20, 100, 30);
    
    self.userView.G_UserStartLabel.autoresizingMask = UIViewAutoresizingFlexibleTopMargin;
    
}
#pragma  mark 页面初始化完成
- (void)viewDidLoad
{
    [super viewDidLoad];
    
   self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"关于我们"   style:UIBarButtonItemStyleDone target:self action:@selector(leftBarButtonItemAction)];
 
    self.navigationItem.rightBarButtonItem= [UIBarButtonItem itemWithTarget:self action:@selector(shareButtonAction) image:@"setting" highImage:@"setting"];
    
    // 数组初始化
    self.G_UserArr = [NSMutableArray array];
    [self G_data];
 
    // 设置图片的监听事件
    [self setPhone];
     [self setupRefresh];
    
}

-(void)setPhone
{
    self.userView.G_UserImage.userInteractionEnabled = YES;
    UITapGestureRecognizer *singleTap1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(UserPhontAction)];
    
    [  self.userView.G_UserImage addGestureRecognizer:singleTap1];
}

-(void)UserPhontAction
{
    UIActionSheet *sheet;
    
    // 判断是否支持相机
    
    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
        
    {
        sheet  = [[UIActionSheet alloc] initWithTitle:@"选择" delegate:self cancelButtonTitle:nil destructiveButtonTitle:@"取消" otherButtonTitles:@"拍照",@"从相册选择", nil];
        
    }
    
    else {
        
        sheet = [[UIActionSheet alloc] initWithTitle:@"选择" delegate:self cancelButtonTitle:nil destructiveButtonTitle:@"取消" otherButtonTitles:@"从相册选择", nil];
        
    }
    
    sheet.tag = 255;
    
    [sheet showInView:self.view];
    
    
}

-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (actionSheet.tag == 255) {
        
        NSUInteger sourceType = 0;
        
        // 判断是否支持相机
        if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
            
            switch (buttonIndex) {
                case 0:
                    // 取消
                    return;
                case 1:
                    // 相机
                    sourceType = UIImagePickerControllerSourceTypeCamera;
                    break;
                    
                case 2:
                    // 相册
                    sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
                    break;
            }
        }
        else {
            if (buttonIndex == 0) {
                
                return;
            } else {
                sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
            }
        }
        // 跳转到相机或相册页面
        UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
        
        imagePickerController.delegate = self;
        
        imagePickerController.allowsEditing = YES;
        
        imagePickerController.sourceType = sourceType;
        
        [self presentViewController:imagePickerController animated:YES completion:^{}];
    }
}

-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    self.issavePhoto =NO;
    [self.navigationController dismissViewControllerAnimated:YES completion:nil ];
}
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(NSDictionary *)editingInfo
{
    self.userView.G_UserImage.image = image;
    self.issavePhoto = YES;
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
    self.G_myImage = image;
    
    
}

- (void)p_setupProgressHud
{
    self.hud = [[MBProgressHUD alloc] initWithView:self.view] ;
    _hud.frame = self.view.bounds;
    _hud.minSize = CGSizeMake(100, 100);
    _hud.mode = MBProgressHUDModeIndeterminate;
    [self.view addSubview:_hud];
    
    [_hud show:YES];
}
#pragma mark 把选取的在照片存在网上
-(void)G_setImageOnline:(UIImage *)img
{
    AVUser *uer = [AVUser currentUser];
    //  NSLog(@"%@",uer);
    NSData *imageData = UIImagePNGRepresentation(img);
    AVFile *imageFile = [AVFile fileWithName:[[G_shareTools shareTools] getUserLogin] data:imageData];
    [imageFile save];
    [uer setObject:imageFile forKey:@"photo"];
    
    [uer saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (!error) {
            NSLog(@" 上传成功");
            
        }else
        {
            //
            NSLog(@" 上传失败");
            
        }
    }];
    
}



- (void)setupRefresh
{
    //1.添加刷新控件
    UIRefreshControl *control=[[UIRefreshControl alloc]init];
    [control addTarget:self action:@selector(refreshStateChange:) forControlEvents:UIControlEventValueChanged];
    [self.tableView addSubview:control];
    
    //2.马上进入刷新状态，并不会触发UIControlEventValueChanged事件
    [control beginRefreshing];
     // 3.加载数据
    [self refreshStateChange:control];
    [self.tableView addLegendFooterWithRefreshingTarget:self refreshingAction:@selector(footerRereshing)];
    
}

#pragma mark 开始进入刷新状态
-(void)refreshStateChange:(UIRefreshControl *)control
{
    
    
    NSNumber *a= [[NSNumber alloc] initWithInt:5];
    
    //    [[G_shareTools shareTools]G_selectStart:a forwardNum:(NSInteger)forwardNum count:(NSInteger)count value:^(NSMutableArray *array) {
    [[G_shareTools shareTools] G_selectStart:a forwardNum:0 count:5 value:^(NSMutableArray *array) {
        if (array.count== 0 || array.count <5) {
            [self.tableView.footer setHidden:YES];
        }
        self.G_UserArr = array;
        
        [self.tableView reloadData];
        
        [control endRefreshing];
        
    }];
    
}

- (void)footerRereshing
{
    
    NSNumber *a= [[NSNumber alloc] initWithInt:5];
    NSLog(@"%ld",self.G_UserArr.count);
    [[G_shareTools shareTools] G_selectStart:a forwardNum:self.G_UserArr.count count:5 value:^(NSMutableArray *array) {
        if (array.count== 0) {
            [self.tableView.footer setHidden:YES];
        }
        [self.G_UserArr addObjectsFromArray: array];
        [self.tableView reloadData];
        [self.tableView.footer endRefreshing];
        
    }];
}




#pragma mark 关于我们 暂时作为处理收藏数据 测试中
-(void)leftBarButtonItemAction
{
    AboutUsViewController *aboutUsVC = [[AboutUsViewController alloc] init];
    aboutUsVC.title =@"关于我们";
    [self.navigationController pushViewController:aboutUsVC animated:YES];
    
}



#pragma mark 设置,包括 修改密码 清除缓存 退出登录
-(void)shareButtonAction
{
    
    SettingTableViewController *settingVC = [[SettingTableViewController alloc] initWithStyle:UITableViewStyleGrouped];
    settingVC.title =@"设置";
    [self.navigationController pushViewController:settingVC animated:YES];
    
}
#pragma mark 用来调节页面图片的大小和根据尺寸隐藏tabBar
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (self.scrollFlag == NO) {
        return;
    }
    CGFloat y = scrollView.contentOffset.y;//+NavigationBarHight;//根据实际选择加不加上NavigationBarHight（44、64 或者没有导航条）
  
    if (y < -ImageHight) {
        CGRect frame = self.userView.frame;
        // CGRect frame =  self.userView.G_backgroundImage.frame;
        frame.origin.y = y;
        frame.size.height =  -y;//contentMode = UIViewContentModeScaleAspectFill时，高度改变宽度也跟着改变
        self.userView.frame = frame;
        AVUser *currentUser = [AVUser currentUser];
        if (currentUser != nil) {
            
            self.userView.G_backgroundImage.frame =CGRectMake(0,0, CGRectGetWidth(self.userView.frame), CGRectGetHeight(self.userView.frame));
        }else
        {
            
        }
    }
    
    
//    
//    if(y>-64){
//        [self.navigationController.navigationBar setBackgroundImage:[UIImage imageFromColor:[UIColor colorWithRed:255 green:255 blue:255 alpha:y / 1000]] forBarMetrics:UIBarMetricsDefault];
//        
//    }else
//    {
        [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"NaviBarBg"] forBarMetrics:UIBarMetricsDefault];
//         
//    }
    
    
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
 
        return self.G_UserArr.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    DesTripsSectonSecondTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"cell"];
    if(cell==nil){
        cell=[[DesTripsSectonSecondTableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.separatorInset=UIEdgeInsetsZero;
        cell.clipsToBounds = YES;
    }
    UserLoginModel *user = self.G_UserArr[indexPath.section];
    
    
    
 
    [cell.myImage sd_setImageWithURL:[NSURL URLWithString:user.imageUrl] placeholderImage:[UIImage imageNamed:@"picholder"]];
    cell.myNameLabel.text = user.name;
    cell.myRatingLabel.frame=CGRectMake(CGRectGetMinX(cell.myNameLabel.frame), CGRectGetMaxY(cell.myNameLabel.frame)+5, CGRectGetWidth(cell.myNameLabel.frame), 0);
    cell.myDescriptionLabel.text = user.reason;
    cell.myDescriptionLabel.numberOfLines = 4;
    return cell;
}
-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 1 删除数据源
    UserLoginModel *user = self.G_UserArr[indexPath.section];
    AVQuery *query = [AVQuery queryWithClassName:[[G_shareTools shareTools] getUserLogin]];
    [query whereKey:@"id1" equalTo:user.id1];
    
    
    [query  findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        
        if (!error) {
            
            AVObject *local = [ AVObject objectWithClassName:[[G_shareTools shareTools] getUserLogin]];
            for ( NSDictionary *dic in [objects valueForKey:@"localData"]) {
                
                [[local objectForKey:@"localData"] setValuesForKeysWithDictionary:dic];
            }
            for ( NSDictionary *dic in [objects valueForKey:@"objectId"] ) {
                
                local.objectId = [NSString stringWithFormat:@"%@",dic];
            }
            
            [local deleteInBackground];
            
            NSLog(@"%@",local);
        }else
        {
            NSLog(@"ddddddd");
            
        }
        
        
    }];
 
    [self.G_UserArr removeObjectAtIndex:indexPath.section ];
  
     [self.tableView deleteSections:[NSIndexSet indexSetWithIndex:indexPath.section] withRowAnimation:UITableViewRowAnimationLeft];
    
    //  });
}



-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.scrollFlag = NO;
    
    
    UserLoginModel *user = self.G_UserArr[indexPath.section];
    
    self.destinationDilVc  = [[DestinationDailViewController alloc] init];
    
    [self p_setupProgressHud];
    self.destinationDilVc.G_imageURL = user.imageUrl;
    // NSLog(@"%@",d.cover);
    [self G_getMothData:user.type id:user.id1];
    
    NSLog(@"%ld====%ld",(long)indexPath.section,(long)indexPath.row);
    
}
-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        
 UILabel *youjiLable = [[ UILabel alloc] initWithFrame:CGRectMake(0, 0, MainScreenWidth, G_Iphone6(57))];
    youjiLable.backgroundColor = [UIColor colorWithHexString:@"fbf7ed"];
    youjiLable.textColor = CustomerColor(51, 51, 51);
    youjiLable.text = @"     游记&故事集";
         return youjiLable;
     } else {
         return  [[UIView alloc] init];
    }
   
}
-(void)G_getMothData:(NSString *)type id:(NSString *)id1
{
    DDLog(@"%@",id1);
    
    [[G_getDestinaData shareGetDestinData] g_getMonthData:type id:id1 passValue:^(DestinationModel *destionModel) {
        self.destinationDilVc.G_destionModel = destionModel;
        [[G_getDestinaData shareGetDestinData] G_getInfoData:0 id:id1 count:5 passValue:^(NSMutableArray *array) {
            
            NSLog(@"准备跳入下一页,游记页面");
            self.destinationDilVc.G_tripsArr =array;
            
            [_hud hide:YES];
            
            [self.navigationController pushViewController:self.destinationDilVc animated:YES];
        }];
        
    }];
     }

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return G_Iphone6(57);
    }else{
        return 5;
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 5;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    return 110;
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
