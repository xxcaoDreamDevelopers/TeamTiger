//
//  TTAddContactorViewController.m
//  TeamTiger
//
//  Created by xxcao on 16/7/30.
//  Copyright © 2016年 MobileArtisan. All rights reserved.
//

#import "TTAddContactorViewController.h"
#import "IQKeyboardManager.h"
#import "ContactTableViewCell.h"
#import "ContactModel.h"
#import "MBProgressHUD.h"
#import "UIColor+HYBHelperKitUIKit.h"

#define KBGColor    [UIColor colorWithRed:21.0/255.0f green:27.0/255.0f blue:39.0/255.0f alpha:1.0f]

@interface TTAddContactorViewController ()<UISearchBarDelegate,UISearchDisplayDelegate>

@property (nonatomic,strong) UISearchBar *searchBar;//搜索框
@property (nonatomic,strong) UISearchDisplayController *searchDisplayController;//搜索VC

@property (nonatomic,strong) NSArray *serverDataArr;//数据源
@property (nonatomic,strong) NSArray *dataArr;//model化的数据源
@property (nonatomic,strong) NSArray *rowArr;//每一个section里面的数据
@property (nonatomic,strong) NSArray *sectionArr;//section数据
@property (nonatomic,strong) NSMutableArray *searchResultArr;//搜索结果Arr

@end

@implementation TTAddContactorViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"添加成员";
    [self hyb_setNavLeftButtonTitle:@"返回" onCliked:^(UIButton *sender) {
        [self.navigationController popViewControllerAnimated:YES];
    }];
    [IQKeyboardManager sharedManager].shouldResignOnTouchOutside = YES;
    
    //contact table
    [Common removeExtraCellLines:self.contactTable];
    UIView *bgView = [[UIView alloc] init];
    bgView.backgroundColor = KBGColor;
    self.contactTable.backgroundView = bgView;
    self.contactTable.tableHeaderView = self.searchBar;
    self.contactTable.sectionIndexBackgroundColor = KBGColor;
    self.contactTable.sectionIndexColor = [UIColor grayColor];
    
    //searchDisplayController
    [self searchDisplayController];
    
    //data source
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDModeIndeterminate;
    hud.label.text = @"正在加载...";
    hud.square = YES;
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        self.rowArr = [ContactModel getFriendListDataBy:self.dataArr.mutableCopy];
        self.sectionArr = [ContactModel getFriendListSectionBy:self.rowArr.mutableCopy];
        dispatch_async(dispatch_get_main_queue(), ^{
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            [self.contactTable reloadData];
        });
    });
}

#pragma -mark UITableView DataSource 
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if (tableView == self.contactTable) {
        return self.rowArr.count;
    } else {
        return 1;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (tableView == self.contactTable) {
        return [self.rowArr[section] count];
    } else {
        return self.searchResultArr.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIde = @"cellIde";
    ContactTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIde];
    if (!cell) {
        cell = [[ContactTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIde];
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    }
    BOOL isLast = NO;
    if (tableView == self.contactTable) {
        if (indexPath.row == [self.rowArr[indexPath.section] count] - 1) {
            isLast = YES;
        }
        [cell reloadCell:self.rowArr[indexPath.section][indexPath.row]
                  IsLast:isLast];
    } else {
        if (indexPath.row == [self.searchResultArr count] - 1) {
            isLast = YES;
        }
        [cell reloadCell:self.searchResultArr[indexPath.row]
                  IsLast:isLast];
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (tableView == self.contactTable) {
        return 28.0;
    }
    return 0;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    //viewforHeader
    id label = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"headerView"];
    if (!label) {
        label = [[UILabel alloc] init];
        [label setFont:[UIFont systemFontOfSize:17.0f]];
        [label setTextColor:[UIColor colorWithRed:49.0/255 green:55.0/255 blue:64.0/255 alpha:1]];
        [label setBackgroundColor:[UIColor colorWithRed:20.0/255.0 green:25.0/255.0 blue:36.0/255.0 alpha:1.0]];
    }
    [label setText:[NSString stringWithFormat:@"    %@",self.sectionArr[section + 1]]];
    return label;
}

- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView{
    if (tableView == self.contactTable) {
        return self.sectionArr;
    }
    return nil;
}

- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index{
    return index - 1;
}


#pragma -mark Getter 
- (UISearchBar *)searchBar {
    if (!_searchBar) {
        _searchBar = [[UISearchBar alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 44)];
        [_searchBar sizeToFit];
        [_searchBar setPlaceholder:@"通过名称或电子邮箱搜索"];
        [_searchBar setDelegate:self];
        [_searchBar setKeyboardType:UIKeyboardTypeDefault];
        _searchBar.searchBarStyle = UISearchBarStyleMinimal;
        _searchBar.tintColor = [UIColor whiteColor];
        
        UIImage *searchBarBg = [UIColor hyb_imageWithColor:[UIColor colorWithRed:31.0 / 255.0 green:33.0 / 255.0 blue:43.0 / 255.0 alpha:1.0] size:Size(1.0, 32.0)];
        [_searchBar setBackgroundImage:searchBarBg];
        [_searchBar setBackgroundColor:[UIColor colorWithRed:31.0 / 255.0 green:33.0 / 255.0 blue:43.0 / 255.0 alpha:1.0]];
        [_searchBar setSearchFieldBackgroundImage:searchBarBg forState:UIControlStateNormal];
        
        UITextField *searchField = [_searchBar valueForKey:@"_searchField"];
        searchField.textColor = [UIColor whiteColor];
        searchField.tintColor = [UIColor whiteColor];
        [searchField setValue:[UIColor lightTextColor] forKeyPath:@"_placeholderLabel.textColor"];
    }
    return _searchBar;
}

- (UISearchDisplayController *)searchDisplayController {
    if (!_searchDisplayController) {
        _searchDisplayController = [[UISearchDisplayController alloc]initWithSearchBar:self.searchBar contentsController:self];
        [_searchDisplayController setDelegate:self];
        [_searchDisplayController setSearchResultsDataSource:self];
        [_searchDisplayController setSearchResultsDelegate:self];
        [Common removeExtraCellLines:_searchDisplayController.searchResultsTableView];
        UIView *bgView = [[UIView alloc] init];
        bgView.backgroundColor = KBGColor;
        _searchDisplayController.searchResultsTableView.backgroundView = bgView;
        _searchDisplayController.searchResultsTableView.backgroundColor = KBGColor;
        _searchDisplayController.searchResultsTableView.rowHeight = 60;
        _searchDisplayController.searchResultsTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        if (!self.searchResultArr) {
            self.searchResultArr = [NSMutableArray array];
        }
    }
    return _searchDisplayController;
}

- (NSArray *)serverDataArr {
    if (!_serverDataArr) {
        _serverDataArr = @[
  @{@"portrait":@"1", @"name":@"1", @"email":@"sdsssfsfdf@qq.com", @"isAdd":@0},
  @{@"portrait":@"2", @"name":@"花无缺", @"email":@"dfdfdfdf@163.com", @"isAdd":@0},
  @{@"portrait":@"3", @"name":@"东方不败", @"email":@"", @"isAdd":@1},
  @{@"portrait":@"4", @"name":@"任我行", @"email":@"ththththth@gmail.com", @"isAdd":@0},
  @{@"portrait":@"5", @"name":@"逍遥王", @"email":@"", @"isAdd":@0},
  @{@"portrait":@"6", @"name":@"阿离", @"email":@"ddbbgbgbgb@qq.com", @"isAdd":@0},
  @{@"portrait":@"13",@"name":@"百草堂", @"email":@"ynynynyny@qq.com", @"isAdd":@0},
  @{@"portrait":@"8", @"name":@"三味书屋", @"email":@"sdsssfsfdf@yahoo.com", @"isAdd":@0},
  @{@"portrait":@"9", @"name":@"彩彩", @"email":@"", @"isAdd":@0},
  @{@"portrait":@"10", @"name":@"陈晨", @"email":@"", @"isAdd":@0},
  @{@"portrait":@"11", @"name":@"多多", @"email":@"vfvfbfbgnbhn@qq.com", @"isAdd":@1},
  @{@"portrait":@"12", @"name":@"峨嵋山", @"email":@"werererere@126.com", @"isAdd":@0},
  @{@"portrait":@"7", @"name":@"哥哥", @"email":@"fbgnhnynyny@souhu.com", @"isAdd":@0},
  @{@"portrait":@"14", @"name":@"林俊杰", @"email":@"dvdvvfvfvf@qq.com", @"isAdd":@0},
  @{@"portrait":@"15", @"name":@"足球", @"email":@"", @"isAdd":@1},
  @{@"portrait":@"16", @"name":@"58赶集", @"email":@"", @"isAdd":@0},
  @{@"portrait":@"17", @"name":@"搜房网", @"email":@"sdsssfsfdf@tencent.com", @"isAdd":@0},
  @{@"portrait":@"18", @"name":@"欧弟王", @"email":@"", @"isAdd":@1}
  ];
    }
    return _serverDataArr;
}


- (NSArray *)dataArr {
    if (!_dataArr) {
        _dataArr = [ContactModel modelArrayFromDictionaryArray:self.serverDataArr];
    }
    return _dataArr;
}


#pragma mark searchBar delegate
//searchBar开始编辑时改变取消按钮的文字
- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar{
    NSArray *subViews;
    subViews = [(searchBar.subviews[0]) subviews];
    for (id view in subViews) {
        if ([view isKindOfClass:[UIButton class]]) {
            UIButton* cancelbutton = (UIButton *)view;
            [cancelbutton setTitle:@"取消" forState:UIControlStateNormal];
            break;
        }
    }
    [searchBar setShowsCancelButton:YES animated:YES];
}

- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar{
    return YES;
}

- (BOOL)searchBarShouldEndEditing:(UISearchBar *)searchBar{
    return YES;
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar{
    //取消
    [searchBar resignFirstResponder];
    [searchBar setShowsCancelButton:NO animated:YES];
}

#pragma mark searchDisplayController delegate
- (void)searchDisplayController:(UISearchDisplayController *)controller willShowSearchResultsTableView:(UITableView *)tableView {
    [Common removeExtraCellLines:tableView];
}

- (BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString {
    [self filterContentForSearchText:searchString
                               scope:[self.searchBar scopeButtonTitles][self.searchBar.selectedScopeButtonIndex]];
    return YES;
}

- (BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchScope:(NSInteger)searchOption{
    [self filterContentForSearchText:self.searchBar.text
                               scope:self.searchBar.scopeButtonTitles[searchOption]];
    return YES;
}

#pragma mark - 源字符串内容是否包含或等于要搜索的字符串内容
- (void)filterContentForSearchText:(NSString*)searchText scope:(NSString*)scope {
    NSMutableArray *tempResults = [NSMutableArray array];
    NSUInteger searchOptions = NSCaseInsensitiveSearch | NSDiacriticInsensitiveSearch;
    for (ContactModel *model in self.dataArr) {
        NSString *name = model.name;
        NSRange storeRange = NSMakeRange(0, name.length);
        NSRange foundRange = [name rangeOfString:searchText options:searchOptions range:storeRange];
        if (foundRange.length) {
            [tempResults addObject:[ContactModel customCopy:model]];
        }
    }
    [self.searchResultArr removeAllObjects];
    [self.searchResultArr addObjectsFromArray:tempResults];
}

@end
