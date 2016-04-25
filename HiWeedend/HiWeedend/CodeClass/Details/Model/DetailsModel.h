//
//  DetailsModel.h
//  HiWeedend
//
//  Created by lanou3g on 16/4/21.
//  Copyright © 2016年 高艳闯. All rights reserved.
//

#import "BaseModel.h"

@interface DetailsModel : BaseModel
@property(nonatomic,strong)NSString *address;
@property(nonatomic,strong)NSString *cn_name;
@property(nonatomic,strong)NSString *price_info;
@property(nonatomic,strong)NSDictionary *location;
@property(nonatomic,strong)NSString *time;
@property(nonatomic,strong)NSString *title;
@property(nonatomic,strong)NSString *poi;




@end
