//
//  DiscussListCell1.m
//  TeamTiger
//
//  Created by Dale on 16/8/2.
//  Copyright © 2016年 MobileArtisan. All rights reserved.
//

#import "DiscussListCell1.h"

@implementation DiscussListCell1

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)configureCellWithModel:(DiscussListModel *)model {
    self.iconImage.image = kImage(model.iconName);
    self.nameLB.text = model.name;
    self.desLB.text = model.des;
    self.timeLB.text = model.time;
    self.desLB.text = model.des2;
}

@end

