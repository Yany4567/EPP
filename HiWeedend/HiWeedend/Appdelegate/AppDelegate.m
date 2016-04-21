//
//  AppDelegate.m
//  HiWeedend
//
//  Created by lanou3g on 16/4/16.
//  Copyright © 2016年 高艳闯. All rights reserved.
//

#import "AppDelegate.h"
#import "HomePageListViewController.h"
#import "DrawerViewController.h"
#import "MenuViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    //主页显示功能
//    HomePageListViewController*homeVC=[[HomePageListViewController alloc]init];
//    UINavigationController*navController=[[UINavigationController alloc]initWithRootViewController:homeVC];
//    
//    //创建抽屉对象
//    DrawerViewController*rootController=[[DrawerViewController alloc]initWithRootViewController:navController];
//    //创建菜单对象
//    MenuViewController*leftVC=[[MenuViewController alloc]init];
//    rootController.leftViewController = leftVC;
//    //将抽屉对象设置为window 主视图
//    self.window.rootViewController =rootController;
//    self.window.backgroundColor=[UIColor whiteColor];
    


   HomePageListViewController *readVC =  [[HomePageListViewController alloc] init];
    UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:readVC];
    //  创建抽屉对象
    DrawerViewController *rootController = [[DrawerViewController alloc] initWithRootViewController:navController];
    _drawerController = rootController;
    //  创建菜单对象
    MenuViewController *leftController = [[MenuViewController alloc] init];
    rootController.leftViewController = leftController;
    //  将抽屉对象设置成window的主视图控制器
    self.window.rootViewController = rootController;
    self.window.backgroundColor = [UIColor whiteColor];
    
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
