//
//  HomePageListViewController.m
//  HiWeedend
//
//  Created by lanou3g on 16/4/17.
//  Copyright © 2016年 高艳闯. All rights reserved.
//

#import "HomePageListViewController.h"
//#import "HomePageListViewContriler.h"
#import "HomePageListModel.h"
#import "GroupListModel.h"

//#import "AFNetworking.h"
#import "GroupListCell.h"
#import "HomePageCell.h"
#import "AFNetworkActivityIndicatorManager.h"
#import "UIActivityIndicatorView+AFNetworking.h"
#import "MapAndKindViewController.h"

#import "SecondaryTableViewController.h"

@interface HomePageListViewController ()<UITableViewDataSource,UITableViewDelegate>
// 初始化一个数组
@property(nonatomic,strong)NSMutableArray *pageListArray;




@property(nonatomic,strong)NSMutableArray *groupListArray;
// 定义的Tableview
@property (weak, nonatomic) IBOutlet UITableView *listTable;
// 给一个bool值判断收藏的状态
//@property(nonatomic,assign)BOOL isTap;

@property(nonatomic,assign)NSInteger index;

@end

@implementation HomePageListViewController
// 初始化数组
-(NSMutableArray *)pageListArray{
    if (_pageListArray == nil) {
        _pageListArray = [NSMutableArray array];
    }
    return _pageListArray;
}

-(NSMutableArray *)groupListArray{
    if (_groupListArray == nil) {
        _groupListArray = [NSMutableArray array];
    }
    return _groupListArray;
}
// 解析数据
-(void)requestData{
    
  //  AFHTTPSessionManager *session = [AFHTTPSessionManager manager];
   
//    [session GET:HWHOMEPAGE parameters:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//        NSLog(@"_________---------%@",responseObject);
//    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//        NSLog(@"失败");
//    }];
//    
    
    

    
        [NetWorkRequestManager requestWithType:GET urlString:HWHOMEPAGE parDic:nil finish:^(NSData *data) {
        NSMutableDictionary *contentDic = [NSJSONSerialization JSONObjectWithData:data options: NSJSONReadingAllowFragments error:nil];
//        NSLog(@"+++++++++++++%@",contentDic);
            NSArray *array = contentDic[@"result"];
            for (NSDictionary *dic in array) {
                HomePageListModel *model = [[HomePageListModel alloc]init];
                [model setValuesForKeysWithDictionary:dic];
                [self.pageListArray addObject:model];
                
//                NSLog(@"#########%@",model);
                
                
                
                
            }
            dispatch_async(dispatch_get_main_queue(), ^{
                [_listTable reloadData];
            });
            
            
    } error:^(NSError *error) {
        NSLog(@"asdfasfd");
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    //self.isTap = YES;
    //[AFNetworkActivityIndicatorManager  sharedManager].enabled = YES;
    [self requestData];
    self.listTable.delegate = self;
    self.listTable.dataSource = self;
    // 定义cell的重用标识符
    [self.listTable registerNib:[UINib nibWithNibName:@"GroupListCell" bundle:nil] forCellReuseIdentifier:@"GroupListCell"];
    [self.listTable registerNib:[UINib nibWithNibName:@"HomePageCell" bundle:nil] forCellReuseIdentifier:@"HomePageCell"];
    // Do any additional setup after loading the view from its nib.
    
    self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed: @"666.png"] style:(UIBarButtonItemStylePlain) target:self action:@selector(rightBarbuttonAction:)];
   // self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc]initWithTitle:@"+" style:(UIBarButtonItemStylePlain) target:self action:@selector(rightBarbuttonAction:)];
    
    
    
}

-(void)rightBarbuttonAction:(UIBarButtonItem*)sender{
    
    MapAndKindViewController*map=[[MapAndKindViewController alloc]init];
    
    UINavigationController*naV=[[UINavigationController alloc]initWithRootViewController:map];
    
    
    //[self.navigationController pushViewController:naV animated:YES];

  [self.navigationController presentViewController:naV animated:YES completion:nil];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.pageListArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    self.index = 0;
    HomePageListModel *model = self.pageListArray[indexPath.row];
    self.index =(long) model.leo_id;
  
    // 通过判断jump_data的值判断用哪个cell
    if ([model.jump_data isEqualToString:@""]) {
         HomePageCell *cell2 = [tableView dequeueReusableCellWithIdentifier:@"HomePageCell" forIndexPath:indexPath];
        [cell2.coverImage sd_setImageWithURL:[NSURL URLWithString:[model.front_cover_image_list firstObject]]];
        cell2.titleLabel.text = model.title;
         NSString *string =  [model.poi stringByAppendingString:@" * "];
        cell2.poiLabel.text = [string stringByAppendingString:model.category];
        cell2.timeIfoLabel.text = [self mystring:@"  " stringByAppding:model.time_info and:@"  "];
        cell2.timeIfoLabel.layer.borderWidth = 0.5;
        cell2.timeIfoLabel.layer.cornerRadius = 5;
        
        NSString *string1 = [self mystring:@"  " stringByAppding:[NSString stringWithFormat:@"%ld",(long)model.collected_num] and:@"人收藏  "];

        // 给button添加图片
        [cell2.collectedButton setImage:[UIImage imageNamed:@"666.png"] forState:(UIControlStateNormal)];
        // 给button的图片添加位置
        cell2.collectedButton.imageEdgeInsets = UIEdgeInsetsMake(0, 5, 0, 0);
        [cell2.collectedButton setTitle:string1 forState:(UIControlStateNormal)];
        cell2.collectedButton.layer.borderWidth = 0.5;
        cell2.collectedButton.layer.cornerRadius = 5;
        self.listTable.delaysContentTouches  = NO;
        // 添加点击事件
        cell2.collectedButton.tag = indexPath.row;
        [cell2.collectedButton addTarget:self action:@selector(cokkectedAction:) forControlEvents:(UIControlEventTouchUpInside)];
      
        cell2.priceLabel.text =[self mystring:@"  ¥" stringByAppding:[NSString stringWithFormat:@"%ld",model.price] and:@"  "];
        cell2.priceLabel.layer.borderWidth = 0.5;
        cell2.priceLabel.layer.cornerRadius = 5;
        cell2.isTap = YES;
        
        return cell2;
    }else{
    GroupListCell *cell1 = [tableView dequeueReusableCellWithIdentifier:@"GroupListCell" forIndexPath:indexPath];

        [cell1.civerImage sd_setImageWithURL:[NSURL URLWithString:[model.front_cover_image_list firstObject]]];
        cell1.TitleLabel.text = model.title;
        cell1.nameLabel.layer.cornerRadius = 2;
        
        return cell1;
    }
    
    
   
    
    
    //return cell;
    
    
}
// 判断button点击的状态
-(void)cokkectedAction:(UIButton *)sender{
//    HomePageCell *cell = [[HomePageCell alloc]init];
//    cell.collectedButton = (UIButton *)sender;
    NSInteger inter = sender.tag;
    HomePageListModel *model =  self.pageListArray[inter];
    HomePageCell *cell =  (HomePageCell *)[[sender superview] superview];
    //cell = [sender viewWithTag:sender.tag];
    
    
    
    NSLog(@"%ld",inter);
    
    //NSLog(@"2222222222222222222");
    //NSIndexPath *index = [self.listTable indexPathForSelectedRow];
    //NSLog(@"%@",index);
    NSLog(@"%ld",model.leo_id);
    
    
    if (cell.isTap) {
        [NetWorkRequestManager requestWithType:POST urlString:HWCOLLECTIONBUTTON parDic:@{@"colects":[NSString stringWithFormat:@"%ld", model.leo_id],@"session_id":@"0000423d7ecd75af788f3763566472ed27f06e"} finish:^(NSData *data) {
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
            NSLog(@"%@",dic[@"result"]);
            
        } error:^(NSError *error) {
            NSLog(@"失败");
            
            
        }];
    //self.index = sender.tag;
        NSString *string1 = [self mystring:@"  " stringByAppding:[NSString stringWithFormat:@"%ld",(long)model.collected_num + 1] and:@"人收藏  "];
        [sender setTitle:string1 forState:(UIControlStateNormal)];
        cell.isTap = NO;
    }else{
        //if (self.index == sender.tag) {
        
        
        [NetWorkRequestManager requestWithType:POST urlString:HWCANCEL parDic:@{@"colects":[NSString stringWithFormat:@"%ld", model.leo_id],@"session_id":@"0000423d7ecd75af788f3763566472ed27f06e"} finish:^(NSData *data) {
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
            NSLog(@"%@",dic[@"result"]);
            
        } error:^(NSError *error) {
            NSLog(@"失败");
            
        }];
        NSString *string1 = [self mystring:@"  " stringByAppding:[NSString stringWithFormat:@"%ld",(long)model.collected_num ] and:@"人收藏  "];
        [sender setTitle:string1 forState:(UIControlStateNormal)];
        cell.isTap = YES;
        }
    }
    
    


//-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
//    NSLog(@"sdfasfd1231232312312312312232131231");
//    
//}

// 给label的前后加空格
-(NSString *)mystring:(NSString *)myString stringByAppding:(NSString *)modelStr and:(NSString *)andString{
    NSString *string = [myString stringByAppendingString:modelStr];
    NSString *str = [string stringByAppendingString:andString];
    return str;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 400;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    SecondaryTableViewController *secVC = [[SecondaryTableViewController alloc]init];
    HomePageListModel *model = self.pageListArray[indexPath.row];
    secVC.string = model.title;
    [self.navigationController pushViewController:secVC animated:YES];
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
//#import "HomePageListViewContriler.h"
//#import "HomePageListModel.h"
//#import "GroupListModel.h"
//
////#import "AFNetworking.h"
//#import "GroupListCell.h"
//#import "HomePageCell.h"
//#import "AFNetworkActivityIndicatorManager.h"
//#import "UIActivityIndicatorView+AFNetworking.h"
//
//
//@interface HomePageListViewContriler ()<UITableViewDelegate,UITableViewDataSource>
//
//@property(nonatomic,strong)NSMutableArray *pageListArray;
//@property(nonatomic,strong)NSMutableArray *groupListArray;
//@property (weak, nonatomic) IBOutlet UITableView *listTable;
//
//@end
//
//
//@implementation HomePageListViewContriler
//-(NSMutableArray *)pageListArray{
//    if (_pageListArray == nil) {
//        _pageListArray = [NSMutableArray array];
//    }
//    return _pageListArray;
//}
//
//-(NSMutableArray *)groupListArray{
//    if (_groupListArray == nil) {
//        _groupListArray = [NSMutableArray array];
//    }
//    return _groupListArray;
//}
//
//-(void)requestData{
//    
//    AFHTTPSessionManager *session = [AFHTTPSessionManager manager];
//    NSMutableDictionary *listdic = [NSMutableDictionary dictionary];
//    [session GET: HWHOMEPAGE parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//        NSLog(@"%@",responseObject);
//        
//    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//        NSLog(@"sdfs");
//    }];
//}
//
//
//- (void)viewDidLoad {
//    [super viewDidLoad];
//    [AFNetworkActivityIndicatorManager  sharedManager].enabled = YES;
//    [self requestData];
//    
//    [self.listTable registerNib:[UINib nibWithNibName:@"GroupListCell" bundle:nil] forCellReuseIdentifier:@"cell"];
//    // Do any additional setup after loading the view from its nib.
//}
//
//- (void)didReceiveMemoryWarning {
//    [super didReceiveMemoryWarning];
//    // Dispose of any resources that can be recreated.
//}
//
//-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
//    return 2;
//}
//
//-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
//    return cell;
//    
//    
//}
//
//
//@end
//

@end
