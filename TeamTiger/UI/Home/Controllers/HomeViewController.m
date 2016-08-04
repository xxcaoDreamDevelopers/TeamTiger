//
//  ViewController.m
//  TeamTiger
//
//  Created by xxcao on 16/7/19.
//  Copyright © 2016年 MobileArtisan. All rights reserved.
//

#import "HomeViewController.h"
#import "HomeCell.h"
#import "HomeCellModel.h"
#import "TTSettingViewController.h"
#import "DiscussViewController.h"
#import "TTAddDiscussViewController.h"


@interface HomeViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSMutableArray *dataSource;
@property (assign, nonatomic) CGFloat height;

@end

@implementation HomeViewController

- (NSMutableArray *)dataSource {
    if (!_dataSource) {
        _dataSource = [NSMutableArray array];
        HomeCellModel *model1 = [[HomeCellModel alloc] init];
        model1.name = @"唐小旭";
        model1.type = @"工作牛";
        model1.isClick = NO;
        [_dataSource addObject:model1];
        
        HomeCellModel *model2 = [[HomeCellModel alloc] init];
        model2.name = @"卞克";
        model2.type = @"BBS";
        model2.isClick = NO;
        [_dataSource addObject:model2];
        
    }
    return _dataSource;
}

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.title = @"工作牛";
    [self configureNavigationItem];
    [Common removeExtraCellLines:self.tableView];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleRefresh:) name:@"isClick" object:nil];
    
}

- (void)handleRefresh:(NSNotification *)notification {
    UITableView *contentTableView = notification.object;
    self.height = contentTableView.contentSize.height;
    [self.tableView reloadData];
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
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
    
    TTAddDiscussViewController *addDiscussVC = [[TTAddDiscussViewController alloc] init];
    [Common customPushAnimationFromNavigation:self.navigationController ToViewController:addDiscussVC Type:kCATransitionMoveIn SubType:kCATransitionFromTop];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
}

#pragma mark UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"cellIdentifier";
    HomeCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = LoadFromNib(@"HomeCell");
    }
    cell.moreBtn.indexPath = indexPath;
    cell.tableView.tag = 1000 + indexPath.row;
    [cell.moreBtn addTarget:self action:@selector(handleClickActin:) forControlEvents:UIControlEventTouchUpInside];
    [cell configureCellWithModel:self.dataSource[indexPath.row]];
    return cell;
}

- (void)handleClickActin:(ButtonIndexPath *)button {
    HomeCellModel *model = self.dataSource[button.indexPath.row];
    model.isClick = !model.isClick;
    HomeCell *cell = (HomeCell *)button.superview.superview.superview;
    if (model.isClick) {
        [button setImage:kImage(@"shang") forState:UIControlStateNormal];
        self.height = cell.tableView.contentSize.height;
        [self.tableView reloadRowsAtIndexPaths:@[button.indexPath] withRowAnimation:UITableViewRowAnimationNone];
    }else {
        [button setImage:kImage(@"xia") forState:UIControlStateNormal];
        [self.tableView reloadRowsAtIndexPaths:@[button.indexPath] withRowAnimation:UITableViewRowAnimationNone];
    }
}

#pragma mark UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    HomeCellModel *model = self.dataSource[indexPath.row];
    if (model.isClick) {
        return 253 + self.height + 5;
    }else {
        return 253;
    }

}


@end
