//
//  SearchShowController.m
//  HiWeedend
//
//  Created by lanou3g on 16/4/28.
//  Copyright © 2016年 高艳闯. All rights reserved.
//

#import "SearchShowController.h"
#import "SearchShowTableViewCell.h"
#import "SearchShowModel.h"
#import <CoreLocation/CoreLocation.h>
#import "DatailsViewController.h"
#import "SecondaryTableViewController.h"
#import "MJRefresh.h"

@interface SearchShowController ()<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *SearchTabelView;
@property(nonatomic,strong)NSMutableArray*dataArray;

//接收经度
@property(nonatomic,assign)double longitudeCity;

//接收维度
@property(nonatomic,assign)double latituCity;

@property(nonatomic,assign)int page;

@end

@implementation SearchShowController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.page=1;
    
    _dataArray=[NSMutableArray array];
    self.title =self.acceptCityName;
    
    [self addView];
    [self setupRefresh];
}

-(void)addView{
    

    self.SearchTabelView.dataSource=self;
    self.SearchTabelView.delegate =self;
    [self.SearchTabelView registerNib:[UINib nibWithNibName:@"SearchShowTableViewCell" bundle:nil] forCellReuseIdentifier:@"cell"];

    self.navigationItem.leftBarButtonItem=[[UIBarButtonItem alloc]initWithTitle:@"<" style:(UIBarButtonItemStylePlain) target:self action:@selector(BackAction:)];
    
     [self requestData:self.page++];

}
-(void)BackAction:(UIBarButtonItem*)sender{


    [self dismissViewControllerAnimated:YES completion:nil];


}

#pragma mark================ 加载刷新============
- (void)setupRefresh //添加下载刷新
{
    self. SearchTabelView.header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewShops)];
    [self. SearchTabelView.header beginRefreshing];
    
    self.SearchTabelView.footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreShops)];
    //隐藏上拉加载隐藏
    //self.selectCityShowTabelView.footer.hidden = YES;
}

//下拉刷新
- (void)loadNewShops
{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        //调用数据 刷新UI
        
        
        [self requestData:self.page++];
        [self.dataArray removeAllObjects];
        //[self.dataArray addObjectsFromArray:shops];
        
        // 刷新数据
        [self.SearchTabelView  reloadData];
        
        //停止
        [self. SearchTabelView.header endRefreshing];
    });
}
//上拉加载
- (void)loadMoreShops
{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        
        
        [self requestData:self.page++];
        
        // 刷新数据
        [self. SearchTabelView reloadData];
        
        //停止
        [self. SearchTabelView.footer endRefreshing];
    });
}



//根据地名获取经纬度
-(void)getlOcation:(NSString*)string{
    
    
    
    NSString *oreillyAddress = string;
    CLGeocoder *myGeocoder = [[CLGeocoder alloc] init];
    [myGeocoder geocodeAddressString:oreillyAddress completionHandler:^(NSArray *placemarks, NSError *error) {
        if ([placemarks count] > 0 && error == nil) {
            NSLog(@"Found %lu placemark(s).", (unsigned long)[placemarks count]);
            CLPlacemark *firstPlacemark = [placemarks objectAtIndex:0];
            NSLog(@"Longitude = %f", firstPlacemark.location.coordinate.longitude);
            NSLog(@"Latitude = %f", firstPlacemark.location.coordinate.latitude);
            
            self.latituCity= firstPlacemark.location.coordinate.latitude;
            self.longitudeCity=firstPlacemark.location.coordinate.longitude;
            
            NSLog(@"******************%f",self.longitudeCity);
            NSUserDefaults*userDefaults=[NSUserDefaults standardUserDefaults];
            [userDefaults setDouble:self.latituCity forKey:@"lat"];
            [userDefaults setDouble:self.longitudeCity forKey:@"lon"];
            
            
        }
        else if ([placemarks count] == 0 && error == nil) {
            NSLog(@"Found no placemarks.");
        } else if (error != nil) {
            NSLog(@"An error occurred = %@", error);
        }
    }];
    
    
    
}

-(void)requestData:(int)page {
    NSString*pag=[NSString stringWithFormat:@"%d",page];
    
    NSString*cityID= [NSString stringWithFormat:@"%@", self.acceptCityID ];
    
    //获取经纬度(nsstring)
    NSUserDefaults*userDefaults=[NSUserDefaults standardUserDefaults];
    double laitude =[userDefaults doubleForKey:@"let"];
    double longitude =[userDefaults doubleForKey:@"lon"];
    //double转nsstring
    NSString *lat = [NSString stringWithFormat:@"%f",laitude];
    NSString *lon = [NSString stringWithFormat:@"%f",longitude];
    
    
    //self.requestURLString 种类关键字
    // NSString*pageNumber=[NSString stringWithFormat:@"%d",page];
    
//    [NetWorkRequestManager requestWithType:GET urlString:[self String:HWHOMEPAGE byAppendingdic:@{@"city_id":cityID,@"lat":lat,@"lon":lon,@"session_id":@"0000423d7ecd75af788f3763566472ed27f06e",@"v":@"3"}] parDic:nil finish:^(NSData *data) {
      [NetWorkRequestManager requestWithType:GET urlString:[self String:HWHOMEPAGE byAppendingdic:@{@"city_id":cityID,@"lat":lat,@"lon":lon,@"page":pag,@"session_id":@"0000423d7ecd75af788f3763566472ed27f06e",@"v":@"3"}] parDic:nil finish:^(NSData *data) {
    
        NSMutableDictionary *contentDic = [NSJSONSerialization JSONObjectWithData:data options: NSJSONReadingAllowFragments error:nil];
        
        NSArray *array = contentDic[@"result"];
        NSString*aa=@"111";
        for (NSDictionary *dic in array) {
           SearchShowModel *model = [[SearchShowModel alloc]init];
            [model setValuesForKeysWithDictionary:dic];
            [self.dataArray addObject:model];
            aa=@"222";
            
        }
        //判断是否有数据 如果没有调弹框
        if (  ![aa isEqual:@"222"]) {
            [self alreation];
        }
        
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [_SearchTabelView reloadData];
            
        });
        
        
    } error:^(NSError *error) {
        NSLog(@"asdfasfd");
    }];
    
    
    
    
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return  self.dataArray.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    return 350;

}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    SearchShowTableViewCell*cell=[_SearchTabelView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];

    
    SearchShowModel*model=self.dataArray[indexPath.row];
    [cell setData:model];



    return  cell;

}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
  if (indexPath.row ==0 ) {
//        
//        if ( [self.acceptCityName isEqual:@"北京"]||[self.acceptCityName isEqual:@"上海"]||[self.acceptCityName isEqual:@"广州"]||[self.acceptCityName isEqual:@"深圳"]||[self.acceptCityName isEqual:@"杭州"]||[self.acceptCityName isEqual:@"成都"]) {
//            
//            SecondaryTableViewController*sec=[[SecondaryTableViewController alloc]init];
//            //  UINavigationController*nav=[[UINavigationController alloc]initWithRootViewController:sec];
//            
//            [self.navigationController pushViewController:sec animated:YES];
//
//        
//        }else{
//    
            DatailsViewController*detail=[[DatailsViewController alloc]init];
            SearchShowModel*model=self.dataArray[indexPath.row];
            detail.HpmeModel = (HomePageListModel*)model;
            
           // [self.navigationController pushViewController:detail animated:YES];
            [self.navigationController pushViewController:detail animated:YES];

       //}
        
    }else{

    DatailsViewController*detail=[[DatailsViewController alloc]init];
    SearchShowModel*model=self.dataArray[indexPath.row];
    detail.HpmeModel = (HomePageListModel*)model;
    
    [self.navigationController pushViewController:detail animated:YES];

    }


}


//字符串拼接方法
-(NSString *)String:(NSString *)string byAppendingdic :(NSDictionary *)dictionary{
    
    NSMutableArray *array = [NSMutableArray array];
    //遍历字典得到每一个键，得到所有的 Key＝Value类型的字符串
    for (NSString *key in dictionary) {
        NSString *str = [NSString stringWithFormat:@"%@=%@", key, dictionary[key]];
        [array addObject:str];
    }
    //数组里所有Key＝Value的字符串通过&符号连接
    NSString *parString = [array componentsJoinedByString:@"&"];
    NSString *urlString = [string stringByAppendingString:parString];
    return urlString;
    
}

-(void)alreation{
    
    UIAlertController*alre=[UIAlertController alertControllerWithTitle:@"提示" message:@"暂无你所选城市信息或信息加载完毕,请选择其他城市" preferredStyle:(UIAlertControllerStyleAlert)];
    // UIAlertAction*al=[UIAlertAction actionWithTitle:@"返回" style:(UIAlertActionStyleDefault) handler:nil];
    UIAlertAction*al=[UIAlertAction actionWithTitle:@"返回" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
//        [self .navigationController popToViewController:self.navigationController.viewControllers[2] animated:YES];
        
        [self dismissViewControllerAnimated:YES completion:nil];
        
    }];
    //UIAlertAction*al1=[UIAlertAction actionWithTitle:@"确定" style:(UIAlertActionStyleDefault) handler:nil];
    UIAlertAction*al1=[UIAlertAction actionWithTitle:@"确定" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    
    
    [alre addAction:al];
    [alre addAction:al1];
    
    
    [self presentViewController:alre animated:YES completion:nil];
    
    
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
