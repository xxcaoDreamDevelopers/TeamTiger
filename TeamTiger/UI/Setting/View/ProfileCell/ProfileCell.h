//
//  ProfileCell.h
//  TeamTiger
//
//  Created by xxcao on 16/8/5.
//  Copyright © 2016年 MobileArtisan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProfileCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *bgImgV;
@property (weak, nonatomic) IBOutlet UILabel *nameLab;
@property (weak, nonatomic) IBOutlet UITextField *detailTxtField;
@property (weak, nonatomic) IBOutlet UIImageView *accessoryImgV;
@property (weak, nonatomic) IBOutlet UIButton *exitBtn;

@property (weak, nonatomic) IBOutlet UIImageView *headImgV;

+ (instancetype)loadCellWithType:(int)type;

+ (CGFloat)loadCellHeightWithType:(int)type;

- (void)reloadCellData:(id)obj;

@end
