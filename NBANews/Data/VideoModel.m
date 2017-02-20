//
//  ShowMainModel.m
//  VideoDemoToSun
//
//  Created by 涂婉丽 on 16/12/15.
//  Copyright © 2016年 涂婉丽. All rights reserved.
//

#import "VideoModel.h"

@implementation VideoModel
- (instancetype)initWithBmob:(BmobObject *)bmobObject{

    self = [super init];
    if (self) {

        if ([bmobObject objectForKey:@"video_content"]) {
            self.video_content = [bmobObject objectForKey:@"video_content"];
        }
        if ([bmobObject objectForKey:@"video_videoUrl"]) {
            self.video_videoUrl = [bmobObject objectForKey:@"video_videoUrl"];
        }
        if ([bmobObject objectForKey:@"video_coverUrl"]) {
            self.video_coverUrl = [bmobObject objectForKey:@"video_coverUrl"];
        }
        
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
        [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm"];
        
        self.video_createTime = [dateFormatter stringFromDate:bmobObject.updatedAt];
    }
    return self;
}
@end
