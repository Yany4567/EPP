//
//  SecendViewController.m
//  传值练习 _yst
//
//  Created by lanou3g on 16/4/24.
//  Copyright © 2016年 YST. All rights reserved.
//

#import "SecendViewController.h"

@interface SecendViewController ()
@property(nonatomic,strong)UITextField * firstT;

@end

@implementation SecendViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor yellowColor];
    
    self.firstT =[[UITextField alloc]initWithFrame:CGRectMake(50, 100, 200, 40)];
    self.firstT.backgroundColor=[UIColor whiteColor];
    
    [self.view addSubview:self.firstT];
    
    self.navigationItem.leftBarButtonItem=[[UIBarButtonItem alloc]initWithTitle:@"back" style:(UIBarButtonItemStylePlain) target:self action:@selector(back)];
}

-(void)back{
    
    
    //push 入栈
    //pop dismi 前传值
    [self.delegate passValue:self.firstT.text];
    
        NSArray*temp =self.navigationController.viewControllers;

    [self.navigationController popToViewController:temp[1] animated:YES];
//
//    NSArray*temp =self.navigationController.viewControllers;
//  返回根视图
   // [self.navigationController popToRootViewControllerAnimated:YES];

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
