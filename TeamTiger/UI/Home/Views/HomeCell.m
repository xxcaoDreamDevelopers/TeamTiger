//
//  HomeCell.m
//  TeamTiger
//
//  Created by Dale on 16/8/1.
//  Copyright © 2016年 MobileArtisan. All rights reserved.
//

#import "HomeCell.h"
#import "HomeDetailCell.h"
#import "HomeDetailCell1.h"
#import "HomeDetailCell2.h"
#import "HomeDetailCellModel.h"

@interface HomeCell ()

@property (strong, nonatomic) NSMutableArray *dataSource;

@end

@implementation HomeCell

- (NSMutableArray *)dataSource {
    if (_dataSource == nil) {
        _dataSource = [NSMutableArray array];
        NSDictionary *dic1 = @{@"time":@"19:50", @"firstName":@"唐小旭", @"secondName":@"@卞克", @"des":@"TypeSomething...", @"firstImage":@"placeImage", @"secondImage":@"placeImage", @"typeCell":@(TypeCellImage)};
        HomeDetailCellModel *model1 = [[HomeDetailCellModel alloc] init];
        [model1 setValuesForKeysWithDictionary:dic1];
        [_dataSource addObject:model1];
        
        NSDictionary *dic2 = @{@"time":@"13:55", @"firstName":@"卞克", @"secondName":@"@唐小旭", @"des":@"TypeSomething...", @"firstImage":@"placeImage", @"secondImage":@"placeImage", @"typeCell":@(TypeCellTitle)};
        HomeDetailCellModel *model2 = [[HomeDetailCellModel alloc] init];
        [model2 setValuesForKeysWithDictionary:dic2];
        [_dataSource addObject:model2];
        
        NSDictionary *dic3 = @{@"time":@"9:00", @"firstName":@"齐云猛", @"secondName":@"", @"des":@"TypeSomething...", @"secondImage":@"placeImage", @"firstImage":@"placeImage", @"typeCell":@(TypeCellTitle)};
        HomeDetailCellModel *model3 = [[HomeDetailCellModel alloc] init];
        [model3 setValuesForKeysWithDictionary:dic3];
        [_dataSource addObject:model3];
        
        NSDictionary *dic4 = @{@"time":@"昨天", @"firstName":@"2016年7月18日", @"secondName":@"@唐小旭", @"des":@"TypeSomething...", @"firstImage":@"placeImage", @"secondImage":@"placeImage", @"typeCell":@(TypeCellTime)};
        HomeDetailCellModel *model4 = [[HomeDetailCellModel alloc] init];
        [model4 setValuesForKeysWithDictionary:dic4];
        [_dataSource addObject:model4];
        
        NSDictionary *dic5 = @{@"time":@"13:55", @"firstName":@"俞弦", @"secondName":@"", @"des":@"TypeSomething...", @"firstImage":@"placeImage", @"secondImage":@"placeImage", @"typeCell":@(TypeCellTitle)};
        HomeDetailCellModel *model5 = [[HomeDetailCellModel alloc] init];
        [model5 setValuesForKeysWithDictionary:dic5];
        [_dataSource addObject:model5];
        
    }
    return _dataSource;
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [Common removeExtraCellLines:self.tableView];
    [self.tableView registerNib:[UINib nibWithNibName:@"HomeDetailCell" bundle:nil] forCellReuseIdentifier:@"cellIdentifier"];
    [self.tableView registerNib:[UINib nibWithNibName:@"HomeDetailCell1" bundle:nil] forCellReuseIdentifier:@"cellIdentifier1"];
    [self.tableView registerNib:[UINib nibWithNibName:@"HomeDetailCell2" bundle:nil] forCellReuseIdentifier:@"cellIdentifier2"];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

- (void)configureCellWithModel:(HomeCellModel *)model {
    self.nameLB.text = model.name;
    self.typeLB.text = model.type;
}

#pragma mark UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (self.isOpen) {
        return self.dataSource.count;
    }else {
        return 3;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    HomeDetailCellModel *model = self.dataSource[indexPath.row];
    if (model.typeCell == TypeCellImage) {
        HomeDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellIdentifier" forIndexPath:indexPath];
        [cell configureCellWithModel:model];
        return cell;
    }else if (model.typeCell == TypeCellTitle) {
        HomeDetailCell1 *cell = [tableView dequeueReusableCellWithIdentifier:@"cellIdentifier1" forIndexPath:indexPath];
        if (indexPath.row == 1) {
            cell.moreBtn.hidden = YES;
        }
        typeof(cell) weakCell = cell;
        cell.clickMoreBtn = ^() {
            weakCell.moreBtn.hidden = YES;
            self.isOpen = YES;
            [tableView reloadData];
        };
        if (self.isOpen) {
            cell.moreBtn.hidden = YES;
        }
        [cell configureCellWithModel:model];
        return cell;
    }else if (model.typeCell == TypeCellTime){
        HomeDetailCell2 *cell = [tableView dequeueReusableCellWithIdentifier:@"cellIdentifier2" forIndexPath:indexPath];
        if (indexPath.row == self.dataSource.count - 1) {
            cell.line2.hidden = YES;
        }
        [cell configureCellWithModel:model];
        return cell;
    }
    return nil;
}

#pragma mark UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    HomeDetailCellModel *model = self.dataSource[indexPath.row];
    switch (model.typeCell) {
        case TypeCellImage:
            return 160;
            break;
        case TypeCellTitle:{
            if (indexPath.row == 2) {
                if (self.isOpen) {
                    return 60;
                }
                return 100;
            } else {
                return 60;
            }
        }
            break;
        case TypeCellTime:
            return 30;
            break;
        default:
            break;
    }
    return 0;
}

- (IBAction)handleMoreAction:(UIButton *)sender {
    if (self.clickBlock) {
        self.clickBlock();
    }
}

- (IBAction)hanldeCommentAction:(UIButton *)sender {
}


@end
