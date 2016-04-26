//
//  ThirdViewController.h
//  传值练习 _yst
//
//  Created by lanou3g on 16/4/24.
//  Copyright © 2016年 YST. All rights reserved.
//

#import <UIKit/UIKit.h>

//block
typedef void(^passValue)(NSString*s);
@interface ThirdViewController : UIViewController

//声明属性
@property(nonatomic,strong)passValue passBlock;
@end
