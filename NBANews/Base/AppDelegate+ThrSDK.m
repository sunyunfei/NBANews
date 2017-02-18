//
//  AppDelegate+ThrSDK.m
//  NBANews
//
//  Created by 孙云飞 on 2017/2/17.
//  Copyright © 2017年 孙云飞. All rights reserved.
//

#import "AppDelegate+ThrSDK.h"
#import "IQKeyboardManager.h"
@implementation AppDelegate (ThrSDK)

//bmob的导入
- (void)loadBmobSDK{

    [Bmob registerWithAppKey:@"498a895e9239b1f08068933aa6ec70ad"];
}
//键盘框架使用
- (void)loadIQKeySDK{

    IQKeyboardManager *manager = [IQKeyboardManager sharedManager];
    manager.enable = YES;
    manager.shouldResignOnTouchOutside = YES;
    manager.enableAutoToolbar = NO;
}
@end
