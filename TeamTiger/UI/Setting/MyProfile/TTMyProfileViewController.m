//
//  TTMyProfileViewController.m
//  TeamTiger
//
//  Created by xxcao on 16/8/4.
//  Copyright © 2016年 MobileArtisan. All rights reserved.
//

#import "TTMyProfileViewController.h"

@interface TTMyProfileViewController ()

@end

@implementation TTMyProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我的信息";
    [self hyb_setNavLeftButtonTitle:@"返回" onCliked:^(UIButton *sender) {
        [self dismissViewControllerAnimated:YES completion:^{
        }];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
