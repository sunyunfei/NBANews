//
//  YFMYRefresh.m
//  NBANews
//
//  Created by 孙云飞 on 2017/2/17.
//  Copyright © 2017年 孙云飞. All rights reserved.
//

#import "YFMYRefresh.h"

@implementation YFMYRefresh

//下啦刷新
+ (void)pushDownAndRefreshData:(UITableView *)tableView withResult:(void(^)())eventBlock{

    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        eventBlock();
    }];
    [header setTitle:@"刷新新闻" forState:MJRefreshStateIdle];
    [header setTitle:@"松开刷新" forState:MJRefreshStatePulling];
    [header setTitle:@"刷新中..." forState:MJRefreshStateRefreshing];
    tableView.mj_header = header;
}

//上啦加载
+ (void)pushUpAndMoreData:(UITableView *)tableView withResult:(void(^)())eventBlock{

    MJRefreshAutoNormalFooter *footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        
        eventBlock();
    }];
    [footer setTitle:@"松开加载新闻" forState:MJRefreshStateIdle];
    [footer setTitle:@"加载中..." forState:MJRefreshStateRefreshing];
    [footer setTitle:@"没有数据了" forState:MJRefreshStateNoMoreData];
    tableView.mj_footer = footer;
}

//下啦刷新
+ (void)pushDownAndRefreshCollectionView:(UICollectionView *)tableView withResult:(void(^)())eventBlock{

    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        eventBlock();
    }];
    [header setTitle:@"刷新新闻" forState:MJRefreshStateIdle];
    [header setTitle:@"松开刷新" forState:MJRefreshStatePulling];
    [header setTitle:@"刷新中..." forState:MJRefreshStateRefreshing];
    tableView.mj_header = header;
}

//上啦加载
+ (void)pushUpAndMoreCollectionView:(UICollectionView *)tableView withResult:(void(^)())eventBlock{

    MJRefreshAutoNormalFooter *footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        
        eventBlock();
    }];
    [footer setTitle:@"松开加载新闻" forState:MJRefreshStateIdle];
    [footer setTitle:@"加载中..." forState:MJRefreshStateRefreshing];
    [footer setTitle:@"没有数据了" forState:MJRefreshStateNoMoreData];
    tableView.mj_footer = footer;
}
@end
