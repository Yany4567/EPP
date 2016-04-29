//
//  DatabaseManager.h
//  Leisure
//
//  Created by lanou3g on 16/4/11.
//  Copyright © 2016年 wenze. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FMDB.h"

@interface DatabaseManager : NSObject

// 对外暴露的数据库单例对象
@property(nonatomic,strong) FMDatabase *database;


+(instancetype)defaultManager;

-(void)colseDB;

















@end
