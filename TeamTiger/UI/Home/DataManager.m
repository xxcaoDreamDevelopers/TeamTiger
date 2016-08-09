//
//  DataManager.m
//  TeamTiger
//
//  Created by Dale on 16/8/4.
//  Copyright © 2016年 MobileArtisan. All rights reserved.
//

#import "DataManager.h"
#import "HomeDetailCellModel.h"

@implementation DataManager

+ (DataManager *)mainSingleton {
    static DataManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[[self class] alloc] init];
    });
    return manager;
}

- (NSMutableArray *)dataSource {
    if (_dataSource == nil) {
        _dataSource = [NSMutableArray arrayWithCapacity:1];
        NSMutableDictionary *dic1 = [@{@"time":@"19:50", @"firstName":@"唐小旭", @"secondName":@"@卞克", @"des":@"TypeSomething...", @"firstImage":@"placeImage", @"secondImage":@"placeImage", @"typeCell":@(TypeCellImage), @"isClick":@(NO)} mutableCopy];
        HomeDetailCellModel *model1 = [[HomeDetailCellModel alloc] init];
        [model1 setValuesForKeysWithDictionary:dic1];
        [_dataSource addObject:model1];
        
        NSMutableDictionary *dic2 = [@{@"time":@"13:55", @"firstName":@"卞克", @"secondName":@"@唐小旭", @"des":@"TypeSomething...", @"firstImage":@"placeImage", @"secondImage":@"placeImage", @"typeCell":@(TypeCellTitleNoButton), @"isClick":@(NO)} mutableCopy];
        HomeDetailCellModel *model2 = [[HomeDetailCellModel alloc] init];
        [model2 setValuesForKeysWithDictionary:dic2];
        [_dataSource addObject:model2];
        
        NSMutableDictionary *dic3 = [@{@"time":@"9:00", @"firstName":@"齐云猛", @"secondName":@"", @"des":@"TypeSomething...", @"secondImage":@"placeImage", @"firstImage":@"placeImage", @"typeCell":@(TypeCellTitle), @"isClick":@(NO)} mutableCopy];
        HomeDetailCellModel *model3 = [[HomeDetailCellModel alloc] init];
        [model3 setValuesForKeysWithDictionary:dic3];
        [_dataSource addObject:model3];
        
        NSMutableDictionary *dic4 = [@{@"time":@"昨天", @"firstName":@"2016年7月18日", @"secondName":@"@唐小旭", @"des":@"TypeSomething...", @"firstImage":@"placeImage", @"secondImage":@"placeImage", @"typeCell":@(TypeCellTime), @"isClick":@(NO)} mutableCopy];
        HomeDetailCellModel *model4 = [[HomeDetailCellModel alloc] init];
        [model4 setValuesForKeysWithDictionary:dic4];
        [_dataSource addObject:model4];
        
        NSMutableDictionary *dic5 = [@{@"time":@"13:55", @"firstName":@"俞弦", @"secondName":@"", @"des":@"TypeSomething...", @"firstImage":@"placeImage", @"secondImage":@"placeImage", @"typeCell":@(TypeCellTitleNoButton), @"isClick":@(NO)} mutableCopy];
        HomeDetailCellModel *model5 = [[HomeDetailCellModel alloc] init];
        [model5 setValuesForKeysWithDictionary:dic5];
        [_dataSource addObject:model5];
        
    }
    return _dataSource;
}

@end
