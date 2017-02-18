//
//  YFRClassifyightView.h
//  NBANews
//
//  Created by 孙云飞 on 2017/2/18.
//  Copyright © 2017年 孙云飞. All rights reserved.
//
@protocol YFRClassifyightViewDelegate <NSObject>

- (void)hiddenOrShowRightView:(BOOL)flag;//是否显示分类视图
- (void)giveRightTextToVC:(NSString *)typeName;//传递需要搜索的数据

@end
#import <UIKit/UIKit.h>

@interface YFRClassifyightView : UIView
@property(nonatomic,weak)id<YFRClassifyightViewDelegate>delegate;
@end
