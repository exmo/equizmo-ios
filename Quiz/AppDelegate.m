//
//  AppDelegate.m
//  Quiz
//
//  Created by Robson Saraiva Ximenes on 19/06/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "AppDelegate.h"

#import "LoginViewController.h"

@implementation AppDelegate

@synthesize window = _window;
@synthesize viewController = _viewController;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    
    [self customizeAppearance];
    
    self.viewController = [[LoginViewController alloc] initWithNibName:@"LoginViewController" bundle:nil];
    
    self.window.rootViewController = self.viewController;
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

#pragma mark Customizações
- (void)customizeAppearance
{
    self.window.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"background"]];
    
//    UIImage *background = [UIImage imageNamed:@"background"]; 
//    [[UIView appearance] setBackgroundImage:background];
    
    // Create resizable images
    //    UIImage *gradientImage44 = [[UIImage imageNamed:@"barra_de_acao_v"] 
    //                                resizableImageWithCapInsets:UIEdgeInsetsMake(0, 0, 0, 0)];
    //    UIImage *gradientImage32 = [[UIImage imageNamed:@"barra_de_acao_v"] 
    //                                resizableImageWithCapInsets:UIEdgeInsetsMake(0, 0, 0, 0)];
    //    
    //    // Set the background image for *all* UINavigationBars
    //    [[UINavigationBar appearance] setBackgroundImage:gradientImage44 
    //                                       forBarMetrics:UIBarMetricsDefault];
    //    [[UINavigationBar appearance] setBackgroundImage:gradientImage32 
    //                                       forBarMetrics:UIBarMetricsLandscapePhone];
    //    
    //    
    //    UIImage *buttonBack30 = [[UIImage imageNamed:@"bt_dashboard_v"]         resizableImageWithCapInsets:UIEdgeInsetsMake(0, 0, 0, 0)];
    //                            // resizableImageWithCapInsets:UIEdgeInsetsMake(0, 13, 0, 5)];
    //    UIImage *buttonBack24 = [[UIImage imageNamed:@"bt_dashboard_h"] 
    //                             resizableImageWithCapInsets:UIEdgeInsetsMake(0, 12, 0, 5)];
    //    
    //    [[UIBarButtonItem appearance] setBackButtonBackgroundImage:buttonBack30 
    //                                                      forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
    //    
    //    [[UIBarButtonItem appearance] setBackButtonBackgroundImage:buttonBack24 
    //                                                      forState:UIControlStateNormal barMetrics:UIBarMetricsLandscapePhone];
    //    
    
}

@end
