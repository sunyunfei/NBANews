//
//  ShowMainModel.h
//  VideoDemoToSun
//
//  Created by 涂婉丽 on 16/12/15.
//  Copyright © 2016年 涂婉丽. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface VideoModel : NSObject
@property (nonatomic, copy) NSString *video_createTime;//时间
@property (nonatomic, copy) NSString *video_content;//内容
@property (nonatomic, copy) NSString *video_videoUrl;//视频链接
@property (nonatomic, copy) NSString *video_coverUrl;//封面链接
- (instancetype)initWithBmob:(BmobObject *)bmobObject;
@end
