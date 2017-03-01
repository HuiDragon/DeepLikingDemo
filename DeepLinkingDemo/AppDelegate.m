//
//  AppDelegate.m
//  DeepLinkingDemo
//
//  Created by Liuguiliang on 2017/3/1.
//  Copyright © 2017年 HuiDragon. All rights reserved.
//

#import "AppDelegate.h"

#import "ViewController.h"
#import "OneVC.h"
#import "TwoVC.h"
#import "ThreeVC.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    return YES;
}

// 处理 url scheme
- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
    
    UINavigationController *nav = (UINavigationController *)application.keyWindow.rootViewController;
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    if([[url host] isEqualToString:@"page"]){
        if([[url path] isEqualToString:@"/main"]){
            [nav popToRootViewControllerAnimated:YES];
        }
        else if([[url path] isEqualToString:@"/page1"]){
            UIViewController    *oneVC = [storyboard instantiateViewControllerWithIdentifier:@"one"];
            [nav  pushViewController:oneVC animated:YES];
        }
        else if([[url path] isEqualToString:@"/page2"]){
            UIViewController    *twoVC = [storyboard instantiateViewControllerWithIdentifier:@"two"];
            [nav pushViewController:twoVC animated:YES];
        }
        else if([[url path] isEqualToString:@"/page3"]){
            UIViewController    *threeVC = [storyboard instantiateViewControllerWithIdentifier:@"three"];
            [nav pushViewController:threeVC animated:YES];
        }
        else{
            return NO;
        }
        return YES;
    }
    else{
        return NO;
    }
    
}

//ios9以后用这个
- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<NSString *,id> *)options {
    NSString *sourceApp = [options objectForKey:UIApplicationOpenURLOptionsSourceApplicationKey];
    return [self application:app openURL:url sourceApplication:sourceApp annotation:options];
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
