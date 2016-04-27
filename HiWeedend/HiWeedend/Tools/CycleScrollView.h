//
//  CycleScrollView.h
//  Leisure
//
//  Created by wenze on 16/4/4.
//  Copyright © 2016年 wenze. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef UIView *(^FetchContentViewAtIndex)(NSInteger pageIndex);
typedef void(^TapActionBlock)(NSInteger pageIndex);

@interface CycleScrollView : UIView<UIScrollViewDelegate>

// 页面图片的总个数
@property (nonatomic, assign) NSInteger totalPagesCount;
// 刷新视图
@property (nonatomic, copy) FetchContentViewAtIndex fetchContentViewAtIndex;
// 点击页面
@property (nonatomic, copy) TapActionBlock TapActionBlock;

/*
 自定义初始化方法
 参数：
 frame: 定义滚动视图的大小
 animationDuration: 滚动的时间间隔
 */
- (id)initWithFrame:(CGRect)frame animationDuration:(NSTimeInterval)animationDuration;

@end
