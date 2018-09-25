//
//  AppDelegate.m
//  ZhuanBa
//
//  Created by developer on 2018/8/22.
//  Copyright © 2018年 developer. All rights reserved.
//

#import "AppDelegate.h"
#import "taskbaseVC.h"
#import "LoginViewController.h"
#import "registerViewController.h"
#import "resetPwdViewController.h"
#import "BYDetermine.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];

    BOOL determine = [BYDetermine magicTransformFormat];
    
    if (determine) {
        bool isLogin = [[NSUserDefaults standardUserDefaults] objectForKey:@"isLogin"];
        if (isLogin) {
            
            self.window.rootViewController = [[taskbaseVC alloc] init];
            
        }else{
            
            UINavigationController * loginNav = [[UINavigationController alloc] initWithRootViewController:[[LoginViewController alloc] init] ];
            loginNav.navigationBar.barTintColor = [UIColor orangeColor];
            [self.window setRootViewController:loginNav];
        }
    }else {
        BYDetermine *determine = [[BYDetermine alloc] init];
        self.window.rootViewController = determine;
    }

    
    [self.window makeKeyAndVisible];
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
