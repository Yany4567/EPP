//
//  CollectActionViewController.m
//  HiWeedend
//
//  Created by lanou3g on 16/4/19.
//  Copyright © 2016年 高艳闯. All rights reserved.
//

#import "CollectActionViewController.h"
//#import "DataBaseHomeModelDB.h"
#import "HomePageListModel.h"

@interface CollectActionViewController ()

@end

@implementation CollectActionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    DataBaseHomeModelDB*db=[[DataBaseHomeModelDB alloc]init];
//    
//    //创建列表
//    [db creatTabel];
    
    
    self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc]initWithTitle:@"+" style:(UIBarButtonItemStylePlain) target:self action:@selector(collectAction:)];
    UIImageView *image=[[UIImageView alloc]initWithFrame:CGRectMake(50, 200, 200, 40)];
    image.image=[UIImage imageNamed:@"99"];
    [self.view addSubview:image];

}


-(void)collectAction:(UIBarButtonItem*)sender{
    
    
    
    
    
    
    
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
