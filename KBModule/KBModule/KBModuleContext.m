//
//  KBModuleContext.m
//  KBModuleManager
//
//  Created by 肖雄 on 17/4/17.
//  Copyright © 2017年 kuaibao. All rights reserved.
//

#import "KBModuleContext.h"

@interface KBModuleContext ()

@end

@implementation KBModuleContext

+ (instancetype)shareInstance
{
    static KBModuleContext *shareInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shareInstance = [[KBModuleContext alloc] init];
    });
    return shareInstance;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_9_0
        self.touchShortcutItem = [KBShortcutItem new];
#endif
        self.openURLItem = [KBOpenURLItem new];
        self.notificationsItem = [KBNotificationsItem new];
        self.userActivityItem = [KBUserActivityItem new];
    }
    return self;
}

@end


@implementation KBNotificationsItem

@end


@implementation KBShortcutItem

@end

@implementation KBOpenURLItem

@end

@implementation KBUserActivityItem

@end
