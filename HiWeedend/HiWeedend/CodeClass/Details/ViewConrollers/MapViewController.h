//
//  MapViewController.h
//  HiWeedend
//
//  Created by lanou3g on 16/4/23.
//  Copyright © 2016年 高艳闯. All rights reserved.
//

#import "BaseViewController.h"
#import <CoreLocation/CoreLocation.h>


@interface MapViewController : BaseViewController
@property(nonatomic,strong)NSDictionary *locationDiction;
@property(nonatomic,strong)NSString *address;
@property(nonatomic,strong)NSString *poi;
@property(nonatomic)CLLocationCoordinate2D coord2d;
@end
