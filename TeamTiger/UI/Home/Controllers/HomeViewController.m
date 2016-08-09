//
//  ViewController.m
//  TeamTiger
//
//  Created by xxcao on 16/7/19.
//  Copyright © 2016年 MobileArtisan. All rights reserved.
//

#import "HomeViewController.h"
#import "DataManager.h"
#import "HomeCell.h"
#import "VoteHomeCell.h"
#import "HomeCellModel.h"
#import "TTSettingViewController.h"
#import "TTAddDiscussViewController.h"


@interface HomeViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (assign, nonatomic) NSInteger projectType;
@property (strong, nonatomic) DataManager *manager;

@property (assign, nonatomic) CGFloat height;

@end

@implementation HomeViewController

- (DataManager *)manager {
    if (_manager == nil) {
        _manager = [DataManager mainSingleton];
    }
    return _manager;
}

- (void)reloadWithData:(id)data {
    self.title = data;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configureNavigationItem];
    [Common removeExtraCellLines:self.tableView];
    [self.tableView registerNib:[UINib nibWithNibName:@"HomeCell" bundle:nil] forCellReuseIdentifier:@"HomeCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"VoteHomeCell" bundle:nil] forCellReuseIdentifier:@"VoteHomeCell"];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleRefresh:) name:@"isClick" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleClickCard:) name:@"ClickCard" object:nil];
}

- (void)handleRefresh:(NSNotification *)notification {
    self.height = ((NSNumber *)notification.object).floatValue;
    [self.tableView reloadData];
}

- (void)handleClickCard:(NSNotification *)notification {
    self.projectType = ((NSNumber *)(notification.object)).integerValue;
    [self.tableView reloadData];
}

- (void)configureNavigationItem {
    UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    leftBtn.frame = CGRectMake(0, 0, 20, 20);
    [leftBtn setBackgroundImage:kImage(@"icon_install") forState:UIControlStateNormal];
    [leftBtn addTarget:self action:@selector(handleLeftBtnAction) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:leftBtn];
    
    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    rightBtn.frame = CGRectMake(0, 0, 30, 30);
    [rightBtn setImage:kImage(@"icon_add") forState:UIControlStateNormal];
    rightBtn.tintColor = [UIColor whiteColor];
    [rightBtn setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 0, -25)];
    [rightBtn addTarget:self action:@selector(handleRightBtnAction) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
}

- (void)handleLeftBtnAction {
    TTSettingViewController *settingVC = [[TTSettingViewController alloc] initWithNibName:@"TTSettingViewController" bundle:nil];
    [Common customPushAnimationFromNavigation:self.navigationController ToViewController:settingVC Type:kCATransitionPush SubType:kCATransitionFromLeft];
}

- (void)handleRightBtnAction {
    TTAddDiscussViewController *addDiscussVC = [[TTAddDiscussViewController alloc] init];
    [Common customPushAnimationFromNavigation:self.navigationController ToViewController:addDiscussVC Type:kCATransitionMoveIn SubType:kCATransitionFromTop];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"isClick" object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"ClickCard" object:nil];
}

#pragma mark UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    switch (self.projectType) {
        case 0:
            return self.manager.dataSource.count;
            break;
        case 1:
        case 2:
        case 3:
        case 4:
            return 1;
            break;
        default:
            break;
    }
    return 0;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    HomeCellModel *model = self.manager.dataSource[indexPath.row];
    switch (self.projectType) {
        case 0:{
            if (indexPath.row == 0) {
                HomeCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HomeCell"];
                [cell configureCellWithModel:model];
                cell.moreBtn.indexPath = indexPath;
                [cell.moreBtn addTarget:self action:@selector(handleClickAction:) forControlEvents:UIControlEventTouchUpInside];
                return cell;
            }else {
                self.manager.indexPath = indexPath;
                VoteHomeCell *cell = [tableView dequeueReusableCellWithIdentifier:@"VoteHomeCell"];
                [cell configureCellWithModel:model];
                cell.moreBtn.indexPath = indexPath;
                [cell.moreBtn addTarget:self action:@selector(handleAction:) forControlEvents:UIControlEventTouchUpInside];
                cell.clickBtn = ^ (UIButton *btn){
                    btn.selected = !btn.selected;
                    if (btn.selected) {
                        [btn setBackgroundImage:kImage(@"xin1") forState:UIControlStateNormal];
                    }else {
                        [btn setBackgroundImage:kImage(@"xin") forState:UIControlStateNormal];
                    }
                    switch (btn.tag) {
                        case 100:{
                           
                        }
                            break;
                        case 101:{
                            
                        }
                            break;
                        case 102:{
                            
                        }
                            break;
                        default:
                            break;
                    }
                };
                return cell;
            }
        }
            break;
        case 1:
        case 2:
        case 3:
        case 4:{
            HomeCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HomeCell"];
            cell.moreBtn.indexPath = indexPath;
            [cell.moreBtn addTarget:self action:@selector(handleClickAction:) forControlEvents:UIControlEventTouchUpInside];
            [cell configureCellWithModel:self.manager.dataSource[indexPath.row]];
            return cell;
        }
        default:
            break;
    }
    return nil;
}

- (void)handleClickAction:(ButtonIndexPath *)button {
    HomeCellModel *model = self.manager.dataSource[button.indexPath.row];
    model.isClick = !model.isClick;
    HomeCell *cell = (HomeCell *)button.superview.superview.superview;
    if (model.isClick) {
        [cell.tableView reloadData];
        self.height = cell.tableView.contentSize.height;
        [self.tableView reloadRowsAtIndexPaths:@[button.indexPath] withRowAnimation:UITableViewRowAnimationNone];
        [button setImage:kImage(@"icon_xia") forState:UIControlStateNormal];
    }else {
        [self.tableView reloadRowsAtIndexPaths:@[button.indexPath] withRowAnimation:UITableViewRowAnimationNone];
        [button setImage:kImage(@"icon_shang") forState:UIControlStateNormal];
    }
}

- (void)handleAction:(ButtonIndexPath *)button {
    HomeCellModel *model = self.manager.dataSource[button.indexPath.row];
    model.isClick = !model.isClick;
    HomeCell *cell = (HomeCell *)button.superview.superview.superview;
    if (model.isClick) {
        [cell.tableView reloadData];
        self.manager.height = cell.tableView.contentSize.height;
        [button setImage:kImage(@"icon_shang") forState:UIControlStateNormal];
        [self.tableView reloadRowsAtIndexPaths:@[button.indexPath] withRowAnimation:UITableViewRowAnimationNone];
    }else {
        [button setImage:kImage(@"icon_xia") forState:UIControlStateNormal];
        [self.tableView reloadRowsAtIndexPaths:@[button.indexPath] withRowAnimation:UITableViewRowAnimationNone];
        
    }
}

#pragma mark UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    HomeCellModel *model = self.manager.dataSource[indexPath.row];
    switch (self.projectType) {
        case 0:{
            if (indexPath.row == 0) {
                if (model.isClick) {
                    return 253 + self.height + 5;
                }else {
                    return 253;
                }
            }else {
                if (model.isClick) {
                    return 431 + self.manager.height + 5;
                }else {
                    return 431;
                }
            }
        }
            break;
        case 1:{
            
        }
        case 2:{
            
        }
        case 3:{
            
        }
        case 4:{
            if (model.isClick) {
                return 253 + self.height + 5;
            }else {
                return 253;
            }
        }
        default:
            break;
    }
    return 0;
}


@end
