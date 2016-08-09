//
//  CirclesManager.m
//  TeamTiger
//
//  Created by 刘鵬 on 16/8/9.
//  Copyright © 2016年 MobileArtisan. All rights reserved.
//

#import "CirclesManager.h"

@implementation CirclesManager



//static NSMutableArray *circles = nil;
+ (CirclesManager *)sharedInstance {
    
    static CirclesManager *circlesManager;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        circlesManager = [[self alloc] init];
    });
    
    return circlesManager;
}

- (void)loadingGlobalCirclesInfo {
    self.circles = [NSMutableArray arrayWithArray:@[@"所有项目",@"工作牛",@"易会",@"MPP",@"营配"]];
    self.selectIndex = 0;
    self.selectCircle = self.circles[_selectIndex];
}

- (void)addCircle:(NSString *)circle {

}

- (void)delectCircleWithIndex:(NSInteger)index OrTitle:(NSString *)title {

}

- (void)setSelectIndex:(NSInteger)selectIndex {
    if (self.circles.count > selectIndex ) {
        _selectIndex = selectIndex;
        self.selectCircle = self.circles[selectIndex];
    } else
    {
        NSAssert(NO, @"set SelectIndex error.");
    }
}

//-(NSMutableArray *)circles{
//    if (!_circles) {
//        _circles = [[NSMutableArray alloc] init];
//    }
//    return _circles;
//}
@end
