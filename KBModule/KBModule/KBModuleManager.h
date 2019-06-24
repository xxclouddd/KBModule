//
//  KBModuleManager.h
//  KBModuleManager
//
//  Created by 肖雄 on 17/4/17.
//  Copyright © 2017年 xiaoxiong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "KBModuleProtocol.h"
#import "KBModuleContext.h"

#define KB_EXPORT_MODULE(isAsync) \
+ (void)load { [KBModuleManager registerDynamicModule:self]; } \
-(BOOL)async { return [[NSString stringWithUTF8String:#isAsync] boolValue];}


typedef NS_ENUM(NSInteger, KBModuleEventType)
{
    KBModuleEventTypeSetup = 0,
    KBModuleEventTypeInit,
    KBModuleEventTypeDidBeconmeActive,
    KBModuleEventTypeWillResignActive,
    KBModuleEventTypeDidEnterBackground,
    KBModuleEventTypeWillEnterForeground,
    KBModuleEventTypeWillTerminal,
    KBModuleEventTypeDidReceiveMemoryWarning,
    KBModuleEventTypePerformShortcut,
    KBModuleEventTypeOpenURL,
    KBModuleEventTypeDidFailToRegisterForRemoteNotifications,
    KBModuleEventTypeDidRegisterForRemoteNotifications,
    KBModuleEventTypeDidReceiveRemoteNotification,
    KBModuleEventTypeDidReceiveLocalNotification,
    KBModuleEventTypeDidUpdateUserActivity,
    KBModuleEventTypeDidFailToContinueUserActivity,
    KBModuleEventTypeContinueUserActivity,
    KBModuleEventTypeWillContinueUserActivity,

    KBModuleEventTypeCustom = 1000
};

@interface KBModuleManager : NSObject

+ (instancetype)shareInstance;

+ (void)registerDynamicModule:(Class)moduleClass;

- (void)triggerEvent:(KBModuleEventType)eventType;
- (void)triggerCustomEvent:(NSInteger)eventType;

@end
