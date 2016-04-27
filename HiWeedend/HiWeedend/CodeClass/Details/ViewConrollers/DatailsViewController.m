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
#import "FooterView.h"
#import "MapViewController.h"
#import "CycleScrollView.h"


#import "UMSocial.h"


@interface DatailsViewController ()<UITableViewDataSource,UITableViewDelegate,UMSocialUIDelegate>
@property(nonatomic,strong)UITableView *listTable;
@property(nonatomic,strong)NSMutableArray *dataListArray;
@property(nonatomic,strong)NSMutableArray *contentArray;
@property(nonatomic,strong)NSMutableArray *imageArray;
@property(nonatomic,strong)NSDictionary *diction;
// 创建scroolview
@property(nonatomic,strong)CycleScrollView *cyScroll;



@end

@implementation DatailsViewController

-(NSDictionary *)diction{
    if (_diction == nil) {
        _diction = [NSDictionary dictionary];
    }
    return _diction;
}

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
     [SVProgressHUD showWithStatus:@"正在努力加载...."];
  //  leo_id=1355295201&session_id=0000423d7ecd75af788f3763566472ed27f06e&v=4"
    [NetWorkRequestManager requestWithType:GET urlString:[self String:HWSEONDDETAILT byAppendingdic:@{@"leo_id":[NSString stringWithFormat:@"%ld",(long)self.HpmeModel.leo_id],@"session_id":@"0000423d7ecd75af788f3763566472ed27f06e",@"v":@"4"}] parDic:nil finish:^(NSData *data) {
        NSDictionary *dataDic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
        DetailsModel *model = [[DetailsModel alloc]init];
        [model setValuesForKeysWithDictionary:dataDic[@"result"]];
        [self.dataListArray addObject:model];
        self.diction = dataDic[@"result"][@"location"];
        NSArray *array = dataDic[@"result"][@"description"];
        for (NSDictionary *dic in array) {
            DescriptionModel *model1 = [[DescriptionModel alloc]init];
            [model1 setValuesForKeysWithDictionary:dic];
            [self.contentArray addObject:model1];
        }
               dispatch_async(dispatch_get_main_queue(), ^{
            [_listTable reloadData];
          
                   
        });
        [SVProgressHUD dismiss];
    } error:^(NSError *error) {
        NSLog(@"失败");
        
    }];
    
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"%@",self.HpmeModel);
    self.listTable = [[UITableView alloc]initWithFrame:CGRectMake(0, -64, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height+64)];
    [self.view addSubview:self.listTable];
    // 添加头视图
    HaderView *haView = [[[NSBundle mainBundle] loadNibNamed:@"HaderView" owner:nil options:nil] firstObject];
    // 添加底视图
    FooterView *footerView = [[[NSBundle mainBundle]loadNibNamed:@"FooterView" owner:nil options:nil]firstObject];
    [self creatcreatCycleScrollView];
    // 添加轮播图
    self.cyScroll = [[CycleScrollView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 300) animationDuration:2];
    self.imageArray = self.HpmeModel.front_cover_image_list.mutableCopy;
    NSMutableArray *viewsArray = [NSMutableArray array];
    for (int i = 0; i < self.imageArray.count; i++) {
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:self.cyScroll.frame];
        [imageView sd_setImageWithURL:self.imageArray[i] placeholderImage:nil];
        [viewsArray addObject:imageView];
    }
    
    [haView addSubview:self.cyScroll];
    self.cyScroll.totalPagesCount = viewsArray.count;
    
    self.cyScroll.fetchContentViewAtIndex = ^UIView*(NSInteger pageindex){
        return viewsArray[pageindex];
    };

    
    footerView.frame = CGRectMake(0, 0, self.view.frame.size.width, 120);
    self.listTable.tableFooterView = footerView;
    //[haView awakeFromNib];
    haView.titleLabel.text = self.HpmeModel.title;
    NSLog(@"%@",self.HpmeModel.title);
   // haView.timeLabel.text = self.HpmeModel.time_desc;
    haView.categoryLabel.text = self.HpmeModel.category;
    haView.timeLabel.text = self.HpmeModel.time_desc;
    haView.mapLabel.text = [self mystring:self.HpmeModel.address stringByAppding:@" · " and:self.HpmeModel.poi];
    [haView.mapButton addTarget:self action:@selector(mapAction:)  forControlEvents:UIControlEventTouchUpInside];
    haView.priceLabel.text = self.HpmeModel.price_info;
    NSLog(@"%@",self.HpmeModel.time_desc);
    haView.frame = CGRectMake(0, 0, self.view.frame.size.width, 570);
    
    [footerView.shearButton addTarget:self action:@selector(shareFriendAction:) forControlEvents:(UIControlEventTouchUpInside)];
    //haderView.backgroundColor = [UIColor redColor];
    self.listTable.tableHeaderView = haView;
    self.listTable.backgroundColor = [UIColor grayColor];
    
    
    self.listTable.delegate = self;
    self.listTable.dataSource = self;
    
    [self.listTable registerNib:[UINib nibWithNibName:@"ContentCell" bundle:nil] forCellReuseIdentifier:@"ContentCell"];
    [self.listTable registerNib:[UINib nibWithNibName:@"ImageCell" bundle:nil] forCellReuseIdentifier:@"ImageCell"];
    [self.listTable registerNib:[UINib nibWithNibName:@"ReservationCell" bundle:nil] forCellReuseIdentifier:@"ReservationCell"];
    [self requestData];
    
    
    // Do any additional setup after loading the view from its nib.
}
//分享button
- (void)shareFriendAction:(UIButton *)sender{
    [UMSocialSnsService presentSnsIconSheetView:self appKey:UMAPPK shareText:@"你要分享的文字"shareImage:[UIImage imageNamed:@"icon.png"] shareToSnsNames:[NSArray arrayWithObjects:UMShareToQQ,UMShareToQzone,UMShareToWechatSession,UMShareToWechatTimeline,UMShareToWechatFavorite,UMShareToSina,UMShareToDouban,UMShareToTencent,nil] delegate:self];
    
    
}
-(void)creatcreatCycleScrollView{
    self.cyScroll = [[CycleScrollView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 300) animationDuration:2];
    self.imageArray = self.HpmeModel.front_cover_image_list.mutableCopy;
    NSMutableArray *viewsArray = [NSMutableArray array];
    for (int i = 0; i < self.imageArray.count; i++) {
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:self.cyScroll.frame];
        [imageView sd_setImageWithURL:self.imageArray[i] placeholderImage:nil];
        [viewsArray addObject:imageView];
    }
    
    HaderView *haView = [[[NSBundle mainBundle]loadNibNamed:@"HaderView" owner:nil options:nil]firstObject];
    [haView addSubview:self.cyScroll];
    self.cyScroll.totalPagesCount = viewsArray.count;
    
    self.cyScroll.fetchContentViewAtIndex = ^UIView*(NSInteger pageindex){
        return viewsArray[pageindex];
    };
    
    }


-(void)mapAction:(id)sender{
    DetailsModel *model = [[DetailsModel alloc]init];
    model = [self.dataListArray firstObject];
    if ([self.dataListArray firstObject] == nil) {
        return;
    }
    MapViewController *mapVC = [[MapViewController alloc]init];
    mapVC.locationDiction = self.diction;
    mapVC.address = self.HpmeModel.address;
    mapVC.poi = self.HpmeModel.poi;
    [mapVC.navigationItem setTitle:self.HpmeModel.title];
    [self.navigationController pushViewController:mapVC animated:YES];
    
    
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
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }else{
        ImageCell *cell1 = [tableView dequeueReusableCellWithIdentifier:@"ImageCell" forIndexPath:indexPath];
        [cell1.contenImage sd_setImageWithURL:[NSURL URLWithString:model.content] placeholderImage:nil];
        cell1.selectionStyle = UITableViewCellSelectionStyleNone;
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

-(NSString *)mystring:(NSString *)myString stringByAppding:(NSString *)modelStr and:(NSString *)andString{
    NSString *string = [myString stringByAppendingString:modelStr];
    NSString *str = [string stringByAppendingString:andString];
    return str;
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
