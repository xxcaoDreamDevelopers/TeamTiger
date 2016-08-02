//
//  HomeDetailCellModel.m
//  TeamTiger
//
//  Created by Dale on 16/8/1.
//  Copyright © 2016年 MobileArtisan. All rights reserved.
//

#import "HomeDetailCellModel.h"

@implementation HomeDetailCellModel

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    
}

- (void)setValue:(id)value forKey:(NSString *)key {
    [super setValue:value forKey:key];
    if ([key isEqualToString:[NSString stringWithFormat:@"%ld", self.typeCell]]) {
        self.typeCell = [value integerValue];
    }
}

@end
