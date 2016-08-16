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

//通过长宽和最小长度获取改变后的长宽
+ (CGSize)sizeWith:(CGSize)oldSize withMin:(CGFloat)minLen {
    BOOL isWidth = YES;
    if (oldSize.height < oldSize.width) {
        isWidth = NO;
    }
    CGFloat minOfsize = MIN(oldSize.height, oldSize.width);
    CGFloat scale = minOfsize / minLen;
    
    CGSize retSize;
    
    if (isWidth) {
        retSize.width = minLen;
        retSize.height = oldSize.height / scale;
    } else {
        retSize.height = minLen;
        retSize.width = oldSize.width / scale;
    }
    
    return  retSize;
}

//改变图片大小
+ (UIImage*)scaleImage:(UIImage*)image
                toSize:(CGSize)newSize {
    UIGraphicsBeginImageContext(newSize);
    [image drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

+ (UIImage*)imageByScalingAndCroppingForSize:(UIImage*)anImage toSize:(CGSize)targetSize
{
    UIImage* sourceImage = anImage;
    UIImage* newImage = nil;
    CGSize imageSize = sourceImage.size;
    CGFloat width = imageSize.width;
    CGFloat height = imageSize.height;
    CGFloat targetWidth = targetSize.width;
    CGFloat targetHeight = targetSize.height;
    CGFloat scaleFactor = 0.0;
    CGFloat scaledWidth = targetWidth;
    CGFloat scaledHeight = targetHeight;
    CGPoint thumbnailPoint = CGPointMake(0.0, 0.0);
    
    if (CGSizeEqualToSize(imageSize, targetSize) == NO) {
        CGFloat widthFactor = targetWidth / width;
        CGFloat heightFactor = targetHeight / height;
        
        if (widthFactor > heightFactor) {
            scaleFactor = widthFactor; // scale to fit height
        } else {
            scaleFactor = heightFactor; // scale to fit width
        }
        scaledWidth = width * scaleFactor;
        scaledHeight = height * scaleFactor;
        
        // center the image
        if (widthFactor > heightFactor) {
            thumbnailPoint.y = (targetHeight - scaledHeight) * 0.5;
        } else if (widthFactor < heightFactor) {
            thumbnailPoint.x = (targetWidth - scaledWidth) * 0.5;
        }
    }
    
    UIGraphicsBeginImageContext(targetSize); // this will crop
    
    CGRect thumbnailRect = CGRectZero;
    thumbnailRect.origin = thumbnailPoint;
    thumbnailRect.size.width = scaledWidth;
    thumbnailRect.size.height = scaledHeight;
    
    [sourceImage drawInRect:thumbnailRect];
    
    newImage = UIGraphicsGetImageFromCurrentImageContext();
    if (newImage == nil) {
        NSLog(@"could not scale image");
    }
    
    // pop the context to get back to the default
    UIGraphicsEndImageContext();
    return newImage;
}


//等比压缩图片
+ (UIImage *)scaleImage:(UIImage *)image
                toScale:(CGFloat)scaleSize {
    UIGraphicsBeginImageContext(CGSizeMake(image.size.width * scaleSize, image.size.height * scaleSize));
    [image drawInRect:CGRectMake(0, 0, image.size.width * scaleSize, image.size.height * scaleSize)];
    UIImage *scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return scaledImage;
}

//截屏成UIImageView图片
+ (UIImageView *)cutScreenImage {
    UIGraphicsBeginImageContextWithOptions(SingletonApplication.keyWindow.frame.size, NO, 0);
    CGContextRef context = UIGraphicsGetCurrentContext();
    [SingletonApplication.keyWindow.layer renderInContext:context];
    UIImage *cutImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    UIImageView *imgV = [[UIImageView alloc] initWithFrame:SingletonApplication.keyWindow.bounds];
    imgV.image = cutImage;
    return imgV;
}


//绘制圆形Image
+ (UIImage*)circleImage:(UIImage*)image withParam:(CGFloat) inset {
    UIGraphicsBeginImageContext(image.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(context, 2);
    CGContextSetStrokeColorWithColor(context, [UIColor clearColor].CGColor);
    CGRect rect = CGRectMake(inset, inset, image.size.width - inset * 2.0f, image.size.height - inset * 2.0f);
    CGContextAddEllipseInRect(context, rect);
    CGContextClip(context);
    
    [image drawInRect:rect];
    CGContextAddEllipseInRect(context, rect);
    CGContextStrokePath(context);
    UIImage *newimg = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newimg;
}

//生成自己绘制的图片
+ (UIImage *)drawImageSize:(CGSize)size
                     Color:(UIColor *)color {
    UIGraphicsBeginImageContextWithOptions(size, 0, [UIScreen mainScreen].scale);
    [color set];
    UIRectFill(Frame(0, 0, size.width, size.height));
    UIImage *resImg = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return resImg;
}


//根据16进制显示颜色
+ (UIColor *)colorFromHexRGB:(NSString *)inColorString {
    UIColor *result = nil;
    unsigned int colorCode = 0;
    unsigned char redByte, greenByte, blueByte;
    if (![Common isEmptyString:inColorString]) {
        NSScanner *scanner = [NSScanner scannerWithString:inColorString];
        (void) [scanner scanHexInt:&colorCode]; // ignore error
    }
    redByte = (unsigned char) (colorCode >> 16);
    greenByte = (unsigned char) (colorCode >> 8);
    blueByte = (unsigned char) (colorCode); // masks off high bits
    result = [UIColor
              colorWithRed: (float)redByte / 0xff
              green: (float)greenByte/ 0xff
              blue: (float)blueByte / 0xff
              alpha: 1.0];
    return result;
}

@end
