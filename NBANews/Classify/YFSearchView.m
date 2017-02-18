//
//  YFSearchView.m
//  NBANews
//
//  Created by 孙云飞 on 2017/2/18.
//  Copyright © 2017年 孙云飞. All rights reserved.
//

#import "YFSearchView.h"
#import "HomeModel.h"
@interface YFSearchView()<UISearchBarDelegate>
@property(nonatomic,strong)UISearchBar *searchBar;//搜索
@property(nonatomic,strong)UIButton *searchBtn;//搜索按钮
@end
@implementation YFSearchView

- (instancetype)initWithFrame:(CGRect)frame{

    self = [super initWithFrame: frame];
    if (self) {
        
        self.searchBar = [[UISearchBar alloc]initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.frame)- CGRectGetHeight(self.frame),CGRectGetHeight(self.frame))];
        self.searchBar.delegate = self;
        self.searchBar.showsCancelButton = NO;
        self.searchBar.searchBarStyle = UISearchBarStyleMinimal;
        [self addSubview:self.searchBar];
        
        self.searchBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        self.searchBtn.frame = CGRectMake(CGRectGetWidth(self.frame)- CGRectGetHeight(self.frame), 0, CGRectGetHeight(self.frame), CGRectGetHeight(self.frame));
        [self.searchBtn setTitle:@"搜索" forState:UIControlStateNormal];
        self.searchBtn.backgroundColor = [UIColor redColor];
        [self.searchBtn addTarget:self action:@selector(clickSearchBtn) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:self.searchBtn];
    }
    return self;
}

//按钮事件
- (void)clickSearchBtn{

    //判断是否有内容
    if (self.searchBar.text.length <= 0) {
        NSLog(@"搜索内容为空");
        return;
    }
    //键盘消失
    [self.searchBar resignFirstResponder];
    //代理传旨
    if ([self.delegate respondsToSelector:@selector(giveTextToVC:)]) {
        [self.delegate giveTextToVC:self.searchBar.text];
    }
}
@end
