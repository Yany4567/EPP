//
//  SelectCityViewController.m
//  HiWeedend
//
//  Created by lanou3g on 16/4/26.
//  Copyright © 2016年 高艳闯. All rights reserved.
//

#import "SelectCityViewController.h"
#import "SelectTableViewCell.h"
#import <CoreLocation/CoreLocation.h>
#import "SelectCityModel.h"
#import "ShowToLocationModel.h"
#import "CityViewController.h"

@interface SelectCityViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *selectCityShowTabelView;
//接收经度
@property(nonatomic,assign)double longitudeCity;

//接收维度
@property(nonatomic,assign)double latituCity;

@property(nonatomic,strong)NSMutableArray*dataArray;
@property(nonatomic,strong)NSMutableArray*locationArray;
@end

@implementation SelectCityViewController
-(NSMutableArray *)dataArray{

    if (!_dataArray) {
        _dataArray=[NSMutableArray array ];
    }
    return _dataArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title =self.acceptCityName;
    
    [self addView];
    [self requestData];
    
    
    //self.navigationItem.leftBarButtonItem=[[UIBarButtonItem alloc]initWithTitle:@"<" style:(UIBarButtonItemStylePlain) target:self action:@selector(BackAction:)];
    
    
}

//-(void)BackAction:(UIBarButtonItem*)sender{
////    CityViewController*city=[[CityViewController alloc]init];
////
////    [self.navigationController pushViewController:city  animated:YES];
//    //[self.navigationController popToRootViewControllerAnimated:YES];
//    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
//}

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
//// 解析位置数据
//-(void)requestLocation{
//
//    
//    //获取经纬度(nsstring)
//    NSUserDefaults*userDefaults=[NSUserDefaults standardUserDefaults];
//    double laitude =[userDefaults doubleForKey:@"let"];
//    double longitude =[userDefaults doubleForKey:@"lon"];
//    //double转nsstring
//    NSString *lat = [NSString stringWithFormat:@"%f",laitude];
//    NSString *lon = [NSString stringWithFormat:@"%f",longitude];
//
//    
//    AFHTTPSessionManager *session = [AFHTTPSessionManager manager];
//    session.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"application/x-json",@"text/html", nil];
//    [session GET:[self String:HWPOSITIONING byAppendingdic:@{@"lat":lat,@"lon":lon,@"session_id":@"0000423d7ecd75af788f3763566472ed27f06e"}] parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//        NSLog(@"_________---------%@",responseObject);
//        ShowToLocationModel *model = [[ShowToLocationModel alloc]init];
//        [model setValuesForKeysWithDictionary:responseObject[@"result"]];
//        [self.locationArray addObject:model];
//        NSLog(@"-------------%@",self.locationArray);
//        //调用数据
//        [self requestData];
//        
//    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//        NSLog(@"失败");
//    }];
//}


-(void)requestData {
    
    
    ShowToLocationModel *model1 = [self.locationArray lastObject];
    NSString *city = [NSString stringWithFormat:@"%ld",(long)model1.cityId];
    
    //获取经纬度(nsstring)
    NSUserDefaults*userDefaults=[NSUserDefaults standardUserDefaults];
    double laitude =[userDefaults doubleForKey:@"let"];
    double longitude =[userDefaults doubleForKey:@"lon"];
    //double转nsstring
    NSString *lat = [NSString stringWithFormat:@"%f",laitude];
    NSString *lon = [NSString stringWithFormat:@"%f",longitude];
    NSLog(@"%f88888888888",laitude);
    
    //self.requestURLString 种类关键字
   // NSString*pageNumber=[NSString stringWithFormat:@"%d",page];
    NSLog(@"lllllllllllllllllll%@",lon);
    
       [NetWorkRequestManager requestWithType:GET urlString:[self String:HWHOMEPAGE byAppendingdic:@{@"city_id":@"53",@"lat":lat,@"lon":lon,@"session_id":@"0000423d7ecd75af788f3763566472ed27f06e",@"v":@"3"}] parDic:nil finish:^(NSData *data) {
           
        NSMutableDictionary *contentDic = [NSJSONSerialization JSONObjectWithData:data options: NSJSONReadingAllowFragments error:nil];
        //  NSLog(@"++++++888888888+++++++%@",contentDic);
        NSArray *array = contentDic[@"result"];
        for (NSDictionary *dic in array) {
             SelectCityModel *model = [[SelectCityModel alloc]init];
            [model setValuesForKeysWithDictionary:dic];
            [self.dataArray addObject:model];
            
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            [_selectCityShowTabelView reloadData];
            
        });
        
        
    } error:^(NSError *error) {
        NSLog(@"asdfasfd");
    }];
    
    
    
    
}

//-(void)requestDataAndPageString:(int)page {
//
//    //self.requestURLString 种类关键字
//    NSString*pageNumber=[NSString stringWithFormat:@"%d",page];
//
//    [NetWorkRequestManager requestWithType:GET urlString:[self String:KindUrlHead byAppendingdic:@{@"category":self.requestURLString, @"city_id":@"53",@"lat":@"40.02932",@"lon":@"116.3376",@"page":pageNumber,@"session_id":@"000042c8e69cff884054bb4ccd6352be417c1d"}] parDic:nil finish:^(NSData *data) {
//        NSMutableDictionary *contentDic = [NSJSONSerialization JSONObjectWithData:data options: NSJSONReadingAllowFragments error:nil];
//        //  NSLog(@"++++++888888888+++++++%@",contentDic);
//        NSArray *array = contentDic[@"result"];
//        for (NSDictionary *dic in array) {
//            ShowModel *model = [[ShowModel alloc]init];
//            [model setValuesForKeysWithDictionary:dic];
//            [self.dataArray addObject:model];
//
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
//
//
//
//}
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
    
 
    self.selectCityShowTabelView.dataSource =self;
    self.selectCityShowTabelView.delegate =self;
    
    [self.selectCityShowTabelView registerNib:[UINib nibWithNibName:@"SelectTableViewCell" bundle:nil] forCellReuseIdentifier:@"cell"];
    
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
    NSLog(@"count === %ld",self.dataArray.count);
}



-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    SelectTableViewCell*cell=[self.selectCityShowTabelView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    SelectCityModel*model=self.dataArray[indexPath.row];
    [cell.selectShoeImahe sd_setImageWithURL:[NSURL URLWithString:[model.front_cover_image_list firstObject]]];


    return  cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return  350;
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
