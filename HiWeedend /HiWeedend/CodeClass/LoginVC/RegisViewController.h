//
//  RegisViewController.h
//  HiWeedend
//
//  Created by lanou3g on 16/4/20.
//  Copyright © 2016年 高艳闯. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RegisViewController : UIViewController

@property(nonatomic,strong)UITextField*regisPhoneNumber;
@property(nonatomic,strong)UITextField*regisPassword;
@property(nonatomic,strong)UITextField*regisPasswordAgein;

-(void)keyChina;

@end
