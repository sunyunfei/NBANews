//
//  CommentFootView.h
//  NBANews
//
//  Created by 孙云飞 on 2017/2/18.
//  Copyright © 2017年 孙云飞. All rights reserved.
//
@protocol CommentFootViewDelegate <NSObject>

- (void)refreshData;//刷新评论数据

@end
#import <UIKit/UIKit.h>

@interface CommentFootView : UIView
@property(nonatomic,strong)NSNumber *homeId;//获取评论事件的id
@property(nonatomic,weak)id<CommentFootViewDelegate>delegate;
+ (instancetype)createView;//创建

@end
