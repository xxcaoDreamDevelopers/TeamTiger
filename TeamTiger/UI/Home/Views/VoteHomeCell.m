//
//  VoteHomeCell.m
//  TeamTiger
//
//  Created by Dale on 16/8/5.
//  Copyright © 2016年 MobileArtisan. All rights reserved.
//

#import "VoteHomeCell.h"

@interface VoteHomeCell ()

@property (strong, nonatomic) DataManager *manager;
@property (assign, nonatomic) NSInteger index;
@end

@implementation VoteHomeCell

- (DataManager *)manager {
    if (_manager == nil) {
        _manager = [DataManager mainSingleton];
    }
    return _manager;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [Common removeExtraCellLines:self.tableView];
    [self.tableView registerNib:[UINib nibWithNibName:@"HomeDetailCell4" bundle:nil] forCellReuseIdentifier:@"cellIdentifier4"];
    [self.tableView registerNib:[UINib nibWithNibName:@"HomeDetailCell5" bundle:nil] forCellReuseIdentifier:@"cellIdentifier5"];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    HomeCellModel *cellModel = self.manager.dataSource[1];
    HomeDetailCellModel *model = cellModel.comment[self.manager.index1];
    if (model.isClick) {
        return cellModel.comment.count;
    }
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    HomeCellModel *cellModel = self.manager.dataSource[1];
    HomeDetailCellModel *model = cellModel.comment[indexPath.row];
    if (model.typeCell == TypeCellTimeAndTitle) {
        HomeDetailCell4 *cell = [tableView dequeueReusableCellWithIdentifier:@"cellIdentifier4"];
        [cell configureCellWithModel:model];
        if (indexPath.row == cellModel.comment.count - 1) {
            cell.lineView2.hidden = YES;
        }
        
        return cell;
    }else if (model.typeCell == TypeCellName){
        HomeDetailCell5 *cell = [tableView dequeueReusableCellWithIdentifier:@"cellIdentifier5"];
        kWeakObject(cell);
        if (!model.isClick) {
            cell.moreBtn.hidden = NO;
        }
        cell.clickBlock = ^() {
            self.manager.index1 = indexPath.row;
            weakObject.moreBtn.hidden = YES;
            model.isClick = YES;
            [tableView reloadData];
            CGFloat height = self.tableView.contentSize.height;
            [[NSNotificationCenter defaultCenter] postNotificationName:@"isClick" object:@{@"height":@(height), @"type":@"1"}];
        };
        return cell;
    }
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    HomeCellModel *cellModel = self.manager.dataSource[1];
    HomeDetailCellModel *model = cellModel.comment[indexPath.row];
    if (model.typeCell == TypeCellTimeAndTitle) {
        return 40;
    }else if (model.typeCell == TypeCellName){
        if (model.isClick) {
            return 40;
        }
        return 80;
    }
    return 0;
}

- (IBAction)handleBtnAction:(UIButton *)sender {
    if (self.clickBtn) {
        self.clickBtn(sender);
    }
}

- (void)configureCellWithModel:(HomeCellModel *)model {
   
    self.headImage.image = kImage(model.headImage);
    self.nameLB.text = model.name;
    self.typeLB.text = model.type;
    self.image1.image = kImage(model.image1);
    self.image2.image = kImage(model.image2);
    self.image3.image = kImage(model.image3);
    self.aDesLB.text = model.aDes;
    self.bDesLB.text = model.bDes;
    self.cDesLB.text = model.cDes;
    self.aProgress.progress = [model.aTicket floatValue];
    self.bProgress.progress = [model.bTicket floatValue];
    self.cProgress.progress = [model.cTicket floatValue];

    self.aTicketLB.text = [NSString stringWithFormat:@"%.0f票", (model.aTicket.floatValue) * 10];
    self.bTicketLB.text = [NSString stringWithFormat:@"%.0f票", (model.bTicket.floatValue) * 10];
    self.cTicketLB.text = [NSString stringWithFormat:@"%.0f票", (model.cTicket.floatValue) * 10];
    
    self.aPerLB.text = [NSString stringWithFormat:@"(%.0f%%)", (model.aTicket.floatValue) * 100];
    self.bPerLB.text = [NSString stringWithFormat:@"(%.0f%%)", (model.bTicket.floatValue) * 100];
    self.cPerLB.text = [NSString stringWithFormat:@"(%.0f%%)", (model.cTicket.floatValue) * 100];
    
}

@end
