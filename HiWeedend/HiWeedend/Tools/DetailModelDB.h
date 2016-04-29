//
//  DetailModelDB.h
//  Leisure
//
//  Created by lanou3g on 16/4/11.
//  Copyright © 2016年 wenze. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HomePageListModel.h"

@interface DetailModelDB : NSObject

// 创建表
-(void)createTabel;

// 查询
-(NSArray *)selectModelWithRserId:(NSString *)userId;


// 插入
-(void)insertModelWithModel:(HomePageListModel *)model;


// 删除
-(void)deleteModelWithTitle:(NSString *)title;





@end
