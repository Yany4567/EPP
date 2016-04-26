//
//  ViewController.m
//  传值练习 _yst
//
//  Created by lanou3g on 16/4/24.
//  Copyright © 2016年 YST. All rights reserved.
//

#import "ViewController.h"
#import "FirstViewController.h"

#import "secendActepViewController.h"
#import "ThitdActpeViewController.h"
#import "FourthViewController.h"
#import "FirstViewController.h"
#import "SixthViewController.h"
#import "SecendViewController.h"
#import "EightViewController.h"


#define ScreenWidth [UIScreen mainScreen].bounds.size.width
#define  ScreenHight  [UIScreen mainScreen].bounds.size.height



@interface ViewController ()<UITableViewDataSource,UITableViewDelegate> @property(nonatomic,strong)UILabel*labelv;
@property (weak, nonatomic) IBOutlet UITableView *tabelView;
//@property(nonatomic,strong)UITableView*tabelview;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title =@"八种传值练习";
    
    self.tabelView .dataSource =self;
    self.tabelView.delegate =self;
    
    
    UIView*view=[[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 200)];
    view.backgroundColor=[UIColor cyanColor];
    [self.view addSubview:view];
    self.labelv=[[UILabel alloc]initWithFrame:CGRectMake(50, 70, 200, 40)];
    self.labelv.backgroundColor=[UIColor whiteColor];
    
    [view addSubview:self.labelv];
    
    self.tabelView.tableHeaderView = view;
    self.labelv.text = @"接受下个页面传值";
    
 }

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{


    return 8;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    return 80;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell=[self.tabelView dequeueReusableCellWithIdentifier:@"cell" ];

    if (cell==0) {
        cell=[[UITableViewCell alloc]initWithStyle:(UITableViewCellStyleSubtitle) reuseIdentifier:@"cell"];
    }
    
    
    if (indexPath.row == 0) {
        cell.textLabel.text=@"属性传值:适合从前传到后面,在push 或modal时传 在跳转页面.h 里声明接收,接受与传的类型要一致";
        //小标题
        cell.detailTextLabel.text= @"";

        
    }else if (indexPath.row ==1){
        
       cell.textLabel.text =@"协议传值 ";
        
        
    }else if (indexPath.row ==2){
      cell.textLabel.text = @"block";
    
    }else if (indexPath.row ==3){
        
          cell.textLabel.text =@" ";
    }else if (indexPath.row ==4){
        
         cell.textLabel.text =@" ";
    }else if (indexPath.row ==5){
        
         cell.textLabel.text =@" ";
    }else if (indexPath.row ==6){
        
          cell.textLabel.text =@" ";
    }else if (indexPath.row ==7){
        
         cell.textLabel.text =@" ";
    }


    return  cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    

    if (indexPath.row == 0) {
       
        //小标题
       
        FirstViewController*first=[[FirstViewController alloc]init];
        first.string = @"从前面传过来字符串";
        
        [self.navigationController pushViewController:first animated:YES];
        
    }else if (indexPath.row ==1){
        
                   secendActepViewController*sec=[[secendActepViewController alloc]init];
        
             
        
                 [self.navigationController pushViewController:sec animated:YES];
    }else if (indexPath.row ==2){
        
      ThitdActpeViewController*third=[[ThitdActpeViewController alloc]init];
        

        
        [self.navigationController pushViewController:third animated:YES];
        
        
    }else if (indexPath.row ==3){
        
        
    }else if (indexPath.row ==4){
        
        
    }else if (indexPath.row ==5){
        
        
    }else if (indexPath.row ==6){
        
        
    }else if (indexPath.row ==7){
        
        
    }
    





}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
