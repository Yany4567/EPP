//
//  SelectTableViewCell.h
//  HiWeedend
//
//  Created by lanou3g on 16/4/26.
//  Copyright © 2016年 高艳闯. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SelectCityModel;
@interface SelectTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *selectShoeImahe;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
-(void)setDataModel:(SelectCityModel*)model;

@end
