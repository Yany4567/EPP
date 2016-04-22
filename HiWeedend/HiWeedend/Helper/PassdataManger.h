//
//  PassdataManger.h
//  HiWeedend
//
//  Created by lanou3g on 16/4/21.
//  Copyright © 2016年 高艳闯. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PassdataManger : NSObject

+(PassdataManger*)defaultManger;

@property(nonatomic,strong)NSMutableArray*passArray;

@end
