//
//  UserModel.h
//  NBANews
//
//  Created by 孙云飞 on 2017/2/18.
//  Copyright © 2017年 孙云飞. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserModel : NSObject
@property(nonatomic,strong)NSNumber *user_id;
@property(nonatomic,copy)NSString *user_account;
@property(nonatomic,copy)NSString *user_pwd;
@property(nonatomic,copy)NSString *user_troops;
@end
