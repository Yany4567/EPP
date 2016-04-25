//
//  MyAnnotation.h
//  HiWeedend
//
//  Created by lanou3g on 16/4/23.
//  Copyright © 2016年 高艳闯. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface MyAnnotation : NSObject<MKAnnotation>
// 大头针的经纬度
@property(nonatomic,assign) CLLocationCoordinate2D coordinate;
@property(nonatomic,copy) NSString *title;
@property(nonatomic,copy)NSString *subtitle;
// 大头针图标
@property(nonatomic,strong)UIImage *icon;



@end
