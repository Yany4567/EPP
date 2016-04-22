//
//  ButtonAction.h
//  HiWeedend
//
//  Created by lanou3g on 16/4/21.
//  Copyright © 2016年 高艳闯. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ButtonAction : UIView
@property (nonatomic,copy)void(^didSelectedBtn)(int tag);
@property(nonatomic,strong)NSMutableArray*cityArray;
@end
