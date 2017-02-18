//
//  CoreScrollView.h
//  无限视觉轮播
//
//  Created by 孙云飞 on 2016/10/9.
//  Copyright © 2016年 haidai. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HomeModel.h"
@protocol CoreScrollViewDelegate <NSObject>

- (void)tranTapEventToVC:(HomeModel *)model;//传递点击数据

@end
@interface CoreScrollView : UIView
@property(nonatomic,strong)NSArray *headerArray;//数据
@property(nonatomic,weak)id<CoreScrollViewDelegate>delegate;
@end
