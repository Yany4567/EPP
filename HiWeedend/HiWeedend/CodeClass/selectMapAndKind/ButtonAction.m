//
//  ButtonAction.m
//  HiWeedend
//
//  Created by lanou3g on 16/4/21.
//  Copyright © 2016年 高艳闯. All rights reserved.
//

#import "ButtonAction.h"

@implementation ButtonAction
-(instancetype)initWithFrame:(CGRect)frame{

    if (self =[super initWithFrame:frame]) {
        [self addView];
        
    }


    return self;


}
-(void)addView{


    NSMutableArray *array=(NSMutableArray*)@[@"1",@"2",@"3",@"3",@"4",@"5",@"6",@"7",@"8"];
    for(int i=0;i<array.count;i++)
    {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.center = CGPointMake(kWidth/6+(kWidth/3-10)*(i%3), 30+(30+15)*(i/3));
        btn.tag = 200+i;
        btn.bounds = CGRectMake(0, 0,kWidth/3-30, 35);
        [btn setTitleColor:[UIColor colorWithRed:54/255.0 green:54/255.0 blue:54/255.0 alpha:1] forState:0];
        [btn setTitle:array[i] forState:0];
        [btn addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
        [btn setBackgroundColor:[UIColor redColor]];
        [self addSubview:btn];
        btn.layer.borderWidth = 0.5;
        btn.layer.borderColor = [UIColor colorWithRed:210/255.0 green:210/255.0 blue:210/255.0 alpha:1].CGColor;
    }




}
-(void)click:(UIButton *)btn{
    NSLog(@"2222222222222");
//    
        if(_cityArray.count==1&btn.tag==0)
        {
//            self.didSelectedBtn(1111);
            self.didSelectedBtn((int)btn.tag);
       }
//        else
//        {
//            self.didSelectedBtn((int)btn.tag);
//        }
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
