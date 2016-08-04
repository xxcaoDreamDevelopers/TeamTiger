//
//  TTAddDiscussViewController.m
//  TeamTiger
//
//  Created by xxcao on 16/8/4.
//  Copyright © 2016年 MobileArtisan. All rights reserved.
//

#import "TTAddDiscussViewController.h"

@interface TTAddDiscussViewController ()

@end

@implementation TTAddDiscussViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"发起讨论";
    [self hyb_setNavLeftButtonTitle:@"返回" onCliked:^(UIButton *sender) {
        [Common customPopAnimationFromNavigation:self.navigationController Type:kCATransitionReveal SubType:kCATransitionFromBottom];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
