//
//  DatabaseManager.m
//  Leisure
//
//  Created by lanou3g on 16/4/11.
//  Copyright © 2016年 wenze. All rights reserved.
//

#import "DatabaseManager.h"

@implementation DatabaseManager

+(instancetype)defaultManager{
    static DatabaseManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[DatabaseManager alloc]init];
    });
    return manager;
}

-(instancetype)init{
    if (self = [super init]) {
        // 获取documents 路径
        NSString *string = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
        // 创建数据库路径
    NSString *path = [string stringByAppendingPathComponent:SqliteName];
        NSLog(@"%@",path);
        // 打开数据库路径
        self.database = [[FMDatabase alloc]initWithPath:path];
        BOOL isOpen = [self.database open];
        if (!isOpen) {
            NSLog(@"open sqilt error");
        }
        
        
    }
    return self;
    
    
}
-(void)colseDB{
    [self.database close];
    
    
}


@end
