//
//  ViewController.m
//  MyBody
//
//  Created by lanou3g on 15/11/8.
//  Copyright © 2015年 lanou3g. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title =@"用户注册隐私协议";
    
    NSString * s = @"\n用户注册隐私协议\n一、总则\n    1.1 用户在注册之前，应当仔细阅读本协议，并同意遵守本协议后方可成为注册用户。用户在使用特殊的服务或产品时，应当同意接受相关协议后方能使用。\n \n   1.2 本协议由点滴团队更新，用户应当及时关注并同意本站不承担通知义务。本站的通知、公告、声明或其它类似内容是本协议的一部分。\n  \n  二、服务内容\n\n    2.1 本站仅提供相关的网络服务，除此之外与相关网络服务有关的设备(如个人电脑、手机、及其他与接入互联网或移动网有关的装置)及所需的费用(如为接入互联网而支付的电话费及上网费、为使用移动网而支付的手机费)均应由用户自行负担。\n \n   三、用户帐号\n\n    3.1 经本站注册系统完成注册程序并通过身份认证的用户即成为正式用户，可以获得本站规定用户所应享有的一切权限；未经认证仅享有本站规定的部分会员权限。知晓团队有权对会员的权限设计进行变更。\n \n   3.2 用户只能按照注册要求使用合法账号注册。用户有义务保证密码和帐号的安全，用户利用该密码和帐号所进行的一切活动引起的任何损失或损害，由用户自行承担全部责任，本团队不承担任何责任。如用户发现帐号遭到未授权的使用或发生其他任何安全问题，应立即修改帐号密码并妥善保管，如有必要，请通知本站。因黑客行为或用户的保管疏忽导致帐号非法使用，本站不承担任何责任。\n\n    四、使用规则\n\n    4.1 遵守中华人民共和国相关法律法规，包括但不限于《中华人民共和国计算机信息系统安全保护条例》、《计算机软件保护条例》、《最高人民法院关于审理涉及计算机网络著作权纠纷案件适用法律若干问题的解释(法释[2004]1号)》、《全国人大常委会关于维护互联网安全的决定》、《互联网电子公告服务管理规定》、《互联网新闻信息服务管理规定》、《互联网著作权行政保护办法》和《信息网络传播权保护条例》等有关计算机互联网规定和知识产权的法律和法规、实施办法。    4.2 用户对其自行发表、上传或传送的内容负全部责任，所有用户不得在本app任何页面发送含有下列内容之一的信息，否则本团队有权自行处理并不通知用户：\n\n    (1)违反宪法确定的基本原则的；\n \n   (2)危害国家安全，泄漏国家机密，颠覆国家政权，破坏国家统一的；\n \n   (3)损害国家荣誉和利益的；\n \n   (4)煽动民族仇恨、民族歧视，破坏民族团结的；\n \n   (5)破坏国家宗教政策，宣扬邪教和封建迷信的；\n\n    (6)散布谣言，扰乱社会秩序，破坏社会稳定的；\n \n   (7)散布淫秽、色情、赌博、暴力、恐怖或者教唆犯罪的；\n\n    (8)侮辱或者诽谤他人，侵害他人合法权益的；\n \n   (9)煽动非法集会、结社、游行、示威、聚众扰乱社会秩序的；\n \n   (10)以非法民间组织名义活动的；\n    (11)含有法律、行政法规禁止的其他内容的。\n \n   五、隐私保护\n \n   5.1 本团队不对外公开或向第三方提供单个用户的注册资料及用户在使用网络服务时存储在本站的非公开内容。\n \n   5.2 在不透露单个用户隐私资料的前提下，本站有权对整个用户数据库进行分析并对用户数据库进行商业上的利用。\n \n   六、责任声明\n \n   6.1 本团队有权于任何时间暂时或永久修改或终止本服务。\n \n   七、附则\n\n    7.1 本协议的订立、执行和解释及争议的解决均应适用中华人民共和国法律。 \n  \n  7.2 如本协议中的任何条款无论因何种原因完全或部分无效或不具有执行力，本协议的其余条款仍应有效并且有约束力。\n";
    
    
    UIScrollView *scroll = [[UIScrollView alloc] initWithFrame:CGRectMake(10, 20, CGRectGetWidth(self.view.frame)-20, CGRectGetHeight(self.view.frame))];
    
    
    scroll.contentSize = CGSizeMake(CGRectGetWidth(self.view.frame)-20, [self G_heightForString:s]+40*3);
    
    
    
    [self.view addSubview:scroll];
    
    
    
    UILabel * laber = [[UILabel alloc] initWithFrame:CGRectMake(0, 20, CGRectGetWidth(scroll.frame), [self G_heightForString:s]+40*2)];
    laber.backgroundColor = [UIColor colorWithRed:251/255.0 green:247/255.0 blue:237/255.0 alpha:1];
    laber.numberOfLines = 0;
    laber.text = s;
    laber.textAlignment = NSTextAlignmentCenter;
    [scroll addSubview:laber];
    


}
-(CGFloat)G_heightForString:(NSString *)aString
{
    NSDictionary *dict = @{NSFontAttributeName:[UIFont systemFontOfSize:17.2]};// 一定要大于等于实际的字体
    //将传进来的字符串放在一个矩形中
    CGRect rect = [aString boundingRectWithSize:CGSizeMake(CGRectGetWidth(self.view.frame)-20, 2000) options:NSStringDrawingUsesLineFragmentOrigin attributes:dict context:nil];
    return rect.size.height;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
