//
//  YFDefaultsManager.h
//  NBANews
//
//  Created by 孙云飞 on 2017/2/18.
//  Copyright © 2017年 孙云飞. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YFDefaultsManager : NSObject
//存储登陆的状态
+ (void)saveBoolDefaults:(NSString *)name withData:(BOOL)flag;
//存储用户id
+ (void)saveNumber:(NSString *)name withData:(NSNumber *)userId;
//获取登陆状态
+ (BOOL)obtainIsLoginStatus:(NSString *)name;
//获取用户id
+(NSNumber*)obtainUserId:(NSString *)name;

//删除用户信息
+ (void)deleteUserDataForUserStatus:(NSString *)name1 withUserId:(NSString *)name2;
@end
