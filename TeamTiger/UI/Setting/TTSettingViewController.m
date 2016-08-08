//
//  TTSettingViewController.m
//  TeamTiger
//
//  Created by xxcao on 16/7/27.
//  Copyright © 2016年 MobileArtisan. All rights reserved.
//

#import "TTSettingViewController.h"
#import "ProjectCell.h"
#import "IQKeyboardManager.h"
#import "TTAddContactorViewController.h"
#import "TTPickerView.h"
@interface TTSettingViewController ()

@property(nonatomic,strong)NSMutableArray *dataSource;

@end

@implementation TTSettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"项目设置";
    WeakSelf;
    [self hyb_setNavLeftButtonTitle:@"返回" onCliked:^(UIButton *sender) {
        [Common customPopAnimationFromNavigation:wself.navigationController Type:kCATransitionReveal SubType:kCATransitionFromRight];
    }];
    
    [IQKeyboardManager sharedManager].shouldResignOnTouchOutside = YES;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
            TTPickerView *picker = [[TTPickerView alloc] initWithDatas:@[@"工作牛",@"易会",@"MPP",@"电动汽车"] SelectBlock:^(TTPickerView *view, id selObj) {
                NSLog(@"%@",selObj);
                NSMutableDictionary *mDic = [NSMutableDictionary dictionaryWithDictionary:self.dataSource.firstObject];
                mDic[@"Description"] = selObj;
                [self.dataSource replaceObjectAtIndex:0 withObject:mDic];
                [self.contentTable reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:0 inSection:0]] withRowAnimation:UITableViewRowAnimationNone];
            } TapBlock:^(TTPickerView *view) {
                [UIView animateWithDuration:0.3 animations:^{
                    [view mas_updateConstraints:^(MASConstraintMaker *make) {
                        make.top.mas_equalTo(self.view.mas_top).offset(200);
                    }];
                    [self.view layoutIfNeeded];
                } completion:^(BOOL finished) {
                    [view removeFromSuperview];
                }];
            }];
            [self.view addSubview:picker];
            [picker mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(self.view.mas_left);
                make.top.mas_equalTo(self.view.mas_top).offset(200);
                make.height.equalTo(self.view.mas_height);
                make.width.equalTo(self.view.mas_width);
            }];
            [self.view layoutIfNeeded];
            [UIView animateWithDuration:0.3 animations:^{
                [picker mas_updateConstraints:^(MASConstraintMaker *make) {
                    make.top.mas_equalTo(self.view.mas_top);
                }];
                [self.view layoutIfNeeded];
            }];
        } else if (type == EProjectAddMember){
            NSLog(@"跳转微信，增加人员");
        } else if (type == EProjectDleteProject){
            NSLog(@"删除并退出");
        }
    };
    return cell;
}

- (NSMutableArray *)dataSource {
    if (!_dataSource) {
        _dataSource = @[
    @{@"Type":@0,
      @"Name":@"项目",
      @"Description":@"工作牛",
      @"ShowAccessory":@1,
      @"IsEdit":@0,
      @"Color":kRGB(21.0, 30.0, 44.0)},
    
    @{@"Type":@1,
      @"Name":@"项目成员",
      @"Description":@"",
      @"ShowAccessory":@0,
      @"IsEdit":@0,
      @"Color":kRGB(25.0, 34.0, 49.0),
      @"Members":@[@{@"Image":@"1.png",@"Name":@"曹兴星"},
                   @{@"Image":@"3.png",@"Name":@"刘鹏"},
                   @{@"Image":@"5.png",@"Name":@"陈杰"},
                   @{@"Image":@"7.png",@"Name":@"赵瑞"},
                   @{@"Image":@"9.png",@"Name":@"琳琳"},
                   @{@"Image":@"11.png",@"Name":@"俞弦"},
                   @{@"Image":@"13.png",@"Name":@"董宇鹏"},
                   @{@"Image":@"15.png",@"Name":@"齐云猛"},
                   @{@"Image":@"17.png",@"Name":@"焦兰兰"},
                   @{@"Image":@"2.png",@"Name":@"严必庆"},
                   @{@"Image":@"4.png",@"Name":@"陆毅全"}]},
    
    @{@"Type":@2,
      @"Name":@"",
      @"Description":@"",
      @"ShowAccessory":@0,
      @"IsEdit":@0,
      @"Color":[UIColor clearColor]}].mutableCopy;
    }
    return  _dataSource;
}

@end
