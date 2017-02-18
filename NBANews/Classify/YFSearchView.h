//
//  YFSearchView.h
//  NBANews
//
//  Created by 孙云飞 on 2017/2/18.
//  Copyright © 2017年 孙云飞. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol YFSearchViewDelegate <NSObject>

- (void)giveTextToVC:(NSString *)typeName;//传递搜索数据

@end
@interface YFSearchView : UIView
@property(nonatomic,weak)id<YFSearchViewDelegate>delegate;
@end
