//
//  UNicoderTurnNsstring.m
//  HiWeedend
//
//  Created by lanou3g on 16/4/27.
//  Copyright © 2016年 高艳闯. All rights reserved.
//

#import "UNicoderTurnNsstring.h"

@implementation UNicoderTurnNsstring

+ (NSString *)replaceUnicode:(NSString *)unicodeStr

{
    
    
    
    NSString *tempStr1 = [unicodeStr stringByReplacingOccurrencesOfString:@"\\u"withString:@"\\U"];
    
    NSString *tempStr2 = [tempStr1 stringByReplacingOccurrencesOfString:@""withString:@"\\"];
    
    NSString *tempStr3 = [[@""stringByAppendingString:tempStr2] stringByAppendingString:@""];
    
    NSData *tempData = [tempStr3 dataUsingEncoding:NSUTF8StringEncoding];
    
    NSString* returnStr = [NSPropertyListSerialization propertyListFromData:tempData
                           
                                                           mutabilityOption:NSPropertyListImmutable
                           
                                                                     format:NULL
                           
                                                           errorDescription:NULL];
    
    NSLog(@"%@",returnStr);
    
    return [returnStr stringByReplacingOccurrencesOfString:@"\\r\\n"withString:@"\n"];
    
}



@end