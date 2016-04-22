//
//  LoginViewController.m
//  HiWeedend
//
//  Created by lanou3g on 16/4/20.
//  Copyright © 2016年 高艳闯. All rights reserved.
//

#import "LoginViewController.h"
#import "RegisViewController.h"


@interface LoginViewController ()



@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
self.title=@" 登录";
//    self.loginPhoneTextfile.frame=CGRectMake(20, 200, self.view.frame.size.width-40, 100);

    [self addView];
    

    
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    NSString *passWord = [ user objectForKey:@"userPassWord"];
    self.loginPhonefiled.text =passWord;
    
}

-(void)addView{

    UITextField*phone=[[UITextField alloc]init];
    phone.frame=CGRectMake(20, 240, kWidth-40, 45);
    phone.backgroundColor=[UIColor redColor];
    [self.view addSubview:phone];
    UITextField*password=[[UITextField alloc]init];
    password.frame=CGRectMake(20, CGRectGetMaxY(phone.frame)+15, kWidth-40, 45);
    password.backgroundColor=[UIColor redColor];
    [self.view addSubview:password];
    
    phone.layer.cornerRadius=8;
    password.layer.cornerRadius=8;
    self.loginPhonefiled = phone;
    self.loginPassword = password;
    self.loginPassword.secureTextEntry=YES;
    
    self.loginPhonefiled.placeholder=@"请输入电话号码";
    self.loginPassword.placeholder=@"请输入密码";
    
    UIView*left =[[UIView alloc]initWithFrame:CGRectMake(20, CGRectGetMaxY(self.weichat.frame)+35, (kWidth-100)/2-10, 2)];
    UIView*right =[[UIView alloc]initWithFrame:CGRectMake(kWidth -(kWidth-100)/2-20, CGRectGetMaxY(self.weichat.frame)+35,(kWidth-100)/2-10, 2)];
    left.backgroundColor=[UIColor redColor];
    right.backgroundColor=[UIColor yellowColor];
    [self.view addSubview:left];
    [self.view addSubview:right];
    
    UILabel*label=[[UILabel alloc]initWithFrame:CGRectMake((kWidth-100)/2+35, CGRectGetMaxY(self.weichat.frame)+20, 60, 30)];
   label.text=@"或者";
    [self.view addSubview:label];
    
    //button
    
  UIButton*  quickButton=[UIButton buttonWithType:(UIButtonTypeSystem)];
    UIButton*  finish=[UIButton buttonWithType:(UIButtonTypeSystem)];
    UIButton*  regist=[UIButton buttonWithType:(UIButtonTypeSystem)];
    
    [quickButton setBackgroundColor:[UIColor yellowColor]];
    [regist setBackgroundColor:[UIColor cyanColor]];
     [finish setBackgroundColor:[UIColor purpleColor]];
    
    quickButton.frame = CGRectMake(20, CGRectGetMaxY(self.loginPassword.frame)+35, 100, 40);
    finish.frame = CGRectMake(CGRectGetMaxX(quickButton.frame)+32, CGRectGetMaxY(self.loginPassword.frame)+35, 100, 40);
      regist.frame = CGRectMake(CGRectGetMaxX(finish.frame)+32, CGRectGetMaxY(self.loginPassword.frame)+35, 100, 40);
    quickButton.layer.cornerRadius=8;
    finish.layer.cornerRadius=8;
    regist.layer.cornerRadius=8;
    
        [quickButton setTitle:@"快速登录" forState:(UIControlStateNormal)];
        [finish setTitle:@"登录 " forState:(UIControlStateNormal)];
        [regist setTitle:@" 注册" forState:(UIControlStateNormal)];
    
    
    [self.view addSubview:finish];
    [self.view addSubview:quickButton];
    [self.view addSubview:regist];
  
    

    
  
    
    [quickButton addTarget:self action:@selector(quickAction:) forControlEvents:(UIControlEventTouchUpInside)];
     [finish addTarget:self action:@selector(finishAction:) forControlEvents:(UIControlEventTouchUpInside)];
     [regist addTarget:self action:@selector(regisAction:) forControlEvents:(UIControlEventTouchUpInside)];
    
}

//跳转到注册页面
-(void)regisAction:(UIButton*)sender{

    
    
    RegisViewController*regis=[[RegisViewController alloc]init];
    UINavigationController*na=[[UINavigationController alloc]initWithRootViewController:regis];
    na.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
    
    [self.navigationController presentViewController:na animated:YES completion:nil];
    
    
}

//点击登录跳转到收藏页面
-(void)finishAction:(UIButton*)sender{

    
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    NSString *passWord = [ user objectForKey:@"userName"];
    //self.loginPhonefiled.text =passWord;
    
    if([self.loginPassword.text isEqualToString: passWord] ){
    NSLog(@"登录成功");
    
    }else{
    
        [self alrect:@"密码输入错误,登录失败!"];
    
    }
    
}

//已注册一键登录
-(void)quickAction:(UIButton*)sender{
    
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    NSString *passWord = [ user objectForKey:@"userPassWord"];
    self.loginPhonefiled.text =passWord;
    
  
}

//警告框
-(void)alrect:(NSString*)string{
    
    UIAlertController*alrect=[UIAlertController alertControllerWithTitle:@"提示" message: string preferredStyle:(UIAlertControllerStyleAlert)];
    
    UIAlertAction*al=[UIAlertAction actionWithTitle:@"返回" style:(UIAlertActionStyleDefault) handler:nil];
    UIAlertAction*al1=[UIAlertAction actionWithTitle:@"确定" style:(UIAlertActionStyleDefault) handler:nil];
    
    [alrect addAction:al1];
    [alrect addAction:al];
    [self presentViewController:alrect animated:YES completion:nil];
    
    
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
