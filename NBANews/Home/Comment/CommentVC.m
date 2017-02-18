//
//  CommentVC.m
//  NBANews
//
//  Created by 孙云飞 on 2017/2/17.
//  Copyright © 2017年 孙云飞. All rights reserved.
//

#import "CommentVC.h"
#import "CommentCell.h"
#import "CommentModel.h"
#import "CommentFootView.h"
static NSString *comment_cell =@"CommentCell";
@interface CommentVC ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView *tableView;//数据表
@property(nonatomic,strong)NSMutableArray *commentArray;//数据
@property(nonatomic,assign)int lastIndex;//最后一条数据的位置
@end

@implementation CommentVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.lastIndex = 0;
    self.commentArray = [NSMutableArray array];
    [self p_loadTableView];
    [self p_loadFootView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark ----data
//数据查询
- (void)p_loadCommentData{

    //查找home表
    BmobQuery   *bquery = [BmobQuery queryWithClassName:@"news_comment"];
    [bquery whereKey:@"home_id" equalTo:self.homeId];
    bquery.skip = self.lastIndex;
    //查找GameScore表里面id为0c6db13c的数据
    [bquery findObjectsInBackgroundWithBlock:^(NSArray *array, NSError *error) {
        
        if (!error) {
            
            for (BmobObject *obj in array) {
                
                CommentModel *model = [[CommentModel alloc]initWithBmob:obj];
                [_commentArray addObject:model];
            }
            //刷新表
            [_tableView reloadData];
            //结束刷新
            [self.tableView.mj_header endRefreshing];
            [self.tableView.mj_footer endRefreshing];
            self.lastIndex += 100;
        }else{
            
            NSLog(@"error");
        }
        
    }];
}
#pragma mark ----加载ui

- (void)p_loadTableView{

    self.tableView = [[UITableView alloc]initWithFrame:self.view.bounds];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    //注册
    [self.tableView registerNib:[UINib nibWithNibName:comment_cell bundle:nil] forCellReuseIdentifier:comment_cell];
    self.tableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 0, 1)];
    [self.view addSubview:self.tableView];
    //刷新加载
    __block typeof(self)weakSelf = self;
    [YFMYRefresh pushDownAndRefreshData:self.tableView withResult:^{
        
        [weakSelf.commentArray removeAllObjects];
        weakSelf.lastIndex = 0;
        [weakSelf p_loadCommentData];
    }];
    [YFMYRefresh pushUpAndMoreData:self.tableView withResult:^{
        
        [weakSelf p_loadCommentData];
    }];
    //数据加载
    [self p_loadCommentData];
}

//加载底部视图
- (void)p_loadFootView{

    CommentFootView *footView = [CommentFootView createView];
    footView.frame = CGRectMake(0, K_H - 49, K_W, 49);
    footView.homeId = self.homeId;
    [self.view addSubview:footView];
}
#pragma mark ----delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return self.commentArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    CommentCell *cell = [tableView dequeueReusableCellWithIdentifier:comment_cell forIndexPath:indexPath];
    cell.commentModel = self.commentArray[indexPath.row];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    return [tableView fd_heightForCellWithIdentifier:comment_cell configuration:^(CommentCell *cell) {
        
        cell.commentModel = self.commentArray[indexPath.row];
    }];
}
@end
