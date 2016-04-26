//
//  MapAndKindViewController.m
//  HiWeedend
//
//  Created by lanou3g on 16/4/19.
//  Copyright © 2016年 高艳闯. All rights reserved.
//
#import <UIKit/UIKit.h>
@interface CityViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *_tableView;
}
@property (nonatomic,copy)void(^selectString)(NSString *string);
@property (nonatomic,copy)NSString *currentCityString;
@end
