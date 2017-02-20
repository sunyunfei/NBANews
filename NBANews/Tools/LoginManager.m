//
//  LoginManager.m
//  NBANews
//
//  Created by 孙云飞 on 2017/2/18.
//  Copyright © 2017年 孙云飞. All rights reserved.
//

#import "LoginManager.h"
#import "LoginVC.h"
@implementation LoginManager
+ (void)skipLoginVC{

    //登陆/注册
    UIStoryboard *story = [UIStoryboard storyboardWithName:@"Login" bundle:nil];
    LoginVC *loginVC = [story instantiateViewControllerWithIdentifier:@"LoginVC"];
    loginVC.title = @"登陆";
    YFBaseNav *nav = [[YFBaseNav alloc]initWithRootViewController:loginVC];
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:nav animated:YES completion:nil];
}
@end
