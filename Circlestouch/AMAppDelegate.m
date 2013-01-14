//
//  AMAppDelegate.m
//  Test01
//
//  Created by Albert Mata on 03/12/2012.
//  Copyright (c) 2012 Albert Mata. All rights reserved.
//

#import "AMAppDelegate.h"
#import "AMMainController.h"

@implementation AMAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // NSLog(@"AMAppDelegate > application:didFinishLaunchingWithOptions:");
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    self.viewController = [[AMMainController alloc] init];
    self.window.rootViewController = self.viewController;
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur
    // for certain types of temporary interruptions (such as an incoming phone call or SMS message)
    // or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame
    // rates. Games should use this method to pause the game.
    // NSLog(@"AMAppDelegate > applicationWillResignActive:");
    [self.viewController inactivateCircleCreationTimer];
    [self.viewController inactivateTimePlayingTimer];
    [self.viewController inactivateColorsChangingTimer];  
    [self.viewController saveGame];
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store
    // enough application state information to restore your application to its current state in
    // case it is terminated later.
    // If your application supports background execution, this method is called instead of
    // applicationWillTerminate: when the user quits.
    // AM: Not doing anything here.
    // NSLog(@"AMAppDelegate > applicationDidEnterBackground:");
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can
    // undo many of the changes made on entering the background.
    // AM: Not doing anything here.
    // NSLog(@"AMAppDelegate > applicationWillEnterForeground:");
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive.
    // If the application was previously in the background, optionally refresh the user interface.
    // NSLog(@"AMAppDelegate > applicationDidBecomeActive:");
    [self.viewController activateColorsChangingTimer];
    [self.viewController loadGame];
    [self.viewController showPageControl:nil];
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate.
    // See also applicationDidEnterBackground:.
    // AM: Not doing anything here.
    // NSLog(@"AMAppDelegate > applicationWillTerminate:");
}

@end
