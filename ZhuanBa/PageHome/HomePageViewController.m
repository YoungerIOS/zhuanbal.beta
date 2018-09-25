//
//  HomePageViewController.m
//  ZhuanBa
//
//  Created by developer on 2018/8/22.
//  Copyright © 2018年 developer. All rights reserved.
//

#import "HomePageViewController.h"
#import "fabuTaskViewController.h"
#import "homeTaskCell.h"
#import "fabuTaskView.h"
#import "taskDetailView.h"

@interface HomePageViewController () <UITableViewDelegate,UITableViewDataSource>
@property (nonnull,strong) UILabel * day_countSaleLabel;
@property (nonnull,strong) UILabel * day_totalSaleLabel;
@property (nonnull,strong) UILabel * month_countSaleLabel;
@property (nonnull,strong) UILabel * month_totalSaleLabel;
@property (nonnull,strong) UILabel * day_countLabel;
@property (nonnull,strong) UILabel * day_totalLabel;
@property (nonnull,strong) UILabel * month_countLabel;
@property (nonnull,strong) UILabel * month_totalLabel;
@property (nonnull,strong) UITableView * orderTableView;
@property (nonnull,strong) NSArray * datas;
@end

@implementation HomePageViewController

-(CGFloat)getScreenW{
    
    
    return [[UIScreen mainScreen] bounds].size.width;
}
-(CGFloat)getScreenH{
    
    
    return (([[UIScreen mainScreen] bounds].size.height == 812)?([[UIScreen mainScreen] bounds].size.height-34):[[UIScreen mainScreen] bounds].size.height);
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"抢单";
    
    [self initUI];
    [self getDatas];
    [self getPhoneScale];
    [self getCityInfo];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getPhoneScale) name:@"updatePhoneScale" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getDatas) name:@"updatePaiDans" object:nil];
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];

      [self.tabBarController.tabBar setHidden:NO];
}
-(void)initUI{
    
    
    self.day_countLabel = [[UILabel alloc] init];
    self.day_totalLabel = [[UILabel alloc] init];
    self.month_countLabel = [[UILabel alloc] init];
    self.month_totalLabel = [[UILabel alloc] init];
    
    
    self.day_countSaleLabel = [[UILabel alloc] init];
    self.day_totalSaleLabel = [[UILabel alloc] init];
    self.month_countSaleLabel = [[UILabel alloc] init];
    self.month_totalSaleLabel = [[UILabel alloc] init];
    
    
    self.day_countLabel.font = [UIFont systemFontOfSize:14.0];
    self.day_totalLabel.font = [UIFont systemFontOfSize:14.0];
    self.month_countLabel.font = [UIFont systemFontOfSize:14.0];
    self.month_totalLabel.font = [UIFont systemFontOfSize:14.0];
    
    self.day_totalSaleLabel.font = [UIFont systemFontOfSize:18.0];
    self.day_countSaleLabel.font = [UIFont systemFontOfSize:18.0];
    self.month_totalSaleLabel.font = [UIFont systemFontOfSize:18.0];
    self.month_countSaleLabel.font = [UIFont systemFontOfSize:18.0];
    
    
    self.day_countLabel.textAlignment = NSTextAlignmentCenter;
    self.day_totalLabel.textAlignment = NSTextAlignmentCenter;
    self.month_countLabel.textAlignment = NSTextAlignmentCenter;
    self.month_totalLabel.textAlignment = NSTextAlignmentCenter;
    
    self.day_countLabel.textColor = [UIColor orangeColor];
    self.day_totalLabel.textColor = [UIColor orangeColor];
    self.month_countLabel.textColor = [UIColor orangeColor];
    self.month_totalLabel.textColor = [UIColor orangeColor];
    
    self.day_totalSaleLabel.textAlignment = NSTextAlignmentCenter;
    self.day_countSaleLabel.textAlignment = NSTextAlignmentCenter;
    self.month_totalSaleLabel.textAlignment = NSTextAlignmentCenter;
    self.month_countSaleLabel.textAlignment = NSTextAlignmentCenter;
    
    self.day_totalSaleLabel.textColor = [UIColor redColor];
    self.day_countSaleLabel.textColor = [UIColor redColor];
    self.month_totalSaleLabel.textColor = [UIColor redColor];
    self.month_countSaleLabel.textColor = [UIColor redColor];
  
    self.day_countLabel.text = @"今日完成";
    self.day_totalLabel.text = @"今日收入";
    self.month_countLabel.text = @"本月完成";
    self.month_totalLabel.text = @"本月收入";
    
    
    self.day_countSaleLabel.text = @"00.0";
    self.day_totalSaleLabel.text = @"00.0";
    self.month_countSaleLabel.text = @"00.0";
    self.month_totalSaleLabel.text = @"00.0";
    
   
    [self.view addSubview:self.day_countLabel];
    [self.view addSubview:self.day_totalLabel];
    [self.view addSubview:self.month_countLabel];
    [self.view addSubview:self.month_totalLabel];
    
    
    [self.view addSubview:self.day_countSaleLabel];
    [self.view addSubview:self.day_totalSaleLabel];
    [self.view addSubview:self.month_totalSaleLabel];
    [self.view addSubview:self.month_countSaleLabel];
    
    UIView *line = [[UIView alloc] init];
    line.backgroundColor = [UIColor blackColor];
    [self.view addSubview:line];
    
    
    UIButton * fabu = [[UIButton alloc] init];
    fabu.titleLabel.font = [UIFont systemFontOfSize:14.0];
    [fabu setTitle:@"发单" forState:UIControlStateNormal];
    [fabu setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [fabu addTarget:self action:@selector(fabuqiangDan) forControlEvents:UIControlEventTouchUpInside];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:fabu];
    

    [self.day_countLabel mas_makeConstraints:^(MASConstraintMaker * marker){
        
        
            marker.left.mas_equalTo(0);
            marker.top.mas_equalTo(120);
            marker.width.equalTo(self.view).multipliedBy(0.25);
            marker.height.equalTo(@40);
        
    }];
    
    [self.day_countSaleLabel mas_makeConstraints:^(MASConstraintMaker * marker){
   
        marker.left.mas_equalTo(0);
        marker.top.mas_equalTo(80);
        marker.width.equalTo(self.view).multipliedBy(0.25);
        marker.height.equalTo(@40);
        
    }];
    
    [self.day_totalLabel mas_makeConstraints:^(MASConstraintMaker * marker){
        
        marker.left.mas_equalTo(self.day_countLabel.mas_right);
        marker.top.mas_equalTo(120);
        marker.width.equalTo(self.view).multipliedBy(0.25);
        marker.height.equalTo(@40);
        
    }];
    
    [self.day_totalSaleLabel mas_makeConstraints:^(MASConstraintMaker * marker){
     
        marker.left.mas_equalTo(self.day_countLabel.mas_right);
        marker.top.mas_equalTo(80);
        marker.width.equalTo(self.view).multipliedBy(0.25);
        marker.height.equalTo(@40);
        
    }];
    
    
    [self.month_countLabel mas_makeConstraints:^(MASConstraintMaker * marker){
     
        marker.left.mas_equalTo(self.day_totalLabel.mas_right);
        marker.top.mas_equalTo(120);
        marker.width.equalTo(self.view).multipliedBy(0.25);
        marker.height.equalTo(@40);
        
    }];
    
    [self.month_countSaleLabel mas_makeConstraints:^(MASConstraintMaker * marker){
     
         marker.left.mas_equalTo(self.day_totalLabel.mas_right);
        marker.top.mas_equalTo(80);
        marker.width.equalTo(self.view).multipliedBy(0.25);
        marker.height.equalTo(@40);
        
    }];
    
    [self.month_totalLabel mas_makeConstraints:^(MASConstraintMaker * marker){
        
        marker.left.equalTo(self.month_countLabel.mas_right);
        marker.top.mas_equalTo(120);
        marker.width.equalTo(self.view).multipliedBy(0.25);
        marker.height.equalTo(@40);
        
    }];
    [self.month_totalSaleLabel mas_makeConstraints:^(MASConstraintMaker * marker){
        
        marker.left.equalTo(self.month_countSaleLabel.mas_right);
        marker.top.mas_equalTo(80);
        marker.width.equalTo(self.view).multipliedBy(0.25);
        marker.height.equalTo(@40);
        
    }];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.day_countLabel.mas_bottom).offset(-1);
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        
        make.height.mas_equalTo(1);
        
    }];
  

    
    self.orderTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 160, self.view.frame.size.width, self.view.frame.size.height - 160 - 44)];
    [self.orderTableView registerClass:[homeTaskCell class] forCellReuseIdentifier:@"TaskCell"];
    self.orderTableView.estimatedRowHeight = 80.0;
    self.orderTableView.tableFooterView = [[UIView alloc] init];
    self.orderTableView.delegate = self;
    self.orderTableView.dataSource = self;
    [self.view addSubview:self.orderTableView];
}
-(void)fabuqiangDan{
    
    fabuTaskViewController * fabu = [[fabuTaskViewController alloc] init];

    [self.navigationController pushViewController:fabu animated:YES];
    
}
-(void)getDatas{
    
    Network * nt = [[Network alloc] init];
    NSString * phone = [[NSUserDefaults standardUserDefaults] objectForKey:@"phone"];
    NSString * city = [[NSUserDefaults standardUserDefaults] objectForKey:@"city"];
    
    
    
    [nt getqiangDanTaskList:phone paidancity:city type:1 success:^(NSDictionary * dict){
        
        
        if (![dict isKindOfClass:[NSDictionary class]]) {
            return;
        }
        
        NSString * code = [NSString stringWithFormat:@"%@",dict[@"code"]];
        if ([code isEqualToString:@"200"]) {
            
            self.datas = dict[@"data"];
            if (self.datas.count > 0) {
                
                NSMutableArray * array1 = [NSMutableArray array];
                for (int i = (int)self.datas.count - 1; i >=0; i--) {
                    
                    [array1 addObject:self.datas[i]];
                    
                }
                
                self.datas = array1;
                
            }
            
            [self.orderTableView reloadData];
            
        }
        
    } fail:^(NSError * error){
        
        
        
        
    }];
    

}
-(void)getPhoneScale{
    
    Network * nt = [[Network alloc] init];
    NSString * phone = [[NSUserDefaults standardUserDefaults] objectForKey:@"phone"];
    
    [nt getphoneSaleinfo:phone success:^(NSDictionary * dict){
        
        if (![dict isKindOfClass:[NSDictionary class]]) {
            return;
        }
            NSString * code = [NSString stringWithFormat:@"%@",dict[@"code"]];
            if ([code isEqualToString:@"200"]) {
                
                NSDictionary * data = dict[@"data"];
                
                self.day_countSaleLabel.text = [NSString stringWithFormat:@"%@.0",data[@"daycount"]];
                self.day_totalSaleLabel.text = [NSString stringWithFormat:@"%@.0",data[@"dayscalecount"]];
                self.month_countSaleLabel.text = [NSString stringWithFormat:@"%@.0",data[@"moncount"]];
                self.month_totalSaleLabel.text = [NSString stringWithFormat:@"%@.0",data[@"monscalecount"]];
            }
        
            } fail:^(NSError * error){
        
        
        
    }];
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 80.0;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (!self.datas) {
        
        return 0;
    }
    
    return self.datas.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    homeTaskCell * cell = [tableView dequeueReusableCellWithIdentifier:@"TaskCell"];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    NSDictionary * data = self.datas[indexPath.row];
    
    cell.priceLabel.text = [NSString stringWithFormat:@" ￥%@",data[@"taskscale"]];
    
    cell.originLabel.text = [NSString stringWithFormat:@"%@",data[@"sourceaddress"]];
    
    cell.destionLabel.text = [NSString stringWithFormat:@"%@",data[@"desaddress"]];
    
    __weak typeof(self) weakSelf = self;
    cell.qinagDan = ^(UITableViewCell * cell){
      
        NSIndexPath * indexPath = [tableView indexPathForCell:cell];
        
        [weakSelf qiangDanliji:indexPath againShow:1];
        
        
    };

    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
      __weak typeof(self) weakSelf = self;
    taskDetailView * detailView = [[taskDetailView alloc] initWithFrame:self.view.bounds];
    detailView.detailTask = self.datas[indexPath.row];
    detailView.detailView = chakanxinxi;
    detailView.buttonMethod = ^(taskDetailView * taskView){
        
        [taskView removeFromSuperview];
        
        [weakSelf qiangDanliji:indexPath againShow:0];
        
    };
    
    [[UIApplication sharedApplication].keyWindow addSubview:detailView];
    
    
    
}
-(void)getCityInfo{
    
    Network * nt = [[Network alloc] init];
    
    [nt getNetworkLocation:^(NSString * city){
        
                [[NSUserDefaults standardUserDefaults] setObject:city forKey:@"city"];
                [[NSUserDefaults standardUserDefaults] synchronize];
        
            } fail:^(NSError * error){
                
                
    }];
    
}

// 0. 查看详情抢单成功后不再显示订单信息     1. 立即抢单成功后查看订单信息
-(void)qiangDanliji:(NSIndexPath * )indexPath againShow:(int)isshow{
    
    Network * nt = [[Network alloc] init];
    NSString* phone = [[NSUserDefaults standardUserDefaults] objectForKey:@"phone"];
    
    NSString * city = [[NSUserDefaults standardUserDefaults] objectForKey:@"city"];
    
    if (!city) {
        
        return;
    }
    
            NSDictionary * taskdata = self.datas[indexPath.row];
            NSString * tasknumber = taskdata[@"tasknumber"];
    
        [nt qiangDanphone:phone tasknumber:tasknumber success:^(NSDictionary * dict){
        
                    NSString * code = [NSString stringWithFormat:@"%@",dict[@"code"]];
                    if ([code isEqualToString:@"200"]) {
                
                        if (isshow == 1) {
                            
                             [self loadDetailInfo:indexPath];
                        }
                       
                         [[NSNotificationCenter defaultCenter] postNotificationName:@"updatePaiDans" object:nil];
                    }else{
                        
                        NSString  * reason = [NSString stringWithFormat:@"%@",dict[@"data"][@"data"]];
                        [self showtitle:reason];
                        
                    }
        
                } fail:^(NSError * error){
        
        
        
            }];
  
    
    
}
-(void)showtitle:(NSString *)title{
    
    UIAlertController * control = [UIAlertController alertControllerWithTitle:@"提示" message:title preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction * action = [UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action){}];
    
    [control addAction:action];
    
    
    [self presentViewController:control animated:YES completion:nil];
}
-(void)loadDetailInfo:(NSIndexPath *)indexPath{
    
    taskDetailView * detailView = [[taskDetailView alloc] initWithFrame:self.view.bounds];
    detailView.detailTask = self.datas[indexPath.row];
    detailView.detailView = qiangdanSuccess;
    detailView.buttonMethod = ^(taskDetailView * taskView){
      
        [taskView removeFromSuperview];
       
        
    };
    
    [[UIApplication sharedApplication].keyWindow addSubview:detailView];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
  
}


@end
