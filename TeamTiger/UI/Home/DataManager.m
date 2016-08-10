//
//  DataManager.m
//  TeamTiger
//
//  Created by Dale on 16/8/4.
//  Copyright © 2016年 MobileArtisan. All rights reserved.
//

#import "DataManager.h"
#import "HomeCellModel.h"
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
        NSMutableArray *arr1 = [NSMutableArray arrayWithCapacity:1];
        NSMutableDictionary *dic1 = [@{@"time":@"19:50", @"firstName":@"唐小旭", @"secondName":@"@卞克", @"des":@"TypeSomething...", @"firstImage":@"placeImage", @"secondImage":@"placeImage", @"typeCell":@(TypeCellImage), @"isClick":@(NO)} mutableCopy];
        HomeDetailCellModel *model1 = [[HomeDetailCellModel alloc] init];
        [model1 setValuesForKeysWithDictionary:dic1];
        [arr1 addObject:model1];
        
        NSMutableDictionary *dic2 = [@{@"time":@"13:55", @"firstName":@"卞克", @"secondName":@"@唐小旭", @"des":@"TypeSomething...", @"firstImage":@"placeImage", @"secondImage":@"placeImage", @"typeCell":@(TypeCellTitleNoButton), @"isClick":@(NO)} mutableCopy];
        HomeDetailCellModel *model2 = [[HomeDetailCellModel alloc] init];
        [model2 setValuesForKeysWithDictionary:dic2];
        [arr1 addObject:model2];
        
        NSMutableDictionary *dic3 = [@{@"time":@"9:00", @"firstName":@"齐云猛", @"secondName":@"", @"des":@"TypeSomething...", @"secondImage":@"placeImage", @"firstImage":@"placeImage", @"typeCell":@(TypeCellTitle), @"isClick":@(NO)} mutableCopy];
        HomeDetailCellModel *model3 = [[HomeDetailCellModel alloc] init];
        [model3 setValuesForKeysWithDictionary:dic3];
        [arr1 addObject:model3];
        
        NSMutableDictionary *dic4 = [@{@"time":@"昨天", @"firstName":@"2016年7月18日", @"secondName":@"@唐小旭", @"des":@"TypeSomething...", @"firstImage":@"placeImage", @"secondImage":@"placeImage", @"typeCell":@(TypeCellTime), @"isClick":@(NO)} mutableCopy];
        HomeDetailCellModel *model4 = [[HomeDetailCellModel alloc] init];
        [model4 setValuesForKeysWithDictionary:dic4];
        [arr1 addObject:model4];
        
        NSMutableDictionary *dic5 = [@{@"time":@"13:55", @"firstName":@"俞弦", @"secondName":@"", @"des":@"TypeSomething...", @"firstImage":@"placeImage", @"secondImage":@"placeImage", @"typeCell":@(TypeCellTitleNoButton), @"isClick":@(NO)} mutableCopy];
        HomeDetailCellModel *model5 = [[HomeDetailCellModel alloc] init];
        [model5 setValuesForKeysWithDictionary:dic5];
        [arr1 addObject:model5];

        
        NSMutableArray *arr2 = [NSMutableArray array];
        NSMutableDictionary *dic6 = [@{@"time":@"19:50", @"firstName":@"卞克", @"secondName":@"A", @"des":@"卞克", @"firstImage":@"placeImage", @"secondImage":@"placeImage", @"typeCell":@(TypeCellTimeAndTitle), @"isClick":@(NO)} mutableCopy];
        HomeDetailCellModel *model6 = [[HomeDetailCellModel alloc] init];
        [model6 setValuesForKeysWithDictionary:dic6];
        [arr2 addObject:model6];

        NSMutableDictionary *dic7 = [@{@"time":@"13:55", @"firstName":@"卞克", @"secondName":@"A", @"typeCell":@(TypeCellName), @"isClick":@(NO)} mutableCopy];
        HomeDetailCellModel *model7 = [[HomeDetailCellModel alloc] init];
        [model7 setValuesForKeysWithDictionary:dic7];
        [arr2 addObject:model7];
        
        NSMutableDictionary *dic8 = [@{@"time":@"9:55", @"firstName":@"唐小旭", @"secondName":@"B", @"typeCell":@(TypeCellTimeAndTitle), @"isClick":@(NO)} mutableCopy];
        HomeDetailCellModel *model8 = [[HomeDetailCellModel alloc] init];
        [model8 setValuesForKeysWithDictionary:dic8];
        [arr2 addObject:model8];

        NSMutableDictionary *mDic1 = [@{@"headImage":@"touxiang", @"name":@"唐小旭", @"type":@"工作牛", @"image1":@"placeImage", @"image2":@"placeImage", @"image3":@"placeImage", @"isClick":@(NO), @"comment":arr1} mutableCopy];
        HomeCellModel *cellModel1 = [[HomeCellModel alloc] init];
        [cellModel1 setValuesForKeysWithDictionary:mDic1];
        [_dataSource addObject:cellModel1];
        
        NSMutableDictionary *mDic2 = [@{@"headImage":@"touxiang", @"name":@"卞克", @"type":@"BBS", @"image1":@"placeImage", @"image2":@"placeImage", @"image3":@"placeImage", @"aDes":@"tape something", @"bDes":@"tape something", @"cDes":@"tape something", @"aTicket":@"0.7", @"bTicket":@"0.4", @"cTicket":@"0.1", @"isClick":@(NO), @"comment":arr2} mutableCopy];
        HomeCellModel *cellModel2 = [[HomeCellModel alloc] init];
        [cellModel2 setValuesForKeysWithDictionary:mDic2];
        [_dataSource addObject:cellModel2];
        
    }
    return _dataSource;
}

@end
