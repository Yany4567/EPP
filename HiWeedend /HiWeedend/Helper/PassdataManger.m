//
//  PassdataManger.m
//  HiWeedend
//
//  Created by lanou3g on 16/4/21.
//  Copyright © 2016年 高艳闯. All rights reserved.
//

#import "PassdataManger.h"


@implementation PassdataManger

+(PassdataManger *)defaultManger{

    static PassdataManger*manger=nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manger =[[PassdataManger alloc]init];
        manger.passArray =[NSMutableArray array];
    });

    return manger;


}


@end
