//
//  SearchShowTableViewCell.h
//  HiWeedend
//
//  Created by lanou3g on 16/4/28.
//  Copyright © 2016年 高艳闯. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SearchShowModel;

@interface SearchShowTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *showImage;
@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UILabel *time;
@property (weak, nonatomic) IBOutlet UILabel *price;

-(void)setData:(SearchShowModel*)model;
@end
