//
//  DictiontyTurnUNIcode.m
//  HiWeedend
//
//  Created by lanou3g on 16/4/28.
//  Copyright © 2016年 高艳闯. All rights reserved.
//

#import "DictiontyTurnUNIcode.h"

@implementation DictiontyTurnUNIcode
+ (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString {
    if (jsonString == nil) {
        return nil;
    }
    
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                        options:NSJSONReadingMutableContainers
                                                          error:&err];
    if(err) {
        NSLog(@"json解析失败：%@",err);
        return nil;
    }
    return dic;
}
@end
