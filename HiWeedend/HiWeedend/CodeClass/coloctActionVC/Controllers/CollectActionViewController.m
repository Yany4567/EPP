//
//  CollectActionViewController.m
//  HiWeedend
//
//  Created by lanou3g on 16/4/19.
//  Copyright © 2016年 高艳闯. All rights reserved.
//

#import "CollectActionViewController.h"
#import "collecetModel.h"
#import "DetailModelDB.h"
#import "CollectTableViewCell.h"




@interface CollectActionViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *collectAction;
@property(nonatomic,strong)NSArray *array;

@end



@implementation CollectActionViewController

-(NSArray *)array{
    if (_array == nil) {
        _array = [NSArray array];
    }
    return _array;
}

-(void)viewWillAppear:(BOOL)animated{
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    DetailModelDB *db = [[DetailModelDB alloc]init];
    self.array = [db selectModelWithRserId:[UserInfoManager getUserIcon]];
   // [self.collectAction reloadData];
    NSLog(@"%@",self.array);
    

    self.collectAction.delegate = self;
    self.collectAction.dataSource = self;

    [self.collectAction registerNib:[UINib nibWithNibName:@"CollectTableViewCell" bundle:nil] forCellReuseIdentifier:@"CollectTableViewCell"];
    
    [self.navigationItem setTitle:@"收藏"];
   }

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.array.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    collecetModel *model = self.array[indexPath.row];
    CollectTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CollectTableViewCell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    NSLog(@"%@",model);
    [cell.images sd_setImageWithURL:[NSURL URLWithString:[model.front_cover_image_list firstObject]]];
    NSLog(@"-----+++++++++++++++%@",model.front_cover_image_list);
    cell.titleLabel.text = model.title;
    cell.adessLabel.text = model.address;
    NSLog(@"====================%@",model.address);
    return cell;
}



-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 120;
    
}


-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    return YES;
}

-(NSArray<UITableViewRowAction *> *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewRowAction *action = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDefault title:@"删除" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
        collecetModel *model = self.array[indexPath.row];
        [(NSMutableArray *)self.array removeObjectAtIndex:indexPath.row];
        DetailModelDB *db = [[DetailModelDB alloc]init];
        [db deleteModelWithTitle:model.title];
//        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationLeft];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationTop];
        [self.collectAction reloadData];

    }];
    
    return @[action];
    
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
