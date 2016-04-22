//
//  LoginViewController.h
//  HiWeedend
//
//  Created by lanou3g on 16/4/20.
//  Copyright © 2016年 高艳闯. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoginViewController : UIViewController

@property(nonatomic,strong)UITextField*loginPhonefiled;
@property(nonatomic,strong)UITextField*loginPassword;
@property (weak, nonatomic) IBOutlet UIButton *weibo;
@property (weak, nonatomic) IBOutlet UIButton *weichat;
@end
