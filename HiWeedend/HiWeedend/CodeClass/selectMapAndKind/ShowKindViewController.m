//
//  ShowKindViewController.m
//  HiWeedend
//
//  Created by lanou3g on 16/4/23.
//  Copyright © 2016年 高艳闯. All rights reserved.
//

#import "ShowKindViewController.h"
#import "ShowKindTableViewCell.h"
#import "ShowModel.h"
#import "HomePageListViewController.h"
#import "AFNetworkActivityIndicatorManager.h"
#import "UIActivityIndicatorView+AFNetworking.h"
#import "DatailsViewController.h"
#import "MJExtension.h" //xml plist json数据解析封装
#import "MJRefresh.h" //加载刷新

@interface ShowKindViewController ()<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,strong)UITableView*showTabelView;
@property(nonatomic,strong)NSMutableArray*dataArray;




@end

@implementation ShowKindViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"%@%%%%%%%%%%%%%%",self.cityLocation);

  
//        self.navigationItem.leftBarButtonItem=[[UIBarButtonItem alloc]initWithTitle:@"<" style:(UIBarButtonItemStylePlain) target:self action:@selector(rightAction:)];
    self.dataArray=[NSMutableArray array];
    
    [self addView];
    [self setupRefresh]; //上拉加载下拉刷新

}
#pragma mark================ 加载刷新============
- (void)setupRefresh //添加下载刷新
{
    self. showTabelView.header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewShops)];
    [self. showTabelView.header beginRefreshing];
    
    self. showTabelView.footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreShops)];
    //隐藏上拉加载隐藏
    //self.collectionView.footer.hidden = YES;
}

//下拉刷新
- (void)loadNewShops
{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        //调用数据 刷新UI
    
        
            [self requestData];
        [self.dataArray removeAllObjects];
        //[self.dataArray addObjectsFromArray:shops];
        
        // 刷新数据
        [self. showTabelView reloadData];
        
        //停止
        [self. showTabelView.header endRefreshing];
    });
}
//上拉加载
- (void)loadMoreShops
{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        

    [self requestData];
        
        // 刷新数据
        [self. showTabelView reloadData];
        
        //停止
        [self. showTabelView.footer endRefreshing];
    });
}




-(void)requestData{
    
    
    [NetWorkRequestManager requestWithType:GET urlString:self.requestURLString parDic:nil finish:^(NSData *data) {
        NSMutableDictionary *contentDic = [NSJSONSerialization JSONObjectWithData:data options: NSJSONReadingAllowFragments error:nil];
      //  NSLog(@"++++++888888888+++++++%@",contentDic);
        NSArray *array = contentDic[@"result"];
        for (NSDictionary *dic in array) {
            ShowModel *model = [[ShowModel alloc]init];
            [model setValuesForKeysWithDictionary:dic];
            [self.dataArray addObject:model];
            // NSLog(@"%@",_dataArray);
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            [_showTabelView reloadData];
            
        });
        
        
    } error:^(NSError *error) {
        NSLog(@"asdfasfd");
    }];
    
    
    
    
}

//-(void)rightAction:(UIBarButtonItem*)sender{
//    
//    [self dismissViewControllerAnimated:YES completion:nil];
//    
//}


-(void)addView{
    
    
    
    
    
    self.showTabelView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, kWidth, kHeight)];
    [self.view addSubview:self.showTabelView];
    
    
    self.showTabelView.delegate =self;
    self.showTabelView.dataSource =self;
    [self.showTabelView registerNib:[UINib nibWithNibName:@"ShowKindTableViewCell" bundle:nil] forCellReuseIdentifier:@"cell"];
// [self.showTabelView registerNib:[UINib nibWithNibName:@"ShowHeadTableViewCell" bundle:nil] forCellReuseIdentifier:@"cell"];
    



}


#pragma mark ========delegate===========

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return  self.dataArray.count;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ShowKindTableViewCell*cell=[_showTabelView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    ShowModel*model = self.dataArray[indexPath.row];
    cell.showTitle .text =model.title;
    
    [cell.showImage sd_setImageWithURL:[NSURL URLWithString:[model.front_cover_image_list firstObject]]];
 
    NSString *string =  [model.poi stringByAppendingString:@" * "];
    cell.showkind.text = [string stringByAppendingString:model.category];
    
    //navation title
    self.title = model.category;
//    cell.showTime.text = model.time_desc;
   cell.showTime.text = [self mystring:@"  " stringByAppding:model.time_desc and:@"  "];
    NSLog(@"****%@,&&&%@",model.time_info,model.time_desc);

    NSString *string1 = [self mystring:@"  " stringByAppding:[NSString stringWithFormat:@"%ld",(long)model.collected_num] and:@"人收藏  "];
    // 给button添加图片
    [cell.showButton setImage:[UIImage imageNamed:@"666.png"] forState:(UIControlStateNormal)];
    // 给button的图片添加位置
    cell.showButton.imageEdgeInsets = UIEdgeInsetsMake(0, 5, 0, 0);
    [cell.showButton setTitle:string1 forState:(UIControlStateNormal)];
    cell.showButton.layer.borderWidth = 0.5;
    cell.showButton.layer.cornerRadius = 5;
    self.showTabelView.delaysContentTouches  = NO;
    // 添加点击事件
    cell.showButton.tag = indexPath.row;
    [cell.showButton addTarget:self action:@selector(cokkectedAction:) forControlEvents:(UIControlEventTouchUpInside)];
    cell.showprice.text =[self mystring:@"  ¥" stringByAppding:[NSString stringWithFormat:@"%ld",(long)model.price] and:@"  "];


    return  cell;

}

// 判断button点击的状态
-(void)cokkectedAction:(UIButton *)sender{
    ShowModel *model =  self.self.dataArray[sender.tag];
    ShowKindTableViewCell *cell =  (ShowKindTableViewCell *)[[sender superview] superview];
    // 判断cell上button的状态
    if (cell.isTap) {
        [NetWorkRequestManager requestWithType:POST urlString:HWCOLLECTIONBUTTON parDic:@{@"colects":[NSString stringWithFormat:@"%ld", (long)model.leo_id],@"session_id":@"0000423d7ecd75af788f3763566472ed27f06e"} finish:^(NSData *data) {
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
            NSLog(@"%@",dic[@"result"]);
        } error:^(NSError *error) {
            NSLog(@"失败");
        }];
        NSString *string1 = [self mystring:@"  " stringByAppding:[NSString stringWithFormat:@"%ld",(long)model.collected_num + 1] and:@"人收藏  "];
        [sender setTitle:string1 forState:(UIControlStateNormal)];
        cell.isTap = NO;
    }else{
        [NetWorkRequestManager requestWithType:POST urlString:HWCANCEL parDic:@{@"colects":[NSString stringWithFormat:@"%ld", (long)model.leo_id],@"session_id":@"0000423d7ecd75af788f3763566472ed27f06e"} finish:^(NSData *data) {
            //            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
            //            NSLog(@"%@",dic[@"result"]);
            
        } error:^(NSError *error) {
            NSLog(@"失败");
            
        }];
        NSString *string1 = [self mystring:@"  " stringByAppding:[NSString stringWithFormat:@"%ld",(long)model.collected_num ] and:@"人收藏  "];
        [sender setTitle:string1 forState:(UIControlStateNormal)];
        cell.isTap = YES;
    }
}



// 给label的前后加空格
-(NSString *)mystring:(NSString *)myString stringByAppding:(NSString *)modelStr and:(NSString *)andString{
    NSString *string = [myString stringByAppendingString:modelStr];
    NSString *str = [string stringByAppendingString:andString];
    return str;
    
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{



    return  350;

}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    DatailsViewController*detail=[[DatailsViewController alloc]init];
    ShowModel*model=self.dataArray[indexPath.row];
    detail.HpmeModel = (HomePageListModel*)model;

    [self.navigationController pushViewController:detail animated:YES];

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
