//
//  SettingViewController.m
//  HiWeedend
//
//  Created by lanou3g on 16/4/19.
//  Copyright © 2016年 高艳闯. All rights reserved.
//

#import "SettingViewController.h"
#import "UMSocial.h"
#import "QQLoginViewController.h"
#import "AppDelegate.h"
#import "DrawerViewController.h"
#import "HomePageListViewController.h"
@interface SettingViewController ()<UITableViewDataSource,UITableViewDelegate,UMSocialUIDelegate,UITextFieldDelegate>

@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)UIImageView *imgView;
@property(nonatomic,strong)NSMutableArray *commentArray;//评论数据源
@property(nonatomic,assign)CGFloat keyBoardHeight;
@property(nonatomic,assign)CGRect originalkey;
@property(nonatomic,assign)CGRect originalText;
@property(nonatomic,strong)ChatConsoleView *chatConsoleView;


@end

@implementation SettingViewController
@synthesize chatConsoleView;

-(void)viewWillAppear:(BOOL)animated{
    [self.tableView reloadData];
    
    
}



- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"设置";
    //设置tableview
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 400) style:(UITableViewStylePlain)];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.separatorColor = [UIColor brownColor];
    self.tableView.separatorInset = UIEdgeInsetsMake(0, 50, 0, 20);
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    self.tableView.scrollEnabled = NO;
    [self.view addSubview:self.tableView];
    self.imgView = [[UIImageView alloc]initWithFrame:CGRectMake(5, 10, 30, 30)];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if ([[UserInfoManager getUserID]isEqualToString:@" "]) {
        return 5;
    }else{
        return 6;
    }
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];

    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:(UITableViewCellStyleSubtitle) reuseIdentifier:@"Cell"];
    }
    if ([[UserInfoManager getUserID]isEqualToString:@" "]) {
        if (indexPath.row == 0) {
            cell.textLabel.text = @"分享给好友";
            
            cell.imageView.image = [UIImage imageNamed:@"2.png"];
        }
        
        if (indexPath.row == 1) {
            cell.imageView.image = [UIImage imageNamed:@"laji.png"];
            cell.textLabel.text = @"清除缓存";
            
            
        }
        
        if (indexPath.row == 2) {
            cell.textLabel.text = @"给我们一个评价";
            cell.imageView.image = [UIImage imageNamed:@"shoucang.png"];
        }
        
        if (indexPath.row == 3) {
            cell.textLabel.text = @"拨打客服电话          400-844-0900";
            cell.imageView.image = [UIImage imageNamed:@"dianhua.png"];
        }
        
        if (indexPath.row == 4) {
            cell.textLabel.text = @"用户反馈";
            cell.imageView.image = [UIImage imageNamed:@"888.png"];
        }
        return cell;

    }else{

    if (indexPath.row == 0) {
        cell.textLabel.text = @"分享给好友";
        
        cell.imageView.image = [UIImage imageNamed:@"2.png"];
    }
    
    if (indexPath.row == 1) {
        cell.imageView.image = [UIImage imageNamed:@"laji.png"];
        cell.textLabel.text = @"清除缓存";
        
       
    }
    
    if (indexPath.row == 2) {
        cell.textLabel.text = @"给我们一个评价";
        cell.imageView.image = [UIImage imageNamed:@"shoucang.png"];
    }
    
    if (indexPath.row == 3) {
        cell.textLabel.text = @"拨打客服电话          400-844-0900";
        cell.imageView.image = [UIImage imageNamed:@"dianhua.png"];
    }
    
    if (indexPath.row == 4) {
        cell.textLabel.text = @"用户反馈";
        cell.imageView.image = [UIImage imageNamed:@"888.png"];
    }
    
    if (indexPath.row == 5) {
        cell.textLabel.text = @"退出登录";
        cell.imageView.image = [UIImage imageNamed:@"9999.png"];
        
    }
        return cell;
    }
//    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
}



- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}
//拨打电话
-(void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 0) {
        NSURL * url = [NSURL URLWithString:@"tel:400-844-0900"];
        if ([[UIApplication sharedApplication] canOpenURL:url]) {
            [[UIApplication sharedApplication] openURL:url];
        } else{
//            [MyUtil showTipText:@"您的设备不支持拨打电话"];
        }
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //点击cell松开后恢复cell颜色的方法
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.row == 3) {
        //拨打电话
        UIAlertView * alertView = [[UIAlertView alloc] init];
        alertView.message = @"400-844-0900";
        alertView.delegate = self;
        [alertView addButtonWithTitle:@"呼叫"];
        [alertView addButtonWithTitle:@"取消"];
        [alertView show];
    }
    
    if (indexPath.row == 0) {
       //QQ
        [UMSocialSnsService presentSnsIconSheetView:self appKey:UMAPPK shareText:@"你想分享的文字"shareImage:[UIImage imageNamed:@"icon.png"] shareToSnsNames:[NSArray arrayWithObjects:UMShareToQQ,UMShareToQzone,UMShareToWechatSession,UMShareToWechatTimeline,UMShareToWechatFavorite,UMShareToSina,UMShareToDouban,UMShareToTencent,nil] delegate:self];
        
//        [[ShareEngine sharedInstance] sendWeChatMessage:nil url:momentUrl shareType:SHARE_ENGINE_FRIEND titleString:titleString description:nil thubnilImage:scaleImage];
        
        
    }
    
    if (indexPath.row == 1) {
        
        //清除缓存
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            
            
            NSString *cachPath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)lastObject];
            
            NSArray *files = [[NSFileManager defaultManager] subpathsAtPath:cachPath];
            NSLog(@"files :%lu",(unsigned long)[files count]);
            for (NSString *p in files) {
                NSError *error;
                NSString *path = [cachPath stringByAppendingPathComponent:p];
                if ([[NSFileManager defaultManager]fileExistsAtPath:path]) {
                    [[NSFileManager defaultManager]removeItemAtPath:path error:&error];
                }
            }
    
        });
        //设置一个弹框 title 和信息
        UIAlertController *Alert = [UIAlertController alertControllerWithTitle:@"清理清理更健康" message:nil preferredStyle:UIAlertControllerStyleAlert];
        
        //设置弹框里取消按钮
        UIAlertAction *quxiao = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
        //设置弹框里的确定按钮
        UIAlertAction *queding = [UIAlertAction actionWithTitle:@"确定" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
            
            [self performSelectorOnMainThread:@selector(clearCacheSuccess) withObject:nil waitUntilDone:YES];
            
        }];
        
        [Alert addAction:quxiao];
        [Alert addAction:queding];
        [self presentViewController:Alert animated:YES completion:nil];

    }
    //跳转到AppStore评价
    if (indexPath.row == 2) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"itms-apps://itunes.apple.com/CN/lookup?id=917930451"]];
    }
    if (indexPath.row == 4) {

    }
    
    if (indexPath.row == 5) {
        [UserInfoManager cancelUserID];
        DrawerViewController *menuController = (DrawerViewController*)((AppDelegate *)[[UIApplication sharedApplication] delegate]).drawerController;
        
        HomePageListViewController*homeVc=[[HomePageListViewController alloc]init];
        
        
        UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:homeVc];
        
        [menuController setRootController:navController animated:YES];

    }
    
    
    
    
}






//弹出列表方法presentSnsIconSheetView需要设置delegate为self
-(BOOL)isDirectShareInIconActionSheet
{
    return YES;
}

-(void)clearCacheSuccess
{
    NSLog(@"清理成功");
}


//回调方法,即返回app后左上角不显示第三方app名字
//-(void)didFinishGetUMSocialDataInViewController:(UMSocialResponseEntity *)response
//{
//    //根据`responseCode`得到发送结果,如果分享成功
//    if(response.responseCode == UMSResponseCodeSuccess)
//    {
//        
//        //得到分享到的微博平台名
//        NSLog(@"share to sns name is %@",[[response.data allKeys] objectAtIndex:0]);
//    }
//}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
