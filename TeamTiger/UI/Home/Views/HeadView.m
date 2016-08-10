//
//  HeadView.m
//  TeamTiger
//
//  Created by Dale on 16/8/10.
//  Copyright © 2016年 MobileArtisan. All rights reserved.
//

#import "HeadView.h"

@implementation HeadView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

+ (instancetype)headerViewWithTableView:(UITableView *)tableView {
    static NSString *headerViewID = @"headerView";
    HeadView *headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:headerViewID];
    if (headerView == nil) {
        headerView = LoadFromNib(@"HeadView");
    }
    return headerView;
}

- (IBAction)handleClickHeaderView:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(headViewDidClickWithHeadView:)]) {
        [self.delegate headViewDidClickWithHeadView:self];
    }
}


@end
