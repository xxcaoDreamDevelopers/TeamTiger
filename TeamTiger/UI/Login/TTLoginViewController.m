//
//  TTLoginViewController.m
//  TeamTiger
//
//  Created by xxcao on 16/8/4.
//  Copyright © 2016年 MobileArtisan. All rights reserved.
//

#import "TTLoginViewController.h"
#import "UIControl+YYAdd.h"
#import "AppDelegate.h"
#import "WXApiRequestHandler.h"
#import "Constant.h"
#import "WXApi.h"
#import "UIAlertView+HYBHelperKit.h"

@interface TTLoginViewController ()

@end

@implementation TTLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self.loginBtn addBlockForControlEvents:UIControlEventTouchUpInside block:^(id  _Nonnull sender) {
        UIViewController *rootVC = [kAppDelegate creatHomeVC];
        UIWindow *window = kAppDelegate.window;
        window.rootViewController = rootVC;
        [window makeKeyAndVisible];
//
//        if ([WXApi isWXAppInstalled]) {
//            [WXApiRequestHandler sendAuthRequestScope:kAuthScope
//                                                State:kAuthState
//                                               OpenID:kAuthOpenID
//                                     InViewController:self];
//        } else {
//            [UIAlertView hyb_showWithTitle:@"提醒" message:@"不装微信怎么玩儿？" buttonTitles:@[@"确定"] block:nil];
//        }
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
