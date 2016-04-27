//
//  ShowToLocationModel.h
//  HiWeedend
//
//  Created by lanou3g on 16/4/26.
//  Copyright © 2016年 高艳闯. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ShowToLocationModel : NSObject
@property(nonatomic,assign)NSInteger cityId;
@property(nonatomic,strong)NSString *cityName;
@property(nonatomic,assign)NSInteger lat;
@property(nonatomic,assign)NSInteger lon;
@property(nonatomic,assign)NSInteger provinceId;
@property(nonatomic,strong)NSString *provinceName;
@end
