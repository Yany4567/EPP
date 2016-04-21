//
//  SecondaryTableViewController.m
//  HiWeedend
//
//  Created by lanou3g on 16/4/20.
//  Copyright © 2016年 高艳闯. All rights reserved.
//

#import "SecondaryTableViewController.h"
#import "secondaryTableViewCell.h"
#import "secondaryModel.h"
@interface SecondaryTableViewController ()<UITableViewDataSource,UITableViewDelegate>

@property(nonatomic,strong)NSMutableArray *dataArray;


@end

@implementation SecondaryTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    [self.tableView registerClass:[secondaryTableViewCell class] forCellReuseIdentifier:@"Cell"];
    
    
    [self requestData];
    
}

//数组懒加载
- (NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

- (void)requestData{
    _dataArray = [NSMutableArray array];
    [NetWorkRequestManager requestWithType:GET urlString:HWFIRSTIMAGE parDic:nil finish:^(NSData *data) {
        
        NSMutableDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:(NSJSONReadingAllowFragments) error:nil];
        
        NSArray *array = dic[@"result"];
        for (NSDictionary *dict in array) {
            
            secondaryModel *model = [[secondaryModel alloc]init];
            [model setValuesForKeysWithDictionary:dict];
            [_dataArray addObject:model];
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
        });
        
    } error:^(NSError *error) {
        NSLog(@"____________%@",error);
    }];
    
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.dataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 350;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    secondaryTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    secondaryModel *model = self.dataArray[indexPath.row];
    
    [cell.front_image_QD sd_setImageWithURL:[NSURL URLWithString:[model.front_cover_image_list firstObject]]];
    
    cell.titleLab.text = model.title;
    cell.poiLab.text = model.poi;
    cell.categoryLab.text = model.category;
    cell.time_infoLab.text = model.time_info;
//    cell.want_statusLab.text = model.want_status;
    NSString *str = [NSString stringWithFormat:@"¥:%ld",(long)model.price_info];
    cell.price_infoLab.text = str;
//    cell.distanceLab.text = model.distance;
    
    
    return cell;
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
