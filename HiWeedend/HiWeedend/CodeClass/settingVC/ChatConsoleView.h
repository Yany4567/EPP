//
//  ChatConsoleView.h
//  Leisure
//
//  Created by lanou3g on 16/4/7.
//  Copyright © 2016年 wenze. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^ButtonClicked)(NSString *draftText);

@interface ChatConsoleView : UIView

@property(nonatomic,copy)ButtonClicked buttonClicked;
@property(nonatomic,strong)UITextField *draftTextField;

@end
