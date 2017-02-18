//
//  YFDefaultsManager.m
//  NBANews
//
//  Created by 孙云飞 on 2017/2/18.
//  Copyright © 2017年 孙云飞. All rights reserved.
//

#import "YFDefaultsManager.h"

@implementation YFDefaultsManager

//存储登陆的状态
+ (void)saveBoolDefaults:(NSString *)name withData:(BOOL)flag{

    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setBool:flag forKey:name];
    [defaults synchronize];
}

//存储用户id
+ (void)saveNumber:(NSString *)name withData:(NSNumber *)userId{

    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:userId forKey:name];
    [defaults synchronize];
}

//获取登陆状态
+ (BOOL)obtainIsLoginStatus:(NSString *)name{

    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    return [defaults boolForKey:name];
}

//获取用户id
+(NSNumber*)obtainUserId:(NSString *)name{

    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    return [defaults objectForKey:name];
}

//删除用户信息
+ (void)deleteUserDataForUserStatus:(NSString *)name1 withUserId:(NSString *)name2{

    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults removeObjectForKey:name2];
    [defaults removeObjectForKey:name1];
    [defaults synchronize];
}
@end
