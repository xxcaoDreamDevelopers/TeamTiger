//
//  CacheManager.h
//  TeamTiger
//
//  Created by xxcao on 16/8/1.
//  Copyright © 2016年 MobileArtisan. All rights reserved.
//

typedef enum : NSUInteger {
    ECacheTypeMemory = 0,
    ECacheTypeDisk,
} ECacheType;


//全局超时时长
static NSTimeInterval const gCacheTimeInterval = 6 * 60 * 60;//默认三小时

//CacheKey
static NSString *const Row_Data_Cache_Key = @"Row_Data_Cache_Key_String";
static NSString *const Section_Data_Cache_Key = @"Section_Data_Cache_Key_String";


@interface CacheManager : NSObject

@property(nonatomic,assign) ECacheType cacheType;

@property(nonatomic,strong) NSMutableDictionary *mCache;

+ (instancetype)sharedInstance;

- (id)getObjectForKey:(NSString *)key;

- (void)setObject:(id)object ForKey:(NSString *)key;

//根据时间
- (void)setObject:(id)object ForKey:(NSString *)key TimeOut:(NSTimeInterval)timeOut;

- (void)cleanCacheWithKey:(NSString *)key;

@end
