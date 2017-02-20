//
//  LikeVC.m
//  NBANews
//
//  Created by 孙云飞 on 2017/2/19.
//  Copyright © 2017年 孙云飞. All rights reserved.
//

#import "LikeVC.h"
#import "HomeCell.h"
#import "HomeModel.h"
#import "DetailsVC.h"
static NSString *like_cell = @"HomeCell";
@interface LikeVC ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)YFBaseTableView *tableView;
@property(nonatomic,strong)NSMutableArray *likeArray;
@end

@implementation LikeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.likeArray = [NSMutableArray array];
    [self p_loadTableView];
    [self p_loadHomeData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark-----数据加载
//单元格数据
- (void)p_loadHomeData{
    
    //查找home表
    BmobQuery   *bquery = [BmobQuery queryWithClassName:@"news_like"];
    //查找GameScore表里面id为0c6db13c的数据
    [bquery findObjectsInBackgroundWithBlock:^(NSArray *array, NSError *error) {
        
        if (!error) {
            
            for (BmobObject *obj in array) {
                
                HomeModel *model = [[HomeModel alloc]initWithBmob:obj isLikeVC:YES];
                [_likeArray addObject:model];
            }
            //刷新表
            [_tableView reloadData];
        }else{
            
            NSLog(@"error");
        }
        
    }];
}

#pragma mark ----ui加载
//表加载
- (void)p_loadTableView{
    
    self.tableView = [[YFBaseTableView alloc]initWithFrame:self.view.bounds];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView setViewColor];
    self.tableView.rowHeight = 90;
    self.tableView.separatorColor = [UIColor lightGrayColor];
    //注册单元格
    [self.tableView registerNib:[UINib nibWithNibName:like_cell bundle:nil] forCellReuseIdentifier:like_cell];
    //添加一个表尾，去除分割线
    self.tableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 0, 1)];
    [self.view addSubview:self.tableView];
}

#pragma mark ----delegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return _likeArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    HomeCell *cell = [tableView dequeueReusableCellWithIdentifier:like_cell forIndexPath:indexPath];
    cell.homeModel = self.likeArray[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    //选中状态消失
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    [self p_skipVC:self.likeArray[indexPath.row]];
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
