//
//  VoteHomeCell.m
//  TeamTiger
//
//  Created by Dale on 16/8/5.
//  Copyright © 2016年 MobileArtisan. All rights reserved.
//

#import "VoteHomeCell.h"

@implementation VoteHomeCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (IBAction)handleBtnAction:(UIButton *)sender {
    if (self.clickBtn) {
        self.clickBtn(sender);
    }
}

- (void)configureCellWithModel:(HomeCellModel *)model {
    self.headImage.image = kImage(model.headImage);
    self.nameLB.text = model.name;
    self.typeLB.text = model.type;
    self.image1.image = kImage(model.image1);
    self.image2.image = kImage(model.image2);
    self.image3.image = kImage(model.image3);
    self.aDesLB.text = model.aDes;
    self.bDesLB.text = model.bDes;
    self.cDesLB.text = model.cDes;
    self.aProgress.progress = [model.aTicket floatValue];
    self.bProgress.progress = [model.bTicket floatValue];
    self.cProgress.progress = [model.cTicket floatValue];

    self.aTicketLB.text = [NSString stringWithFormat:@"%.0f票", (model.aTicket.floatValue) * 10];
    self.bTicketLB.text = [NSString stringWithFormat:@"%.0f票", (model.bTicket.floatValue) * 10];
    self.cTicketLB.text = [NSString stringWithFormat:@"%.0f票", (model.cTicket.floatValue) * 10];
    
    self.aPerLB.text = [NSString stringWithFormat:@"(%.0f%%)", (model.aTicket.floatValue) * 100];
    self.bPerLB.text = [NSString stringWithFormat:@"(%.0f%%)", (model.bTicket.floatValue) * 100];
    self.cPerLB.text = [NSString stringWithFormat:@"(%.0f%%)", (model.cTicket.floatValue) * 100];
    
}

@end
