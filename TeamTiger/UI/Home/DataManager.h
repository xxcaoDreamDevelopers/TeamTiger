//
//  DataManager.h
//  TeamTiger
//
//  Created by Dale on 16/8/4.
//  Copyright © 2016年 MobileArtisan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DataManager : NSObject

+ (DataManager *)mainSingleton;
@property (strong, nonatomic) NSMutableArray *dataSource;

@property (strong, nonatomic) NSIndexPath *indexPath;
@property (assign, nonatomic) NSInteger index;
@property (assign, nonatomic) NSInteger index1;
@property (assign, nonatomic) CGFloat height;


@end
