//
//  HomeDetailCell2.h
//  TeamTiger
//
//  Created by Dale on 16/8/2.
//  Copyright © 2016年 MobileArtisan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HomeDetailCellModel.h"

@interface HomeDetailCell2 : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *timeLB;
@property (weak, nonatomic) IBOutlet UILabel *nameLB;
@property (weak, nonatomic) IBOutlet UIView *line2;

- (void)configureCellWithModel:(HomeDetailCellModel *)model;

@end
