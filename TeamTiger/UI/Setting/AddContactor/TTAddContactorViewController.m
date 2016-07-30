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

@interface TTAddContactorViewController ()<UISearchBarDelegate,UISearchDisplayDelegate>

@property (nonatomic,strong) UISearchBar *searchBar;//搜索框
@property (nonatomic,strong) UISearchDisplayController *searchDisplayController;//搜索VC
@end

@implementation TTAddContactorViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"添加成员";
    [self hyb_setNavLeftButtonTitle:@"返回" onCliked:^(UIButton *sender) {
        [self.navigationController popViewControllerAnimated:YES];
    }];
    [IQKeyboardManager sharedManager].shouldResignOnTouchOutside = YES;
    
    [Common removeExtraCellLines:self.contactTable];
    UIView *bgView = [[UIView alloc] init];
    bgView.backgroundColor = [UIColor colorWithRed:21/255.0f green:27/255.0f blue:39/255.0f alpha:1.0f];
    self.contactTable.backgroundView = bgView;
    
    self.contactTable.tableHeaderView = self.searchBar;
    [self searchDisplayController];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma -mark UITableView DataSource 
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 8;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIde = @"cellIde";
    ContactTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIde];
    if (!cell) {
        cell = [[ContactTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIde];
    }
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 28.0;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    //viewforHeader
    id label = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"headerView"];
    if (!label) {
        label = [[UILabel alloc] init];
        [label setFont:[UIFont systemFontOfSize:16.0f]];
        [label setTextColor:[UIColor colorWithRed:49.0/255 green:55.0/255 blue:64.0/255 alpha:1]];
        [label setBackgroundColor:[UIColor colorWithRed:20.0/255.0 green:25.0/255.0 blue:36.0/255.0 alpha:1.0]];
    }
    [label setText:[NSString stringWithFormat:@"  %@",@"1111"]];
    return label;
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
        
        UIImage *searchBarBg = [self GetImageWithColor:[UIColor colorWithRed:31.0 / 255.0 green:33.0 / 255.0 blue:43.0 / 255.0 alpha:1.0] andHeight:32.0f];
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
    }
    return _searchDisplayController;
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
    searchBar.showsCancelButton = YES;
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
    searchBar.showsCancelButton = NO;
}


#pragma -mark Other
/**
 *  生成图片
 *
 *  @param color  图片颜色
 *  @param height 图片高度
 *
 *  @return 生成的图片
 */
- (UIImage*) GetImageWithColor:(UIColor*)color andHeight:(CGFloat)height
{
    CGRect r= CGRectMake(0.0f, 0.0f, 1.0f, height);
    UIGraphicsBeginImageContext(r.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, r);
    
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return img;
}
@end
