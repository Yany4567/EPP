//
//  MenuViewController.m
//  Leisure
//
//  Created by wenze on 16/3/28.
//  Copyright © 2016年 wenze. All rights reserved.
//

#import "MenuViewController.h"
#import "AppDelegate.h"
#import "DrawerViewController.h"
#import "HomePageListViewController.h"
#import "ModfileViewController.h"
#import "SelectHobbyViewController.h"
#import "SelectBookViewController.h"
#import "CollectActionViewController.h"
#import "SettingViewController.h"
#import "QQLoginViewController.h"

@interface MenuViewController () {
    NSMutableArray *list;  //  菜单列表数据源
}

@end

@implementation MenuViewController

-(void)viewWillAppear:(BOOL)animated{
    list = [[NSMutableArray alloc]init];
    if ([[UserInfoManager getUserID]isEqualToString:@" "]) {
        [list removeAllObjects];
        //例子
        [list addObject:@"首页"];
        // [list addObject:@"修改个人资料"];
        // [list addObject:@"收藏活动"];
        [list addObject:@"设置"];
        [list addObject:@"登录"];
        
    }else{
        [list removeAllObjects];
        [list addObject:@"首页"];
//        [list addObject:@"修改个人资料"];

        [list addObject:@"收藏活动"];
        [list addObject:@"设置"];

    
}
    [self.listTable reloadData];

}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        
//    });
    list = [[NSMutableArray alloc]init];
    if ([[UserInfoManager getUserID]isEqualToString:@" "]) {
        [list removeAllObjects];
    //例子
    [list addObject:@"首页"];
   // [list addObject:@"修改个人资料"];
   // [list addObject:@"收藏活动"];
   [list addObject:@"设置"];
       [list addObject:@"登录"];

    }else{
        [list removeAllObjects];
        [list addObject:@"首页"];
//        [list addObject:@"修改个人资料"];
        [list addObject:@"收藏活动"];
        [list addObject:@"设置"];
        //[list addObject:@"登录"];
        
        
    }
    
    }

//改变行的高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
}
//返回TableView中有多少数据
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return list.count;
}
//返回有多少个TableView
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
//组装每一条的数据
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
//    static NSString *CustomCellIdentifier =@"CellIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier: @"cell"];
    if (cell ==nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    cell.textLabel.text = [list objectAtIndex:indexPath.row];

    
    return cell;
}


//选中Cell响应事件
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    //  获取抽屉对象
    DrawerViewController *menuController = (DrawerViewController*)((AppDelegate *)[[UIApplication sharedApplication] delegate]).drawerController;
    if ([[UserInfoManager getUserID]isEqualToString:@" "]) {
        if(indexPath.row == 0) {  // 设置首页为抽屉的根视图
            //        NSLog(@"1111111");
            
            HomePageListViewController*homeVc=[[HomePageListViewController alloc]init];
            
            
            UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:homeVc];
            
            
            [menuController setRootController:navController animated:YES];
                }else if(indexPath.row == 1){ //设置 设置页面为抽屉的根视图
            SettingViewController *controller = [[SettingViewController  alloc] init];
            UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:controller];
            [menuController setRootController:navController animated:YES];
        }else{
            // 设置登陆界面为根视图
            QQLoginViewController *controller = [[QQLoginViewController  alloc] init];
            UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:controller];
           [menuController setRootController:navController animated:YES];
            
        }

    }else{
        
        if(indexPath.row == 0) {  // 设置首页为抽屉的根视图
            //        NSLog(@"1111111");
            
            HomePageListViewController*homeVc=[[HomePageListViewController alloc]init];
            
            
            UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:homeVc];
            
            
            [menuController setRootController:navController animated:YES];
//        }else if(indexPath.row == 1){
//            ModfileViewController *controller = [[ModfileViewController alloc] init];
//            UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:controller];
//            [menuController setRootController:navController animated:YES];
        } else if(indexPath.row == 1){ //设置收藏为抽屉的根视图
            CollectActionViewController *controller = [[CollectActionViewController alloc] init];
            UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:controller];
            [menuController setRootController:navController animated:YES];
        }else if(indexPath.row == 2){ //设置 设置界面 为抽屉的根视图
            SettingViewController *controller = [[SettingViewController alloc] init];
            UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:controller];
            [menuController setRootController:navController animated:YES];

        
    }
    
    }
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
