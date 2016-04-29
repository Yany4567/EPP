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
#import "AppDelegate.h"
#import "HomePageListViewController.h"
#import "MenuViewController.h"
#import "DrawerViewController.h"
#import <CoreLocation/CoreLocation.h>

@interface ShowKindViewController ()<UITableViewDataSource,UITableViewDelegate,CLLocationManagerDelegate>
@property(nonatomic,strong)UITableView*showTabelView;
@property(nonatomic,strong)NSMutableArray*dataArray;
@property(nonatomic,assign)int page;
@property(nonatomic,strong)NSString*cityName;
@property(nonatomic,strong)NSString*cityID;

//3 创建位置管理者
@property(nonatomic,strong)CLLocationManager * locationManger;
//二 地理编码 反编码

//编码管理者
@property(nonatomic,strong)CLGeocoder *geo;

//编码方法 (具体地理位置转换为具体位置,坐标)
-(void)geoAddress:(NSString*)address;

//反地理编码 (通过经纬度 转为具体的地理位置 街道,区,市 等)

-(void)rdegeoCoordinate:(CLLocationCoordinate2D)cood;

@end

@implementation ShowKindViewController
//懒加载
-(CLLocationManager *)locationManger
{
    
    if (!_locationManger) {
        
        
        //4 初始化位置管理者
        _locationManger =  [[CLLocationManager alloc]init];
        
        //5 设置代理
        _locationManger .delegate = self;
        
        //6 访问授权
        //ios8之前不需要访问授权
        //ios8 以后需要用户授权使用定位服务
        if([[UIDevice currentDevice].systemVersion floatValue] >=8.0){
            
            //设置支持前台定位服务使用
            [_locationManger requestWhenInUseAuthorization];
            
            //支持前后台定位服务
            [_locationManger requestAlwaysAuthorization];
            
            
        }
        //7 需要在plist文件做设置
        
        //    （1）NSLocationAlwaysUsageDescription搜索
        //
        //    （2）NSLocationWhenInUseUsageDescription
        
        //8 设置精度 精度越高越费电
        
        self.locationManger.desiredAccuracy = kCLLocationAccuracyBest;//最高精度
        //9 设置最小更新距离
        // _locationManger .distanceFilter = 10;
        
        
        
    }
    
    return  _locationManger;
    
    
}

-(CLGeocoder*)geo
{
    
    if (!_geo) {
        _geo =[[CLGeocoder alloc]init];
    }
    
    return  _geo;
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"%@%%%%%%%%%%%%%%",self.cityLocation);
      self.page=1;
  
        //self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc]initWithTitle:@"^" style:(UIBarButtonItemStylePlain) target:self action:@selector(rightAction:)];
    
         self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"home2.png"] style:(UIBarButtonItemStylePlain) target:self action:@selector(rightAction:)];
    
    self.dataArray=[NSMutableArray array];
    [self degeoCoordinate];//根据经纬度获取地址
    [self addView];
    [self setupRefresh]; //上拉加载下拉刷新
    

    NSUserDefaults*user=[NSUserDefaults standardUserDefaults];
   _cityName= [user objectForKey:@"cityName"];
    NSLog(@"----------------------------------%@",_cityName);
  _cityID=  [self isEquestString:_cityName];
        NSLog(@"----------------------------------%@",_cityID);
 
    
}

//反地理编码 (通过经纬度 转为具体的地理位置 街道,区,市 等)

-(void)degeoCoordinate{
    NSUserDefaults*userDefaults=[NSUserDefaults standardUserDefaults];
    NSString*la =[userDefaults objectForKey:@"homeLa"];
    NSString*lon =[userDefaults objectForKey:@"homeLon"];
    double la1=[la doubleValue];
    double lon1=[lon doubleValue];
    
    //CLLocationCoordinate2D coor2D = CLLocationCoordinate2DMake(la1, lon);

    
    //CLLocationCoordinate2D 坐标点
    
    //使用坐标点生成位置对象
    CLLocation *location =[[CLLocation alloc]initWithLatitude:la1 longitude:lon1];
    
    //反地理编码方法
    [self.geo reverseGeocodeLocation:location completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        if (error) {
            NSLog(@"反地理编码%@",error);
            return ;
        }
        
        //没有错误取出信息
        CLPlacemark *piachMark =placemarks.firstObject;
        
        //使用枚举方法得到信息
        [piachMark.addressDictionary enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
            
            
            if([obj isKindOfClass:[NSArray class]]){
                
                
                NSArray *objArr= obj;
                NSLog(@"keykkkkk = %@, obj = %@",key,objArr);
                
                
            }else
            {
                
                NSLog(@"key lllllll= %@, obj = %@",key,obj);
            
               // _cityName =[obj firstObject];
                  _cityName =obj ;
                NSUserDefaults*user=[NSUserDefaults standardUserDefaults];
                [user setObject:obj forKey:@"cityName"];

                
                
            }
            
        }];
        
        //打印经纬度
        
        NSLog(@"维度 =%f 经度 = %f",piachMark.location.coordinate.latitude ,piachMark.location.coordinate.longitude);
        
    }];
    
}


-(void)rightAction:(UIBarButtonItem*)sender{
//    
//    [self dismissViewControllerAnimated:YES completion:nil];
    
    //  获取抽屉对象
    DrawerViewController *menuController = (DrawerViewController*)((AppDelegate *)[[UIApplication sharedApplication] delegate]).drawerController;
    
    
        HomePageListViewController*homeVc=[[HomePageListViewController alloc]init];
        
        
        UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:homeVc];
        
        
        [ menuController setRootController:navController animated:YES];

    
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
    
        
       [self requestDataAndPageString:self.page++];
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
        
        

    [self requestDataAndPageString:self.page++];
        
        // 刷新数据
        [self. showTabelView reloadData];
        
        //停止
        [self. showTabelView.footer endRefreshing];
    });
}



-(void)requestDataAndPageString:(int)page {
    
//    
//    [NetWorkRequestManager requestWithType:GET urlString:self.requestURLString parDic:nil finish:^(NSData *data) {
//        NSMutableDictionary *contentDic = [NSJSONSerialization JSONObjectWithData:data options: NSJSONReadingAllowFragments error:nil];
//      //  NSLog(@"++++++888888888+++++++%@",contentDic);
//        NSArray *array = contentDic[@"result"];
//        for (NSDictionary *dic in array) {
//            ShowModel *model = [[ShowModel alloc]init];
//            [model setValuesForKeysWithDictionary:dic];
//            [self.dataArray addObject:model];
//            // NSLog(@"%@",_dataArray);
//        }
//        dispatch_async(dispatch_get_main_queue(), ^{
//            [_showTabelView reloadData];
//            
//        });
//        
//        
//    } error:^(NSError *error) {
//        NSLog(@"asdfasfd");
//    }];
//    
    //获取经纬度(nsstring)
        NSUserDefaults*userDefaults=[NSUserDefaults standardUserDefaults];
     NSString*la =[userDefaults objectForKey:@"homeLa"];
       NSString*lon =[userDefaults objectForKey:@"homeLon"];
     //NSString*cityID =[userDefaults objectForKey:@"homeCityID"];
    
    
    
    //double转nsstring
//        NSString *lat = [NSString stringWithFormat:@"%f",laitude];
//        NSString *lon = [NSString stringWithFormat:@"%f",longitude];
    //self.requestURLString 种类关键字
    NSString*pageNumber=[NSString stringWithFormat:@"%d",page];
    
    if (_cityID==nil) {
        _cityID=@"53";
    }
    
    [NetWorkRequestManager requestWithType:GET urlString:[self String:KindUrlHead byAppendingdic:@{@"category":self.requestURLString, @"city_id":_cityID,@"lat":la,@"lon":lon,@"page":pageNumber,@"session_id":@"000042c8e69cff884054bb4ccd6352be417c1d"}] parDic:nil finish:^(NSData *data) {
        NSMutableDictionary *contentDic = [NSJSONSerialization JSONObjectWithData:data options: NSJSONReadingAllowFragments error:nil];
        //  NSLog(@"++++++888888888+++++++%@",contentDic);
        NSArray *array = contentDic[@"result"];
        for (NSDictionary *dic in array) {
            ShowModel *model = [[ShowModel alloc]init];
            [model setValuesForKeysWithDictionary:dic];
            [self.dataArray addObject:model];
            
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            [_showTabelView reloadData];
            
        });
        
        
    } error:^(NSError *error) {
        NSLog(@"asdfasfd");
    }];
    

    
    
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

-(NSString*)isEquestString:(NSString*)isqueString {
    // NSString utf8Str = @"sfsfdaf";
    
    
    //NSString*str=[NSString stringWithCString:[isqueString UTF8String] encoding:NSUnicodeStringEncoding];
    //NSString *str = [isqueString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    //NSString *str = [[@"\""stringByAppendingString:isqueString] stringByAppendingString:@"\""];
    
    NSUserDefaults*userDefaultes=[NSUserDefaults standardUserDefaults];
    NSDictionary *myDictionary = [userDefaultes dictionaryForKey:@"aaa"];
    NSString*cityIdnumber= myDictionary[isqueString];
    //
    //    NSLog(@"%@",myDictionary);
    //    NSLog(@"KKKKKKKKKKKKKKKKKKKKKK%@",cityIdnumber);
    
    if (myDictionary[isqueString] !=nil) {
        
        return cityIdnumber;
    }else if ([myDictionary[isqueString]  isEqual: @" "]){
        [self alreation];
        
        return nil;
        
        
    }else{
        
        [self alreation];
        return nil;
    }
    
    
    
    
    return nil;
    
}

-(void)alreation{
    
    UIAlertController*alre=[UIAlertController alertControllerWithTitle:@"提示" message:@"暂无你定位城市信息,请选择其他城市,默认为北京市" preferredStyle:(UIAlertControllerStyleAlert)];
    UIAlertAction*al=[UIAlertAction actionWithTitle:@"返回" style:(UIAlertActionStyleDefault) handler:nil];
    UIAlertAction*al1=[UIAlertAction actionWithTitle:@"确定" style:(UIAlertActionStyleDefault) handler:nil];
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
