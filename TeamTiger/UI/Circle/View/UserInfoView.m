//
//  UserInfoView.m
//  TeamTiger
//
//  Created by 刘鵬 on 16/8/2.
//  Copyright © 2016年 MobileArtisan. All rights reserved.
//

#import "UserInfoView.h"

@implementation UserInfoView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

+ (instancetype)userInfoViewWithData:(id) dataSource
{
//    NSBundle *bundle = [NSBundle mainBundle];
    // 读取xib文件(会创建xib中的描述的所有对象,并且按顺序放到数组中返回)
//    NSArray *objs = [bundle loadNibNamed:@"UserInfoView" owner:nil options:nil];
    UserInfoView *userInfoView =  LoadFromNib(@"UserInfoView");

    return userInfoView;
}

+ (instancetype)userInfoView
{
    return [self userInfoViewWithData:nil];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.headImgV.layer.masksToBounds = YES;
    self.headImgV.layer.cornerRadius = self.headImgV.hyb_height * 0.5;
    self.headImgV.backgroundColor = [UIColor clearColor];
    self.headImgV.image = kImageForHead;
}

@end
