//
//  CommentModel.m
//  NBANews
//
//  Created by 孙云飞 on 2017/2/17.
//  Copyright © 2017年 孙云飞. All rights reserved.
//

#import "CommentModel.h"

@implementation CommentModel

- (instancetype)initWithBmob:(BmobObject *)obj{

    self = [super init];
    if (self) {
        
        if ([obj objectForKey:@"comment_id"]) {
            self.comment_id = [obj objectForKey:@"comment_id"];
        }
        if ([obj objectForKey:@"comment_name"]) {
            self.comment_name = [obj objectForKey:@"comment_name"];
        }
        if ([obj objectForKey:@"comment_icon"]) {
            self.comment_icon = [obj objectForKey:@"comment_icon"];
        }
        if ([obj objectForKey:@"comment_content"]) {
            self.comment_content = [obj objectForKey:@"comment_content"];
        }
        
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
        [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm"];
        
        self.comment_time = [dateFormatter stringFromDate:obj.updatedAt];
    }
    return self;
}
@end
