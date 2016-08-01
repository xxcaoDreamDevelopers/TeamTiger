//
//  HomeCellModel.m
//  TeamTiger
//
//  Created by Dale on 16/8/1.
//  Copyright © 2016年 MobileArtisan. All rights reserved.
//

#import "HomeCellModel.h"

@implementation HomeCellModel

- (NSMutableArray *)dataArr {
    if (_dataArr) {
        _dataArr = [NSMutableArray array];
    }
    return _dataArr;
}

@end
