//
//  DataHandle.m
//  Lesson2_数据库操作
//
//  Created by lanou3g on 16/2/25.
//  Copyright © 2016年 高艳闯. All rights reserved.
//

#import "DataHandle.h"

@implementation DataHandle
static DataHandle *handle = nil;
+(DataHandle *)shareInstance{
    if (handle == nil) {
        handle
        = [[DataHandle alloc]init];
    }
    return handle;
}

// 将对象归档

-(NSData *)dataOfArchiverObject:(id)object forKey:(NSString *)key{
    NSMutableData *data = [NSMutableData data];
    NSKeyedArchiver *archiver = [[NSKeyedArchiver alloc]initForWritingWithMutableData:data];
    [archiver encodeObject:object forKey:key];
    [archiver finishEncoding];
    return data;
}

// 反归档
-(id)unarchiverObject:(NSData *)data forKey:(NSString *)key{
    
    NSKeyedUnarchiver *unarchiver = [[NSKeyedUnarchiver alloc]initForReadingWithData:data];
    id object = [unarchiver decodeObjectForKey:key];
    [unarchiver finishDecoding];
    return object;
    
}



@end
