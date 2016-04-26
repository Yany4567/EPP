//
//  ShowKindTableViewCell.h
//  HiWeedend
//
//  Created by lanou3g on 16/4/23.
//  Copyright © 2016年 高艳闯. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ShowKindTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *showTitle;
@property (weak, nonatomic) IBOutlet UIImageView *showImage;

@property (weak, nonatomic) IBOutlet UILabel *showkind;

@property (weak, nonatomic) IBOutlet UILabel *showTime;

@property (weak, nonatomic) IBOutlet UIButton *showButton;
@property (weak, nonatomic) IBOutlet UILabel *showprice;

@property(nonatomic,assign) BOOL isTap;
@end
