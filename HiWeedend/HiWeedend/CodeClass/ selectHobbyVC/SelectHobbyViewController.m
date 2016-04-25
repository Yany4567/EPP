//
//  SelectHobbyViewController.m
//  HiWeedend
//
//  Created by lanou3g on 16/4/19.
//  Copyright © 2016年 高艳闯. All rights reserved.
//

#import "SelectHobbyViewController.h"

#import "SelsectHobbyCollectionViewCell.h"

@interface SelectHobbyViewController ()<UICollectionViewDataSource,UICollectionViewDelegate>

@property(nonatomic,strong)NSMutableArray*dataArray;
@property(nonatomic,strong)UICollectionView*collectView;

@end

@implementation SelectHobbyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.navigationItem.leftBarButtonItem=[[UIBarButtonItem alloc]initWithTitle:@"<" style:(UIBarButtonItemStylePlain) target:self action:@selector(leftAction:)];
     self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc]initWithTitle:@"保存" style:(UIBarButtonItemStylePlain) target:self action:@selector(collectAction:)];
    [self addView];

}
-(void)addView{

    UICollectionViewFlowLayout*layout=[[UICollectionViewFlowLayout alloc]init];

    layout.minimumLineSpacing=5;
    layout.minimumInteritemSpacing=5;
    layout.itemSize= CGSizeMake((kWidth-45)/3, (200)/3);
    layout.scrollDirection =UICollectionViewScrollDirectionVertical;
    layout.sectionInset =UIEdgeInsetsMake(10, 15, 10, 15);

    _collectView=[[UICollectionView alloc]initWithFrame:CGRectMake(0, 80, kWidth, 400) collectionViewLayout:layout];
    
  _collectView.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:_collectView];
    _collectView.dataSource = self;
    _collectView.delegate =self;
    
    [_collectView registerNib:[UINib nibWithNibName:@"SelsectHobbyCollectionViewCell"  bundle:nil] forCellWithReuseIdentifier:@"cell"];

}

//-(void)leftAction:(UIBarButtonItem*)sender{
//
//
//    [self .navigationController ];
//
//
//}
-(void)collectAction:(UIBarButtonItem*)sender{




}

#pragma mark ====================delegate=============


-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{


    return  12;
}

-(UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{

    SelsectHobbyCollectionViewCell*cell=[_collectView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];




    return  cell;

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
