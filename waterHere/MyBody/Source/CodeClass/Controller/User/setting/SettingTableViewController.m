//
//  SettingTableViewController.m
//  ZouZou
//
//  Created by gx110387 on 15/10/23.
//  Copyright (c) 2015年 gx110387. All rights reserved.
//

#import "SettingTableViewController.h"
#import "SDImageCache.h"

@interface SettingTableViewController ()<UIAlertViewDelegate>

@end

@implementation SettingTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
 

}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
 
    // Return the number of sections.
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
 

    
    if (section == 1) {
        return 1;
    }
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" ];
    
    if (cell  == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    if (indexPath.section == 0) {
        
        
        if (indexPath.row == 0) {
            
             cell.textLabel.text = [NSString stringWithFormat:@"修改密码"];
            
        }
        if (indexPath.row == 1) {
            CGFloat s = [[SDImageCache sharedImageCache] checkTmpSize];
          //  cell.lLabel.text = [NSString stringWithFormat:@"%.2fMB",s];
             cell.textLabel.text = [NSString stringWithFormat:@"清空缓存  %.2fMB",s];
            
        }
           }
    
    
    
    if (indexPath.section == 1) {
        cell.textLabel.text = [NSString stringWithFormat:@"退出登录"];
    
    }
  
    
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    NSLog(@"%ld====%ld",indexPath.section,indexPath.row);
    
    if (indexPath.section == 0 &&indexPath.row ==0) {
        // 修改密码
        restartPsdViewController *resVC = [[restartPsdViewController alloc] init];
        
        [self.navigationController  pushViewController:resVC animated:YES];
        
    }
    
    if (indexPath.section == 0 && indexPath.row == 1) {
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"确定要清除缓存么" delegate:self cancelButtonTitle:@"取消"otherButtonTitles:@"清除", nil];
        alert.tag = 100;
        [alert show];
    }
    
    
    if (indexPath.section == 1) {
        
        [AVUser logOut];  //清除缓存用户对象
       // AVUser *currentUser = [AVUser currentUser];
        
        
//            [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"isLogin"];
//            [[NSUserDefaults standardUserDefaults] synchronize];
        [self.navigationController popToRootViewControllerAnimated:YES];
         [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"isFor"];
        [Toolshares logout];
        
    }
    
    
}



- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    switch (buttonIndex) {
        case 0:
            
            break;
        case 1:
            [[SDImageCache sharedImageCache] clearDiskOnCompletion:^{
                //                [CHNotices noticesWithTitle:@"删除成功" Time:1 View:self.view Style:CHNoticesStyleSuccess];
                NSLog(@"123121234412412412");
                [self.tableView reloadData];
            }];
            break;
            
    }
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
