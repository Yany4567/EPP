//
//  HomePageListViewController.m
//  HiWeedend
//
//  Created by lanou3g on 16/4/17.
//  Copyright © 2016年 高艳闯. All rights reserved.
//

#import "HomePageListViewController.h"
#import "HomePageListModel.h"
#import "GroupListModel.h"

#import "GroupListCell.h"
#import "HomePageCell.h"
#import "AFNetworkActivityIndicatorManager.h"
#import "UIActivityIndicatorView+AFNetworking.h"
#import "MapAndKindViewController.h"
#import "LocationModel.h"
#import <CoreLocation/CoreLocation.h>

#import "SecondaryTableViewController.h"
#import "DatailsViewController.h"
#import "MapViewController.h"

// 添加上拉加载 下拉刷新
#import "MJRefresh.h"

@interface HomePageListViewController ()<UITableViewDataSource,UITableViewDelegate,CLLocationManagerDelegate>
// 初始化一个数组
@property(nonatomic,strong)NSMutableArray *pageListArray;

@property(nonatomic,strong)NSMutableArray *locationArray;
// 定义的Tableview
@property (weak, nonatomic) IBOutlet UITableView *listTable;
@property(nonatomic,assign)NSInteger index;
// 创建位置管理
@property(nonatomic,strong)CLLocationManager *locationManager;

@property(nonatomic,strong)NSString *longitude;

@property(nonatomic,strong)NSString *latitude;
@property(nonatomic,assign)int page;
@property(nonatomic,assign)NSInteger cityId;


@end

@implementation HomePageListViewController
// 初始化数组
-(NSMutableArray *)pageListArray{
    if (_pageListArray == nil) {
        _pageListArray = [NSMutableArray array];
    }
    return _pageListArray;
}

// 初始化locationManager
-(CLLocationManager *)locationManager{
    if (!_locationManager) {
        _locationManager = [[CLLocationManager alloc]init];
        
    }
    return _locationManager;
}

-(NSMutableArray *)locationArray{
    if (_locationArray == nil) {
        _locationArray = [NSMutableArray array];
    }
    return _locationArray;
}

// 解析位置数据
-(void)requestLocation{
    NSLog(@"+++++精度%@",self.latitude);
    NSLog(@"++++++纬度%@",self.longitude);
    
    AFHTTPSessionManager *session = [AFHTTPSessionManager manager];
       session.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"application/x-json",@"text/html", nil];
    [session GET:[self String:HWPOSITIONING byAppendingdic:@{@"lat":self.latitude,@"lon":self.longitude,@"session_id":@"0000423d7ecd75af788f3763566472ed27f06e"}] parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"_________---------%@",responseObject);
        LocationModel *model = [[LocationModel alloc]init];
        [model setValuesForKeysWithDictionary:responseObject[@"result"]];
        [self.locationArray addObject:model];
        NSLog(@"-------------%@",self.locationArray);
        [self requestData];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"失败");
    }];
}
// 进入界面的请求数据
-(void)FirstrequestData{
    [SVProgressHUD showWithStatus:@"加载中"];
   // [self performSelector:@selector(dismiss:) withObject:nil afterDelay:3];
    [NetWorkRequestManager requestWithType:GET urlString:[self String:HWHOMEPAGE byAppendingdic:@{@"city_id":@"0",@"lat":self.latitude,@"lon":self.longitude,@"page":@"1",@"session_id":@"0000423d7ecd75af788f3763566472ed27f06e",@"v":@"3"}] parDic:nil finish:^(NSData *data) {
        NSMutableDictionary *contentDic = [NSJSONSerialization JSONObjectWithData:data options: NSJSONReadingAllowFragments error:nil];
        // NSLog(@"+++++++++++++%@",contentDic);
        NSArray *array = contentDic[@"result"];
        // 移除pageListArray的内容
        [self.pageListArray removeAllObjects];
        for (NSDictionary *dic in array) {
            HomePageListModel *model = [[HomePageListModel alloc]init];
            [model setValuesForKeysWithDictionary:dic];
            [self.pageListArray addObject:model];
            
        }
       [SVProgressHUD dismiss];

        dispatch_async(dispatch_get_main_queue(), ^{
            [_listTable reloadData];
            
        });
        
        
    } error:^(NSError *error) {
        NSLog(@"asdfasfd");
    }];
}

-(void)dismiss:(id)sender{

    [SVProgressHUD dismiss];

}

// GET请求时拼接字符串完成网址
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

// 解析数据
-(void)requestData{
    LocationModel *model1 = [self.locationArray lastObject];
    self.cityId = model1.cityId;
     NSString *city = [NSString stringWithFormat:@"%ld",(long)self.cityId];
    [NetWorkRequestManager requestWithType:GET urlString:[self String:HWHOMEPAGE byAppendingdic:@{@"city_id":city,@"lat":self.latitude,@"lon":self.longitude,@"page":@"1",@"session_id":@"0000423d7ecd75af788f3763566472ed27f06e",@"v":@"3"}] parDic:nil finish:^(NSData *data) {
        NSMutableDictionary *contentDic = [NSJSONSerialization JSONObjectWithData:data options: NSJSONReadingAllowFragments error:nil];
            NSArray *array = contentDic[@"result"];
            // 移除pageListArray的内容
            [self.pageListArray removeAllObjects];
            for (NSDictionary *dic in array) {
                HomePageListModel *model = [[HomePageListModel alloc]init];
                [model setValuesForKeysWithDictionary:dic];
                [self.pageListArray addObject:model];
                
            }
        
            dispatch_async(dispatch_get_main_queue(), ^{
                [_listTable reloadData];
                
            });
            [self setupRefresh]; //上拉加载下拉刷新
            
    } error:^(NSError *error) {
        NSLog(@"asdfasfd");
    }];
}

-(void)requestRefresh{
    
    LocationModel *model1 = [self.locationArray lastObject];
    NSString *city = [NSString stringWithFormat:@"%ld",(long)model1.cityId];
    [NetWorkRequestManager requestWithType:GET urlString:[self String:HWHOMEPAGE byAppendingdic:@{@"city_id":city,@"lat":self.latitude,@"lon":self.longitude,@"page":[NSString stringWithFormat:@"%d",self.page++],@"session_id":@"0000423d7ecd75af788f3763566472ed27f06e",@"v":@"3"}] parDic:nil finish:^(NSData *data) {
        NSMutableDictionary *contentDic = [NSJSONSerialization JSONObjectWithData:data options: NSJSONReadingAllowFragments error:nil];
        NSArray *array = contentDic[@"result"];
        for (NSDictionary *dic in array) {
            HomePageListModel *model = [[HomePageListModel alloc]init];
            [model setValuesForKeysWithDictionary:dic];
            [self.pageListArray addObject:model];
            
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            [_listTable reloadData];
            
        });
        
        
    } error:^(NSError *error) {
        NSLog(@"asdfasfd");
    }];

    
}


- (void)viewDidLoad {
    self.cityId = 0;
    self.longitude = 0;
    self.latitude = 0;
    self.page = 2;
    [super viewDidLoad];
    [AFNetworkActivityIndicatorManager  sharedManager].enabled = YES;
    // 判断版本 请求定位
   [self getlocation];
    
    // 设置代理
    _locationManager.delegate = self;
    self.listTable.delegate = self;
    self.listTable.dataSource = self;
    
    // 定义cell的重用标识符
    [self.listTable registerNib:[UINib nibWithNibName:@"GroupListCell" bundle:nil] forCellReuseIdentifier:@"GroupListCell"];
    [self.listTable registerNib:[UINib nibWithNibName:@"HomePageCell" bundle:nil] forCellReuseIdentifier:@"HomePageCell"];
    self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed: @"666.png"] style:(UIBarButtonItemStylePlain) target:self action:@selector(rightBarbuttonAction:)];
    [self.navigationItem setTitle:@"嗨!周末"];
    

}

// 上了加载
-(void)setupRefresh{
//    self.listTable.header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewShops)];
//    [self.listTable.header beginRefreshing];
//    
    self.listTable.footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreShops)];
    
}
- (void)loadMoreShops
{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
       
        // 刷新数据
        [self requestRefresh];
                //停止
            [self.listTable.footer endRefreshing];
            [self.listTable reloadData];
    });
}

// 上拉加载
- (void)loadNewShops
{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        
        [self requestData];
        [self.listTable reloadData];
        
        //停止
        [self.listTable.header endRefreshing];
    });
}


-(void)getlocation{
    _locationManager = [[CLLocationManager alloc]init];
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 8.0) {
        [_locationManager requestWhenInUseAuthorization];
    }
    _locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    _locationManager.distanceFilter = 1000;
    [_locationManager startUpdatingLocation];
    
   
}

// 定位的代理方法 获得经纬度
-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations{
    CLLocation *location = [locations lastObject];
    self.longitude = [NSString stringWithFormat:@"%f",location.coordinate.longitude];
    self.latitude = [NSString stringWithFormat:@"%f",location.coordinate.latitude];
    [_locationManager stopUpdatingLocation];
    
    NSLog(@"精度%f",location.coordinate.longitude);
    NSLog(@"纬度%f",location.coordinate.latitude);
    MapViewController *mapVC = [[MapViewController alloc]init];
   // mapVC.coord2d = CLLocationCoordinate2DMake(location.coordinate.latitude, location.coordinate.longitude);
    NSLog(@"精度%f",mapVC.coord2d.longitude);
    
        [self FirstrequestData];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.01 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self requestLocation];
    }); 
    
    
}
// 监听状态的改变
-(void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status{
    
    switch (status) {
        case kCLAuthorizationStatusNotDetermined:
            NSLog(@"用户未完成");
            break;
        case kCLAuthorizationStatusRestricted:
            NSLog(@"访问受限");
           // [self requestFirstData];
            break;
        case kCLAuthorizationStatusDenied:
            // 判断当前定位服务是否有用
            if ([CLLocationManager locationServicesEnabled]) {
                NSLog(@"定位服务可用，但拒绝");
            }else{
                NSLog(@"定位服务关闭");
            }
            break;
        case kCLAuthorizationStatusAuthorizedAlways:
            NSLog(@"前后台定位服务授权");
            break;
        case kCLAuthorizationStatusAuthorizedWhenInUse:
            NSLog(@"前台服务授权");
            break;
        default:
            break;
    }
    
    
}


//跳转到地图和分类列表
-(void)rightBarbuttonAction:(UIBarButtonItem*)sender{
    
    MapAndKindViewController*map=[[MapAndKindViewController alloc]init];
   //UINavigationController*naV=[[UINavigationController alloc]initWithRootViewController:map];
   // UINavigationController*nav=[[UINavigationController alloc]initWithRootViewController:map];
    
 [self.navigationController pushViewController:map animated:YES];
    //[self.navigationController presentViewController:naV animated:YES completion:nil];

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
        cell2.priceLabel.text =[self mystring:@"  ¥" stringByAppding:[NSString stringWithFormat:@"%ld",(long)model.price] and:@"  "];
        cell2.priceLabel.layer.borderWidth = 0.5;
        cell2.priceLabel.layer.cornerRadius = 5;
        // 记录button的状态
        cell2.isTap = YES;
        
        return cell2;
    }else{
    GroupListCell *cell1 = [tableView dequeueReusableCellWithIdentifier:@"GroupListCell" forIndexPath:indexPath];
        [cell1.civerImage sd_setImageWithURL:[NSURL URLWithString:[model.front_cover_image_list firstObject]]];
        cell1.TitleLabel.text = model.title;
        cell1.nameLabel.text = [self mystring:@"  " stringByAppding:@"精选" and:@"  "];
        cell1.nameLabel.layer.cornerRadius = 5;
        cell1.nameLabel.layer.borderWidth = 0.5;
        return cell1;
    }
    
}
// 判断button点击的状态
-(void)cokkectedAction:(UIButton *)sender{
    HomePageListModel *model =  self.pageListArray[sender.tag];
    HomePageCell *cell =  (HomePageCell *)[[sender superview] superview];
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

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    DatailsViewController *dataVC = [[DatailsViewController alloc]init];
    SecondaryTableViewController *secondVC = [[SecondaryTableViewController alloc]init];
    
    HomePageListModel *model = self.pageListArray[indexPath.row];
    
    if ([model.jump_data isEqualToString:@""]) {
         dataVC.HpmeModel = model;
        [self.navigationController pushViewController:dataVC animated:YES];
    }else{
       
        
        [self.navigationController pushViewController:secondVC animated:YES];
    }
    
    
}

// 给label的前后加空格
-(NSString *)mystring:(NSString *)myString stringByAppding:(NSString *)modelStr and:(NSString *)andString{
    NSString *string = [myString stringByAppendingString:modelStr];
    NSString *str = [string stringByAppendingString:andString];
    return str;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 330;
    
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
