//
//  HomeDetailCell1.h
//  TeamTiger
//
//  Created by Dale on 16/8/1.
//  Copyright © 2016年 MobileArtisan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HomeDetailCellModel.h"

@interface HomeDetailCell1 : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *timeLB;
@property (weak, nonatomic) IBOutlet UILabel *firstNameLB;
@property (weak, nonatomic) IBOutlet UILabel *secondNameLB;
@property (weak, nonatomic) IBOutlet UILabel *descipitionLB;
@property (weak, nonatomic) IBOutlet UIButton *moreBtn;
@property (copy, nonatomic) ClickBlock clickMoreBtn;

- (void)configureCellWithModel:(HomeDetailCellModel *)model;

@end
