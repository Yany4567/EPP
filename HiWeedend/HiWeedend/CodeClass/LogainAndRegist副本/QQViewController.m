//
//  QQViewController.m
//  HiWeedend
//
//  Created by lanou3g on 16/4/28.
//  Copyright © 2016年 高艳闯. All rights reserved.
//

#import "QQViewController.h"
#import "UMSocial.h"
#import "DrawerViewController.h"
#import "HomePageListViewController.h"
#import "AppDelegate.h"
#import "ModfileViewController.h"

@interface QQViewController ()

@end

@implementation QQViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"返回" style:(UIBarButtonItemStyleDone) target:self action:@selector(backAction:)];
    // Do any additional setup after loading the view from its nib.
}
- (IBAction)QQlogin:(id)sender {
    
    UMSocialSnsPlatform *snsPlatform = [UMSocialSnsPlatformManager getSocialPlatformWithName:UMShareToQQ];
    
    snsPlatform.loginClickHandler(self,[UMSocialControllerService defaultControllerService],YES,^(UMSocialResponseEntity *response){
        
        //          获取微博用户名、uid、token等
        
        if (response.responseCode == UMSResponseCodeSuccess) {
            
            UMSocialAccountEntity *snsAccount = [[UMSocialAccountManager socialAccountDictionary] valueForKey:UMShareToQQ];
            
            NSLog(@"username is %@, uid is %@, token is %@ url is %@",snsAccount.userName,snsAccount.usid,snsAccount.accessToken,snsAccount.iconURL);
            [UserInfoManager conserveUserName:snsAccount.userName];
            [UserInfoManager conserveUserID:snsAccount.usid];
            [UserInfoManager conserveUserIcon:snsAccount.iconURL];
            ModfileViewController *modVC = [[ModfileViewController alloc]init];
            modVC.nameString = snsAccount.userName;
            modVC.iconURL = snsAccount.iconURL;
            
            
        }});

    [self dismissViewControllerAnimated:YES completion:nil];

    
    
}
- (IBAction)backAction:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
    
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
