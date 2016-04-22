//
//  ModfileViewController.h
//  HiWeedend
//
//  Created by lanou3g on 16/4/19.
//  Copyright © 2016年 高艳闯. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ModfileViewController : UIViewController
@property(nonatomic,strong)UITextField *nameTextF;//姓名
@property(nonatomic,strong)UIImageView *imageV;//头像
@property(nonatomic,strong)UILabel *sexLab;//性别

@property(nonatomic,strong)UIButton *maleBtn;
@property(nonatomic,strong)UIButton *femaleBtn;
@property(nonatomic,strong)UILabel *maleLab;
@property(nonatomic,strong)UILabel *femaleLab;

@property(nonatomic,strong)UILabel *stateLab;

@property(nonatomic,strong)UIImageView *image1;
@property(nonatomic,strong)UIImageView *image2;
@property(nonatomic,strong)UIImageView *image3;

@property(nonatomic,strong)UILabel *lab1;
@property(nonatomic,strong)UILabel *lab2;
@property(nonatomic,strong)UILabel *lab3;

@end
