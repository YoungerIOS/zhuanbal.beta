//
//  taskbaseVC.m
//  ZhuanBa
//
//  Created by developer on 2018/8/27.
//  Copyright © 2018年 developer. All rights reserved.
//

#import "taskbaseVC.h"
#import "HomePageViewController.h"
#import "taskPageController.h"
#import "meViewController.h"


@interface taskbaseVC ()

@end

@implementation taskbaseVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tabBar.tintColor = [UIColor orangeColor];
    [self loadAllViews];
}

-(void)loadAllViews{
    
    HomePageViewController * home = [[HomePageViewController alloc] init];
    taskPageController * task = [[taskPageController alloc] init];
    meViewController * mevc = [[meViewController alloc] init];
    
  
    
    UINavigationController * homeNav = [[UINavigationController alloc] initWithRootViewController:home];
    homeNav.navigationBar.barTintColor = [UIColor orangeColor];
    UINavigationController * taskNav = [[UINavigationController alloc] initWithRootViewController:task];
    taskNav.navigationBar.barTintColor = [UIColor orangeColor];
    UINavigationController * meNav   = [[UINavigationController alloc] initWithRootViewController:mevc];
    meNav.navigationBar.barTintColor = [UIColor orangeColor];
    
    
    UITabBarItem * hometab =[[UITabBarItem alloc] initWithTitle:@"抢单" image:[UIImage imageNamed:@"qiangdan"] selectedImage:[UIImage imageNamed:@"qiangdan_selected"]];
    [hometab setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:10.0]} forState:UIControlStateNormal];
    UITabBarItem * tasktab = [[UITabBarItem alloc] initWithTitle:@"任务" image:[UIImage imageNamed:@"renwu"] selectedImage:[UIImage imageNamed:@"renwu_selected"]];
    [tasktab setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:10.0]} forState:UIControlStateNormal];
    UITabBarItem * metab = [[UITabBarItem alloc] initWithTitle:@"帐户" image:[UIImage imageNamed:@"zhanghu"] selectedImage:[UIImage imageNamed:@"zhanghu_selected"]];
    [metab setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:10.0]} forState:UIControlStateNormal];
    
    [homeNav setTabBarItem:hometab];
    [taskNav setTabBarItem:tasktab];
    [meNav setTabBarItem:metab];
    
    [self setViewControllers:@[homeNav,taskNav,meNav]];
    
    [self setSelectedIndex:0];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
