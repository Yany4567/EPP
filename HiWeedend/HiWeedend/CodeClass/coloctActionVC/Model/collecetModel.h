//
//  collecetModel.h
//  HiWeedend
//
//  Created by lanou3g on 16/4/28.
//  Copyright © 2016年 高艳闯. All rights reserved.
//

#import "BaseModel.h"
#import "HomePageListModel.h"

@interface collecetModel : BaseModel
@property(nonatomic,strong)NSString *address;
@property(nonatomic,strong)NSArray *front_cover_image_list;
@property(nonatomic,assign)NSInteger leo_id;
@property(nonatomic,strong)NSString *title;
@property(nonatomic,strong)HomePageListModel *homePageListModel;



@end
