//
//  ClassCenterView.m
//  NBANews
//
//  Created by 孙云飞 on 2017/2/18.
//  Copyright © 2017年 孙云飞. All rights reserved.
//

#import "ClassCenterView.h"
#import "HomeModel.h"
#import "HomeCell.h"
static NSString *center_cell = @"HomeCell";
@interface ClassCenterView()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)NSMutableArray *dataArray;//数据
@property(nonatomic,assign)int lastIndex;
@end
@implementation ClassCenterView
- (instancetype)initWithFrame:(CGRect)frame{

    self = [super initWithFrame:frame];
    if (self) {
        self.dataArray = [NSMutableArray array];
        self.lastIndex = 0;
        self.delegate = self;
        self.dataSource = self;
        self.rowHeight = 90;
        self.separatorColor = [UIColor lightGrayColor];
        self.tableFooterView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 0, 1)];
        __block typeof(self)weakSelf = self;
        [YFMYRefresh pushDownAndRefreshData:self withResult:^{
            weakSelf.lastIndex = 0;
            [weakSelf.dataArray removeAllObjects];
            [weakSelf p_loadData];
        }];
        
        [YFMYRefresh pushUpAndMoreData:self withResult:^{
            [weakSelf p_loadData];
        }];
        [self registerNib:[UINib nibWithNibName:center_cell bundle:nil] forCellReuseIdentifier:center_cell];
    }
    return self;
}

//数据
- (void)setTypeName:(NSString *)typeName{

    _typeName = typeName;
    self.lastIndex = 0;
    [self.dataArray removeAllObjects];
    [self p_loadData];
}

- (void)p_loadData{

    //查找home表
    BmobQuery   *bquery = [BmobQuery queryWithClassName:@"news_home"];
    [bquery whereKey:@"home_type" equalTo:self.typeName];
    bquery.limit = 20;
    bquery.skip = self.lastIndex;
    //查找GameScore表里面id为0c6db13c的数据
    [bquery findObjectsInBackgroundWithBlock:^(NSArray *array, NSError *error) {
        
        if (!error) {
            
            for (BmobObject *obj in array) {
                
                HomeModel *model = [[HomeModel alloc]initWithBmob:obj];
                [_dataArray addObject:model];
            }
            //刷新表
            [self reloadData];
            //结束刷新
            [self.mj_header endRefreshing];
            [self.mj_footer endRefreshing];
            self.lastIndex += 20;
        }else{
            
            NSLog(@"error");
        }
        
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    HomeCell *cell = [tableView dequeueReusableCellWithIdentifier:center_cell forIndexPath:indexPath];
    cell.homeModel = self.dataArray[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    [self deselectRowAtIndexPath:indexPath animated:YES];
    //代理跳转
    if ([self.centerDelegate respondsToSelector:@selector(skipVcToShow:)]) {
        [self.centerDelegate skipVcToShow:self.dataArray[indexPath.row]];
    }
}
@end
