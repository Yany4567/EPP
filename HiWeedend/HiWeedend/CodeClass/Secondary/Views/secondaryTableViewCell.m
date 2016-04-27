//
//  secondaryTableViewCell.m
//  HiWeedend
//
//  Created by lanou3g on 16/4/20.
//  Copyright © 2016年 高艳闯. All rights reserved.
//

#import "secondaryTableViewCell.h"

@implementation secondaryTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self addCells];
    }
    return self;
}

- (void)addCells{
    //cell图片
    self.front_image_QD = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 230)];
    self.front_image_QD.backgroundColor = [UIColor cyanColor];
    [self.contentView addSubview:self.front_image_QD];
    //标题
    self.titleLab = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.front_image_QD.frame), CGRectGetWidth(self.front_image_QD.frame), CGRectGetHeight(self.front_image_QD.frame)*0.19)];
    self.titleLab.font = [UIFont systemFontOfSize:18];
//    self.titleLab.backgroundColor = [UIColor redColor];
    self.titleLab.numberOfLines = 0;
    [self.contentView addSubview:self.titleLab];
    
    //目的地
    self.poiLab = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.titleLab.frame), CGRectGetWidth(self.titleLab.frame)*0.35, CGRectGetHeight(self.titleLab.frame)-10)];
    self.poiLab.textAlignment = NSTextAlignmentCenter;
    self.poiLab.font = [UIFont systemFontOfSize:14];
//    self.poiLab.backgroundColor = [UIColor blueColor];
    [self.contentView addSubview:self.poiLab];
    
    //显示距离的lab
    self.distanceLab = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.poiLab.frame), CGRectGetMinY(self.poiLab.frame), CGRectGetWidth(self.poiLab.frame)-30, CGRectGetHeight(self.poiLab.frame))];
    self.distanceLab.text = @"·              ·";
    self.distanceLab.font = [UIFont systemFontOfSize:14];
    self.distanceLab.textAlignment = NSTextAlignmentCenter;
//    self.distanceLab.backgroundColor = [UIColor brownColor];
    [self.contentView addSubview:self.distanceLab];
    
    //类别
    self.categoryLab = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.distanceLab.frame), CGRectGetMinY(self.distanceLab.frame), CGRectGetWidth(self.poiLab.frame)-10, CGRectGetHeight(self.distanceLab.frame))];
    self.categoryLab.textAlignment = NSTextAlignmentCenter;
    self.categoryLab.font = [UIFont systemFontOfSize:14];
//    self.categoryLab.backgroundColor = [UIColor greenColor];
    [self.contentView addSubview:self.categoryLab];
    
    //日期
    self.time_infoLab = [[UILabel alloc]initWithFrame:CGRectMake(7, CGRectGetMaxY(self.distanceLab.frame), CGRectGetWidth(self.categoryLab.frame), CGRectGetHeight(self.distanceLab.frame)-5)];
//    self.time_infoLab.backgroundColor = [UIColor orangeColor];
    self.time_infoLab.font = [UIFont systemFontOfSize:14];
    self.time_infoLab.textAlignment = NSTextAlignmentCenter;
    self.time_infoLab.layer.borderWidth = 0.5;
    self.time_infoLab.clipsToBounds = YES;
    self.time_infoLab.layer.cornerRadius = 5;
    [self.contentView addSubview:self.time_infoLab];
    
    //收藏
    self.want_statusLab = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.time_infoLab.frame)+5, CGRectGetMinY(self.time_infoLab.frame), CGRectGetWidth(self.time_infoLab.frame)-20, CGRectGetHeight(self.time_infoLab.frame))];
//    self.want_statusLab.backgroundColor = [UIColor orangeColor];
    self.want_statusLab.font = [UIFont systemFontOfSize:14];
    self.want_statusLab.layer.borderWidth = 0.5;
    self.want_statusLab.clipsToBounds = YES;
    self.want_statusLab.layer.cornerRadius = 5;
    [self.contentView addSubview:self.want_statusLab];
    
    //价格
    self.price_infoLab = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.want_statusLab.frame)+20, CGRectGetMinY(self.want_statusLab.frame), CGRectGetWidth(self.distanceLab.frame), CGRectGetHeight(self.want_statusLab.frame))];
    self.price_infoLab.textAlignment = NSTextAlignmentCenter;
    self.price_infoLab.font = [UIFont systemFontOfSize:14];
    self.price_infoLab.layer.borderWidth = 0.5;
    self.price_infoLab.clipsToBounds = YES;
    self.price_infoLab.layer.cornerRadius = 5;
//    self.price_infoLab.backgroundColor = [UIColor greenColor];
    [self.contentView addSubview:self.price_infoLab];
    
    
}



- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
