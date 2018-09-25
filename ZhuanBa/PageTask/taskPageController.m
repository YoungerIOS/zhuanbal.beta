//
//  taskPageController.m
//  ZhuanBa
//
//  Created by developer on 2018/8/27.
//  Copyright © 2018年 developer. All rights reserved.
//

#import "taskPageController.h"
#import "taskCell.h"
#import "taskDetailView.h"

@interface taskPageController ()<UITableViewDelegate , UITableViewDataSource >

@property (nonatomic,strong) UISegmentedControl * segment;
@property (nonatomic,strong) UITableView * taskTable;
@property (nonatomic,strong) NSArray * datas;
@property (nonatomic,strong) UIActivityIndicatorView * indicatorView;
@property (nonatomic) int countday;
@property (nonatomic) int countSaleday;
@property (nonatomic) int countmonth;
@property (nonatomic) int countSalemonth;
@property (nonatomic) int counttotal;
@property (nonatomic) int countSale;
@end

@implementation taskPageController

- (void)viewDidLoad {
    [super viewDidLoad];
 

    self.segment = [[UISegmentedControl alloc] initWithFrame:CGRectMake(0, 0, 200, 30)];
    self.segment.center = CGPointMake(self.view.frame.size.width / 2, 24);
    [self.segment insertSegmentWithTitle:@"抢单" atIndex:0 animated:NO];
    [self.segment insertSegmentWithTitle:@"派单" atIndex:1 animated:NO];
//    self.segment.backgroundColor = [UIColor lightGrayColor];
    self.segment.tintColor = [UIColor orangeColor];
    [self.segment  setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]} forState:UIControlStateSelected];
    [self.segment  setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor blackColor]} forState:UIControlStateNormal];
    
    [self.segment addTarget:self action:@selector(segmentTarget:) forControlEvents:UIControlEventValueChanged];

     [self.navigationController.navigationBar addSubview:self.segment];

    [self.segment setSelectedSegmentIndex:0];
    [self loadqiangdandata];
    
    [self getPhoneScale];
    self.taskTable = [[UITableView alloc] init];
    self.taskTable.delegate = self;
    self.taskTable.dataSource = self;
    [self.view addSubview:self.taskTable];
    
    
    [self.taskTable mas_makeConstraints:^(MASConstraintMaker * maker){
      
        maker.left.right.top.bottom.equalTo(@0);
        
    }];
    
    
    [self.taskTable registerClass:[taskCell class] forCellReuseIdentifier:@"taskCell"];
   
    self.taskTable.tableFooterView = [[UIView alloc] init];
}
-(void)segmentTarget:(UISegmentedControl *)segment{
    
        self.datas = [NSArray array];
        [self.taskTable reloadData];
    
    
    if (segment.selectedSegmentIndex == 0) {
        
        [self loadqiangdandata];
        
    }else if (segment.selectedSegmentIndex == 1){
        
        [self loadpaidandata];
        
    }
    
    
}
-(void)loadqiangdandata{
    
    [self.view addSubview:self.indicatorView];
    
    NSString * phone = [[NSUserDefaults standardUserDefaults] objectForKey:@"phone"];
    NSString * city = [[NSUserDefaults standardUserDefaults] objectForKey:@"city"];
    
    Network * nt = [[Network alloc] init];
    [nt getqiangdanlist:phone paidancity:city type:8 success:^(NSDictionary * dict){
        
        
        NSString * code = [NSString stringWithFormat:@"%@",dict[@"code"]];
        if ([code isEqualToString:@"200"]) {
            
            self.datas = dict[@"data"];
            
            if (self.datas.count > 0) {
                
                NSMutableArray * array1 = [NSMutableArray array];
                
                for (int i = (int)self.datas.count - 1; i >= 0; i--) {
                    
                    [array1 addObject:self.datas[i]];
                }
                
                self.datas = array1;
                
            }
            
            [self.taskTable reloadData];
        }
        
        
        } fail:^(NSError * error){
        
        
        
    }];
}

-(void)loadpaidandata{
     [self.view addSubview:self.indicatorView];
    
    NSString * phone = [[NSUserDefaults standardUserDefaults] objectForKey:@"phone"];
    
    Network * nt = [[Network alloc] init];
    [nt getpaidanlist:phone type:2 success:^(NSDictionary * dict){
        
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
            [self.taskTable reloadData];
        }
        
            } fail:^(NSError * error){
    
        
    }];
    
    
}
-(void)getPhoneScale{
    
    Network * nt = [[Network alloc] init];
    NSString * phone = [[NSUserDefaults standardUserDefaults] objectForKey:@"phone"];
    
    [nt getphoneSaleinfo:phone success:^(NSDictionary * dict){
        
        NSString * code = [NSString stringWithFormat:@"%@",dict[@"code"]];
        if ([code isEqualToString:@"200"]) {
            
            NSDictionary * data = dict[@"data"];
            
            self.countday = [[NSString stringWithFormat:@"%@",data[@"daycount"]] intValue];
            self.countSaleday = [[NSString stringWithFormat:@"%@",data[@"dayscalecount"]] intValue];
            self.countmonth = [[NSString stringWithFormat:@"%@",data[@"moncount"]] intValue];
            self.countSalemonth = [[NSString stringWithFormat:@"%@",data[@"monscalecount"]] intValue];
            self.counttotal = [[NSString stringWithFormat:@"%@",data[@"totalcount"]] intValue];
            self.countSale = [[NSString stringWithFormat:@"%@",data[@"totalscalecount"]] intValue];
        }
        
    } fail:^(NSError * error){
        
        
        
    }];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (!self.datas) {
        
        return 0;
    }
    
    return self.datas.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    taskCell * cell = [tableView dequeueReusableCellWithIdentifier:@"taskCell"];
    cell.taskData = self.datas[indexPath.row];
    
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 80.0;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    taskDetailView * detail = [[taskDetailView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    detail.buttonMethod = ^(taskDetailView * detailView){
        
        NSDictionary * taskdata = detailView.detailTask;
        if (self.segment.selectedSegmentIndex == 0) {
            
            [self confirmpaysuccess:taskdata];
            
        }else if (self.segment.selectedSegmentIndex == 1){
            
            [self confirmdonesuccess:taskdata];
        }
        
        [detailView removeFromSuperview];
        
    };
    
    detail.detailTask = self.datas[indexPath.row];
    
    if (self.segment.selectedSegmentIndex == 0) {
        
        detail.detailView = qiangdanlist;
        
    }else if (self.segment.selectedSegmentIndex == 1){
        
        detail.detailView = paidanlist;
    }
    
 
    
    [[UIApplication sharedApplication].keyWindow addSubview:detail];
    
}
// 确认支付成功
-(void)confirmpaysuccess:(NSDictionary *)taskmodel{
    
    
    int taskstatus = [[NSString stringWithFormat:@"%@",taskmodel[@"taskstatus"]] intValue];
    // 对方已经确认任务完成，才能确认支付
    if (taskstatus == 3) {
        Network * nt = [[Network alloc] init];
        NSString * phone = [[NSUserDefaults standardUserDefaults] objectForKey:@"phone"];
        NSString * tasknumber = [NSString stringWithFormat:@"%@",taskmodel[@"tasknumber"]];
        
        [nt confirmFinishPay:phone tasknumber:tasknumber success:^(NSDictionary * dict){
            
            
            NSString * code = [NSString stringWithFormat:@"%@",dict[@"code"]];
            
            if ([code isEqualToString:@"200"]) {
                
                [self updateSale:tasknumber];
                [self loadqiangdandata];
                
            }
            
        } fail:^(NSError * error){
            
            
            
        }];
    }
                      
    
   
}
// 确认任务完成
-(void)confirmdonesuccess:(NSDictionary *)taskmodel{
    
    
    int taskstatus = [[NSString stringWithFormat:@"%@",taskmodel[@"taskstatus"]] intValue];
    // 必须要对方已经开始任务后，才能确认任务完成
    if (taskstatus == 2) {
   
    
        Network * nt = [[Network alloc] init];
        NSString * phone = [[NSUserDefaults standardUserDefaults] objectForKey:@"phone"];
    
        NSString * tasknumber = [NSString stringWithFormat:@"%@",taskmodel[@"tasknumber"]];
        [nt confirmFinishTask:phone tasknumber:tasknumber success:^(NSDictionary *dict){
        
                NSString * code = [NSString stringWithFormat:@"%@",dict[@"code"]];
                if ([code isEqualToString:@"200"]) {
                
                    [self loadpaidandata];
                }
        
                } fail:^(NSError * error){
        
                }];
        
        }
    
}
-(void)updateSale:(NSString * )tasknumber{
    
    self.countday ++;
    self.countmonth ++;
    self.counttotal ++;
    
    NSString * phone = [[NSUserDefaults standardUserDefaults] objectForKey:@"phone"];
    
    int singleSale;
    
    for (NSDictionary * data in self.datas) {
        
        NSString * number = [NSString stringWithFormat:@"%@",data[@"tasknumber"]];
        if ([number isEqualToString:tasknumber]) {
            
            singleSale = [[NSString stringWithFormat:@"%@",data[@"taskscale"]] intValue];
        }
        
        
    }
    
    self.countSaleday += singleSale;
    self.countSalemonth += singleSale;
    self.countSale += singleSale;
    
    
    Network * nt = [[Network alloc] init];
    
    [nt personScalesuccess:phone countDay:[NSString stringWithFormat:@"%d",self.countday] saleDay:[NSString stringWithFormat:@"%d",self.countSaleday] countMonth:[NSString stringWithFormat:@"%d",self.countmonth] saleMonth:[NSString stringWithFormat:@"%d",self.countSalemonth] countTotal:[NSString stringWithFormat:@"%d",self.counttotal] saletotal:[NSString stringWithFormat:@"%d",self.countSale] success:^(NSDictionary * dict){
        
        NSString * code = [NSString stringWithFormat:@"%@",dict[@"code"]];
   
            if ([code isEqualToString:@"200"]) {
            
                NSDictionary * data = dict[@"data"];
                
                [[NSNotificationCenter defaultCenter] postNotificationName:@"updatePhoneScale" object:nil];
                
            }
            } fail:^(NSError * error){
        
        
        
        
    }];
    
}
-(UIActivityIndicatorView *)indicatorView{
    
    if (!_indicatorView) {
        
        _indicatorView = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
        _indicatorView.center = self.view.center;
        [_indicatorView startAnimating];
    }
    
    
    return _indicatorView;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
