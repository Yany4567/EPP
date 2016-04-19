//
//  HomePageCell.h
//  HiWeedend
//
//  Created by lanou3g on 16/4/17.
//  Copyright © 2016年 高艳闯. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HomePageCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *coverImage;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *poiLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeIfoLabel;

@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UIButton *collectedButton;
@property(nonatomic,assign) BOOL isTap;

@end
