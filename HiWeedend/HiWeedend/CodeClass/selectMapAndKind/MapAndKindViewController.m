//
//  MapAndKindViewController.m
//  HiWeedend
//
//  Created by lanou3g on 16/4/19.
//  Copyright © 2016年 高艳闯. All rights reserved.
//

#import "MapAndKindViewController.h"

@interface MapAndKindViewController ()

@end

@implementation MapAndKindViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
        self.navigationItem.leftBarButtonItem=[[UIBarButtonItem alloc]initWithTitle:@"+" style:(UIBarButtonItemStylePlain) target:self action:@selector(rightBarbuttonAction:)];
    
}

-(void)rightBarbuttonAction:(UIBarButtonItem*)sender{

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
