//
//  TTSettingViewController.m
//  TeamTiger
//
//  Created by xxcao on 16/7/27.
//  Copyright © 2016年 MobileArtisan. All rights reserved.
//

#import "IQKeyboardManager.h"
#import "ProjectCell.h"
#import "TTPickerView.h"
#import "TTSettingViewController.h"
#import "UIAlertView+HYBHelperKit.h"
#import "MockDatas.h"

@interface TTSettingViewController ()

@property(nonatomic,strong)NSMutableArray *dataSource;

@property(nonatomic,strong)TTPickerView *ttPicker;

@end

@implementation TTSettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"项目设置";
    WeakSelf;
    [self hyb_setNavLeftImage:[UIImage imageNamed:@"icon_back"] block:^(UIButton *sender) {
        [Common customPopAnimationFromNavigation:wself.navigationController Type:kCATransitionPush SubType:kCATransitionFromRight];
    }];
    
    [IQKeyboardManager sharedManager].shouldResignOnTouchOutside = YES;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 3;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSDictionary *dic = self.dataSource[indexPath.row];
    return [ProjectCell loadCellHeightWithData:dic];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSDictionary *dic = self.dataSource[indexPath.row];
    static NSString *cellID = @"cellIdentify";
    ProjectCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [ProjectCell loadCellWithType:[dic[@"Type"] intValue]];
    }
    [cell reloadCellData:dic];
    cell.block = ^(ProjectCell *cell,int type){
        if (type == EProjectSelect) {
            [self ttPicker];
        } else if (type == EProjectAddMember){
            NSLog(@"跳转微信，增加人员");
            [UIAlertView hyb_showWithTitle:@"提示" message:@"跳转微信，拉好友" buttonTitles:@[@"确定"] block:^(UIAlertView *alertView, NSUInteger buttonIndex) {
                
            }];
        } else if (type == EProjectDleteProject){
            NSLog(@"删除并退出");
        }
    };
    return cell;
}

#pragma -mark Customer Methods
- (void)loadProjectDataById:(id)projectId {
    NSPredicate *predicate = [NSPredicate predicateWithBlock:^BOOL(id  _Nonnull evaluatedObject, NSDictionary<NSString *,id> * _Nullable bindings) {
        return [evaluatedObject[@"Id"] isEqualToString:projectId];
    }];
    NSArray *resArray = [[MockDatas projects] filteredArrayUsingPredicate:predicate];
    if (resArray && resArray.count > 0) {
        [self.dataSource removeAllObjects];
        self.dataSource = @[
                        @{@"Type":@0,
                          @"Name":@"项目",
                          @"Description":resArray.firstObject[@"Name"],
                          @"ShowAccessory":@1,
                          @"IsEdit":@0,
                          @"Color":kRGB(21.0, 30.0, 44.0)},
                        
                        @{@"Type":@1,
                          @"Name":@"项目成员",
                          @"Description":@"",
                          @"ShowAccessory":@0,
                          @"IsEdit":@0,
                          @"Color":kRGB(25.0, 34.0, 49.0),
                          @"Members":[MockDatas membersOfproject:projectId]},
                        
                        @{@"Type":@2,
                          @"Name":@"",
                          @"Description":@"",
                          @"ShowAccessory":@0,
                          @"IsEdit":@0,
                          @"Color":[UIColor clearColor]}].mutableCopy;
        
        [self.contentTable reloadData];
    }
}

#pragma -mark getter
- (NSMutableArray *)dataSource {
    if (!_dataSource) {
        _dataSource = @[
    @{@"Type":@0,
      @"Name":@"项目",
      @"Description":[MockDatas projects][0][@"Name"],
      @"ShowAccessory":@1,
      @"IsEdit":@0,
      @"Color":kRGB(21.0, 30.0, 44.0)},
    
    @{@"Type":@1,
      @"Name":@"项目成员",
      @"Description":@"",
      @"ShowAccessory":@0,
      @"IsEdit":@0,
      @"Color":kRGB(25.0, 34.0, 49.0),
      @"Members":[MockDatas membersOfproject:[MockDatas projects][0][@"Id"]]},
    
    @{@"Type":@2,
      @"Name":@"",
      @"Description":@"",
      @"ShowAccessory":@0,
      @"IsEdit":@0,
      @"Color":[UIColor clearColor]}].mutableCopy;
    }
    return  _dataSource;
}


- (TTPickerView *)ttPicker {
    if (!_ttPicker) {
        WeakSelf;
        _ttPicker = [[TTPickerView alloc] initWithDatas:[MockDatas projects] SelectBlock:^(TTPickerView *view, id selObj) {
            NSLog(@"%@",selObj);
            [wself loadProjectDataById:selObj[@"Id"]];
        } TapBlock:^(TTPickerView *view) {
            [UIView animateWithDuration:0.3 animations:^{
                [view mas_updateConstraints:^(MASConstraintMaker *make) {
                    make.top.mas_equalTo(wself.view.mas_top).offset(200);
                }];
                [wself.view layoutIfNeeded];
            } completion:^(BOOL finished) {
                [view removeFromSuperview];
                _ttPicker = nil;
            }];
        }];
        [wself.view addSubview:_ttPicker];
        [_ttPicker mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(wself.view.mas_left);
            make.top.mas_equalTo(wself.view.mas_top).offset(200);
            make.height.equalTo(wself.view.mas_height);
            make.width.equalTo(wself.view.mas_width);
        }];
        [wself.view layoutIfNeeded];
        [UIView animateWithDuration:0.3 animations:^{
            [wself.ttPicker mas_updateConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(wself.view.mas_top);
            }];
            [wself.view layoutIfNeeded];
        }];
    }
    return _ttPicker;
}

@end
