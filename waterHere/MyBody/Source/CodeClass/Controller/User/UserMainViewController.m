//
//  UserMainViewController.m
//  ZouZou
//
//  Created by lanou3g on 15/10/14.
//  Copyright (c) 2015年 lanou3g. All rights reserved.
//

#import "UserMainViewController.h"

@interface UserMainViewController ()<UITableViewDataSource,UITableViewDelegate,UserViewDelegate,UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>
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
-(void)viewWillAppear:(BOOL)animated
{

    self.scrollFlag = YES;
   
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    [self isLogin];
  }
-(void)isLogin
{
     AVUser *currentUser = [AVUser currentUser];
    if (currentUser != nil) {
        // 允许用户使用应用
          [self setupRefresh];
        NSLog(@"有");
        self.navigationItem.title = [[G_shareTools shareTools]getUserLogin];
        //已登录 显示 图片和收藏
        //  图片
        self.userView.G_UserImage.frame = CGRectMake( CGRectGetWidth(self.userView.frame)/2-50, CGRectGetHeight(self.userView.frame)/2-50, 100, 100);
        self.userView.G_UserImage.layer.cornerRadius = CGRectGetHeight(self.userView.G_UserImage.frame)/2;
        self.userView.G_UserImage.layer.masksToBounds = YES;
        self.userView.G_UserImage.backgroundColor = [UIColor cyanColor];
        self.userView.G_UserImage.autoresizingMask = UIViewAutoresizingFlexibleTopMargin;
        
      
        
        //我的收藏
        self.userView.G_UserStartLabel.frame = CGRectMake(CGRectGetMinX(self.userView.G_UserImage.frame), CGRectGetMaxY(self.userView.G_UserImage.frame)+10, 100, 30);
        self.userView.G_UserStartLabel.backgroundColor  = [UIColor colorWithRed:251/255.0 green:247/255.0 blue:237/255.0 alpha:1];
        self.userView.G_UserStartLabel.autoresizingMask = UIViewAutoresizingFlexibleTopMargin;
        
        [self.navigationItem.rightBarButtonItem setEnabled:YES];
        

        NSLog(@"%d",self.issavePhoto);
        if (self.issavePhoto ==YES) {
            NSLog(@"怎么回事%@",self.G_myImage);
            
            [self G_setImageOnline:self.G_myImage];
            self.issavePhoto = NO;
        }
        
          AVFile *file =   [currentUser objectForKey:@"photo"];
        
        
        if ([[[NSUserDefaults standardUserDefaults] valueForKey:[[G_shareTools shareTools] getUserLogin]] intValue]!=1) {
             NSLog(@">>>>>>>>>%@",[file valueForKey:@"url"]);
            [self.userView.G_UserImage sd_setImageWithURL:[NSURL URLWithString:[file valueForKey:@"url"]] placeholderImage:[UIImage imageNamed:@"picholder"]];
            [[NSUserDefaults standardUserDefaults]setBool:YES forKey:[[G_shareTools shareTools] getUserLogin] ];
        }
        
        
        
        
        
        
    } else {
        //缓存用户对象为空时，可打开用户注册界面…
        NSLog(@"没有 ");
       
        self.navigationItem.title = @"";
        //已注销 显示登陆
        // [self loginButton];
        //self.userView.G_UserImage.image =[UIImage imageNamed:@"picholder"];
        self.userView.G_UserLoginOrRegistButton.frame = CGRectMake(CGRectGetWidth(self.userView.frame)/2-50, CGRectGetHeight(self.userView.frame)/2-15, 100, 30);
        self.userView.G_UserLoginOrRegistButton.backgroundColor = [UIColor redColor];
        [self.navigationItem.rightBarButtonItem setEnabled:NO];
        [self.userView.G_UserStartLabel setHidden:YES];
        [self.userView.G_UserImage setHidden:YES];
        [self.userView.G_UserLoginOrRegistButton setHidden:NO];
       
        if ([[[NSUserDefaults standardUserDefaults] valueForKey:@"isFor"] intValue] ==1) {
             [self setupRefresh];
        }
        
        [self showTabBar];
    }

}

#pragma mark 显示UI
-(void)G_data
{
    
    self.tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"userground.jpg"]];
    // self.tableView.backgroundColor = [UIColor colorWithRed:251/255.0 green:247/255.0 blue:237/255.0 alpha:1];
    self.tableView.contentInset = UIEdgeInsetsMake(ImageHight-0, 0, 0, 0);
    [self.view addSubview:self.tableView];
    self.tableView.tableFooterView = [[UIView alloc]init];
    
    
    // 视图~
    self.userView = [[UserView alloc] init];
    self.userView.frame = CGRectMake(0, -ImageHight, self.view.frame.size.width, ImageHight );
    self.userView.G_backgroundImage.frame =CGRectMake(0,0, CGRectGetWidth(self.userView.frame), CGRectGetHeight(self.userView.frame));
    self.userView.G_backgroundImage.image = [UIImage imageNamed:@"bg.jpg"];
    // self.userView.backgroundColor = [UIColor yellowColor];
    [self.tableView addSubview:self.userView];
    self.userView.delegate = self;
   }
#pragma  mark 页面初始化完成
- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationController.navigationBar.barTintColor = [UIColor orangeColor];//不能放init处
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
  // self.navigationItem.title = self.G_destinationmodel.name;
     self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"关于我们"   style:UIBarButtonItemStyleDone target:self action:@selector(leftBarButtonItemAction)];
    UIBarButtonItem *share=[[UIBarButtonItem alloc]initWithTitle:@"设置" style:UIBarButtonItemStyleDone target:self action:@selector(shareButtonAction)];
    self.navigationItem.rightBarButtonItem= share;

        // 数组初始化
    self.G_UserArr = [NSMutableArray array];
    [self G_data];
    [self G_creatUI];
    // 设置图片的监听事件
    [self setPhone];
   
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
////拍摄完成后要执行的方法
//-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
// {
// //得到图片
// UIImage * image = [info objectForKey:UIImagePickerControllerOriginalImage];
//     self.userView.G_UserImage.image = image;
// //图片存入相册
// //UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil);
//      NSLog(@"你走了么1");
// [self dismissModalViewControllerAnimated:YES];
// 
// }
 //点击Cancel按钮后执行方法
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

#pragma mark 没用 删掉
//- (void)uzysAssetsPickerControllerDidExceedMaximumNumberOfSelection:(UzysAssetsPickerController *)picker
//{
//    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@""
//                                                    message:NSLocalizedStringFromTable(@"请只选择一张图片", @"UzysAssetsPickerController", nil)
//                                                   delegate:nil
//                                          cancelButtonTitle:@"OK"
//                                          otherButtonTitles:nil];
//    [alert show];
//}


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
        
         [self.G_UserArr addObjectsFromArray: array];
        [self.tableView reloadData];
        [self.tableView.footer endRefreshing];
        
    }];
}

#pragma mark 隐藏tabBar
- (void)hideTabBar
{
    if (self.tabBarController.tabBar.hidden == YES) {
        return;
    }
    UIView *contentView;
    if ( [[self.tabBarController.view.subviews objectAtIndex:0] isKindOfClass:[UITabBar class]] )
        contentView = [self.tabBarController.view.subviews objectAtIndex:1];
    else
        contentView = [self.tabBarController.view.subviews objectAtIndex:0];
    contentView.frame = CGRectMake(contentView.bounds.origin.x,  contentView.bounds.origin.y,  contentView.bounds.size.width, contentView.bounds.size.height + self.tabBarController.tabBar.frame.size.height);
    self.tabBarController.tabBar.hidden = YES;
    
}
#pragma mark 显示tabBar
- (void)showTabBar
{
    if (self.tabBarController.tabBar.hidden == NO)
    {
        return;
    }
    UIView *contentView;
    if ([[self.tabBarController.view.subviews objectAtIndex:0] isKindOfClass:[UITabBar class]])
        
        contentView = [self.tabBarController.view.subviews objectAtIndex:1];
    
    else
        
        contentView = [self.tabBarController.view.subviews objectAtIndex:0];
    contentView.frame = CGRectMake(contentView.bounds.origin.x, contentView.bounds.origin.y,  contentView.bounds.size.width, contentView.bounds.size.height - self.tabBarController.tabBar.frame.size.height);
    NSLog(@"showTabBar");
    self.tabBarController.tabBar.hidden = NO;

    
    
}

#pragma mark 登录页面
-(void)loginButton
{
    
    
    LoginViewController *loginVC = [[LoginViewController alloc] init];
    
     __block UserMainViewController * userVC = self;
    
    loginVC.mblock = ^(UserLoginModel *u){
       // [userVC p_setupLogoutButtonItem];
        userVC.navigationItem.title = u.username;
        [userVC.userView.G_UserImage setHidden:NO];
        [userVC.userView.G_UserStartLabel setHidden:NO];
        [userVC.userView.G_UserLoginOrRegistButton setHidden:YES];
        
    };
    UINavigationController *loginNC = [[UINavigationController alloc] initWithRootViewController:loginVC];
    
    [self.navigationController presentViewController:loginNC animated:YES completion:nil];
    
 
}
#pragma mark 暂无方法
-(void)G_creatUI{
    
}
#pragma mark 关于我们 暂时作为处理收藏数据 测试中
-(void)leftBarButtonItemAction
{
    
  
    AboutUsViewController *aboutUsVC = [[AboutUsViewController alloc] init];
    aboutUsVC.title =@"关于我们";
    UINavigationController *aboutUsNc = [[UINavigationController alloc] initWithRootViewController:aboutUsVC];
    [self.navigationController presentViewController:aboutUsNc animated:YES completion:nil];
    
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
    //NSLog(@"%f",y);
    if (y >=-8) {
        [self hideTabBar];
    }else{
        [self showTabBar];
    }
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
       //加判断为空的时候,
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    
    
    AVUser *currentUser = [AVUser currentUser];
    if (currentUser != nil) {
        return self.G_UserArr.count;
    } else {
        return 0;
    }

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
    UserLoginModel *user = self.G_UserArr[indexPath.row];
    
    
    
    cell.backgroundColor = [UIColor colorWithRed:251/255.0 green:247/255.0 blue:237/255.0 alpha:1];
    cell.myBackgroundView.backgroundColor = [UIColor colorWithRed:251/255.0 green:247/255.0 blue:237/255.0 alpha:1];
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
    
    
  //  dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)( 1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.G_UserArr removeObjectAtIndex:indexPath.section ];
        //    NSLog(@"%@",self.G_UserArr);
        
        //2 操作ui
        NSLog(@"%@d",@[indexPath]);
       // [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationRight];
          [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationLeft];
        
  //  });
 }


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    return 150;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.scrollFlag = NO;
    
    
    UserLoginModel *user = self.G_UserArr[indexPath.row];
    
    self.destinationDilVc  = [[DestinationDailViewController alloc] init];
    
    [self p_setupProgressHud];
    self.destinationDilVc.G_imageURL = user.imageUrl;
    // NSLog(@"%@",d.cover);
    [self G_getMothData:user.type id:user.id1];
    
    NSLog(@"%ld====%ld",(long)indexPath.section,(long)indexPath.row);
    
}
-(void)G_getMothData:(NSString *)type id:(NSString *)id1
{
     
    
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

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 1;
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
