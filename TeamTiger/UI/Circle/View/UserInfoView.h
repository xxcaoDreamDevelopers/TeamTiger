//
//  UserInfoView.h
//  TeamTiger
//
//  Created by 刘鵬 on 16/8/2.
//  Copyright © 2016年 MobileArtisan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UserInfoView : UIView
@property (weak, nonatomic) IBOutlet UILabel *nameLab;
@property (weak, nonatomic) IBOutlet UILabel *offerLab;
@property (weak, nonatomic) IBOutlet UIImageView *headImgV;
+ (instancetype)userInfoViewWithData:(id) dataSource;

+ (instancetype)userInfoView;
@end
