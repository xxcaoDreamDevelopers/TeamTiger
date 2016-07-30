//
//  Macros.h
//  TeamTiger
//
//  Created by xxcao on 16/7/19.
//  Copyright © 2016年 MobileArtisan. All rights reserved.
//

#ifndef Macros_h
#define Macros_h

//View相关
#define Point(Xpos, Ypos)                  CGPointMake(Xpos, Ypos)
#define Size(Width, Height)                CGSizeMake(Width, Height)
#define Frame(Xpos, Ypos, Width, Height)   CGRectMake(Xpos, Ypos, Width, Height)
#define Xpos                               origin.x
#define Ypos                               origin.y
#define Width                              size.width
#define Height                             size.height

//frame相关
#define SetFrameByXPos(frame,xpos)        {CGRect rect = frame; rect.origin.x = xpos; frame = rect;}
#define SetFrameByYPos(frame,ypos)        {CGRect rect = frame; rect.origin.y = ypos; frame = rect;}
#define SetFrameByWidth(frame,kWidth)     {CGRect rect = frame; rect.size.width = kWidth; frame = rect;}
#define SetFrameByHeight(frame,kHeight)   {CGRect rect = frame; rect.size.height = kHeight; frame = rect;}

//Window相关
#define Screen_Width                 [UIScreen mainScreen].bounds.size.width
#define Screen_Height                [UIScreen mainScreen].bounds.size.height

//弧度与角度的转换
#define DegreeToRadian(X)            ((X) * M_PI / 180.0)
#define RadianToDegree(Radian)       ((Radian) * 180.0 / M_PI)

//设置View圆角
#define setViewCorner(view,radius)   {view.layer.cornerRadius = radius; view.layer.masksToBounds = YES;}

//设置View圆角加边框
#define setViewCornerAndBorder(view,radius)   {view.layer.cornerRadius = radius; view.layer.masksToBounds = YES; view.layer.borderWidth = (minLineWidth); view.layer.borderColor = ColorRGB(190, 190, 190).CGColor;}

//设置View边框
#define setViewBorder(view, width) {view.layer.borderWidth = width; view.layer.borderColor = ColorRGB(190, 190, 190).CGColor;}

//block self
#define WeakSelf        __weak typeof(self) wself = self


//从nib中加载cell
#define LoadFromNib(nibName)  [[[NSBundle mainBundle] loadNibNamed:nibName owner:self options:nil] lastObject]

#endif /* Macros_h */
