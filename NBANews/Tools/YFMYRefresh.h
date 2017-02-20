//
//  YFMYRefresh.h
//  NBANews
//
//  Created by 孙云飞 on 2017/2/17.
//  Copyright © 2017年 孙云飞. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YFMYRefresh : NSObject
//下啦刷新
+ (void)pushDownAndRefreshData:(UITableView *)tableView withResult:(void(^)())eventBlock;
//上啦加载
+ (void)pushUpAndMoreData:(UITableView *)tableView withResult:(void(^)())eventBlock;

//下啦刷新
+ (void)pushDownAndRefreshCollectionView:(UICollectionView *)tableView withResult:(void(^)())eventBlock;
//上啦加载
+ (void)pushUpAndMoreCollectionView:(UICollectionView *)tableView withResult:(void(^)())eventBlock;
@end
