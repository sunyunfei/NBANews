//
//  CommentModel.h
//  NBANews
//
//  Created by 孙云飞 on 2017/2/17.
//  Copyright © 2017年 孙云飞. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CommentModel : NSObject
@property(nonatomic,strong)NSNumber *comment_id;
@property(nonatomic,copy)NSString *comment_name;
@property(nonatomic,copy)NSString *comment_icon;
@property(nonatomic,copy)NSString *comment_time;
@property(nonatomic,copy)NSString *comment_content;
- (instancetype)initWithBmob:(BmobObject *)obj;
@end
