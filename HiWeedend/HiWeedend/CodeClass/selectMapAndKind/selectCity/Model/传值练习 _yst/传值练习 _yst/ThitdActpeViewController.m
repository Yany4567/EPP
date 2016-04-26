//
//  ThitdActpeViewController.m
//  传值练习 _yst
//
//  Created by lanou3g on 16/4/24.
//  Copyright © 2016年 YST. All rights reserved.
//

#import "ThitdActpeViewController.h"
#import "ThirdViewController.h"
@interface ThitdActpeViewController ()
@property(nonatomic,strong)UILabel*labelv;
@end

@implementation ThitdActpeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor cyanColor];;
    
    self.labelv=[[UILabel alloc]initWithFrame:CGRectMake(50, 100, 200, 40)];
    self.labelv.backgroundColor=[UIColor whiteColor];
    
    [self.view addSubview:self.labelv];
    
    self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc]initWithTitle:@"next" style:(UIBarButtonItemStylePlain) target:self action:@selector(back)];
    
    
}
-(void)back{

    ThirdViewController*third=[[ThirdViewController alloc]init];
    
    //接收
    third.passBlock = ^(NSString*s) {self.labelv.text =s;};
    
    [self.navigationController pushViewController:third animated:YES];
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
