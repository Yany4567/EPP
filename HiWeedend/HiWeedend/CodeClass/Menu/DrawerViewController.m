//
//  DrawerViewController.m
//  Leisure
//
//  Created by wenze on 16/3/28.
//  Copyright © 2016年 wenze. All rights reserved.
//

#import "DrawerViewController.h"
#define kMenuFullWidth  [UIScreen mainScreen].bounds.size.width  //菜单的宽度
#define kMenuDisplayedWidth 280.0f  // 菜单显示的宽度

@interface DrawerViewController () {
    BOOL canShowLeft;   //判断左菜单是否能够显示
    BOOL showingLeftView;   //判断左菜单正在显示
}

@end

@implementation DrawerViewController
@synthesize leftViewController=_left;
@synthesize rootViewController=_root;

//  实现初始化方法
- (id)initWithRootViewController:(UIViewController*)controller {
    if ((self = [super init])) {
        _root = controller;
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setRootViewController:_root];
    
    if (!_tap) {
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
        tap.delegate = (id<UIGestureRecognizerDelegate>)self;
        [self.view addGestureRecognizer:tap];
        [tap setEnabled:NO];
        _tap = tap;
    }
}

- (void)setRootViewController:(UIViewController *)rootViewController {
    UIViewController *tempRoot = _root;
    _root = rootViewController;
    if (_root) {
        if (tempRoot) {
            [tempRoot.view removeFromSuperview];
            tempRoot = nil;
        }
        UIView *view = _root.view;
        view.frame = self.view.bounds;
        [self.view addSubview:view];
    } else {
        if (tempRoot) {
            [tempRoot.view removeFromSuperview];
            tempRoot = nil;
        }
    }
    [self setNavButtons];
}

- (void)setNavButtons {
    // 如果跟视图控制器为空  直接跳出
    if (!_root) {
        return;
    }
    
    // 设置根视图控制器
    UIViewController *topController = nil;
    if ([_root isKindOfClass:[UINavigationController class]]) {
        UINavigationController *navController = (UINavigationController*)_root;
        if ([[navController viewControllers] count] > 0) {
            topController = [[navController viewControllers] objectAtIndex:0];
        }
    } else {
        topController = _root;
    }
    
    // 在根视图导航栏上添加左按钮
    if (canShowLeft) {
        UIBarButtonItem *button = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"nav_menu_icon.png"] style:UIBarButtonItemStylePlain target:self action:@selector(showLeft:)];
        topController.navigationItem.leftBarButtonItem = button;
    } else {
        topController.navigationItem.leftBarButtonItem = nil;
    }
}
//  显示左菜单栏
- (void)showLeft:(id)sender {
    [self showLeftController:NO];
}


#pragma mark -单击手势-

- (void)tap:(UITapGestureRecognizer*)gesture {
    [gesture setEnabled:NO];
    [self showRootController:YES];
}
//  手势的代理方法
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
    
    if (gestureRecognizer == _tap) {
        if (_root && showingLeftView) {
            //判断给定的点是否被一个CGRect包含,可以用CGRectContainsPoint函数
            // 设置单击手势能够响应的范围
            return CGRectContainsPoint(_root.view.frame, [gestureRecognizer locationInView:self.view]);
        }
        return NO;
    }
    return YES;
}


#pragma mark -显示视图-

- (void)showRootController:(BOOL)animated {
    [_tap setEnabled:NO]; // 让单击手势不能响应
    // 设置根视图能够响应
    _root.view.userInteractionEnabled = YES;
    
    CGRect frame = _root.view.frame;
    frame.origin.x = 0.0f;
    BOOL _enabled = [UIView areAnimationsEnabled];
    if (!animated) {
        [UIView setAnimationsEnabled:NO];
    }
    [UIView animateWithDuration:.3 animations:^{
        _root.view.frame = frame;
    } completion:^(BOOL finished) {
        if (_left && _left.view.superview) {
            [_left.view removeFromSuperview];
        }
        showingLeftView = NO;
    }];
    if (!animated) {
        [UIView setAnimationsEnabled:_enabled];
    }
}
- (void)showLeftController:(BOOL)animated {
    //  如果菜单不能显示， 直接跳出
    if (!canShowLeft) {
        return;
    }
    // 设置菜单正在显示的标记为yes
    showingLeftView = YES;
    
    
    UIView *view = self.leftViewController.view;
    CGRect frame = self.view.bounds;
    frame.size.width = kMenuFullWidth;
    view.frame = frame;
    [self.view insertSubview:view atIndex:0];
    [self.leftViewController viewWillAppear:animated];
    
    frame = _root.view.frame;
    frame.origin.x = CGRectGetMaxX(view.frame) - (kMenuFullWidth - kMenuDisplayedWidth);
    
    BOOL _enabled = [UIView areAnimationsEnabled];
    if (!animated) {
        [UIView setAnimationsEnabled:NO];
    }
    
    _root.view.userInteractionEnabled = NO;
    [UIView animateWithDuration:.3 animations:^{
        _root.view.frame = frame;
    } completion:^(BOOL finished) {
        [_tap setEnabled:YES];  // 激活单击手势
    }];
    
    if (!animated) {
        [UIView setAnimationsEnabled:_enabled];
    }
}


#pragma mark -设置根视图控制器对象和左菜单视图控制器对象-

- (void)setLeftViewController:(UIViewController *)leftController {
    _left = leftController;
    canShowLeft = (_left!=nil);
    [self setNavButtons];
}

- (void)setRootController:(UIViewController *)controller animated:(BOOL)animated {
    
    if (!controller) {
        [self setRootViewController:controller];
        return;
    }
    
    if (showingLeftView) {
        [[UIApplication sharedApplication] beginIgnoringInteractionEvents];
        __block DrawerViewController *selfRef = self;
        __block UIViewController *rootRef = _root;
        
        CGRect frame = rootRef.view.frame;
        frame.origin.x = rootRef.view.bounds.size.width;
        
        [UIView animateWithDuration:.1 animations:^{
            rootRef.view.frame = frame;
        } completion:^(BOOL finished) {
            [[UIApplication sharedApplication] endIgnoringInteractionEvents];
            [selfRef setRootViewController:controller];
            _root.view.frame = frame;
            [selfRef showRootController:animated];
        }];
        
    } else {
        [self setRootViewController:controller];
        [self showRootController:animated];
   
    }
}





- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
