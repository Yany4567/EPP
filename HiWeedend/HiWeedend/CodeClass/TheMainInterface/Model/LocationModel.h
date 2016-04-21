//
//  LocationModel.h
//  HiWeedend
//
//  Created by lanou3g on 16/4/20.
//  Copyright © 2016年 高艳闯. All rights reserved.
//

#import "BaseModel.h"

@interface LocationModel : BaseModel

@property(nonatomic,assign)NSInteger cityId;
@property(nonatomic,strong)NSString *cityName;
@property(nonatomic,assign)NSInteger lat;
@property(nonatomic,assign)NSInteger lon;
@property(nonatomic,assign)NSInteger provinceId;
@property(nonatomic,strong)NSString *provinceName;

@end
