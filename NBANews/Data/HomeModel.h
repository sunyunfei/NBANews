//
//  HomeModel.h
//  NBANews
//
//  Created by 孙云飞 on 2017/2/17.
//  Copyright © 2017年 孙云飞. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HomeModel : NSObject
@property(nonatomic,strong)NSNumber *home_id;
@property(nonatomic,copy)NSString *home_image;
@property(nonatomic,copy)NSString *home_title;
@property(nonatomic,copy)NSString *home_time;
@property(nonatomic,copy)NSString *home_url;
@property(nonatomic,copy)NSString *home_type;
//创建
- (instancetype)initWithBmob:(BmobObject *)bmobObject isLikeVC:(BOOL)flag;
@end
