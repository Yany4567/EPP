//
//  QQLoginViewController.m
//  HiWeedend
//
//  Created by lanou3g on 16/4/27.
//  Copyright © 2016年 高艳闯. All rights reserved.
//

#import "QQLoginViewController.h"
#import "UMSocial.h"
#import "DrawerViewController.h"
#import "HomePageListViewController.h"
#import "AppDelegate.h"


@interface QQLoginViewController ()

@end

@implementation QQLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (IBAction)QQLoginAction:(id)sender {
    
    UMSocialSnsPlatform *snsPlatform = [UMSocialSnsPlatformManager getSocialPlatformWithName:UMShareToQQ];
    
    snsPlatform.loginClickHandler(self,[UMSocialControllerService defaultControllerService],YES,^(UMSocialResponseEntity *response){
        
        //          获取微博用户名、uid、token等
        
        if (response.responseCode == UMSResponseCodeSuccess) {
            
            UMSocialAccountEntity *snsAccount = [[UMSocialAccountManager socialAccountDictionary] valueForKey:UMShareToQQ];
            
            NSLog(@"username is %@, uid is %@, token is %@ url is %@",snsAccount.userName,snsAccount.usid,snsAccount.accessToken,snsAccount.iconURL);
            // 储存用户信息
            [UserInfoManager conserveUserName:snsAccount.userName];
            [UserInfoManager conserveUserID:snsAccount.usid];
            [UserInfoManager conserveUserIcon:snsAccount.iconURL];
            
                   }});
    // 返回首界面
    DrawerViewController *menuController = (DrawerViewController*)((AppDelegate *)[[UIApplication sharedApplication] delegate]).drawerController;

    HomePageListViewController*homeVc=[[HomePageListViewController alloc]init];
    
    
    UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:homeVc];
    
    [menuController setRootController:navController animated:YES];

    

    
    
}


- (IBAction)backAction:(id)sender {
    
    DrawerViewController *menuController = (DrawerViewController*)((AppDelegate *)[[UIApplication sharedApplication] delegate]).drawerController;
    
        HomePageListViewController*homeVc=[[HomePageListViewController alloc]init];
    
    
        UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:homeVc];
    
        [menuController setRootController:navController animated:YES];
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
