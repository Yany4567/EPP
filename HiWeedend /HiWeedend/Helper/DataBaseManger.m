//
//  DataBaseManger.m
//  HiWeedend
//
//  Created by lanou3g on 16/4/22.
//  Copyright © 2016年 高艳闯. All rights reserved.
//

#import "DataBaseManger.h"

@implementation DataBaseManger

+(DataBaseManger *)defaultManger{

    static DataBaseManger*database=nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        database=[[DataBaseManger alloc]init];
    });

    return database;
}

-(instancetype)init{

    if (self = [super init]) {
        [self pathAndOpenDB];
        
    }



    return self;

}

-(void)pathAndOpenDB{

    //获取documents
    NSString*docmentsPath=[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)lastObject];
    
    //获取documents路径方法二
    //  NSString*path =NSHomeDirectory();
    
    //创建数据库路径
    NSString*dataBasepath =[docmentsPath stringByAppendingPathComponent:SqliteName];
    self.dataBase =[[FMDatabase alloc]initWithPath:dataBasepath];
    if ([self.dataBase open]) {
        return;
    }
    
    
}

-(void)closeDB{
    
    
    if ([self.dataBase close]) {
        NSLog(@"关闭成功");
        return;
    }

    [self.dataBase close];

  }



@end
