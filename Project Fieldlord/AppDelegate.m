//
//  AppDelegate.m
//  Project Fieldlord
//
//  Created by Jason Fieldman on 2/24/14.
//  Copyright (c) 2014 Jason Fieldman. All rights reserved.
//

#import "AppDelegate.h"
#import "MainGameController.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
	/* Install flurry */
	[Flurry setCrashReportingEnabled:YES];
	[Flurry startSession:FLURRY_KEY];
	
	/* Seed random time */
	srand(time(0));
	InitializeMathHelper();
	[PreloadedSFX initializePreloadedSFX];
	
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor colorWithWhite:238/255.0 alpha:1];
	
	/* Add the main controller */
	self.window.rootViewController = [MainGameController sharedInstance];
	
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
	// Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
	// Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
	[[GameState sharedInstance] saveState];
	[[MainGameController sharedInstance] updateGCStats];
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
	// Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
	// If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
	[[GameState sharedInstance] saveState];
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
	// Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
	// Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
	[[MainGameController sharedInstance] updateGCStats];
}

- (void)applicationWillTerminate:(UIApplication *)application
{
	// Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
	[[GameState sharedInstance] saveState];
}

@end
