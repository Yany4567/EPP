//
//  DataHandle.h
//  Lesson2_数据库操作
//
//  Created by lanou3g on 16/2/25.
//  Copyright © 2016年 高艳闯. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DataHandle : NSObject


+(DataHandle *)shareInstance;
// 归档

-(NSData *)dataOfArchiverObject:(id)object forKey:(NSString *)key;


// 反归档

-(id)unarchiverObject:(NSData *)data forKey:(NSString *)key;



@end
