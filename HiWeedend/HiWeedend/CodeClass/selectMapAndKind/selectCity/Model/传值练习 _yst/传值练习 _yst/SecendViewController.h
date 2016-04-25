//
//  SecendViewController.h
//  传值练习 _yst
//
//  Created by lanou3g on 16/4/24.
//  Copyright © 2016年 YST. All rights reserved.
//

#import <UIKit/UIKit.h>

//制定协议
@protocol passValueDelegate <NSObject>

//用于传值的方法 string就是要传的值
-(void)passValue:(NSString*)string;

@end


@interface SecendViewController : UIViewController

//2 声明属性 (weak)
@property(nonatomic,weak)id<passValueDelegate>delegate;

@end
