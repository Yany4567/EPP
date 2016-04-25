//
//  secendActepViewController.m
//  传值练习 _yst
//
//  Created by lanou3g on 16/4/24.
//  Copyright © 2016年 YST. All rights reserved.
//

#import "secendActepViewController.h"
#import "SecendViewController.h"
@interface secendActepViewController ()<passValueDelegate>//4 遵循协议
@property(nonatomic,strong)UILabel*labelv;
@end

@implementation secendActepViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor=[UIColor cyanColor];;
    
    self.labelv=[[UILabel alloc]initWithFrame:CGRectMake(50, 100, 200, 40)];
    self.labelv.backgroundColor=[UIColor whiteColor];
    
    [self.view addSubview:self.labelv];
    
        self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc]initWithTitle:@"next" style:(UIBarButtonItemStylePlain) target:self action:@selector(back)];
    
}
-(void)back{

    SecendViewController*sec=[[SecendViewController alloc]init];
    //5设置代理
    sec.delegate =self;

    [self.navigationController pushViewController:sec animated:YES];

}
//6实现协议方法
-(void)passValue:(NSString *)string{
    self.labelv.text =string;
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
