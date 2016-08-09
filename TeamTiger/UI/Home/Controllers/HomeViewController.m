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
#import "DiscussViewController.h"


@interface HomeViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSMutableArray *dataSource;
@property (assign, nonatomic) NSInteger projectType;

@property (strong, nonatomic) DataManager *manager;

@end

@implementation HomeViewController

- (DataManager *)manager {
    if (_manager == nil) {
        _manager = [DataManager mainSingleton];
    }
    return _manager;
}
- (NSMutableArray *)dataSource {
    if (!_dataSource) {
        _dataSource = [NSMutableArray arrayWithCapacity:1];
        NSMutableDictionary *dic1 = [@{@"headImage":@"touxiang", @"name":@"唐小旭", @"type":@"工作牛", @"image1":@"placeImage", @"image2":@"placeImage", @"image3":@"placeImage", @"isClick":@(NO)} mutableCopy];
        HomeCellModel *model1 = [[HomeCellModel alloc] init];
        [model1 setValuesForKeysWithDictionary:dic1];
        [_dataSource addObject:model1];
        
        NSMutableDictionary *dic2 = [@{@"headImage":@"touxiang", @"name":@"卞克", @"type":@"BBS", @"image1":@"placeImage", @"image2":@"placeImage", @"image3":@"placeImage", @"aDes":@"tape something", @"bDes":@"tape something", @"cDes":@"tape something", @"aTicket":@"0.7", @"bTicket":@"0.4", @"cTicket":@"0.1", @"isClick":@(NO)} mutableCopy];
        HomeCellModel *model2 = [[HomeCellModel alloc] init];
        [model2 setValuesForKeysWithDictionary:dic2];
        [_dataSource addObject:model2];
    }
    return _dataSource;
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
    self.manager.height = ((NSNumber *)notification.object).floatValue;
    [self.tableView reloadData];
}

- (void)handleClickCard:(NSNotification *)notification {
    self.projectType = ((NSNumber *)(notification.object)).integerValue;
    [self.tableView reloadData];
}

- (void)configureNavigationItem {
    UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    leftBtn.frame = CGRectMake(0, 0, 20, 20);
    [leftBtn setBackgroundImage:kImage(@"shezhi") forState:UIControlStateNormal];
    [leftBtn addTarget:self action:@selector(handleLeftBtnAction) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:leftBtn];
    
    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    rightBtn.frame = CGRectMake(0, 0, 30, 30);
    [rightBtn setImage:kImage(@"add") forState:UIControlStateNormal];
    rightBtn.tintColor = [UIColor whiteColor];
    [rightBtn setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 0, -25)];
    [rightBtn addTarget:self action:@selector(handleRightBtnAction) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
}

- (void)handleLeftBtnAction {
    TTSettingViewController *settingVC = [[TTSettingViewController alloc] initWithNibName:@"TTSettingViewController" bundle:nil];
    [Common customPushAnimationFromNavigation:self.navigationController ToViewController:settingVC Type:kCATransitionMoveIn SubType:kCATransitionFromLeft];
}

- (void)handleRightBtnAction {
    DiscussViewController *addDiscussVC = [[DiscussViewController alloc] init];
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
            return 2;
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
    HomeCellModel *model = self.dataSource[indexPath.row];
    switch (self.projectType) {
        case 0:{
            if (indexPath.row == 0) {
                HomeCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HomeCell"];
                cell.moreBtn.indexPath = indexPath;
                cell.tableView.tag = 1000 + indexPath.row;
                [cell.moreBtn addTarget:self action:@selector(handleClickActin:) forControlEvents:UIControlEventTouchUpInside];
                [cell configureCellWithModel:model];
                return cell;
            }else {
                VoteHomeCell *cell = [tableView dequeueReusableCellWithIdentifier:@"VoteHomeCell"];
                [cell configureCellWithModel:model];
                [cell.moreBtn addTarget:self action:@selector(handleActin:) forControlEvents:UIControlEventTouchUpInside];
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
            cell.tableView.tag = 1000 + indexPath.row;
            [cell.moreBtn addTarget:self action:@selector(handleClickActin:) forControlEvents:UIControlEventTouchUpInside];
            [cell configureCellWithModel:self.dataSource[indexPath.row]];
            return cell;
        }
        default:
            break;
    }
    return nil;
}

- (void)handleClickActin:(ButtonIndexPath *)button {
    HomeCellModel *model = self.dataSource[button.indexPath.row];
    model.isClick = !model.isClick;
    HomeCell *cell = (HomeCell *)button.superview.superview.superview;
    if (model.isClick) {
        [cell.tableView reloadData];
        self.manager.height = cell.tableView.contentSize.height;
        [self.tableView reloadRowsAtIndexPaths:@[button.indexPath] withRowAnimation:UITableViewRowAnimationNone];
        [button setImage:kImage(@"xia") forState:UIControlStateNormal];
    }else {
        [self.tableView reloadRowsAtIndexPaths:@[button.indexPath] withRowAnimation:UITableViewRowAnimationNone];
        [button setImage:kImage(@"shang") forState:UIControlStateNormal];
    }
}

- (void)handleActin:(ButtonIndexPath *)button {
    HomeCellModel *model = self.dataSource[button.indexPath.row];
    model.isClick = !model.isClick;
    if (model.isClick) {
        [button setImage:kImage(@"shang") forState:UIControlStateNormal];
    }else {
        [button setImage:kImage(@"xia") forState:UIControlStateNormal];
        
    }
}

#pragma mark UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    HomeCellModel *model = self.dataSource[indexPath.row];
    switch (self.projectType) {
        case 0:{
            if (indexPath.row == 0) {
                if (model.isClick) {
                    return 253 + self.manager.height + 5;
                }else {
                    return 253;
                }
            }else {
                return 431;
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
                return 253 + self.manager.height + 5;
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
