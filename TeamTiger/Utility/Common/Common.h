//
//  Common.h
//  TeamTiger
//
//  Created by xxcao on 16/7/28.
//  Copyright © 2016年 MobileArtisan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Common : NSObject

//去除UITableView多余分割线
+ (void)removeExtraCellLines:(UITableView *)tableView;

//字符串为空检查
+ (BOOL)isEmptyString:(NSString *)sourceStr;


//自定义push动画
+ (void)customPushAnimationFromNavigation:(UINavigationController *)nav ToViewController:(UIViewController *)vc Type:(NSString *)animationType SubType:(NSString *)subType;
//自定义pop动画
+ (void)customPopAnimationFromNavigation:(UINavigationController *)nav Type:(NSString *)animationType SubType:(NSString *)subType;

//根据16进制显示颜色
+ (UIColor *)colorFromHexRGB:(NSString *)inColorString;

//scale图片
+ (UIImage *)scaleImage:(UIImage*)image
                 toSize:(CGSize)newSize;

+ (UIImage*)imageByScalingAndCroppingForSize:(UIImage*)anImage toSize:(CGSize)targetSize;

//等比压缩图片
+ (UIImage *)scaleImage:(UIImage *)image
                toScale:(CGFloat)scaleSize;

//截屏成UImageView
+ (UIImageView *)cutScreenImage;

//通过长宽和最小长度获取改变后的长宽
+ (CGSize)sizeWith:(CGSize)oldSize withMin:(CGFloat)minLen;

//绘制圆形图片
+ (UIImage *)circleImage:(UIImage*)image withParam:(CGFloat)inset;

//生成绘制图片
+ (UIImage *)drawImageSize:(CGSize)size
                     Color:(UIColor *)color;

@end
