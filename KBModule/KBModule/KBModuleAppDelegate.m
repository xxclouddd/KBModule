//
//  KBModuleAppDelegate.m
//  KBModuleManager
//
//  Created by 肖雄 on 17/4/17.
//  Copyright © 2017年 xiaoxiong. All rights reserved.
//

#import "KBModuleAppDelegate.h"
#import "KBModuleContext.h"
#import "KBModuleManager.h"

@implementation KBModuleAppDelegate

@synthesize window;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    [[KBModuleManager shareInstance] triggerEvent:KBModuleEventTypeSetup];
    [[KBModuleManager shareInstance] triggerEvent:KBModuleEventTypeInit];
    
    return YES;
}

#if __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_9_0
-(void)application:(UIApplication *)application performActionForShortcutItem:(UIApplicationShortcutItem *)shortcutItem completionHandler:(void (^)(BOOL))completionHandler
{
    [KBModuleContext shareInstance].touchShortcutItem.shortcutItem = shortcutItem;
    [KBModuleContext shareInstance].touchShortcutItem.completionHandler = completionHandler;
    [[KBModuleManager shareInstance] triggerEvent:KBModuleEventTypePerformShortcut];
}
#endif

- (void)applicationWillResignActive:(UIApplication *)application
{
    [[KBModuleManager shareInstance] triggerEvent:KBModuleEventTypeWillResignActive];
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    [[KBModuleManager shareInstance] triggerEvent:KBModuleEventTypeDidEnterBackground];
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    [[KBModuleManager shareInstance] triggerEvent:KBModuleEventTypeWillEnterForeground];
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    [[KBModuleManager shareInstance] triggerEvent:KBModuleEventTypeDidBeconmeActive];
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    [[KBModuleManager shareInstance] triggerEvent:KBModuleEventTypeWillTerminal];
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    [KBModuleContext shareInstance].openURLItem.openURL = url;
    [KBModuleContext shareInstance].openURLItem.sourceApplication = sourceApplication;
    [KBModuleContext shareInstance].openURLItem.annotation = annotation;
    [[KBModuleManager shareInstance] triggerEvent:KBModuleEventTypeOpenURL];
    return YES;
}

#if __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_9_0
- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<NSString *,id> *)options
{
    [KBModuleContext shareInstance].openURLItem.openURL = url;
    [KBModuleContext shareInstance].openURLItem.options = options;
    [[KBModuleManager shareInstance] triggerEvent:KBModuleEventTypeOpenURL];
    return YES;
}
#endif

- (void)applicationDidReceiveMemoryWarning:(UIApplication *)application
{
    [[KBModuleManager shareInstance] triggerEvent:KBModuleEventTypeDidReceiveMemoryWarning];
}

- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error
{
    [KBModuleContext shareInstance].notificationsItem.error = error;
    [[KBModuleManager shareInstance] triggerEvent:KBModuleEventTypeDidFailToRegisterForRemoteNotifications];
}

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken
{
    [KBModuleContext shareInstance].notificationsItem.deviceToken = deviceToken;
    [[KBModuleManager shareInstance] triggerEvent:KBModuleEventTypeDidRegisterForRemoteNotifications];
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo
{
    [KBModuleContext shareInstance].notificationsItem.userInfo = userInfo;
    [[KBModuleManager shareInstance] triggerEvent:KBModuleEventTypeDidReceiveRemoteNotification];
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler
{
    [KBModuleContext shareInstance].notificationsItem.userInfo = userInfo;
    [KBModuleContext shareInstance].notificationsItem.fetchCompletionHandler = completionHandler;
    [[KBModuleManager shareInstance] triggerEvent:KBModuleEventTypeDidReceiveRemoteNotification];
}

- (void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification
{
    [KBModuleContext shareInstance].notificationsItem.localNotification = notification;
    [[KBModuleManager shareInstance] triggerEvent:KBModuleEventTypeDidReceiveLocalNotification];
}

- (void)application:(UIApplication *)application didUpdateUserActivity:(NSUserActivity *)userActivity
{
    [KBModuleContext shareInstance].userActivityItem.userActivity = userActivity;
    [[KBModuleManager shareInstance] triggerEvent:KBModuleEventTypeDidUpdateUserActivity];
}

- (void)application:(UIApplication *)application didFailToContinueUserActivityWithType:(NSString *)userActivityType error:(NSError *)error
{
    [KBModuleContext shareInstance].userActivityItem.userActivityType = userActivityType;
    [KBModuleContext shareInstance].userActivityItem.error = error;
    [[KBModuleManager shareInstance] triggerEvent:KBModuleEventTypeDidFailToContinueUserActivity];
}

- (BOOL)application:(UIApplication *)application continueUserActivity:(NSUserActivity *)userActivity restorationHandler:(void (^)(NSArray * _Nullable))restorationHandler
{
    [KBModuleContext shareInstance].userActivityItem.userActivity = userActivity;
    [KBModuleContext shareInstance].userActivityItem.restorationHandler = restorationHandler;
    [[KBModuleManager shareInstance] triggerEvent:KBModuleEventTypeContinueUserActivity];
    return YES;
}

- (BOOL)application:(UIApplication *)application willContinueUserActivityWithType:(NSString *)userActivityType
{
    [KBModuleContext shareInstance].userActivityItem.userActivityType = userActivityType;
    [[KBModuleManager shareInstance] triggerEvent:KBModuleEventTypeWillContinueUserActivity];
    return YES;
}


@end
