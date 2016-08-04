//
//  Common.m
//  TeamTiger
//
//  Created by xxcao on 16/7/28.
//  Copyright © 2016年 MobileArtisan. All rights reserved.
//

#import "Common.h"

@implementation Common

//去除UITableView多余分割线
+ (void)removeExtraCellLines:(UITableView *)tableView {
    UIView *view = [UIView new];
    view.backgroundColor = [UIColor clearColor];
    view.opaque = NO;
    [tableView setTableFooterView:view];
}

//字符串为空检查
+ (BOOL)isEmptyString:(NSString *)sourceStr {
    if ((NSNull *)sourceStr == [NSNull null]) {
        return YES;
    }
    if (sourceStr == nil) {
        return YES;
    }
    if (sourceStr == NULL) {
        return YES;
    }
    if ([sourceStr isEqual:[NSNull null]]) {
        return YES;
    }
    if (![sourceStr isKindOfClass:[NSString class]]) {
        return YES;
    }
    if([sourceStr isEqualToString:@"<null>"]){
        return YES;
    }
    if ([sourceStr isEqualToString:@"null"]) {
        return YES;
    }
    if ([sourceStr isEqualToString:@""]) {
        return YES;
    }
    if (sourceStr.length == 0) {
        return YES;
    }
    return NO;
}


//自定义push动画
+ (void)customPushAnimationFromNavigation:(UINavigationController *)nav ToViewController:(UIViewController *)vc Type:(NSString *)animationType SubType:(NSString *)subType{
    CATransition *transition = [CATransition animation];
    transition.duration = 0.3f;
    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    transition.type = animationType;
    transition.subtype = subType;
    [nav.view.layer addAnimation:transition forKey:nil];
    [nav pushViewController:vc animated:NO];
}

//自定义pop动画
+ (void)customPopAnimationFromNavigation:(UINavigationController *)nav Type:(NSString *)animationType SubType:(NSString *)subType{
    CATransition *transition = [CATransition animation];
    transition.duration = 0.3f;
    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    transition.type = animationType;
    transition.subtype = subType;
    [nav.view.layer addAnimation:transition forKey:nil];
    [nav popViewControllerAnimated:NO];
}

/*
 animation.type = kCATransitionFade;
 animation.type = kCATransitionPush;
 animation.type = kCATransitionReveal;
 animation.type = kCATransitionMoveIn;
 animation.type = @"cube";
 animation.type = @"suckEffect";
 animation.type = @"oglFlip";
 animation.type = @"rippleEffect";
 animation.type = @"pageCurl";
 animation.type = @"pageUnCurl";
 animation.type = @"cameraIrisHollowOpen";
 animation.type = @"cameraIrisHollowClose";
 
 
 CA_EXTERN NSString * const kCATransitionFromRight
 __OSX_AVAILABLE_STARTING (__MAC_10_5, __IPHONE_2_0);
 CA_EXTERN NSString * const kCATransitionFromLeft
 __OSX_AVAILABLE_STARTING (__MAC_10_5, __IPHONE_2_0);
 CA_EXTERN NSString * const kCATransitionFromTop
 __OSX_AVAILABLE_STARTING (__MAC_10_5, __IPHONE_2_0);
 CA_EXTERN NSString * const kCATransitionFromBottom
 __OSX_AVAILABLE_STARTING (__MAC_10_5, __IPHONE_2_0);

 */

@end
