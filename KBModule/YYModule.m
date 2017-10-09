//
//  YYModule.m
//  KBModuleManager
//
//  Created by 肖雄 on 17/4/17.
//  Copyright © 2017年 kuaibao. All rights reserved.
//

#import "YYModule.h"
#import "KBModuleManager.h"

@implementation YYModule

KB_EXPORT_MODULE(NO)

- (void)moduleInit:(KBModuleContext *)context
{
    NSLog(@"YY module init");
}

- (void)moduleSetup:(KBModuleContext *)context
{
    NSLog(@"YY module setup");
}

- (NSInteger)basicModuleLevel
{
    return 10;
}

- (void)moduleWillTerminal:(KBModuleContext *)context
{
    NSLog(@"YY will terminal");
}

- (void)moduleWillEnterForeground:(KBModuleContext *)context
{
    NSLog(@"YY will enter foreground");
}


@end
