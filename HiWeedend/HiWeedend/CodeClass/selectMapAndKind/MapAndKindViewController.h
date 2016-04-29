//
//  MapAndKindViewController.h
//  HiWeedend
//
//  Created by lanou3g on 16/4/19.
//  Copyright © 2016年 高艳闯. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MapAndKindViewController : UIViewController
@property (weak, nonatomic) IBOutlet UISearchBar *maptextFILE;
@property (weak, nonatomic) IBOutlet UIButton *cityButton;
@property (weak, nonatomic) IBOutlet UILabel *cityLabel;
@property (nonatomic,copy)void(^didSelectedBtn)(int tag);
@property (weak, nonatomic) IBOutlet UISearchBar *mapAndsearch;
@property (weak, nonatomic) IBOutlet UILabel *mapLabel;




@end
