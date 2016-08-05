//
//  ProfileCell.m
//  TeamTiger
//
//  Created by xxcao on 16/8/5.
//  Copyright © 2016年 MobileArtisan. All rights reserved.
//

#import "ProjectCell.h"

@implementation ProjectCell

- (void)awakeFromNib {
    [super awakeFromNib];
    setViewCorner(self.exitBtn, 5);    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
}

+ (instancetype)loadCellWithType:(int)type {
    ProjectCell *cell = nil;
    switch (type) {
        case 0:
            cell = LoadFromNib(@"ProjectCell1");
            break;
        case 1:
            cell = LoadFromNib(@"ProjectCell1");
            break;
        default:
            cell = LoadFromNib(@"ProjectCell2");
            break;
    }
    return cell;
}

+ (CGFloat)loadCellHeightWithType:(int)type {
    return 76.0;
}

- (void)reloadCellData:(id)obj{
    
    NSDictionary *dic = [NSDictionary dictionaryWithDictionary:obj];
    self.bgImgV.backgroundColor = dic[@"Color"];
    self.nameLab.text = dic[@"Name"];
    self.detailTxtField.text = dic[@"Description"];

    if ([dic[@"ShowAccessory"] intValue]) {
        self.accessoryImgV.hidden = NO;
    } else {
        self.accessoryImgV.hidden = YES;
    }

    if ([dic[@"IsEdit"] intValue]) {
        self.detailTxtField.userInteractionEnabled = YES;
    } else {
        self.detailTxtField.userInteractionEnabled = NO;
    }
}

- (void)clickHeaderAction:(id)sender {
    if (self.block) {
        self.block(self);
    }
}

@end
