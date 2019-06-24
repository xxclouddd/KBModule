//
//  KBModuleContext.h
//  KBModuleManager
//
//  Created by 肖雄 on 17/4/17.
//  Copyright © 2017年 xiaoxiong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "KBModuleProtocol.h"
@class KBShortcutItem;
@class KBOpenURLItem;
@class KBNotificationsItem;
@class KBUserActivityItem;

typedef NS_ENUM(NSInteger, KBEnvironment) {
    KBEnvironmentDevelop,
    KBEnvironmentProduct
};


@interface KBModuleContext : NSObject

@property (nonatomic, assign) KBEnvironment env;

@property (nonatomic, strong) UIApplication *application;
@property (nonatomic, strong) NSDictionary *launchOptions;

// customEvent >= 1000
@property (nonatomic, assign) NSInteger customEvent;

#if __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_9_0
@property (nonatomic, strong) KBShortcutItem *touchShortcutItem;  //3D-Touch
#endif
@property (nonatomic, strong) KBOpenURLItem *openURLItem; // open URL
@property (nonatomic, strong) KBNotificationsItem *notificationsItem; // notification
@property (nonatomic, strong) KBUserActivityItem *userActivityItem; // activity

+ (instancetype)shareInstance;

@end


@interface KBNotificationsItem : NSObject

@property (nonatomic, strong) NSError *error;
@property (nonatomic, strong) NSData *deviceToken;
@property (nonatomic, strong) NSDictionary *userInfo;
@property (nonatomic, copy) void(^fetchCompletionHandler)(UIBackgroundFetchResult result);
@property (nonatomic, strong) UILocalNotification *localNotification;

@end


@interface KBShortcutItem : NSObject

#if __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_9_0
@property(nonatomic, strong) UIApplicationShortcutItem *shortcutItem;
@property(nonatomic, copy) void(^completionHandler)(BOOL succeeded);
#endif

@end

@interface KBOpenURLItem : NSObject

@property (nonatomic, strong) NSURL *openURL;
@property (nonatomic, strong) NSString *sourceApplication;
@property (nonatomic, strong) id annotation;

#if __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_9_0
@property (nonatomic, strong) NSDictionary *options;
#endif

@end

@interface KBUserActivityItem : NSObject

@property (nonatomic, strong) NSString *userActivityType;
@property (nonatomic, strong) NSUserActivity *userActivity;
@property (nonatomic, strong) NSError *error;
@property (nonatomic, copy) void(^restorationHandler)(NSArray *restorableObjects);

@end




