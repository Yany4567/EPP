//
//  SearchShowTableViewCell.m
//  HiWeedend
//
//  Created by lanou3g on 16/4/28.
//  Copyright © 2016年 高艳闯. All rights reserved.
//

#import "SearchShowTableViewCell.h"
#import "SearchShowModel.h"

@implementation SearchShowTableViewCell


-(void)setData:(SearchShowModel*)model{
    [self.showImage sd_setImageWithURL:[NSURL URLWithString:[model.front_cover_image_list firstObject]]];
    //
    self.title .text =model.title;
    self.price.text =[NSString stringWithFormat:@"¥:%ld", model.price ];
    
    
    NSString *string =  [model.poi stringByAppendingString:@" * "];
    self.time.text = [string stringByAppendingString:model.category];
//

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

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
