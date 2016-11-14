//
//  FVAppDelegate.m
//  FVCustomTransition
//
//  Created by iforvert on 2016/11/11.
//  Copyright © 2016年 iforvert. All rights reserved.
//

#import "FVAppDelegate.h"

@implementation FVAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Register the initial user defaults
    NSString *initialDefaultsPath = [[NSBundle mainBundle] pathForResource:@"InitialDefaults" ofType:@"plist"];
    NSDictionary *initialDefaults = [NSDictionary dictionaryWithContentsOfFile:initialDefaultsPath];
    [[NSUserDefaults standardUserDefaults]  registerDefaults:initialDefaults];
    
    return YES;
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Sync defaults to disk
    [[NSUserDefaults standardUserDefaults] synchronize];
}

@end
