//
//  UserLoginVC.m
//  MyBody
//
//  Created by hua on 16/7/18.
//  Copyright © 2016年  . All rights reserved.
//

#import "UserLoginVC.h"
#import "UserLoginMainView.h"
#import "UserLoginView.h"
#import "UserRegisterView.h"
@interface UserLoginVC ()<UserLoginViewDelegate,UserRegisterViewDelegate>
@property(nonatomic,strong)UserLoginMainView *MainView;
@end

@implementation UserLoginVC
{
     UIView *  navationBar;

}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self createUI];
    [self createNaviUI];
}



#pragma mark - 导航栏
-(void)createNaviUI{
    navationBar = [[UIView alloc]initWithFrame:CGRectMake(0.0, [[UIApplication sharedApplication] statusBarFrame].size.height, MainScreenWidth, 44)];
    UIView * statusBarView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, MainScreenWidth , 20)];
    
    CGFloat W = self.view.bounds.size.width;
    UIView *xian = [[UIView alloc]initWithFrame:CGRectMake(0, 64, W, 0.5)];
    
    navationBar.backgroundColor = [UIColor clearColor];//CustomerColor(35, 150, 253);
    statusBarView.backgroundColor = [UIColor clearColor];// CustomerColor(20, 147, 255);
    xian.backgroundColor = [UIColor clearColor];
    [self.view addSubview:navationBar];
    [self.view addSubview:statusBarView];
    [self.view addSubview:xian];
    
    
       UIButton *   leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [leftButton setImage:[UIImage imageNamed:@"icon_nav_back_button"] forState:UIControlStateNormal];
    leftButton.frame = CGRectMake(15, 44/2-7 , 20, 20);
    [leftButton addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
    
    UIImageView *naviImg = [[UIImageView alloc]initWithFrame:CGRectMake(MainScreenWidth/2-G_Iphone6(60), 44/2-G_Iphone6(26/2), G_Iphone6(120),G_Iphone6(26))];
    naviImg.image = [UIImage imageNamed:@"NaviTitleImg"];
   
    
    [navationBar addSubview:leftButton];
    [navationBar addSubview:naviImg];
         
}
-(void)backAction
{
    [self dismissViewControllerAnimated:YES completion:nil];
}
-(void)createUI
{
    UIImageView *backImg = [[ UIImageView alloc] initWithFrame:self.view.bounds];
    backImg.image = [ UIImage imageNamed:@"UserLogin"];
    [self.view addSubview:backImg];
    
     UIScrollView * bgScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 64, MainScreenWidth, MainScreenHeight-64)];
    bgScrollView.contentSize = CGSizeMake(MainScreenWidth, MainScreenHeight*(1+0.2));
    [self.view addSubview:bgScrollView];
    
    [self stopKeyBoard:bgScrollView];
    //
    _MainView = [[UserLoginMainView alloc] initWithFrame:self.view.bounds];
    _MainView.userLoginView.delegate = self;
    _MainView.registerView.delegate = self;
    [bgScrollView addSubview:_MainView];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)stopKeyBoard:(UIView *)view
{
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(keyboardHide:)];
    //设置成NO表示当前控件响应后会传播到其他控件上，默认为YES。
    tapGestureRecognizer.cancelsTouchesInView = NO;
    //将触摸事件添加到当前view
    [view addGestureRecognizer:tapGestureRecognizer];
    
}

-(void)keyboardHide:(UITapGestureRecognizer*)tap{
    DoLog(@"d 00");
  [tap.view endEditing:YES];
}

-(void)loginAction:(NSString *)UserName psd:(NSString *)psd
{
    
    [AVUser logInWithUsernameInBackground:UserName password:psd block:^(AVUser *user, NSError *error) {
        if (user != nil) {
            //  NSString *name = self.lv.loginTextField.text;
            UserLoginModel *u = [[UserLoginModel alloc] init];
            u.username = UserName;
            u.password = psd;
            
            [[G_shareTools shareTools]setUserLogin:u];
//            self.mblock(u);
            [AlertShow alertShowWithContent:@"登陆成功:" Seconds:0.5f];
            [Toolshares resetLoginCode:@"0"];
            
           [self dismissViewControllerAnimated:YES completion:nil];
        } else {
            
            // 登录失败
             NSLog(@"登陆失败");
            [AlertShow alertShowWithContent:@"用户名或密码错误:" Seconds:1.0f];
        }
    }];

}

-(void)RegisternAction:(NSString *)UserName emil:(NSString *)emil phone:(NSString *)phone password:(NSString *)password agapsd:(NSString *)agapsd
{
    AVObject *testObject = [AVObject objectWithClassName:[NSString stringWithFormat:@"%@",[Toolshares getUserLogin]]];
    [testObject save];
    [testObject deleteInBackground];
    
    AVUser *user = [AVUser user];
    user.username =  UserName;
    user.password = password  ;
    user.email = emil;
    
    
    [user setObject:phone forKey:@"phone"];
    NSLog(@"正在注册");
    [user signUpInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (succeeded) {
            NSLog(@"注册成功");
             [Toolshares resetLoginCode:@"0"];
            UserLoginModel *u = [[UserLoginModel alloc] init];
            u.username = UserName;
            u.password = password;
             [[G_shareTools shareTools]setUserLogin:u];
          [self dismissViewControllerAnimated:YES completion:nil];
        } else {
            NSLog(@"注册失败,%ld",error.code);
            if (error.code == 202) {
                [AlertShow alertShowWithContent:@"此用户名已存在,换个再来" Seconds:1.f];
            }
            if (error.code == 203) {
                [AlertShow alertShowWithContent:@"电子邮箱地址已经被占用" Seconds:1.f];
            }
            
        }
    }];
    

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
