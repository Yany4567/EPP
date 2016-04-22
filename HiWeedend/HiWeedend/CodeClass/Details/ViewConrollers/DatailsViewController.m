//
//  DatailsViewController.m
//  HiWeedend
//
//  Created by lanou3g on 16/4/21.
//  Copyright © 2016年 高艳闯. All rights reserved.
//

#import "DatailsViewController.h"
#import "DetailsModel.h"
#import "DescriptionModel.h"

#import "ContentCell.h"
#import "ImageCell.h"

#import "HaderView.h"



@interface DatailsViewController ()<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,strong)UITableView *listTable;
@property(nonatomic,strong)NSMutableArray *dataListArray;
@property(nonatomic,strong)NSMutableArray *contentArray;
@property(nonatomic,strong)NSMutableArray *imageArray;



@end

@implementation DatailsViewController
-(NSMutableArray *)dataListArray{
    if (_dataListArray == nil) {
        _dataListArray = [NSMutableArray array];
        
    }
    return _dataListArray;
    
}

-(NSMutableArray *)contentArray{
    if (_contentArray == nil) {
        _contentArray = [NSMutableArray array];
    }
    return _contentArray;
    
}

-(NSMutableArray *)imageArray{
    if (_imageArray == nil) {
        _imageArray = [NSMutableArray array];
    }
    return _imageArray;
    
}



-(void)requestData{
    [NetWorkRequestManager requestWithType:GET urlString:HWSEONDDETAILT parDic:nil finish:^(NSData *data) {
        NSDictionary *dataDic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
        DetailsModel *model = [[DetailsModel alloc]init];
        [model setValuesForKeysWithDictionary:dataDic[@"result"]];
        [self.dataListArray addObject:model];
        NSArray *array = dataDic[@"result"][@"description"];
        for (NSDictionary *dic in array) {
            DescriptionModel *model1 = [[DescriptionModel alloc]init];
            [model1 setValuesForKeysWithDictionary:dic];
            [self.contentArray addObject:model1];
        }
               dispatch_async(dispatch_get_main_queue(), ^{
            [_listTable reloadData];
            
        });
        
    } error:^(NSError *error) {
        NSLog(@"失败");
        
    }];
    
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"%@",self.HpmeModel);
    self.listTable = [[UITableView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    [self.view addSubview:self.listTable];
    
    HaderView *haView = [[[NSBundle mainBundle] loadNibNamed:@"HaderView" owner:nil options:nil] firstObject];
    //[haView awakeFromNib];
    haView.titleLabel.text = self.HpmeModel.title;
    NSLog(@"%@",self.HpmeModel.title);
   // haView.timeLabel.text = self.HpmeModel.time_desc;
    haView.categoryLabel.text = self.HpmeModel.category;
    haView.timeLabel.text = self.HpmeModel.time_desc;
    haView.priceLabel.text = [NSString stringWithFormat:@"%ld",(long)self.HpmeModel.price];
    NSLog(@"%@",self.HpmeModel.time_desc);
    haView.frame = CGRectMake(0, 0, self.view.frame.size.width, 570);
    
    //haderView.backgroundColor = [UIColor redColor];
    self.listTable.tableHeaderView = haView;
    
    self.listTable.delegate = self;
    self.listTable.dataSource = self;
    
    [self.listTable registerNib:[UINib nibWithNibName:@"ContentCell" bundle:nil] forCellReuseIdentifier:@"ContentCell"];
    [self.listTable registerNib:[UINib nibWithNibName:@"ImageCell" bundle:nil] forCellReuseIdentifier:@"ImageCell"];
    [self.listTable registerNib:[UINib nibWithNibName:@"ReservationCell" bundle:nil] forCellReuseIdentifier:@"ReservationCell"];
    [self requestData];
    
    // Do any additional setup after loading the view from its nib.
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSLog(@"%----------------lu",(unsigned long)self.contentArray.count);
    return self.contentArray.count;
    
    
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
//    DetailsModel *model = [[DetailsModel alloc]init];
//    model = self.dataListArray[indexPath.row];
    DescriptionModel *model = [[DescriptionModel alloc]init];
    model = self.contentArray[indexPath.row];
    if ([model.type isEqualToString:@"text"]) {
        ContentCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ContentCell" forIndexPath:indexPath];
        cell.contentLabel.frame = CGRectMake(8, 10, cell.contentView.frame.size.width- 16, [self stringHeight:model.content]);
        cell.contentLabel.text = model.content;
        return cell;
    }else{
        ImageCell *cell1 = [tableView dequeueReusableCellWithIdentifier:@"ImageCell" forIndexPath:indexPath];
        [cell1.contenImage sd_setImageWithURL:[NSURL URLWithString:model.content] placeholderImage:nil];
        return cell1;
    }
  
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    DescriptionModel *model = [[DescriptionModel alloc]init];
    model = self.contentArray[indexPath.row];
    if ([model.type isEqualToString:@"text"]) {
        return [self stringHeight:model.content]+30;
    }else{
        return 200;
    }
    
}


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

-(CGFloat)stringHeight:(NSString *)aString{
    // !!!: 1 传参数的时候 宽度最好和以前label 的宽度一样，字体的大小最好和label上面的字体大小一样
    
    CGRect temp = [aString boundingRectWithSize:CGSizeMake([UIScreen mainScreen].bounds.size.width, 10000) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:17]} context:nil];
    
    return temp.size.height;
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
