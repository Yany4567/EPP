//
//  RegisViewController.m
//  HiWeedend
//
//  Created by lanou3g on 16/4/20.
//  Copyright © 2016年 高艳闯. All rights reserved.
//


//秘钥加密存储
#import "RegisViewController.h"



@interface RegisViewController ()

@end

@implementation RegisViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   self.title = @"输入密码";

    [self addView];


}



-(void)addView{

    self.regisPhoneNumber =[[UITextField alloc]initWithFrame:CGRectMake(20, 80, kWidth-40, 45)];
    self.regisPassword =[[UITextField alloc]initWithFrame:CGRectMake(20, CGRectGetMaxY(self.regisPhoneNumber.frame)+15, kWidth-40, 45)];
   self.regisPasswordAgein =[[UITextField alloc]initWithFrame:CGRectMake(20, CGRectGetMaxY(self.regisPassword.frame)+15, kWidth-40, 45)];

        self.regisPasswordAgein.borderStyle =UITextGranularitySentence;
        self.regisPassword.borderStyle =UITextGranularitySentence;
        self.regisPhoneNumber.borderStyle =UITextGranularitySentence;
     self.regisPhoneNumber.layer.cornerRadius=8;
     self.regisPassword.layer.cornerRadius=8;
     self.regisPasswordAgein.layer.cornerRadius=8;
    
    self.regisPhoneNumber.placeholder=@"请输入电话号码";
    self.regisPassword.placeholder=@"请输入密码";
    self.regisPasswordAgein.placeholder=@"请再次输入密码";
    

    UIButton*button=[UIButton buttonWithType:(UIButtonTypeSystem)];
    button.frame=CGRectMake(20, CGRectGetMaxY(self.regisPasswordAgein.frame)+35, kWidth-40, 45);
    [button setTitle:@"注册" forState:(UIControlStateNormal)];
    [self.view addSubview:button];
     [button addTarget:self action:@selector(finisnAction:) forControlEvents:(UIControlEventTouchUpInside)];
    
    UIButton*buttonRember=[UIButton buttonWithType:(UIButtonTypeSystem)];
   buttonRember.frame=CGRectMake(20, CGRectGetMaxY(button.frame)+15, kWidth-40, 45);
    [buttonRember setTitle:@"记住账号" forState:(UIControlStateNormal)];

    button.layer.cornerRadius=8;
    buttonRember.layer.cornerRadius=8;
    
    [button setBackgroundColor:[UIColor cyanColor]];
    [buttonRember setBackgroundColor:[UIColor yellowColor]];
    
      [self.view addSubview:self.regisPhoneNumber];
     [self.view addSubview:self.regisPassword];
      [self.view addSubview:self.regisPasswordAgein];
     [self.view addSubview:button];
     [self.view addSubview:buttonRember];
    
    [button addTarget:self action:@selector(finisnAction:) forControlEvents:(UIControlEventTouchUpInside)];
       [buttonRember addTarget:self action:@selector(remberAction:) forControlEvents:(UIControlEventTouchUpInside)];
    
}
//完成button
-(void)finisnAction:(UIButton*)senser{
    if (self.regisPhoneNumber.text .length<11) {
        [self alrect:@"电话号码输入错误,请重新输入"];
    }
    
    
    if ([self.regisPasswordAgein.text isEqualToString:self.regisPassword.text]) {
        
        [self keyChina];
                
    }else{
        [self alrect:@"两次输入密码不同,请重新输入"];
        
    }


}


//记住账号button
-(void)remberAction:(UIButton*)senser{
    
    [self keyChina];
}


-(void)keyChina{

    //创建初始化
//    KeychainItemWrapper*wrapper=[[KeychainItemWrapper alloc]initWithIdentifier:keyChainKEY accessGroup:nil];
//    
//    //系统中提供的键值对中的两个键,非系统提供的键是没办法添加到字典中的
//    id kUserNameKey = (__bridge id)kSecAttrAccount;
//    id kPassWordKey = (__bridge id)kSecValueData;
//    
//    //存储
//    [wrapper setObject:self.regisPhoneNumber.text forKey:kUserNameKey];
//    [wrapper setObject:self.regisPasswordAgein.text forKey:kPassWordKey];
//    NSLog(@"%@",wrapper);
//    
    //
    //        //通过相同标记创建的钥匙串 具有相同数据 可以看做是一个对象
    //        KeychainItemWrapper *wrapper_get=[[KeychainItemWrapper alloc]initWithIdentifier:keyChainKEY accessGroup:nil];
    //        //取值
    //        NSString*userName=[wrapper_get objectForKey:kUserNameKey];
    //        NSLog(@"%@",userName);
    //        NSLog(@"%@",[wrapper_get objectForKey:kPassWordKey]);
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    [user setObject: self.regisPhoneNumber.text forKey:@"userPassWord"];
       [user setObject: self.regisPasswordAgein.text forKey:@"userName"];
    
    
    
    



}


//开发实际应用中存储唯一设备的表示 一般是用 与后台做当前app的数据统计



//警告框
-(void)alrect:(NSString*)string{
    
    UIAlertController*alrect=[UIAlertController alertControllerWithTitle:@"提示" message: string preferredStyle:(UIAlertControllerStyleAlert)];
    
    UIAlertAction*al=[UIAlertAction actionWithTitle:@"返回" style:(UIAlertActionStyleDefault) handler:nil];
    UIAlertAction*al1=[UIAlertAction actionWithTitle:@"确定" style:(UIAlertActionStyleDefault) handler:nil];
    
    [alrect addAction:al1];
    [alrect addAction:al];
    [self presentViewController:alrect animated:YES completion:nil];
    
    
}

//返回
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    
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
