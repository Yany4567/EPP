//
//  ThirdViewController.m
//  传值练习 _yst
//
//  Created by lanou3g on 16/4/24.
//  Copyright © 2016年 YST. All rights reserved.
//

#import "ThirdViewController.h"

@interface ThirdViewController ()
@property(nonatomic,strong)UITextField * firstT;
@end

@implementation ThirdViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.firstT =[[UITextField alloc]initWithFrame:CGRectMake(50, 100, 200, 40)];
    self.firstT.backgroundColor=[UIColor whiteColor];
    
    [self.view addSubview:self.firstT];
    self.view.backgroundColor=[UIColor cyanColor];
        NSLog(@"%@",self.firstT.text);
    
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    self.passBlock(self.firstT.text);
    NSLog(@"%@",self.firstT.text);

 
    [self.navigationController popToViewController:self.navigationController.viewControllers[1] animated:YES];
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
