//
//  HomeModel.m
//  NBANews
//
//  Created by 孙云飞 on 2017/2/17.
//  Copyright © 2017年 孙云飞. All rights reserved.
//

#import "HomeModel.h"

@implementation HomeModel
//创建
- (instancetype)initWithBmob:(BmobObject *)bmobObject{

    self = [super init];
    //数据转模型
    if (self) {
        
        if ([bmobObject objectForKey:@"home_id"]) {
            
            self.home_id = [bmobObject objectForKey:@"home_id"];
        }
        if ([bmobObject objectForKey:@"home_image"]) {
            self.home_image = [bmobObject objectForKey:@"home_image"];
        }
        if ([bmobObject objectForKey:@"home_title"]) {
            self.home_title = [bmobObject objectForKey:@"home_title"];
        }
        if ([bmobObject objectForKey:@"home_url"]) {
            self.home_url = [bmobObject objectForKey:@"home_url"];
        }
        if ([bmobObject objectForKey:@"home_type"]) {
            self.home_type = [bmobObject objectForKey:@"home_type"];
        }
        
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
        [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm"];
        
        self.home_time = [dateFormatter stringFromDate:bmobObject.updatedAt];
    }
    return self;
}
@end
