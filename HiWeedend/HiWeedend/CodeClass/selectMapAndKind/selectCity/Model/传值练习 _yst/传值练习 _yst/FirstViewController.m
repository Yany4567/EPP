//
//  FirstViewController.m
//  传值练习 _yst
//
//  Created by lanou3g on 16/4/24.
//  Copyright © 2016年 YST. All rights reserved.
//

#import "FirstViewController.h"

@interface FirstViewController ()
@property(nonatomic,strong)UILabel*labelv;
@end

@implementation FirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.labelv=[[UILabel alloc]initWithFrame:CGRectMake(50, 100, 200, 40)];
    self.labelv.backgroundColor=[UIColor whiteColor];
    
    [self.view addSubview:self.labelv];
    self.labelv.text =self.string;
    self.view.backgroundColor=[UIColor cyanColor];
    
    
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    
    [self.navigationController popToRootViewControllerAnimated:YES];
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
