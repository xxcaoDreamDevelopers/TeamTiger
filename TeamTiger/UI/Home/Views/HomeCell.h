//
//  HomeCell.h
//  TeamTiger
//
//  Created by Dale on 16/8/1.
//  Copyright © 2016年 MobileArtisan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HomeCellModel.h"



typedef NS_ENUM(NSInteger, TypeCell) {
    TypeCellImage = 0,
    TypeCellTitle
};

@interface HomeCell : UITableViewCell <UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *headImage;
@property (weak, nonatomic) IBOutlet UILabel *nameLB;
@property (weak, nonatomic) IBOutlet UILabel *typeLB;
@property (weak, nonatomic) IBOutlet UIImageView *image1;
@property (weak, nonatomic) IBOutlet UIImageView *image2;

@property (weak, nonatomic) IBOutlet UIImageView *image3;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIButton *moreBtn;
@property (copy, nonatomic) ClickBlock clickBlock;
@property (assign, nonatomic) BOOL isFirst;
@property (assign, nonatomic) TypeCell typeCell;

- (void)configureCellWithModel:(HomeCellModel *)model;

@end
