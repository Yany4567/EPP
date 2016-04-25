//
//  ShowModel.h
//  HiWeedend
//
//  Created by lanou3g on 16/4/23.
//  Copyright © 2016年 高艳闯. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ShowModel : NSObject
@property(nonatomic,strong)NSString *address;
@property(nonatomic,strong)NSString *biz_phone;
@property(nonatomic,strong)NSString *category;
@property(nonatomic,assign)NSInteger category_id;
@property(nonatomic,assign)NSInteger collected_num;
@property(nonatomic,strong)NSString *consult_phone;
@property(nonatomic,assign)NSInteger distance;
@property(nonatomic,strong)NSArray *front_cover_image_list;
@property(nonatomic,strong)NSString *item_type;
@property(nonatomic,strong)NSString *jump_data;
@property(nonatomic,strong)NSString *jump_type;
@property(nonatomic,assign)NSInteger leo_id;
@property(nonatomic,strong)NSString *poi;
@property(nonatomic,strong)NSString *poi_name;
@property(nonatomic,assign)NSInteger price;
@property(nonatomic,strong)NSString *price_info;
@property(nonatomic,assign)NSInteger sell_status;
@property(nonatomic,strong)NSString *show_free;
@property(nonatomic,strong)NSString *tags;
@property(nonatomic,strong)NSString *time_desc;
@property(nonatomic,strong)NSString *time_info;
@property(nonatomic,strong)NSString *title;
@property(nonatomic,assign)NSInteger viewed_num;
@property(nonatomic,assign)NSInteger want_status;



@end
