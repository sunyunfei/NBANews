//
//  ClassCenterView.h
//  NBANews
//
//  Created by 孙云飞 on 2017/2/18.
//  Copyright © 2017年 孙云飞. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HomeModel.h"
@protocol ClassCenterViewDelegate <NSObject>

- (void)skipVcToShow:(HomeModel *)model;//跳转界面

@end
@interface ClassCenterView : UITableView
@property(nonatomic,copy)NSString *typeName;//查询条件
@property(nonatomic,weak)id<ClassCenterViewDelegate>centerDelegate;
@end
