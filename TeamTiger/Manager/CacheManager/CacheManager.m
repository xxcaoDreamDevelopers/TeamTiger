//
//  CacheManager.m
//  TeamTiger
//
//  Created by xxcao on 16/8/1.
//  Copyright © 2016年 MobileArtisan. All rights reserved.
//

#import "CacheManager.h"
#import "NSTimer+HYBHelperKit.h"
@implementation CacheManager

static CacheManager *singleton = nil;
+ (instancetype)sharedInstance {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (!singleton) {
            singleton = [[[self class] alloc] init];
            singleton.mCache = [NSMutableDictionary dictionary];
        }
    });
    return singleton;
}

- (id)getObjectForKey:(NSString *)key {
    if (!key || key.length == 0) {
        return nil;
    }
    return [self.mCache objectForKey:key];
}

- (void)setObject:(id)object ForKey:(NSString *)key {
    if (!key || key.length == 0 || !object) {
        return;
    }
    [self.mCache setObject:object forKey:key];
}

//根据时间
- (void)setObject:(id)object ForKey:(NSString *)key TimeOut:(NSTimeInterval)timeOut {
    if(timeOut <= 0){
        return;
    }
    [self setObject:object ForKey:key];
    //自动计时
    __block NSTimeInterval tmpTimerInterval = timeOut;
    [NSTimer hyb_scheduledTimerWithTimeInterval:1.0 repeats:YES callback:^(NSTimer *timer) {
        if (tmpTimerInterval <= 0) {
            //
            [self cleanCacheWithKey:key];
            [timer hyb_invalidate];
        }
        tmpTimerInterval--;
    }];
}

- (void)cleanCacheWithKey:(NSString *)key {
    if (!key || key.length == 0) {
        return;
    }
    [self.mCache removeObjectForKey:key];
}

@end
