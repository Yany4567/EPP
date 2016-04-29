//
//  SelectTableViewCell.m
//  HiWeedend
//
//  Created by lanou3g on 16/4/26.
//  Copyright © 2016年 高艳闯. All rights reserved.
//

#import "SelectTableViewCell.h"
#import "SelectCityModel.h"

@implementation SelectTableViewCell

-(void)setDataModel:(SelectCityModel*)model{

    [self.selectShoeImahe sd_setImageWithURL:[NSURL URLWithString:[model.front_cover_image_list firstObject]]];
    
   self.titleLabel .text =model.title;
    self.priceLabel.text =[NSString stringWithFormat:@"¥:%ld", model.price ];
    
    
    NSString *string =  [model.poi stringByAppendingString:@" * "];
    self.timeLabel.text = [string stringByAppendingString:model.category];




}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
