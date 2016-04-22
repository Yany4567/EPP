//
//  GroupListModel.h
//  HiWeedend
//
//  Created by lanou3g on 16/4/16.
//  Copyright © 2016年 高艳闯. All rights reserved.
//

#import "BaseModel.h"

@interface GroupListModel : BaseModel
@property(nonatomic,strong)NSString *front_cover_image_list;
@property(nonatomic,strong)NSString *item_type;
@property(nonatomic,strong)NSString *jump_data;
@property(nonatomic,strong)NSString *jump_type;
@property(nonatomic,strong)NSString *title;
@end
