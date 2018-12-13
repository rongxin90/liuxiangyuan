//
//  AppDelegate.m
//  liuxiangyuan
//
//  Created by 桂荣信 on 16/7/26.
//  Copyright © 2016年 grx. All rights reserved.
//

#import "AppDelegate.h"

#import "MainTabBarViewController.h"
#import "ADViewController.h"
//#import <AMapFoundationKit/AMapFoundationKit.h>

@interface AppDelegate ()
@property (weak, nonatomic) ADViewController *adController;
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    //1.初始化窗口
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    
    //2.设置根控制器
    MainTabBarViewController *tabbarVC = [[MainTabBarViewController alloc] init];
    tabbarVC.view.backgroundColor = [UIColor redColor];
    self.window.rootViewController = tabbarVC;
    
    
    
    
    //3.展示窗口
    [self.window makeKeyAndVisible];
    
    
//    [self performSelector:@selector(changeRootViewController) withObject:nil afterDelay:2];
    
    
    return YES;
}

- (void)changeRootViewController{
    
//    [self.window.rootViewController dismissViewControllerAnimated:YES completion:^{
    
        MainTabBarViewController *tabbarVC = [[MainTabBarViewController alloc] init];
        tabbarVC.view.backgroundColor = [UIColor redColor];
        self.window.rootViewController = tabbarVC;
//    }];
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
