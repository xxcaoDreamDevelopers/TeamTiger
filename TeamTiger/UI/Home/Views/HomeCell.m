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

@implementation HomeCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [Common removeExtraCellLines:self.tableView];
    [self.tableView registerNib:[UINib nibWithNibName:@"HomeDetailCell" bundle:nil] forCellReuseIdentifier:@"cellIdentifier"];
    [self.tableView registerNib:[UINib nibWithNibName:@"HomeDetailCell1" bundle:nil] forCellReuseIdentifier:@"cellIdentifier1"];
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
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if ( indexPath.row == 0) {
        HomeDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellIdentifier" forIndexPath:indexPath];
        return cell;
    }else {
        HomeDetailCell1 *cell = [tableView dequeueReusableCellWithIdentifier:@"cellIdentifier1" forIndexPath:indexPath];
        if (indexPath.row == 1) {
            cell.moreBtn.hidden = YES;
        }
        return cell;
    }
}

#pragma mark UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        return 170;
    }else if (indexPath.row ==1){
        return 70;
    }else {
        return 100;
    }
}

- (IBAction)handleMoreAction:(UIButton *)sender {
    if (self.clickBlock) {
        self.clickBlock();
    }
}

- (IBAction)hanldeCommentAction:(UIButton *)sender {
}


@end
