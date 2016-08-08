//
//  SelectPhotosManger.h
//  TeamTiger
//
//  Created by 刘鵬 on 16/8/8.
//  Copyright © 2016年 MobileArtisan. All rights reserved.
//

#import <Foundation/Foundation.h>

//CacheKey
static NSString *const SelectPhotoes_Cache_Key = @"SelectPhotoes_Cache_Key_String";
static NSString *const SelectAssets_Cache_Key = @"SelectAssets_Cache_Key_String";
@interface SelectPhotosManger : NSObject
+ (instancetype)sharedInstance;
- (id)getPhotoes;
- (void)setSelectPhotoes:(NSMutableArray *)photoes;
- (void)cleanSelectPhotoes;

- (void)addImage:(id)image;
- (void)deletePhotoeWithIndex:(NSInteger) index;

- (id)getAssets;
- (void)setSelectAssets:(NSMutableArray *)assets;
- (void)cleanSelectAssets;

- (void)addAsset:(id)asset;
- (void)deleteAssetWithIndex:(NSInteger) index;
@end
