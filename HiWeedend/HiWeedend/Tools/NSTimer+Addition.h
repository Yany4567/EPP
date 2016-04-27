//
//  NSTimer+Addition.h
//  Leisure
//
//  Created by wenze on 16/4/4.
//  Copyright © 2016年 wenze. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSTimer (Addition)

// 暂停
- (void)pauseTimer;
// 继续
- (void)resumeTimer;
// 在多少秒以后继续
- (void)resumeTimerAfterTimeInterval:(NSTimeInterval)interval;

@end
