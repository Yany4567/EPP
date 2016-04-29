//
//  MapAndKindViewController.m
//  HiWeedend
//
//  Created by lanou3g on 16/4/19.
//  Copyright © 2016年 高艳闯. All rights reserved.
//

#import "MapAndKindViewController.h"
#import "CityViewController.h" //plist 获取城市名
#import <CoreLocation/CoreLocation.h> //定位框架
#import "HobbyCollectionViewCell.h" //items
#import "ShowKindViewController.h"  //itms跳转页面
#import "HomePageListViewController.h"
#import "ResultCityController.h"
#import "CityViewController.h"



@interface MapAndKindViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,UISearchBarDelegate,CLLocationManagerDelegate>



@property(nonatomic,strong)NSString*cityNameString;

@property(nonatomic,strong)NSString*buttonString;
@property(nonatomic,strong)CLGeocoder *geocoder;

//接收经度
@property(nonatomic,assign)double longitudeCity;

//接收维度
@property(nonatomic,assign)double latituCity;

@property(nonatomic,strong)NSMutableArray*dataArray;
@property(nonatomic,strong)NSMutableArray*cityArray;
@property(nonatomic,strong)UICollectionView*collectView;
@property(nonatomic,strong)NSMutableArray*collectAllay;

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



@implementation MapAndKindViewController

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
    self.title = @"兴趣爱好";
    
//    self.navigationItem.leftBarButtonItem=[[UIBarButtonItem alloc]initWithTitle:@"<" style:(UIBarButtonItemStylePlain) target:self action:@selector(rightBarbuttonAction:)];
    
    
    
    [self addView];
    self.cityLabel.hidden=YES;
    
    self.collectAllay=[NSMutableArray array];
    [_collectAllay addObject:@"全部类目"];
    [_collectAllay addObject:@"户外活动"];
    [_collectAllay addObject:@"剧场演出"];
    [_collectAllay addObject:@"DIY手作"];
    [_collectAllay addObject:@"派对聚会"];
    [_collectAllay addObject:@"运动健身"];
    [_collectAllay addObject:@"文艺生活"];
    [_collectAllay addObject:@"沙龙学院"];
    [_collectAllay addObject:@"茶会雅集"];
    
    
    [self degeoCoordinate];//根据经纬度获取地址
    NSUserDefaults*user=[NSUserDefaults standardUserDefaults];
    _cityName= [user objectForKey:@"cityName"];
    NSLog(@"----------------------------------%@",_cityName);
    _cityID=  [self isEquestString:_cityName];
    NSLog(@"----------------------------------%@",_cityID);

    
}

-(void)addView{
    
    self.mapAndsearch.placeholder=@"👈点击搜索地点,点击👇搜索活动";
    self.mapAndsearch.delegate =self;
   // self.mapAndsearch.hidden=YES;
  //  self.mapLabel.text= @"🔍点击搜索活动或者地点";
    self.mapLabel.hidden =YES;
   
    UICollectionViewFlowLayout*layout=[[UICollectionViewFlowLayout alloc]init];
    layout.minimumLineSpacing=5;
    layout.minimumInteritemSpacing=5;
    layout.itemSize= CGSizeMake((kWidth-45)/3, (200)/3);
    layout.scrollDirection =UICollectionViewScrollDirectionVertical;
   layout.sectionInset =UIEdgeInsetsMake(10, 10, 10, 10);
    
    self.collectView=[[UICollectionView alloc]initWithFrame:CGRectMake(0, 180, kWidth, 230) collectionViewLayout:layout];
    self.collectView.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:self.collectView];
    _collectView.dataSource=self;
    _collectView.delegate =self;

    [_collectView registerNib:[UINib nibWithNibName:@"HobbyCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"cell"];


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



-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{

    UIAlertController*alert=[UIAlertController alertControllerWithTitle:@"提示" message:@"点击左边搜索地点,点击下面搜索活动" preferredStyle:(UIAlertControllerStyleAlert)];
    UIAlertAction*al=[UIAlertAction actionWithTitle:@"返回 " style:(UIAlertActionStyleDefault) handler:nil ];
    [alert addAction:al];
    [self presentViewController:alert animated:YES completion:nil];
    
//    CityViewController*re=[[CityViewController alloc]init];
//    [self presentViewController:re animated:YES completion:nil];
 
}


//根据地名获取经纬度
-(void)getlOcation:(NSString*)string{

         //  NSMutableArray*array=[NSMutableArray array];

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
//            NSString*str1=[NSString stringWithFormat:@"%f",firstPlacemark.location.coordinate.longitude];
//               NSString*str2=[NSString stringWithFormat:@"%f",firstPlacemark.location.coordinate.latitude];
//        
//            dispatch_async(dispatch_get_main_queue(), ^{
                
//                [array addObject:str1];
//                [array addObject:str2];
////            });
            

//
                 NSLog(@"******************%f",self.longitudeCity);
            
        }
        else if ([placemarks count] == 0 && error == nil) {
            NSLog(@"Found no placemarks.");
        } else if (error != nil) {
            NSLog(@"An error occurred = %@", error);
        }
    }];
    

    

   // return array;
    
}
-(void)getAddress{

    //根据经纬度获取地名
//    CLGeocoder *clGeoCoder = [[CLGeocoder alloc] init];
//       CLLocationCoordinate2D coor2d = CLLocationCoordinate2DMake(39.0, 116.1);
//    
//    [clGeoCoder reverseGeocodeLocation:  completionHandler: ^(NSArray *placemarks,NSError *error) {
//        for (CLPlacemark *placeMark in placemarks)
//        {
//            NSDictionary *addressDic=placeMark.addressDictionary;
//            
//            NSString *state=[addressDic objectForKey:@"State"];
//            NSString *city=[addressDic objectForKey:@"City"];
//            NSString *subLocality=[addressDic objectForKey:@"SubLocality"];
//            NSString *street=[addressDic objectForKey:@"Street"];
//            
//            [self stopLocation];
//            [_chooseCityBtn setTitle:city forState:UIControlStateNormal];
//            [_activityIndicator stopAnimating];
//        }
//        
//    }];



}


- (IBAction)cityButton:(id)sender {
    
    NSLog(@"2222222");
    

    
    CityViewController *controller = [[CityViewController alloc] init];
    
   controller.currentCityString = @"北京";
    controller.selectString = ^(NSString *string){
        self.cityLabel.text = string;
        self.cityNameString = string;
        
        if (_cityID==nil) {
             [self.cityButton setTitle:self.cityName forState:(UIControlStateNormal)];
            
        }else{
        [self.cityButton setTitle:self.cityLabel.text forState:(UIControlStateNormal)];
        
        }
           [self getlOcation:self.cityNameString];

        
    };
    
  //  UINavigationController*naV=[[UINavigationController alloc]initWithRootViewController:controller];
    
    
    [self.navigationController pushViewController:controller animated:YES];
    
//    self.longitudeCity = [_dataArray[0] doubleValue];
//       NSLog(@"******************%f",self.longitudeCity);

    
    
}

-(void)rightBarbuttonAction:(UIBarButtonItem*)sender{

 //  [self dismissViewControllerAnimated:YES completion:nil];


}

#pragma mark ===============代理方法=============

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{

    return _collectAllay.count;
}

-(UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{

    HobbyCollectionViewCell*cell=[_collectView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];

    cell.kindLabel.text =_collectAllay[indexPath.row];


    
    if (indexPath.row ==0) {
        cell.kindImage .image=[UIImage imageNamed:@"all6.png"];
    }else if(indexPath.row ==1){
        
 cell.kindImage .image=[UIImage imageNamed:@"outdoor.png"];
        
        
    }else if(indexPath.row ==2){
        
 cell.kindImage .image=[UIImage imageNamed:@"music8.png"];
        
    }else if(indexPath.row ==3){
        
 cell.kindImage .image=[UIImage imageNamed:@"DIY66.png"];
        
    }else if(indexPath.row ==4){
        
        cell.kindImage .image=[UIImage imageNamed:@"party1.png"];;
        
    }else if(indexPath.row ==5){
        
 cell.kindImage .image=[UIImage imageNamed:@"Ball6.png"];
        
    }else if(indexPath.row ==6){
        
 cell.kindImage .image=[UIImage imageNamed:@"wenyi6.png"];
        
    }else if(indexPath.row ==7){
        
     cell.kindImage .image=[UIImage imageNamed:@"salong.png"];
        
    }else if(indexPath.row ==8){
        
 cell.kindImage .image=[UIImage imageNamed:@"tea.png"];
        
    }


    return  cell;


}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    //此处需要传相应的参数 到首页获得分类数据
    //
    if (indexPath.row ==0) {
        
        HomePageListViewController*home=[[HomePageListViewController alloc]init];
        
        [self.navigationController pushViewController:home animated:YES];
    }else if(indexPath.row ==1){
        
        [self turnPage:Outdoors];
        
        
    }else if(indexPath.row ==2){
        
        [self turnPage:Theatre];
        
    }else if(indexPath.row ==3){
        
        [self turnPage:DIY];
        
    }else if(indexPath.row ==4){
        
        [self turnPage:Meeting];
        
    }else if(indexPath.row ==5){
        
        [self turnPage: Health];
        
    }else if(indexPath.row ==6){
        
        [self turnPage: Literature];
        
    }else if(indexPath.row ==7){
        
        [self turnPage:School];
        
    }else if(indexPath.row ==8){
        
        [self turnPage:Tea];
        
    }
    
    NSLog(@"666");

}

-(void)turnPage:(NSString*)string {
    
    ShowKindViewController*show=[[ShowKindViewController alloc]init];
  //UINavigationController*naV=[[UINavigationController alloc]initWithRootViewController:show];
    show.requestURLString = string;
//    show.cutterString= 
    
   [self.navigationController pushViewController:show  animated:YES];
  //[self presentViewController:naV animated:YES completion:nil];
    
    
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
        NSString*message=[NSString stringWithFormat:@"你当前的城市是:%@暂无你所选城市信息,请选择其他城市", _cityName];
    
    UIAlertController*alre=[UIAlertController alertControllerWithTitle:@"提示" message:message preferredStyle:(UIAlertControllerStyleAlert)];
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
