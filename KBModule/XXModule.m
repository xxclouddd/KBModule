//
//  XXModule.m
//  KBModuleManager
//
//  Created by 肖雄 on 17/4/17.
//  Copyright © 2017年 xiaoxiong. All rights reserved.
//

#import "XXModule.h"
#import "KBModuleManager.h"

@implementation XXModule

+ (void)load
{
    [KBModuleManager registerDynamicModule:self];
}

- (void)moduleInit:(KBModuleContext *)context
{
    NSLog(@"XX module init");
}

- (void)moduleSetup:(KBModuleContext *)context
{
    NSLog(@"XX module setup");
}

@end
