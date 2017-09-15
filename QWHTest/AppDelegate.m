//
//  AppDelegate.m
//  QWHDemo
//
//  Created by qinwh2008 on 2017/9/12.
//  Copyright © 2017年 maple. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"
#import "QWHNavigationController.h"
#import "DemoDataListView.h"
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    pub = [[QWHPublic alloc] init];
    
    //设置全局样式；
    [[UITextField appearance] setTintColor:kThemeColor];

    NSDictionary *titleTextAttributes = @{NSFontAttributeName: [UIFont boldSystemFontOfSize:18],NSForegroundColorAttributeName:kBlackColor,NSLigatureAttributeName:kBlackColor};
    [[UINavigationBar appearance] setTitleTextAttributes:titleTextAttributes];
//    [[UINavigationBar appearance] setBarTintColor:[UIColor colorWithRed:249/255.0 green:249/255.0 blue:249/255.0 alpha:1]];
    [[UINavigationBar appearance] setTintColor:kThemeColor];
    
    [[UITabBar appearance] setTintColor:kThemeColor];

    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor blackColor];
    self.window.rootViewController = [self bulidRootVC];
    [self.window makeKeyAndVisible];
    
    return YES;
}

- (UIViewController *)bulidRootVC
{
    DemoDataListView*vc0 = [[DemoDataListView alloc] init];
    vc0.title = @"animation";
    vc0.tabBarItem.title = @"首页";
    vc0.tabBarItem.image = [UIImage imageNamed:@"crazy"];
    
    ViewController *vc1 = [[ViewController alloc] init];
    vc1.title = @"乐贝通";
    vc1.tabBarItem.title = @"乐宝贝";
    vc1.tabBarItem.image = [UIImage imageNamed:@"brick"];
    
    
    QWHNavigationController *nav0 = [[QWHNavigationController alloc] initWithRootViewController: vc0];
    nav0.view.backgroundColor = [UIColor whiteColor];
    
    QWHNavigationController *nav1 = [[QWHNavigationController alloc] initWithRootViewController: vc1];
    nav1.view.backgroundColor = [UIColor whiteColor];
    
    
    UITabBarController *tabbar = [[UITabBarController alloc] init];
    [tabbar setViewControllers:@[nav0,nav1]];
    
    return tabbar;
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
