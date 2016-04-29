//
//  MapViewController.m
//  HiWeedend
//
//  Created by lanou3g on 16/4/23.
//  Copyright © 2016年 高艳闯. All rights reserved.
//

#import "MapViewController.h"
// 地图
#import <MapKit/MapKit.h>
// 大头针
#import "MyAnnotation.h"
//#import "MAGeometry.h"
//#import <MAMapKit/MAMapKit.h>
//typedef void(^delcataion)(CLLocationCoordinate2D);



// 遵循协议
@interface MapViewController ()<CLLocationManagerDelegate,MKMapViewDelegate>
// 创建管理者位置
@property(nonatomic,strong)CLLocationManager *locationManager;
// 创建的图视图
@property(nonatomic,strong)MKMapView *mapView;
// 创建编码管理者（用于反地理编码）
@property(nonatomic,strong)CLGeocoder *geo;
@property(nonatomic,strong)NSString *addre;
@property(nonatomic,assign)CLLocationCoordinate2D adderssCoord2d;
//@property(nonatomic,strong)delcataion delca;





@end

@implementation MapViewController

-(CLLocationManager *)locationManager{
    if (!_locationManager) {
        _locationManager = [[CLLocationManager alloc]init];
        _locationManager.delegate = self;
        if ([[UIDevice currentDevice].systemVersion floatValue] >= 8.0 ) {
            [_locationManager requestWhenInUseAuthorization];
        }
    }
    return _locationManager;
    
}

-(CLGeocoder *)geo{
    if (!_geo) {
        _geo = [[CLGeocoder alloc]init];
    }
    return _geo;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    _locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters;

    // 开启定位
    [self.locationManager startUpdatingLocation];
    // 初始化地图
    self.mapView = [[MKMapView alloc]initWithFrame:self.view.frame];
    // 设置地图类型
    self.mapView.mapType = MKMapTypeStandard;
    // 设置追踪模式
    self.mapView.userTrackingMode = MKUserTrackingModeFollow;
  
    // 设置代理
    self.mapView.delegate = self;
    
    CLLocationCoordinate2D coord2d = CLLocationCoordinate2DMake([self.locationDiction[@"lat"] doubleValue],[self.locationDiction[@"lon"]doubleValue]);
    self.adderssCoord2d = coord2d;
    [self addAnnotationWithCoor:coord2d];
     [self.mapView setCenterCoordinate:coord2d animated:YES];
     [self.mapView setRegion:MKCoordinateRegionMake(coord2d, MKCoordinateSpanMake(0.05, 0.05))];
    [self.view addSubview:self.mapView];


    
    
    
    
    
    
    // Do any additional setup after loading the view from its nib.
}

// Map的delegate
-(void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation{
    self.coord2d = userLocation.location.coordinate;
    
    
}

-(void)addAnnotationWithCoor:(CLLocationCoordinate2D)coor{
    MyAnnotation *an1 = [[MyAnnotation alloc]init];
    an1.coordinate = coor;
    an1.title = self.poi;
    an1.subtitle = self.address;
    // 添加大头针
    [self.mapView addAnnotation:an1];
    [self.mapView selectAnnotation:an1 animated:YES];
        }


-(MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation{
    if (![annotation isKindOfClass:[MyAnnotation class]]) {
        return nil;
    }
    static NSString *identifier = @"identi";
    MKAnnotationView *AnnoView = (MKAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:@"identi"];
    if (!AnnoView) {
        AnnoView = (MKPinAnnotationView *)[[MKPinAnnotationView alloc]initWithAnnotation:annotation reuseIdentifier:identifier];
    }

    AnnoView.annotation = annotation;
    // 如果是系统大头针样式 设置无效
    AnnoView.image = [UIImage imageNamed:@"nav_menu_icon@2x"] ;
    // 设置右边为按钮
    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [rightBtn setFrame:CGRectMake(0, 0, 60, 50)];
    [rightBtn setTitle:@"导航" forState:(UIControlStateNormal)];
    // 赊着右视图为按钮
    AnnoView.rightCalloutAccessoryView = rightBtn;
    [rightBtn addTarget:self action:@selector(rightBtn:) forControlEvents:UIControlEventTouchUpInside];
    rightBtn.backgroundColor = [UIColor blackColor];
    rightBtn.tag = 100010;
    // 设置气泡显示
    AnnoView.canShowCallout = YES;
    return AnnoView;

    
}

-(void)rightBtn:(id)sender{
    NSLog(@"%f",self.coord2d.latitude);
    NSLog(@"%f",self.coord2d.longitude);
    

    UIAlertController *alertcontroller = [UIAlertController alertControllerWithTitle:@"导航" message:@"使用苹果自带导航" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancleAction = [UIAlertAction actionWithTitle:@"取消" style:(UIAlertActionStyleCancel) handler:nil];
    UIAlertAction *OkAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        if (self.coord2d.latitude == 0|| self.coord2d.longitude == 0) {
            return;
        }
        [self roadPlan];
    }];
    [alertcontroller addAction:cancleAction];
    [alertcontroller addAction:OkAction];
    [self.navigationController presentViewController:alertcontroller animated:YES completion:nil];
    
    
      
        
}

-(void)degeoCoordinate:(CLLocationCoordinate2D)cood{
    //CLLocationCoordinate2D 坐标点
    // 使用坐标点生成位置对象
    CLLocation *location = [[CLLocation alloc]initWithLatitude:cood.latitude longitude:cood.longitude];
    // 反地理编码方法
    [self.geo reverseGeocodeLocation:location completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        if (error) {
            NSLog(@"反地理编码错误 %@",error);
            return ;
        }
        // 没有错误取出信息
        CLPlacemark *placemark = [placemarks firstObject];
        
        // 使用枚举方法得到信息
        [placemark.addressDictionary enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
            if (stop) {
                if ([obj isKindOfClass:[NSArray class]]) {
                    NSArray *objArr = obj;
                    NSLog(@"key = %@ obj = %@",key,objArr.firstObject);
                }else{
                    NSLog(@"key = %@ obj = %@",key,obj);
                }
            }
        }];
        NSLog(@"纬度 = %f 经度 = %f",placemark.location.coordinate.latitude,placemark.location.coordinate.longitude);
        [self roadPlan];
        
    }];
    

    
    
    
    
}
-(void)roadPlan{
    // 利用地理编码获取位置
               // 目标位置
                    // 调用系统导航需要的起始目标位置的对象类型
            // 利用placemark得到placeItem
            MKMapItem *item1 = [MKMapItem mapItemForCurrentLocation];
           // MKMapItem *item1 = [[MKMapItem alloc]initWithPlacemark:[[MKPlacemark alloc]initWithPlacemark:placemark1]];
            MKPlacemark *place = [[MKPlacemark alloc]initWithCoordinate:self.adderssCoord2d addressDictionary:nil];
            MKMapItem *item2 = [[MKMapItem alloc]initWithPlacemark:[[MKPlacemark alloc]initWithPlacemark:place]];
            item2.name = self.poi;

            // MKLaunchOptionsMapTypeKey设置的获取地图类型 常规地图
            //MKLaunchOptionsDirectionsModeKey 设置当前选择的模式,驾车
            NSDictionary *dic = @{MKLaunchOptionsMapTypeKey:@(MKMapTypeStandard),MKLaunchOptionsDirectionsModeKey:MKLaunchOptionsDirectionsModeDriving
                                  };
            // 利用系统自带导航
            // 设置初始重点位置
            // 传入调用导航的设置参数
            [MKMapItem openMapsWithItems:@[item1,item2] launchOptions:dic];
            // 获取路线的具体信息
            [self getRouteWithM1:item1 andM2:item2];
    
}




-(void)getRouteWithM1:(MKMapItem *)beginItem andM2:(MKMapItem *)endItem{
    // 获取路线的请求对象
    MKDirectionsRequest *request = [[MKDirectionsRequest alloc]init];
    // 起点
    request.source = beginItem;
    // 终点
    request.destination = endItem;
    // 执行请求的对象 绑定请求对象
    MKDirections *directions = [[MKDirections alloc]initWithRequest:request];
    // 计算路线信息
    [directions calculateDirectionsWithCompletionHandler:^(MKDirectionsResponse * _Nullable response, NSError * _Nullable error) {
        // 获取到反馈对象 MKDirectionsResponse
        // rootes 线路数组
        
        
        //MKRoute
        
        [response.routes enumerateObjectsUsingBlock:^(MKRoute * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            NSLog(@"名字：%@ 时间：%lf  距离：%f",obj.name,obj.expectedTravelTime,obj.distance);
            
            [obj.steps enumerateObjectsUsingBlock:^(MKRouteStep * _Nonnull  obj, NSUInteger idx, BOOL * _Nonnull stop) {
                NSLog(@"路线的指令：%@",obj.instructions);
            }];
            
        }];
    }];
    
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
