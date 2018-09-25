//
//  fabuTaskViewController.m
//  ZhuanBa
//
//  Created by developer on 2018/8/31.
//  Copyright © 2018年 developer. All rights reserved.
//

#import "fabuTaskViewController.h"
#import "fabuTaskView.h"


@interface fabuTaskViewController ()

@end

@implementation fabuTaskViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];

    self.title  = @"发布派单";

    UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(40, 60, self.view.frame.size.width - 80, 80)];
    label.font = [UIFont systemFontOfSize:14.0];
    label.text = @"请准确填写取货地址、收货地址、任务详情等信息，为了不耽误你的时间请核对信息后再进行发布，一旦发布派单将无法取消 !";
    label.contentMode = UIViewContentModeTop;
    label.numberOfLines = 0;
    label.textColor = [UIColor grayColor];
    [self.view addSubview:label];
    

    UIButton * button = [[UIButton alloc] init];
    [button setImage:[UIImage imageNamed:@"返回"] forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:@"返回"] forState:UIControlStateHighlighted];
    [button addTarget:self action:@selector(esc) forControlEvents:UIControlEventTouchUpInside];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    
    fabuTaskView * fabu = [[fabuTaskView alloc] initWithFrame:CGRectMake(0, 60, self.view.frame.size.width, 560)];
    
    __weak typeof(*&self) weakSelf = self;
    fabu.fabuBlock = ^(int a){
        
        if (a == 1) {
            
            
            [weakSelf.navigationController popViewControllerAnimated:YES];
            [[NSNotificationCenter defaultCenter] postNotificationName:@"updatePaiDans" object:nil];
            
        }else{
            
            [weakSelf showtitle:@"发布失败"];
        }
        
        
    };
    
    
    [self.view addSubview:fabu];
}
-(void)showtitle:(NSString *)title{
    
    UIAlertController * control = [UIAlertController alertControllerWithTitle:@"提示" message:title preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction * action = [UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action){}];
    
    [control addAction:action];
    
    
    [self presentViewController:control animated:YES completion:nil];
}
-(void)esc{
    
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    [self.tabBarController.tabBar setHidden:YES];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
