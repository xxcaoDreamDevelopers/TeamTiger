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

@interface DataManager ()

@property (strong, nonatomic) NSArray *dataArr;

@end

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
        _dataSource = [NSMutableArray array];
        for (NSDictionary *dic in self.dataArr) {
            HomeCellModel *model = [HomeCellModel modelWithDic:dic];
            [_dataSource addObject:model];
        }
    }
    return _dataSource;
}

- (NSArray *)dataArr {
    if (_dataArr == nil) {
        _dataArr = @[
                     @{@"headImage":@"touxiang",
                       @"name":@"唐小旭",
                       @"type":@"工作牛",
                       @"image1":@"placeImage",
                       @"image2":@"placeImage",
                       @"image3":@"placeImage",
                       @"comment":@[
                               @{@"time":@"19:50",
                                 @"firstName":@"唐小旭",
                                 @"secondName":@"@卞克",
                                 @"des":@"TypeSomething...",
                                 @"firstImage":@"placeImage",
                                 @"secondImage":@"placeImage",
                                 @"typeCell":@(TypeCellImage)
                                 },
                               @{@"time":@"13:55",
                                 @"firstName":@"卞克",
                                 @"secondName":@"@唐小旭",
                                 @"des":@"TypeSomething...",
                                 @"firstImage":@"placeImage",
                                 @"secondImage":@"placeImage",
                                 @"typeCell":@(TypeCellTitleNoButton)
                                 },
                               @{@"time":@"9:00",
                                 @"firstName":@"齐云猛",
                                 @"secondName":@"",
                                 @"des":@"TypeSomething...",
                                 @"secondImage":@"placeImage",
                                 @"firstImage":@"placeImage",
                                 @"typeCell":@(TypeCellTitle)
                                 },
                               @{@"time":@"昨天",
                                 @"firstName":@"2016年7月18日",
                                 @"secondName":@"@唐小旭",
                                 @"des":@"TypeSomething...",
                                 @"firstImage":@"placeImage",
                                 @"secondImage":@"placeImage",
                                 @"typeCell":@(TypeCellTime)
                                 },
                               @{@"time":@"13:55",
                                 @"firstName":@"俞弦",
                                 @"secondName":@"",
                                 @"des":@"TypeSomething...",
                                 @"firstImage":@"placeImage",
                                 @"secondImage":@"placeImage",
                                 @"typeCell":@(TypeCellTitleNoButton),
                                 },
                               ].mutableCopy
                       },
                     @{@"headImage":@"touxiang",
                       @"name":@"卞克",
                       @"type":@"BBS",
                       @"image1":@"placeImage",
                       @"image2":@"placeImage",
                       @"image3":@"placeImage",
                       @"aDes":@"tape something",
                       @"bDes":@"tape something",
                       @"cDes":@"tape something",
                       @"aTicket":@"0.7",
                       @"bTicket":@"0.4",
                       @"cTicket":@"0.1",
                       @"comment":@[
                               @{@"time":@"19:50",
                                 @"firstName":@"卞克",
                                 @"secondName":@"A",
                                 @"des":@"卞克",
                                 @"firstImage":@"placeImage",
                                 @"secondImage":@"placeImage",
                                 @"typeCell":@(TypeCellTimeAndTitle)
                                 },
                               @{@"time":@"13:55",
                                 @"firstName":@"卞克",
                                 @"secondName":@"A",
                                 @"typeCell":@(TypeCellName)
                                 },
                               @{@"time":@"9:55",
                                 @"firstName":@"唐小旭",
                                 @"secondName":@"B",
                                 @"typeCell":@(TypeCellTimeAndTitle)
                                 }].mutableCopy
                       }
                     ].mutableCopy;
    }
    return _dataArr;
}



@end
