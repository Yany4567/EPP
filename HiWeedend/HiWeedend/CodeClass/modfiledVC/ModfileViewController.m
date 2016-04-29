//
//  ModfileViewController.m
//  HiWeedend
//
//  Created by lanou3g on 16/4/19.
//  Copyright © 2016年 高艳闯. All rights reserved.
//

#import "ModfileViewController.h"
#import <QuartzCore/CoreAnimation.h>
@interface ModfileViewController ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate,UITextFieldDelegate>
{
    NSInteger _gender;
    NSInteger _state;
}
@property(nonatomic,strong)UIButton *button;
@property(nonatomic,strong)UILabel *textLab;
@end

@implementation ModfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"个人资料";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"保存" style:(UIBarButtonItemStyleDone) target:self action:@selector(keepAction:)];
    [self addObjects];
    
    
    // Do any additional setup after loading the view from its nib.
}
//保存的点击事件
- (void)keepAction:(UIBarButtonItem *)sender{
    NSLog(@"保存");
    
   
    
    
    
}

- (void)addObjects{
    //头像
    self.imageV = [[UIImageView alloc]initWithFrame:CGRectMake(0, 10, 100, 100)];
    
    self.imageV.center = CGPointMake([UIScreen mainScreen].bounds.size.width/2, [UIScreen mainScreen].bounds.size.height/5.5);
    //self.imageV.backgroundColor = [UIColor cyanColor];
    self.imageV.layer.cornerRadius = 50;
    UITapGestureRecognizer *ges = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(changeAction:)];
    self.imageV.userInteractionEnabled = YES;
    [self.imageV sd_setImageWithURL:[NSURL URLWithString:[UserInfoManager getUserIcon]]];
    NSLog(@"--------------------###############%@",[UserInfoManager getUserIcon]);
    
    [self.imageV addGestureRecognizer:ges];
    [self.view addSubview:self.imageV];
    
//    self.textLab = [[UILabel alloc]initWithFrame:CGRectMake(0, 35, 80, 30)];
//    self.textLab.center = CGPointMake(self.imageV.bounds.size.width/2, self.imageV.bounds.size.height/2);
//    self.textLab.text = @"更换头像";
//    self.textLab.textAlignment = NSTextAlignmentCenter;
//    [self.imageV addSubview:self.textLab];
    
    //姓名textfiled
    self.nameTextF = [[UITextField alloc]initWithFrame:CGRectMake(0, 0, 100, 40)];
    self.nameTextF.center = CGPointMake([UIScreen mainScreen].bounds.size.width/2, [UIScreen mainScreen].bounds.size.height/5.5 + 75);
    self.nameTextF.textAlignment = NSTextAlignmentCenter;
    self.nameTextF.placeholder = [UserInfoManager getUserName];
    self.nameTextF.font = [UIFont systemFontOfSize:18];
    [self.view addSubview:self.nameTextF];
    
    //性别lab
    self.sexLab = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 60, 30)];
    self.sexLab.center = CGPointMake([UIScreen mainScreen].bounds.size.width/2, [UIScreen mainScreen].bounds.size.height/5.5+117);
    self.sexLab.textAlignment = NSTextAlignmentCenter;
    self.sexLab.text = @"性别";
    self.sexLab.font = [UIFont systemFontOfSize:13];
    [self.view addSubview:self.sexLab];
    
    //性别(男)
    self.maleBtn = [UIButton buttonWithType:(UIButtonTypeSystem)];
    self.maleBtn.frame = CGRectMake(120, 280, 25, 25);
    self.maleBtn.layer.borderWidth = 1;
    [self.maleBtn setTitle:@"♂" forState:(UIControlStateNormal)];
    self.maleBtn.layer.cornerRadius = 12.5;
//    [self.maleBtn setBackgroundColor:[UIColor redColor]];
    [self.view addSubview:self.maleBtn];
    [self.maleBtn addTarget:self action:@selector(routateAction:) forControlEvents:(UIControlEventTouchUpInside)];
    
    self.maleLab = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.maleBtn.frame), CGRectGetMinY(self.maleBtn.frame), CGRectGetWidth(self.maleBtn.frame)*2, CGRectGetHeight(self.maleBtn.frame))];
    self.maleLab.text = @"男性";
    [self.view addSubview:self.maleLab];
    
    //性别(女)
    self.femaleBtn = [UIButton buttonWithType:(UIButtonTypeSystem)];
    self.femaleBtn.frame = CGRectMake(CGRectGetMaxX(self.maleLab.frame)+30, CGRectGetMinY(self.maleBtn.frame), CGRectGetWidth(self.maleBtn.frame), CGRectGetHeight(self.maleBtn.frame));
    [self.femaleBtn setTitle:@"♀" forState:(UIControlStateNormal)];
    self.femaleBtn.layer.borderWidth = 1;
//    [self.femaleBtn setBackgroundColor:[UIColor redColor]];
    self.femaleBtn.layer.cornerRadius = 12.5;
    [self.view addSubview:self.femaleBtn];
    [self.femaleBtn addTarget:self action:@selector(femaleroutateAction:) forControlEvents:(UIControlEventTouchUpInside)];
    
    self.femaleLab = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.femaleBtn.frame), CGRectGetMinY(self.femaleBtn.frame), CGRectGetWidth(self.femaleBtn.frame)*2, CGRectGetHeight(self.femaleBtn.frame))];
    self.femaleLab.text = @"女性";
    [self.view addSubview:self.femaleLab];
    
    
    
    //状态
    self.stateLab = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 80, 30)];
    self.stateLab.center = CGPointMake([UIScreen mainScreen].bounds.size.width/2, [UIScreen mainScreen].bounds.size.height/5.5+230);
    self.stateLab.text = @"当前状态";
    self.stateLab.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:self.stateLab];
    
    //状态圈
    self.image1 = [[UIImageView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.maleBtn.frame)-10, CGRectGetMaxY(self.stateLab.frame)+40, 20, 20)];
//    self.image1 setImage:<#(UIImage * _Nullable)#>
    self.image1.layer.cornerRadius = 10;
    self.image1.backgroundColor = [UIColor greenColor];
    self.image1.layer.borderWidth = 1;
    [self.view addSubview:self.image1];
    
    //手势
    UITapGestureRecognizer *tap1 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tap1:)];
    self.image1.userInteractionEnabled = YES;
    [self.image1 addGestureRecognizer:tap1];
    
    self.lab1 = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.image1.frame)+10, CGRectGetMinY(self.image1.frame), CGRectGetWidth(self.stateLab.frame)+50, CGRectGetHeight(self.image1.frame))];
    self.lab1.text = @"为人父母";
    self.lab1.font = [UIFont systemFontOfSize:17];
    [self.view addSubview:self.lab1];
    
    self.image2 = [[UIImageView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.maleBtn.frame)-10, CGRectGetMaxY(self.image1.frame)+20, 20, 20)];
    //    self.image1 setImage:<#(UIImage * _Nullable)#>
    self.image2.layer.cornerRadius = 10;
    self.image2.backgroundColor = [UIColor greenColor];
    self.image2.layer.borderWidth = 1;
    [self.view addSubview:self.image2];
     UITapGestureRecognizer *tap2 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tap2:)];
    self.image2.userInteractionEnabled = YES;
    [self.image2 addGestureRecognizer:tap2];
    
    self.lab2 = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.image2.frame)+10, CGRectGetMinY(self.image2.frame), CGRectGetWidth(self.stateLab.frame)+50, CGRectGetHeight(self.image1.frame))];
    self.lab2.text = @"恋爱中/已婚";
    self.lab2.font = [UIFont systemFontOfSize:17];
    [self.view addSubview:self.lab2];
    
    
    self.image3 = [[UIImageView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.maleBtn.frame)-10, CGRectGetMaxY(self.image2.frame)+20, 20, 20)];
    //    self.image1 setImage:<#(UIImage * _Nullable)#>
    self.image3.layer.cornerRadius = 10;
    self.image3.backgroundColor = [UIColor greenColor];
    self.image3.layer.borderWidth = 1;
    [self.view addSubview:self.image3];
    UITapGestureRecognizer *tap3 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tap3:)];
    [self.image3 addGestureRecognizer:tap3];
    
    
    
    self.lab3 = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.image3.frame)+10, CGRectGetMinY(self.image3.frame), CGRectGetWidth(self.stateLab.frame)+50, CGRectGetHeight(self.image2.frame))];
    self.lab3.text = @"单身贵族";
    self.lab3.font = [UIFont systemFontOfSize:17];
    self.image3.userInteractionEnabled = YES;
    [self.view addSubview:self.lab3];
    

    
}

- (void)routateAction:(UIButton *)sender{


    if (_gender == 0) {
        
        [self buttonAnimation:sender];
        [self femaleroutateAction:self.femaleBtn];
        [self.maleBtn setBackgroundColor:[UIColor redColor]];
        [self.femaleBtn setBackgroundColor:[UIColor whiteColor]];
       
    }else {
        
        [self buttonAnimation:sender];
        [self buttonAnimation:self.maleBtn];
        [self.maleBtn setBackgroundColor:[UIColor whiteColor]];
        [self.femaleBtn setBackgroundColor:[UIColor redColor]];
       
    }
   
  
}


- (void)femaleroutateAction:(UIButton *)sender{

    
    if (_gender == 1) {
        
        [self buttonAnimation:sender];
        [self femaleroutateAction:self.femaleBtn];
        [self.maleBtn setBackgroundColor:[UIColor redColor]];
        [self.femaleBtn setBackgroundColor:[UIColor whiteColor]];
        
    }else {
        
        [self buttonAnimation:sender];
        [self buttonAnimation:self.maleBtn];
        [self.maleBtn setBackgroundColor:[UIColor whiteColor]];
        [self.femaleBtn setBackgroundColor:[UIColor redColor]];
        
    }
    
    
}
-(void)buttonAnimation:(id)sender{
    UIButton *theButton = sender;
    CAAnimation *myAnimationRotate = [self animationRotate];
    CAAnimationGroup *m_pGroupAnimation;
    m_pGroupAnimation = [CAAnimationGroup animation];
    m_pGroupAnimation.delegate = self;
    m_pGroupAnimation.removedOnCompletion = NO;
    m_pGroupAnimation.duration = 1;
    m_pGroupAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    m_pGroupAnimation.repeatCount = 1;
    m_pGroupAnimation.fillMode = kCAFillModeForwards;
    m_pGroupAnimation.animations = [NSArray arrayWithObjects:myAnimationRotate,nil];
    [theButton.layer addAnimation:m_pGroupAnimation forKey:@"animationRotate"];
    
    
}

-(CAAnimation*)animationRotate{
    CATransform3D rotationTransform=CATransform3DMakeRotation(M_PI/2,0,-1,0);
    
    CABasicAnimation*animation;
    animation=[CABasicAnimation animationWithKeyPath:@"transform"];
    animation.toValue=[NSValue valueWithCATransform3D:rotationTransform];
    animation.duration=0.2;
    animation.autoreverses=YES;
    animation.cumulative=YES;
    animation.repeatCount=1;
    animation.beginTime=0.1;
    animation.delegate=self;
    
    return animation;
}





//手势方法
- (void)tap1:(UITapGestureRecognizer *)sender{

    _state = 0;
    self.image1.backgroundColor = [UIColor whiteColor];
    self.image1.image = [UIImage imageNamed:@"2.jpeg"];
    self.image2.backgroundColor = [UIColor greenColor];
    self.image2.image = [UIImage imageNamed:@" "];
    self.image3.backgroundColor = [UIColor greenColor];
    self.image3.image = [UIImage imageNamed:@" "];
}

- (void)tap2:(UITapGestureRecognizer *)sender{

    _state = 1;
    self.image2.backgroundColor = [UIColor whiteColor];
    self.image2.image = [UIImage imageNamed:@"2.jpeg"];
    self.image1.backgroundColor = [UIColor greenColor];
    self.image1.image = [UIImage imageNamed:@" "];
    self.image3.backgroundColor = [UIColor greenColor];
    self.image3.image = [UIImage imageNamed:@" "];

}

- (void)tap3:(UITapGestureRecognizer *)sender{

    _state = 2;
    self.image3.backgroundColor = [UIColor whiteColor];
    self.image3.image = [UIImage imageNamed:@"2.jpeg"];
    self.image1.backgroundColor = [UIColor greenColor];
    self.image1.image = [UIImage imageNamed:@" "];
    self.image2.backgroundColor = [UIColor greenColor];
    self.image2.image = [UIImage imageNamed:@" "];
    

}
- (void)changeAction:(UITapGestureRecognizer *)sender{
    
    UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:@"请选择照片" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"拍照",@"相册", nil];
    /**
     *  window代表着最高处，所有能看到的view，后面都是window。
     *  当push相机控制器的时候，self.view就自动移除了。而当dismiss控制器的时候，因为self.view移除了，所有sheet无法寄居在view的上面，而固定在self.view.window,就可以保证，sheet一定在view视图上
     */
    [sheet showInView:self.view.window];
    
}

-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    UIImagePickerController *ipc = [[UIImagePickerController alloc] init];
    
    ipc.delegate = self;
    ipc.allowsEditing = YES;  //相片是否可编辑
    switch (buttonIndex) {
        case 0:
            if (![UIImagePickerController isSourceTypeAvailable:
                  UIImagePickerControllerSourceTypeCamera]) return;
            ipc.sourceType = UIImagePickerControllerSourceTypeCamera;
            break;
        case 1:
            if (![UIImagePickerController isSourceTypeAvailable:
                  UIImagePickerControllerSourceTypePhotoLibrary]) return;
            ipc.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            break;
            
        default:
            return;
            break;
    }
    [self presentViewController:ipc animated:YES completion:nil];
}


//点击取消时触发的方法
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker dismissViewControllerAnimated:YES completion:nil];

}

//选取完成时触发的方法
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{

    [picker dismissViewControllerAnimated:YES completion:nil];
    
    //此处需要存储
//    self.imageV.image = [UIImage imageNamed:@"222"];
//    
    self.imageV.image = [info objectForKey:UIImagePickerControllerOriginalImage];
    
    
    self.imageV.layer.cornerRadius = 50;
    self.imageV.layer.masksToBounds = YES;
    
    
    
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.nameTextF endEditing:YES];
}
//回收键盘
//- (BOOL)textFieldShouldReturn:(UITextField *)textField{
//    [textField resignFirstResponder];
//    return YES;
//}
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
