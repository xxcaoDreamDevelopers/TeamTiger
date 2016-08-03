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

@interface HomeViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSMutableArray *dataSource;
@property (assign, nonatomic) BOOL isFirst;
@property (assign, nonatomic) CGFloat height;

@end

@implementation HomeViewController

- (NSMutableArray *)dataSource {
    if (!_dataSource) {
        _dataSource = [NSMutableArray array];
        HomeCellModel *model = [[HomeCellModel alloc] init];
        model.name = @"唐小旭";
        model.type = @"工作牛";
        [_dataSource addObject:model];
    }
    return _dataSource;
}

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.title = @"工作牛";
    [self configureNavigationItem];
    [Common removeExtraCellLines:self.tableView];
    
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
    DiscussViewController *discussVC = [[DiscussViewController alloc] init];
    [self.navigationController pushViewController:discussVC animated:YES];
}

- (void)handleRightBtnAction {
    TTSettingViewController *settingVC = [[TTSettingViewController alloc] initWithNibName:@"TTSettingViewController" bundle:nil];
    [self.navigationController pushViewController:settingVC animated:YES];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
}

#pragma mark UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"cellIdentifier";
    HomeCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = LoadFromNib(@"HomeCell");
    }
    typeof(cell) weakCell = cell;
    cell.clickBlock = ^ () {
        weakCell.isFirst = !weakCell.isFirst;
        if (weakCell.isFirst) {
            weakCell.tableView.hidden = NO;
            [weakCell.moreBtn setImage:kImage(@"shang") forState:UIControlStateNormal];
            self.height = weakCell.tableView.contentSize.height;
        }else {
            weakCell.tableView.hidden = YES;
            [weakCell.moreBtn setImage:kImage(@"xia") forState:UIControlStateNormal];
        }
    };
    [cell configureCellWithModel:self.dataSource[indexPath.row]];
    return cell;
}

#pragma mark UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 650;
    
}

@end
