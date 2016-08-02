//
//  HomeDetailCell.m
//  TeamTiger
//
//  Created by Dale on 16/8/1.
//  Copyright © 2016年 MobileArtisan. All rights reserved.
//

#import "HomeDetailCell.h"

@implementation HomeDetailCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)configureCellWithModel:(HomeDetailCellModel *)model {
    self.timeLB.text = model.time;
    self.firstNameLB.text = model.firstName;
    self.secondeNameLB.text = model.secondName;
    self.desLB.text = model.des;
    self.image1.image = kImage(model.firstImage);
    self.image2.image = kImage(model.secondImage);
    
}

@end
