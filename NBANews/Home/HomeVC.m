//
//  HomeVC.m
//  NBANews
//
//  Created by 孙云飞 on 2017/2/17.
//  Copyright © 2017年 孙云飞. All rights reserved.
//

#import "HomeVC.h"
#import "HomeModel.h"
#import "HomeCell.h"
#import "CoreScrollView.h"
#import "DetailsVC.h"
static NSString *home_cell = @"HomeCell";//用作注册单元格用
@interface HomeVC ()<UITableViewDelegate,UITableViewDataSource,CoreScrollViewDelegate>
@property(nonatomic,strong)UITableView *tableView;//数据表
@property(nonatomic,strong)NSMutableArray *homeArray;//data
@property(nonatomic,strong)NSMutableArray *headerArray;//表头数据
@property(nonatomic,strong)CoreScrollView *scrollView;//无限轮播
@property(nonatomic,assign)int lastIndex;//加载的最后一个位置下标
@end

@implementation HomeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.homeArray = [NSMutableArray array];
    self.lastIndex = 0;
    //ui加载
    [self p_loadTableView];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

#pragma mark-----数据加载
//单元格数据
- (void)p_loadHomeData{

    //查找home表
    BmobQuery   *bquery = [BmobQuery queryWithClassName:@"news_home"];
    //每次查询得到最多20个结果
    bquery.limit = 20;
    bquery.skip = self.lastIndex;
    //查找GameScore表里面id为0c6db13c的数据
    [bquery findObjectsInBackgroundWithBlock:^(NSArray *array, NSError *error) {
        
        if (!error) {
            
            for (BmobObject *obj in array) {
                
                HomeModel *model = [[HomeModel alloc]initWithBmob:obj];
                [_homeArray addObject:model];
            }
            
            self.lastIndex += 20;
            //刷新表
            [_tableView reloadData];
            //结束刷新
            [self.tableView.mj_header endRefreshing];
            [self.tableView.mj_footer endRefreshing];
        }else{
            
            NSLog(@"error");
        }
        
    }];
}
//表头数据加载
- (void)p_loadHeaderData{

    self.headerArray = [NSMutableArray array];
    //查找home表(测试用，以后可以建立一个表头数据表)
    BmobQuery   *bquery = [BmobQuery queryWithClassName:@"news_home"];
    //每次查询得到最多20个结果
    bquery.limit = 5;
    //查找GameScore表里面id为0c6db13c的数据
    [bquery findObjectsInBackgroundWithBlock:^(NSArray *array, NSError *error) {
        
        if (!error) {
            
            for (BmobObject *obj in array) {
                
                HomeModel *model = [[HomeModel alloc]initWithBmob:obj];
                [_headerArray addObject:model];
            }
            //刷新表
            _scrollView.headerArray = _headerArray;
            [_tableView reloadData];
        }else{
            
            NSLog(@"error");
        }
        
    }];
}
#pragma mark ----ui加载
//表加载
- (void)p_loadTableView{

    self.tableView = [[UITableView alloc]initWithFrame:self.view.bounds];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.rowHeight = 90;
    self.tableView.separatorColor = [UIColor lightGrayColor];
    //注册单元格
    [self.tableView registerNib:[UINib nibWithNibName:home_cell bundle:nil] forCellReuseIdentifier:home_cell];
    //添加一个表尾，去除分割线
    self.tableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 0, 1)];
    [self p_loadHeaderView];
    [self.view addSubview:self.tableView];
    
    //下啦刷新
    __block typeof(self)weakSelf = self;
    [YFMYRefresh pushDownAndRefreshData:self.tableView withResult:^{
        
        //数据加载
        [weakSelf.homeArray removeAllObjects];
        weakSelf.lastIndex = 0;
        [weakSelf p_loadHomeData];
    }];
    //上啦加载
    [YFMYRefresh pushUpAndMoreData:self.tableView withResult:^{
        
        [weakSelf p_loadHomeData];
        [weakSelf p_loadHeaderData];
        
    }];
    //数据加载
    [self p_loadHomeData];
}
//表头加载
- (void)p_loadHeaderView{

    self.scrollView = [[CoreScrollView alloc]initWithFrame:CGRectMake(0, 0, K_W, 200)];
    self.scrollView.delegate = self;
    self.tableView.tableHeaderView = self.scrollView;
    //头部数据加载
    [self p_loadHeaderData];
}
#pragma mark ----delegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return _homeArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    HomeCell *cell = [tableView dequeueReusableCellWithIdentifier:home_cell forIndexPath:indexPath];
    cell.homeModel = self.homeArray[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    //选中状态消失
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    [self p_skipVC:self.homeArray[indexPath.row]];
}

//传递点击数据
- (void)tranTapEventToVC:(HomeModel *)model{

    [self p_skipVC:model];
}

//跳转界面
- (void)p_skipVC:(HomeModel *)model{

    UIStoryboard *story = [UIStoryboard storyboardWithName:@"DetailsVC" bundle:nil];
    DetailsVC *vc = [story instantiateViewControllerWithIdentifier:@"details"];
    vc.title = model.home_title;
    vc.homeModel = model;
    self.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
    self.hidesBottomBarWhenPushed = NO;
}
@end
