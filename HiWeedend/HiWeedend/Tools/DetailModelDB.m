//
//  DetailModelDB.m
//  Leisure
//
//  Created by lanou3g on 16/4/11.
//  Copyright © 2016年 wenze. All rights reserved.
//

#import "DetailModelDB.h"
#import "FMDB.h"
#import "DatabaseManager.h"
#import "DataHandle.h"

@interface DetailModelDB(){
    FMDatabase *datase;
}

@end

@implementation DetailModelDB

-(instancetype)init{
    if (self = [super init]) {
        // 绑定数据库
        datase = [DatabaseManager defaultManager].database;
      [datase open];
    }
    return self;
}


-(void)createTabel{
    [datase open];
    NSString *create = [NSString stringWithFormat:@"create Table %@ (title text, leo_id integer,front_cover_image_list text,address text, userId text)",HomeListTabel];
    BOOL isCreat = [datase executeUpdate:create];
    if (!isCreat) {
        NSLog(@"create table error");
    }else{
        NSLog(@"create table ok");
    }
    [datase close];
}

-(void)insertModelWithModel:(HomePageListModel *)model{
    [datase open];
    NSString *insert = [NSString stringWithFormat:@"insert into %@ (title,leo_id,front_cover_image_list,address,userId) values ('%@','%ld','%@','%@','%@')",HomeListTabel,model.title,model.leo_id,[model.front_cover_image_list firstObject],model.address,[UserInfoManager getUserID]];
    [datase executeUpdate:insert];
    
   [datase close];
}



-(NSArray *)selectModelWithRserId:(NSString *)userId{
    [datase open];
    NSMutableArray *array = [[NSMutableArray alloc]init];
    NSString *select = [NSString stringWithFormat:@"select * from %@ where userId = '%@'",HomeListTabel,[UserInfoManager getUserID]];
    // 结果集
    FMResultSet *result = [datase executeQuery:select];
    while ([result next]) {
        // 对数据进行处理
        HomePageListModel *model = [[HomePageListModel alloc]init];
        model.title = [result stringForColumn:@"title"];
        model.leo_id = [result longForColumn:@"leo_id"];
        model.front_cover_image_list  = @[[result stringForColumn:@"front_cover_image_list"]];
        model.address = [result stringForColumn:@"address"];
        
        [array addObject:model];

    }
    [datase close];
    return array;
}

-(void)deleteModelWithTitle:(NSString *)title{
    [datase open];
    NSString *delete = [NSString stringWithFormat:@"delete from %@ where title = '%@'",HomeListTabel,title];
    [datase executeUpdate:delete];
    [datase close];
}

@end
