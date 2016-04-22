//
//  secondaryModel.h
//  HiWeedend
//
//  Created by lanou3g on 16/4/20.
//  Copyright © 2016年 高艳闯. All rights reserved.
//

#import "BaseModel.h"

@interface secondaryModel : BaseModel

@property(nonatomic,strong)NSArray *front_cover_image_list;
@property(nonatomic,strong)NSString *title;
@property(nonatomic,strong)NSString *poi;
@property(nonatomic,strong)NSString *category;
@property(nonatomic,strong)NSString *time_info;
@property(nonatomic,strong)NSString *want_status;
@property(nonatomic,assign)NSInteger price_info;
@property(nonatomic,strong)NSString *distance;


@end
