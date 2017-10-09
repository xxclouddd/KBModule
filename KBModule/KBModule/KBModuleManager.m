//
//  KBModuleManager.m
//  KBModuleManager
//
//  Created by 肖雄 on 17/4/17.
//  Copyright © 2017年 kuaibao. All rights reserved.
//

#import "KBModuleManager.h"

static NSMutableArray *_KBModules = nil;

@interface KBModuleManager ()

@end

@implementation KBModuleManager

+ (instancetype)shareInstance
{
    static KBModuleManager *shareInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shareInstance = [[KBModuleManager alloc] init];
    });
    return shareInstance;
}

- (instancetype)init
{
    if ((self = [super init]) == nil) return nil;
    
    [self registerAllModules];
    
    return self;
}

+ (void)registerDynamicModule:(Class)moduleClass
{
    if (!moduleClass) return;
    
    NSString *moduleName = NSStringFromClass(moduleClass);
    
    if ([moduleClass conformsToProtocol:@protocol(KBModuleProtocol)]) {
        [[self KBModules] addObject:moduleName];
    }
}

- (void)registerAllModules
{
    NSMutableArray *array = [NSMutableArray array];
    
    [_KBModules enumerateObjectsUsingBlock:^(NSString *  _Nonnull className, NSUInteger idx, BOOL * _Nonnull stop) {
        Class moduleClass = NSClassFromString(className);
        if (NSStringFromClass(moduleClass)) {
            id<KBModuleProtocol>instance = [[moduleClass alloc] init];
            [array addObject:instance];
        }
    }];
    
    [array sortUsingComparator:^NSComparisonResult(id<KBModuleProtocol>  _Nonnull obj1, id<KBModuleProtocol>  _Nonnull obj2) {
        NSInteger obj1Level = 0;
        if ([obj1 respondsToSelector:@selector(basicModuleLevel)]) {
            obj1Level = [obj1 basicModuleLevel];
        }
        
        NSInteger obj2Level = 0;
        if ([obj2 respondsToSelector:@selector(basicModuleLevel)]) {
            obj2Level = [obj2 basicModuleLevel];
        }

        return obj1Level > obj2Level;
    }];
    
    [_KBModules removeAllObjects];
    
    [_KBModules addObjectsFromArray:array];
}

- (void)triggerEvent:(KBModuleEventType)eventType
{
    switch (eventType) {
        case KBModuleEventTypeSetup:
            [self handleModuleEvent:@"moduleSetup:"];
            break;
        case KBModuleEventTypeInit:
            [self handleModulesInitEvent];
            break;
        case KBModuleEventTypeDidBeconmeActive:
            [self handleModuleEvent:@"moduleDidBecomeActive:"];
            break;
        case KBModuleEventTypeWillResignActive:
            [self handleModuleEvent:@"moduleWillResignActive:"];
            break;
        case KBModuleEventTypeDidEnterBackground:
            [self handleModuleEvent:@"moduleDidEnterBackground:"];
            break;
        case KBModuleEventTypeWillEnterForeground:
            [self handleModuleEvent:@"moduleWillEnterForeground:"];
            break;
        case KBModuleEventTypeWillTerminal:
            [self handleModuleEvent:@"moduleWillTerminal:"];
            break;
        case KBModuleEventTypeDidReceiveMemoryWarning:
            [self handleModuleEvent:@"moduleDidReceiveMemoryWarning:"];
            break;
        case KBModuleEventTypePerformShortcut:
            [self handleModuleEvent:@"modulePerformShortcut:"];
            break;
        case KBModuleEventTypeOpenURL:
            [self handleModuleEvent:@"moduleOpenURL:"];
            break;
        case KBModuleEventTypeDidFailToRegisterForRemoteNotifications:
            [self handleModuleEvent:@"moduleDidFailToRegisterForRemoteNotifications:"];
            break;
        case KBModuleEventTypeDidRegisterForRemoteNotifications:
            [self handleModuleEvent:@"moduleDidRegisterForRemoteNotifications:"];
            break;
        case KBModuleEventTypeDidReceiveRemoteNotification:
            [self handleModuleEvent:@"moduleDidReceiveRemoteNotification:"];
            break;
        case KBModuleEventTypeDidReceiveLocalNotification:
            [self handleModuleEvent:@"moduleDidReceiveLocalNotification:"];
            break;
        case KBModuleEventTypeDidUpdateUserActivity:
            [self handleModuleEvent:@"moduleDidUpdateUserActivity:"];
            break;
        case KBModuleEventTypeDidFailToContinueUserActivity:
            [self handleModuleEvent:@"moduleDidFailToContinueUserActivity:"];
            break;
        case KBModuleEventTypeContinueUserActivity:
            [self handleModuleEvent:@"moduleContinueUserActivity:"];
            break;
        case KBModuleEventTypeWillContinueUserActivity:
            [self handleModuleEvent:@"moduleWillContinueUserActivity:"];
            break;
        default:
            [KBModuleContext shareInstance].customEvent = eventType;
            [self handleModuleEvent:@"moduleDidCustomEvent:"];
            break;
    }
}

- (void)triggerCustomEvent:(NSInteger)eventType
{
    if(eventType < 1000) return;
    [self triggerEvent:eventType];
}

- (void)handleModuleEvent:(NSString *)selectorStr
{
    SEL seletor = NSSelectorFromString(selectorStr);
    [_KBModules enumerateObjectsUsingBlock:^(id<KBModuleProtocol> moduleInstance, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([moduleInstance respondsToSelector:seletor]) {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
            [moduleInstance performSelector:seletor withObject:[KBModuleContext shareInstance]];
#pragma clang diagnostic pop
        }
    }];
}

- (void)handleModulesInitEvent
{
    [_KBModules enumerateObjectsUsingBlock:^(id<KBModuleProtocol> moduleInstance, NSUInteger idx, BOOL * _Nonnull stop) {
        __weak typeof(&*self) wself = self;
        void ( ^ bk )();
        bk = ^(){
            __strong typeof(&*self) sself = wself;
            if (sself) {
                if ([moduleInstance respondsToSelector:@selector(moduleInit:)]) {
                    [moduleInstance moduleInit:[KBModuleContext shareInstance]];
                }
            }
        };
        
        if ([moduleInstance respondsToSelector:@selector(async)]) {
            BOOL async = [moduleInstance async];
            
            if (async) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    bk();
                });
                
            } else {
                bk();
            }
        } else {
            bk();
        }
    }];
}

#pragma mark - setter and getter

+ (NSMutableArray *)KBModules
{
    if (_KBModules == nil) {
        _KBModules = [NSMutableArray array];
    }
    return _KBModules;
}


@end
