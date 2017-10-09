//
//  KBModuleProtocol.h
//  KBModuleManager
//
//  Created by 肖雄 on 17/4/17.
//  Copyright © 2017年 kuaibao. All rights reserved.
//

#import <Foundation/Foundation.h>
@class KBModuleContext;

@protocol KBModuleProtocol <NSObject>

@optional

// Negative level is only for core mudules which are serviced for other modules.
// If you think the module adding is important, cored. maybe your need to connect to the admins.
// Just set it's zero at most of time.
- (NSInteger)basicModuleLevel;
- (BOOL)async;

- (void)moduleSetup:(KBModuleContext *)context;
- (void)moduleInit:(KBModuleContext *)context;
- (void)moduleDidBecomeActive:(KBModuleContext *)context;
- (void)moduleWillResignActive:(KBModuleContext *)context;
- (void)moduleDidEnterBackground:(KBModuleContext *)context;
- (void)moduleWillEnterForeground:(KBModuleContext *)context;
- (void)moduleWillTerminal:(KBModuleContext *)context;
- (void)moduleDidReceiveMemoryWarning:(KBModuleContext *)context;
- (void)modulePerformShortcut:(KBModuleContext *)context;
- (void)moduleOpenURL:(KBModuleContext *)context;
- (void)moduleDidFailToRegisterForRemoteNotifications:(KBModuleContext *)context;
- (void)moduleDidRegisterForRemoteNotifications:(KBModuleContext *)context;
- (void)moduleDidReceiveRemoteNotification:(KBModuleContext *)context;
- (void)moduleDidReceiveLocalNotification:(KBModuleContext *)context;
- (void)moduleDidUpdateUserActivity:(KBModuleContext *)context;
- (void)moduleDidFailToContinueUserActivity:(KBModuleContext *)context;
- (void)moduleContinueUserActivity:(KBModuleContext *)context;
- (void)moduleWillContinueUserActivity:(KBModuleContext *)context;
- (void)moduleDidCustomEvent:(KBModuleContext *)context;

@end
