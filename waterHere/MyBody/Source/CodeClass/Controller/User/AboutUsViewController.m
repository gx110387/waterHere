//
//  AboutUsViewController.m
//  ZouZou
//
//  Created by lanou3g on 15/10/27.
//  Copyright (c) 2015年 lanou3g. All rights reserved.
//

#import "AboutUsViewController.h"

@interface AboutUsViewController ()

@end

@implementation AboutUsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    // Do any additional setup after loading the view.
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"关闭"   style:UIBarButtonItemStyleDone target:self action:@selector(leftBarButtonItemAction)];

    NSString *s = @"\n\n关于我们\n \n  点滴旅行是一款查看其他人探索世界的轨迹，收获旅途中的点点滴滴,把世界景点收入手中的app应用。让你足不出门,就可以看到世界的精彩瞬间、旅行线路。通过查看附近景点,让你的出行轻松自由,把你喜欢的游记,景点收藏起来,时刻回温那梦想已久的目的地, 你还可以方便地通过新浪微博等社交网络将你看到的游记分享出去，和更多朋友分享你的喜悦,让你的生活充满色彩。\n\n 版本:V1.1\n\n";
    
    
    UILabel * laber = [[UILabel alloc] initWithFrame:CGRectMake(20, 20, CGRectGetWidth(self.view.frame)-40, [self G_heightForString:s]+40)];
    laber.backgroundColor = [UIColor colorWithRed:251/255.0 green:247/255.0 blue:237/255.0 alpha:1];
    laber.numberOfLines = 0;
    laber.text = s;
    laber.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:laber];
    
    
    
}
#pragma mark 关于我们
-(void)leftBarButtonItemAction
{
   
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(CGFloat)G_heightForString:(NSString *)aString
{
    NSDictionary *dict = @{NSFontAttributeName:[UIFont systemFontOfSize:17.2]};// 一定要大于等于实际的字体
    //将传进来的字符串放在一个矩形中
    CGRect rect = [aString boundingRectWithSize:CGSizeMake(CGRectGetWidth(self.view.frame)-20, 2000) options:NSStringDrawingUsesLineFragmentOrigin attributes:dict context:nil];
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
