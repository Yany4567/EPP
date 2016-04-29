

#import "ResultCityController.h"
#import "SelectCityViewController.h"
#import "SearchShowController.h"

@implementation ResultCityController
-(UITableView *)tableView
{
    if(!_tableView)
    {
        _tableView =[[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.showsVerticalScrollIndicator = NO;
        [self.view addSubview:_tableView];
    }
    return _tableView;
}
-(void)viewDidLoad
{

    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    


}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataArray .count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                       reuseIdentifier:@"Cell"] ;
    }
    
    // 一般我们就可以在这开始设置这个cell了，比如设置文字等：
    cell.textLabel.text = _dataArray[indexPath.row];
    cell.textLabel.font = [UIFont systemFontOfSize:16];
    cell.textLabel.textColor = [UIColor colorWithRed:54/255.0 green:54/255.0 blue:54/255.0 alpha:1];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
   SearchShowController*show=[[SearchShowController alloc]init];
    NSString *string = _dataArray[indexPath.row];
    if([_delegate respondsToSelector:@selector(didSelectedString:)])
    {
        [_delegate didSelectedString:string];
    }
//判断
    NSLog(@"%@",string);
    show.acceptCityName=string;
    show.acceptCityID=[self isEquestString:string];

   UINavigationController*nav=[[UINavigationController alloc]initWithRootViewController:show];
    
   [self presentViewController:nav animated:YES completion:nil];
    NSLog(@"turnnnnnnnnnnn");
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
   if([_delegate respondsToSelector:@selector(didScroll)])
   {
       [_delegate didScroll];
   }
}

-(NSString*)isEquestString:(NSString*)isqueString {

    NSUserDefaults*userDefaultes=[NSUserDefaults standardUserDefaults];
    NSDictionary *myDictionary = [userDefaultes dictionaryForKey:@"aaa"];
    NSString*cityIdnumber= myDictionary[isqueString];

    
    if (myDictionary[isqueString] !=nil) {
        
        return cityIdnumber;
    }else if ([myDictionary[isqueString]  isEqual: @" "]){
        [self alreation];
        
        return nil;
        
        
    }else{
        
        [self alreation];
        return nil;
    }
    
    
    
    
    return nil;
    
}

-(void)alreation{
    
    UIAlertController*alre=[UIAlertController alertControllerWithTitle:@"提示" message:@"暂无你所选城市信息,请选择其他城市" preferredStyle:(UIAlertControllerStyleAlert)];
    UIAlertAction*al=[UIAlertAction actionWithTitle:@"返回" style:(UIAlertActionStyleDefault) handler:nil];
    UIAlertAction*al1=[UIAlertAction actionWithTitle:@"确定" style:(UIAlertActionStyleDefault) handler:nil];
    [alre addAction:al];
    [alre addAction:al1];
    
    
    [self presentViewController:alre animated:YES completion:nil];
    
    
}

@end
