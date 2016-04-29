//
//  HomePageListModel.h
//  HiWeedend
//
//  Created by lanou3g on 16/4/16.
//  Copyright © 2016年 高艳闯. All rights reserved.
//

#import "BaseModel.h"

@interface HomePageListModel : BaseModel
@property(nonatomic,strong)NSString *address;
@property(nonatomic,strong)NSString *category;
@property(nonatomic,assign)NSInteger distance;
@property(nonatomic,strong)NSArray *front_cover_image_list;
@property(nonatomic,strong)NSString *jump_data;
@property(nonatomic,assign)NSInteger leo_id;
@property(nonatomic,strong)NSString *poi;
@property(nonatomic,strong)NSString *poi_name;
@property(nonatomic,assign)NSInteger price;
@property(nonatomic,strong)NSString *price_info;
@property(nonatomic,strong)NSString *time_desc;
@property(nonatomic,strong)NSString *time_info;
@property(nonatomic,strong)NSString *title;

@end
