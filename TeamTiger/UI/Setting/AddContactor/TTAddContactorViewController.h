//
//  TTAddContactorViewController.h
//  TeamTiger
//
//  Created by xxcao on 16/7/30.
//  Copyright © 2016年 MobileArtisan. All rights reserved.
//

#import "TTBaseViewController.h"

@interface TTAddContactorViewController : TTBaseViewController<UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *contactTable;

@end
