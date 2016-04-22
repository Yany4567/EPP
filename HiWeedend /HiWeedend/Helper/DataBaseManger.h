//
//  DataBaseManger.h
//  HiWeedend
//
//  Created by lanou3g on 16/4/22.
//  Copyright © 2016年 高艳闯. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FMDB.h"

@interface DataBaseManger : NSObject

@property(nonatomic,strong)FMDatabase*dataBase;

+(DataBaseManger*)defaultManger;

// 关闭数据库
-(void)closeDB;


@end
