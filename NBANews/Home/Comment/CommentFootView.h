//
//  CommentFootView.h
//  NBANews
//
//  Created by 孙云飞 on 2017/2/18.
//  Copyright © 2017年 孙云飞. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CommentFootView : UIView
@property(nonatomic,strong)NSNumber *homeId;//获取评论事件的id
+ (instancetype)createView;//创建
@end
