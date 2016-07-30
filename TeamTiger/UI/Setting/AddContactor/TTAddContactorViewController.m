//
//  TTAddContactorViewController.m
//  TeamTiger
//
//  Created by xxcao on 16/7/30.
//  Copyright © 2016年 MobileArtisan. All rights reserved.
//

#import "TTAddContactorViewController.h"
#import "IQKeyboardManager.h"

@interface TTAddContactorViewController ()

@end

@implementation TTAddContactorViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"添加成员";
    [self hyb_setNavLeftButtonTitle:@"返回" onCliked:^(UIButton *sender) {
        [self.navigationController popViewControllerAnimated:YES];
    }];
    
    [IQKeyboardManager sharedManager].shouldResignOnTouchOutside = YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
