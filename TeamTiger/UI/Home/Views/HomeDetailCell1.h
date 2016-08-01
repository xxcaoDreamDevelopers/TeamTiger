//
//  HomeDetailCell1.h
//  TeamTiger
//
//  Created by Dale on 16/8/1.
//  Copyright © 2016年 MobileArtisan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HomeDetailCell1 : UITableViewCell

@property (weak, nonatomic) IBOutlet UIButton *moreBtn;
@property (copy, nonatomic) ClickBlock clickMoreBtn;

@end
