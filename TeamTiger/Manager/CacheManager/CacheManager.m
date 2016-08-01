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
            singleton.cacheType = ECacheTypeDisk;
            singleton.mCache = [NSMutableDictionary dictionary];
        }
    });
    return singleton;
}

- (id)getObjectForKey:(NSString *)key {
    if (!key || key.length == 0) {
        return nil;
    }
    if(self.cacheType == ECacheTypeMemory) {
        return [self.mCache objectForKey:key];
    } else {
        id object = UserDefaultsGet(key);
        
        NSString *dateKey = [NSString stringWithFormat:@"%@_Date",key];
        NSDate *dateObj = UserDefaultsGet(dateKey);
        
        NSString *timeInterValKey = [NSString stringWithFormat:@"%@_TimeInterval",key];
        NSNumber *timeIntervalObj = UserDefaultsGet(timeInterValKey);
        
        NSDate *now = [NSDate date];
        BOOL isTimeOut = now.timeIntervalSince1970 - dateObj.timeIntervalSince1970 >= timeIntervalObj.doubleValue;
        if (dateObj && timeIntervalObj && isTimeOut) {
            //缓存失效
            [self cleanCacheWithKey:key];
            [self cleanCacheWithKey:dateKey];
            [self cleanCacheWithKey:timeInterValKey];
            return nil;
        } else {
            if ([object isKindOfClass:[NSData class]]) {
                return [NSKeyedUnarchiver unarchiveObjectWithData:object];
            }
            else if ([object isKindOfClass:[NSArray class]]) {
                NSMutableArray *tmpArray = [NSMutableArray array];
                for (id obj in object) {
                    if ([obj isKindOfClass:[NSData class]]) {
                        id tmpObj = [NSKeyedUnarchiver unarchiveObjectWithData:obj];
                        [tmpArray addObject:tmpObj];
                    } else if ([obj isKindOfClass:[NSArray class]]) {
                        NSMutableArray *mObjs = [NSMutableArray array];
                        for (id model in obj) {
                            if ([model isKindOfClass:[NSData class]]) {
                                id tmpModel = [NSKeyedUnarchiver unarchiveObjectWithData:model];
                                [mObjs addObject:tmpModel];
                            } else {
                                [mObjs addObject:model];
                            }
                        }
                        [tmpArray addObject:mObjs];
                    } else {
                        [tmpArray addObject:obj];
                    }
                }
                return tmpArray;
            }
            else if ([object isKindOfClass:[NSDictionary class]]) {
                NSMutableDictionary *tmpDic = [NSMutableDictionary dictionary];
                [object enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
                    if ([obj isKindOfClass:[NSData class]]) {
                        id tmpObj = [NSKeyedUnarchiver unarchiveObjectWithData:obj];
                        tmpDic[key] = tmpObj;
                    } else {
                        tmpDic[key] = obj;
                    }
                }];
            }
            return object;
        }
    }
}

- (void)setObject:(id)object ForKey:(NSString *)key {
    if (!key || key.length == 0 || !object) {
        return;
    }
    if(self.cacheType == ECacheTypeMemory) {
        [self.mCache setObject:object forKey:key];
    } else {
        UserDefaultsSave(object, key);
    }
}

//根据时间
- (void)setObject:(id)object ForKey:(NSString *)key TimeOut:(NSTimeInterval)timeOut {
    if(timeOut <= 0){
        return;
    }
    [self setObject:object ForKey:key];
    
    if (self.cacheType == ECacheTypeMemory) {
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
    } else {
        NSString *dateKey = [NSString stringWithFormat:@"%@_Date",key];
        UserDefaultsSave([NSDate date], dateKey);

        NSString *timeInterValKey = [NSString stringWithFormat:@"%@_TimeInterval",key];
        UserDefaultsSave(@(timeOut), timeInterValKey);
    }
}

- (void)cleanCacheWithKey:(NSString *)key {
    if (!key || key.length == 0) {
        return;
    }
    if(self.cacheType == ECacheTypeMemory) {
        [self.mCache removeObjectForKey:key];
    } else {
        UserDefaultsRemove(key);
    }
}

@end
