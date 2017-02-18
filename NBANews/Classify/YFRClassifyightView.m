//
//  YFRClassifyightView.m
//  NBANews
//
//  Created by 孙云飞 on 2017/2/18.
//  Copyright © 2017年 孙云飞. All rights reserved.
//

#import "YFRClassifyightView.h"
#import "ClassRightCell.h"
static NSString *right_cell = @"ClassRightCell";
@interface YFRClassifyightView()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView *tableView;//数据表
@property(nonatomic,strong)UIButton *activeBtn;//隐藏显示按钮
@property(nonatomic,strong)NSMutableArray *dataArray;//数据
@end
@implementation YFRClassifyightView

- (instancetype)initWithFrame:(CGRect)frame{

    self = [super initWithFrame:frame];
    if (self) {
        
        self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.frame) - 15, CGRectGetHeight(self.frame))];
        self.tableView.delegate = self;
        self.tableView.dataSource = self;
        [self.tableView registerNib:[UINib nibWithNibName:right_cell bundle:nil] forCellReuseIdentifier:right_cell];
        [self addSubview:self.tableView];
        
        self.activeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        self.activeBtn.frame = CGRectMake(CGRectGetWidth(self.frame) - 15, 0, 15, 15);
        self.activeBtn.backgroundColor = [UIColor redColor];
        [self.activeBtn addTarget:self action:@selector(clickActiveBtn:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:self.activeBtn];
    }
    return self;
}

- (void)layoutSubviews{

    //数据加载
    [self p_loadTypeData];
}

//按钮事件
- (void)clickActiveBtn:(UIButton *)sender{

    sender.selected = !sender.selected;
    if ([self.delegate respondsToSelector:@selector(hiddenOrShowRightView:)]) {
        [self.delegate hiddenOrShowRightView:sender.selected];
    }
}

#pragma mark ----数据

- (void)p_loadTypeData{

    _dataArray = [NSMutableArray array];
    //查找home表(测试用，以后可以建立一个表头数据表)
    BmobQuery   *bquery = [BmobQuery queryWithClassName:@"news_type"];
    [bquery findObjectsInBackgroundWithBlock:^(NSArray *array, NSError *error) {
        
        if (!error) {
            
            for (BmobObject *obj in array) {
               
                [_dataArray addObject:[obj objectForKey:@"type_name"]];
            }
            
            //默认显示第一个类别数据
            if ([self.delegate respondsToSelector:@selector(giveRightTextToVC:)]) {
                
                [self.delegate giveRightTextToVC:self.dataArray[0]];
            }
            
            [_tableView reloadData];
        }else{
            
            NSLog(@"error");
        }
        
    }];
}

#pragma mark ---代理
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    ClassRightCell *cell = [tableView dequeueReusableCellWithIdentifier:right_cell forIndexPath:indexPath];
    cell.typeName = self.dataArray[indexPath.row];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    return [tableView fd_heightForCellWithIdentifier:right_cell configuration:^(ClassRightCell *cell) {
        
        cell.typeName = self.dataArray[indexPath.row];
    }];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    if ([self.delegate respondsToSelector:@selector(giveRightTextToVC:)]) {
        
        [self.delegate giveRightTextToVC:self.dataArray[indexPath.row]];
    }
}
@end
