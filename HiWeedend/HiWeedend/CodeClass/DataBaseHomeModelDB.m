//
//  DataBaseHomeModelDB.m
//  HiWeedend
//
//  Created by lanou3g on 16/4/22.
//  Copyright © 2016年 高艳闯. All rights reserved.
//

#import "DataBaseHomeModelDB.h"
#import "FMDB.h"
#import "DataBaseManger.h"
#import "HomePageListModel.h"

@interface DataBaseHomeModelDB(){

    FMDatabase*dataBase;


}
@property(nonatomic,strong)HomePageListModel*model;

@end

@implementation DataBaseHomeModelDB

-(instancetype)init{
    if (self =[super init]) {
        //绑定数据库
        dataBase =[DataBaseManger defaultManger].dataBase;
        //打开数据库
        [dataBase open];
    }


    return  self;

}

//创建表
-(void)creatTabel{

    NSString*creatTabel=[NSString stringWithFormat:@"create Table if not exists %@ (title text,address text,biz_phone text)",HomeListTabel];
    BOOL result =[dataBase executeUpdate:creatTabel];

    if (!result) {
        NSLog(@"creat tabel error");
    }else{
        NSLog(@"creat tabel ok");
    }


}

//插入
-(void)insertModelWithUser:(HomePageListModel*)model;{

    NSString*insertSql=[NSString stringWithFormat:@" insert into %@(title,address,biz_phone)values('%@',%@','%@')",HomeListTabel,model.title,model.address,model.biz_phone];

    [dataBase executeUpdate:insertSql];


}

//删除
-(void)deleteModelWithTitle:(NSString*)title{


    //表名不需要加单引号 title 后面要加单引号
    NSString*delete=[NSString stringWithFormat:@"delete from %@ where biz_phone ='%@' ",HomeListTabel,title];
    [dataBase executeUpdate:delete];


}

//查询
-(NSArray*)selectModelWithUser:(NSString*)userID{

     HomePageListModel*model=[[HomePageListModel alloc]init];
   NSMutableArray*array=[[NSMutableArray alloc]init];
    //结果集
    NSString*select=[NSString stringWithFormat:@"select *from %@ where biz_phone = '%@'",HomeListTabel,model.biz_phone];
    FMResultSet*result =[dataBase executeQuery:select];
    while ([result next]) {
        //对数据进行处理
   
        //是什么类型需要用不同column取
        model.title =[result stringForColumn:@"title"];
        model.address=[result stringForColumn:@"address"];
        model.biz_phone=[result stringForColumn:@"biz_phone"];
        [array addObject:model];
    }
    
    
    return array;

    

}







@end
