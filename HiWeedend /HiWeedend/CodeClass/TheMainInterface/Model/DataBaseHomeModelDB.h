//
//  DataBaseHomeModelDB.h
//  HiWeedend
//
//  Created by lanou3g on 16/4/22.
//  Copyright © 2016年 高艳闯. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HomePageListModel.h"


@interface DataBaseHomeModelDB : NSObject

//创建表
-(void)creatTabel;

//插入
-(void)insertModelWithUser:(HomePageListModel*)model;

//删除
-(void)deleteModelWithTitle:(NSString*)title;

//查询
-(NSArray*)selectModelWithUser:(NSString*)userID;


@end
