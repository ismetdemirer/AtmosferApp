//
//  AppDelegate.m
//  Fenomenya
//
//  Created by Mehmet ONDER on 25.04.2018.
//  Copyright © 2018 Mehmet ONDER. All rights reserved.
//

#import "AppDelegate.h"
#import "Header.h"

#import <linkedin-sdk/LISDK.h>
#include <linkedin-sdk/LISDKSessionManager.h>
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <TwitterKit/TwitterKit.h>

@interface AppDelegate ()
{
	bool isValidToken;
}
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
	// Override point for customization after application launch.
	
	[[FBSDKApplicationDelegate sharedInstance] application:application
							 didFinishLaunchingWithOptions:launchOptions];
	
	 [[Twitter sharedInstance] startWithConsumerKey:@"6Pb3tFkEjSiu4X8Atun02U2Dp" consumerSecret:@"Z5w54qHdKsgwFt7sMMTfwKcXQwMEvUNMYX9yiEN4UXfycOqTNi"];
	
	[self LoadedApp:application];

	
	return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
	// Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
	// Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
	// Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
	// If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
	
	[[User sharedUser] Save];
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
	// Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
	// Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.

	[FBSDKAppEvents activateApp];

}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
	
	bool linkedIn = false;
	if ([LISDKCallbackHandler shouldHandleUrl:url]) {
		linkedIn =  [LISDKCallbackHandler application:application openURL:url sourceApplication:sourceApplication annotation:annotation];
	}
	
	bool fb = [[FBSDKApplicationDelegate sharedInstance] application:application
															 openURL:url
												   sourceApplication:sourceApplication
														  annotation:annotation];
	
	return linkedIn || fb;
}

- (BOOL)application:(UIApplication *)app
			openURL:(NSURL *)url
			options:(NSDictionary *)options {
	
	bool linkedIn = false;
	if ([LISDKCallbackHandler shouldHandleUrl:url]) {
		linkedIn = [LISDKCallbackHandler application:app openURL:url sourceApplication:options[UIApplicationLaunchOptionsSourceApplicationKey] annotation:options[UIApplicationLaunchOptionsAnnotationKey]];
	}
	
	bool facebook = [[FBSDKApplicationDelegate sharedInstance] application:app
																   openURL:url
														 sourceApplication:options[UIApplicationOpenURLOptionsSourceApplicationKey]
																annotation:options[UIApplicationOpenURLOptionsAnnotationKey]];
	
	return linkedIn || facebook;
}

- (void)applicationWillTerminate:(UIApplication *)application {
	// Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
	
	[[User sharedUser] Save];
}

#pragma mark Token Validation
-(void)isTokenValid
{
	[[[WsUtil alloc]
	  initWithCaller:self
	  WithSuccededSel:@selector(isTokenValid:WithResponse:)
	  WithFailedSel:@selector(isTokenValid:WithError:)]
	 WsCallWithUrl:@"Authentication/IsTokenValid"
	 WithHttpMethod:HttpPost
	 WaitWs:false];

}

-(void)isTokenValid:(WsUtil*)ws WithResponse:(NSDictionary*)response
{
	isValidToken = [[response valueForKey:@"Data"] boolValue];
	
	ws = nil;
}

-(void)isTokenValid:(WsUtil*)ws WithError:(NSError*)error
{
	//TODO
	UINavigationController *navController = (UINavigationController*)self.window.rootViewController;
	[UtilCommon ShowConnectionError:error VC:navController.visibleViewController];
	
	ws = nil;
}

#pragma mark Initialize
-(void)LoadedApp:(UIApplication*)application
{
	if([User sharedUser].Id > 0)
	{
		[self GetMemberUnReadMessageCount];
		
		[self isTokenValid];
		if(!isValidToken)
		{
			[self GetToken];
		}
		
		UINavigationController *navController =  (UINavigationController*)self.window.rootViewController;
		
		VcFenomenia * vcFenomenia = [[VcFenomenia alloc] initWithNibName:@"VcFenomenia" bundle:nil];
		[navController pushViewController:vcFenomenia animated:NO];
		
	}
	
	if ([application respondsToSelector:@selector(isRegisteredForRemoteNotifications)])
	{
		// for iOS 8
		[application registerUserNotificationSettings:[UIUserNotificationSettings settingsForTypes:(UIUserNotificationTypeSound | UIUserNotificationTypeAlert | UIUserNotificationTypeBadge) categories:nil]];
		[application registerForRemoteNotifications];
	}
	
	
	[[UIApplication sharedApplication] setApplicationIconBadgeNumber: 0];
}

#pragma mark GetUnread Message Count
-(void)GetMemberUnReadMessageCount
{
	NSString *url = [NSString stringWithFormat:@"Member/GetMemberUnReadMessageCount/%ld",
					 (long)[User sharedUser].Id];
	[[[WsUtil alloc]
	  initWithCaller:self
	  WithSuccededSel:@selector(GetMemberUnReadMessageCount:WithResponse:)
	  WithFailedSel:@selector(GetMemberUnReadMessageCount:WithError:)]
	 WsCallWithUrl:url
	 WithHttpMethod:HttpPost
	 WaitWs:false];
}

-(void)GetMemberUnReadMessageCount:(WsUtil*)ws WithResponse:(NSDictionary*)response
{
	[User sharedUser].UnReadMessageCount = [[response valueForKey:@"Data"] integerValue];
	
	ws = nil;
}

-(void)GetMemberUnReadMessageCount:(WsUtil*)ws WithError:(NSError*)error
{
	//TODO
	//UINavigationController *navController = (UINavigationController*)self.window.rootViewController;
	//[GCCUtility ShowConnectionError:error VC:navController.visibleViewController];
	
	ws = nil;
}

#pragma mark GetToken
-(void)GetToken
{
	NSDictionary * params = @{
							  @"DeviceToken":[[User sharedUser] DeviceToken],
							  @"Id":@([[User sharedUser] Id])
							  };
	
	[[[WsUtil alloc]
	  initWithCaller:self
	  WithSuccededSel:@selector(GetTokenSucceeded:WithResponse:)
	  WithFailedSel:@selector(GetTokenFailed:WithError:)]
	 WsCallWithUrl:@"Authentication/GetToken"
	 WithHttpMethod:HttpPost
	 WithBodyParamters:params
	 WaitWs:false];
	

}
-(void)GetTokenSucceeded:(WsUtil*)ws WithResponse:(NSDictionary*)response
{
	[User sharedUser].Token = [response valueForKey:@"Token"];
	
	ws = nil;
}

-(void)GetTokenFailed:(WsUtil*)ws WithError:(NSError*)error
{
	//TODO
	//UINavigationController *navController = (UINavigationController*)self.window.rootViewController;
	//[GCCUtility ShowConnectionError:error VC:navController.visibleViewController];
	
	ws = nil;
}
@end
