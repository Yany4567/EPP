//
//  SelectCityViewController.m
//  HiWeedend
//
//  Created by lanou3g on 16/4/26.
//  Copyright © 2016年 高艳闯. All rights reserved.
//
//展示页面
#import "SelectCityViewController.h"
#import "SelectTableViewCell.h"
#import <CoreLocation/CoreLocation.h>
#import "SelectCityModel.h"
#import "ShowToLocationModel.h"
#import "CityViewController.h"
#import "AppDelegate.h"
#import "HomePageListViewController.h"
#import "DrawerViewController.h"
#import "MapAndKindViewController.h"
#import "DatailsViewController.h"
#import "SecondaryTableViewController.h"

@interface SelectCityViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *selectCityShowTabelView;
//接收经度
@property(nonatomic,assign)double longitudeCity;

//接收维度
@property(nonatomic,assign)double latituCity;

@property(nonatomic,assign)int intNumber;
@property(nonatomic,assign)BOOL  DataBool;

@property(nonatomic,strong)NSMutableArray*dataArray;
@property(nonatomic,strong)NSMutableArray*locationArray;
@property(nonatomic,strong)CityViewController*city;
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
   // self.title=  [NSString stringWithFormat:@"%@", self.acceptCityID ];
    
    
    [self addView];
    [self requestData];
    
    if([self.searchID isEqualToString:@"1"]){
        
    self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc]initWithTitle:@"^" style:(UIBarButtonItemStylePlain) target:self action:@selector(BackAction:)];
////
//    }else{
//    
////     self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc]initWithTitle:@"^^" style:(UIBarButtonItemStylePlain) target:self action:@selector(BackAction1:)];
//        self.view.userInteractionEnabled=YES;
        UIView*view=[[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 64)];
        view.backgroundColor=[UIColor whiteColor];
//        view.alpha =0.5;
        [self.view addSubview:view];
        self.view.userInteractionEnabled =YES;
        
        UIButton*button=[UIButton buttonWithType:UIButtonTypeCustom];
        button.frame=CGRectMake(10, 10, 30, 30);
        button.backgroundColor=[UIColor redColor];
        [view addSubview:button];
        
        button.userInteractionEnabled=YES;
        [button addTarget:self action:@selector(buttonAction:) forControlEvents:(UIControlEventTouchUpInside)];

  }
    

    
}
-(void)buttonAction:(UIButton*)sender{
    NSLog(@"gdkwfhkjfwflrwkgfe");
    
    CityViewController*city=[[CityViewController alloc]init];
    
    [self presentViewController:city animated:YES completion:nil];
    
    //[self.view  removeFromSuperview];
    //[self.view bringSubviewToFront:_city.view];

    
//       MapAndKindViewController*city=[[MapAndKindViewController alloc]init];
//    
//    
//        [self presentViewController:city animated:YES completion:nil];

//
    DrawerViewController *menuController = (DrawerViewController*)((AppDelegate *)[[UIApplication sharedApplication] delegate]).drawerController;
    
    HomePageListViewController*homeVc=[[HomePageListViewController alloc]init];
    
    UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:homeVc];
    //
    //
    [menuController setRootController:navController animated:YES];
    
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];

}

//
//-(void)BackAction1:(UIBarButtonItem*)sender{
//    CityViewController*city=[[CityViewController alloc]init];
//    
//    [self.navigationController pushViewController:city animated:YES];
//
//
//}

-(void)BackAction:(UIBarButtonItem*)sender{
    [self.view removeFromSuperview];
    

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


-(void)requestData {
    self.intNumber=1;
    
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
    _DataBool=NO;

       [NetWorkRequestManager requestWithType:GET urlString:[self String:HWHOMEPAGE byAppendingdic:@{@"city_id":cityID,@"lat":lat,@"lon":lon,@"session_id":@"0000423d7ecd75af788f3763566472ed27f06e",@"v":@"3"}] parDic:nil finish:^(NSData *data) {
           
        NSMutableDictionary *contentDic = [NSJSONSerialization JSONObjectWithData:data options: NSJSONReadingAllowFragments error:nil];

        NSArray *array = contentDic[@"result"];
           NSString*aa=@"111";
        for (NSDictionary *dic in array) {
             SelectCityModel *model = [[SelectCityModel alloc]init];
            [model setValuesForKeysWithDictionary:dic];
            [self.dataArray addObject:model];
         aa=@"222";
        
         }
           //判断是否有数据 如果没有调弹框
           if (  ![aa isEqual:@"222"]) {
               [self alreation];
           }
           
         
        dispatch_async(dispatch_get_main_queue(), ^{
            [_selectCityShowTabelView reloadData];
            
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
    
 
    self.selectCityShowTabelView.dataSource =self;
    self.selectCityShowTabelView.delegate =self;
    
    [self.selectCityShowTabelView registerNib:[UINib nibWithNibName:@"SelectTableViewCell" bundle:nil] forCellReuseIdentifier:@"cell"];
    
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
    


    
}



-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    SelectTableViewCell*cell=[self.selectCityShowTabelView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    SelectCityModel*model=self.dataArray[indexPath.row];
    [cell.selectShoeImahe sd_setImageWithURL:[NSURL URLWithString:[model.front_cover_image_list firstObject]]];

    cell.titleLabel .text =model.title;
    cell.priceLabel.text =[NSString stringWithFormat:@"¥:%ld", model.price ];
   
    
    NSString *string =  [model.poi stringByAppendingString:@" * "];
    cell.timeLabel.text = [string stringByAppendingString:model.category];
    
    //navation title
    self.title = model.category;
    //    cell.showTime.text = model.time_desc;
//    cell.showTime.text = [self mystring:@"  " stringByAppding:model.time_desc and:@"  "];
//    NSLog(@"****%@,&&&%@",model.time_info,model.time_desc);
//    
//    NSString *string1 = [self mystring:@"  " stringByAppding:[NSString stringWithFormat:@"%ld",(long)model.collected_num] and:@"人收藏  "];

    return  cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return  350;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row==0) {
        
//        if ( [self.acceptCityName isEqual:@"北京"]||[self.acceptCityName isEqual:@"上海"]||[self.acceptCityName isEqual:@"广州"]||[self.acceptCityName isEqual:@"深圳"]||[self.acceptCityName isEqual:@"杭州"]||[self.acceptCityName isEqual:@"成都"]) {
    if ( [self.acceptCityName isEqual:@"北京"]) {
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
            SelectCityModel*model=self.dataArray[indexPath.row];
            detail.HpmeModel = (HomePageListModel*)model;
            
            // [self.navigationController pushViewController:detail animated:YES];
            [self.navigationController pushViewController:detail animated:YES];
            
        }
        
    }else{

    DatailsViewController*detail=[[DatailsViewController alloc]init];
    SelectCityModel*model=self.dataArray[indexPath.row];
    detail.HpmeModel = (HomePageListModel*)model;
    
    [self.navigationController pushViewController:detail animated:YES];

    }
   }





-(void)alreation{
    
    UIAlertController*alre=[UIAlertController alertControllerWithTitle:@"提示" message:@"暂无你所选城市信息,请选择其他城市" preferredStyle:(UIAlertControllerStyleAlert)];
   // UIAlertAction*al=[UIAlertAction actionWithTitle:@"返回" style:(UIAlertActionStyleDefault) handler:nil];
    UIAlertAction*al=[UIAlertAction actionWithTitle:@"返回" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
        [self .navigationController popToViewController:self.navigationController.viewControllers[2] animated:YES];
        
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
