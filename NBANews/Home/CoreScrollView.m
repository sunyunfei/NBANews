//
//  CoreScrollView.m
//  无限视觉轮播
//
//  Created by 孙云飞 on 2016/10/9.
//  Copyright © 2016年 haidai. All rights reserved.
//

#import "CoreScrollView.h"
static NSInteger k_tagMargin = 1000;
@interface CoreScrollView()<UIScrollViewDelegate>
@property(nonatomic,strong)UIScrollView *coreView;
@property(nonatomic,strong)NSTimer *scrTimer;//轮播时间
@property(nonatomic,strong)UIPageControl *pageControl;//小点
@end
@implementation CoreScrollView

//构造
- (instancetype)initWithFrame:(CGRect)frame{

    self = [super initWithFrame:frame];
    if (self) {
        //设置
        self.coreView = [[UIScrollView alloc]initWithFrame:self.bounds];
        self.coreView.delegate = self;
        self.coreView.pagingEnabled = YES;
        self.coreView.decelerationRate = 0.1f;
        [self addSubview:self.coreView];
        self.coreView.showsVerticalScrollIndicator = NO;
        self.coreView.showsHorizontalScrollIndicator = NO;
        //轮播时间设置
        [self p_setScrTimer];
    }
    return self;
}

#pragma mark ----自动轮播设置
- (void)p_setScrTimer{

    self.scrTimer = [NSTimer timerWithTimeInterval:2.0 target:self selector:@selector(p_scrAgainTimer) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:self.scrTimer forMode:NSRunLoopCommonModes];
}
//轮播时间事件
- (void)p_scrAgainTimer{

    [self.coreView setContentOffset:CGPointMake(self.coreView.contentOffset.x + CGRectGetWidth(self.frame), 0) animated:YES];
    [self p_dealPageCurrent];
    [self p_alwaysScrollView];
}
#pragma mark-----数据ui加载
//数据加载
- (void)setHeaderArray:(NSArray *)headerArray{

    _headerArray = headerArray;
    //开始加载内部ui
    [self p_loadUI];
}
//ui加载
- (void)p_loadUI{

    
    for(int i = 0;i < self.headerArray.count + 2;i ++){
    
        UIImageView *imageScr = [[UIImageView alloc]initWithFrame:CGRectMake(i * CGRectGetWidth(self.frame), 0, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame))];
        UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(i * CGRectGetWidth(self.frame), CGRectGetHeight(self.frame) - 40, CGRectGetWidth(self.frame), 40)];
        titleLabel.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.3];
        titleLabel.textColor = [UIColor whiteColor];
        titleLabel.numberOfLines = 3;
        titleLabel.font = [UIFont systemFontOfSize:13];
        imageScr.userInteractionEnabled = YES;//打开交互
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clickImageEvent)];
        [imageScr addGestureRecognizer:tap];
        imageScr.tag = i + k_tagMargin;
        
        if (i <= 0) {
            HomeModel *model = self.headerArray[self.headerArray.count - 1];
           [imageScr sd_setImageWithURL:[NSURL URLWithString:model.home_image]];
            titleLabel.text = model.home_title;
        }else if (i >= self.headerArray.count + 1){
        
            HomeModel *model = self.headerArray[0];
            [imageScr sd_setImageWithURL:[NSURL URLWithString:model.home_image]];
            titleLabel.text = model.home_title;
        }else{
        
            HomeModel *model = self.headerArray[i - 1];
            [imageScr sd_setImageWithURL:[NSURL URLWithString:model.home_image]];
            titleLabel.text = model.home_title;
        }
        
        [self.coreView addSubview:imageScr];
        [self.coreView addSubview:titleLabel];
        
    }
    self.coreView.contentSize = CGSizeMake((self.headerArray.count + 2) * CGRectGetWidth(self.frame), 0);
    
    //默认显示的是处于下标为1的位置
    [self.coreView setContentOffset:CGPointMake(CGRectGetWidth(self.frame), 0) animated:NO];
    
    //设置page
    self.pageControl = [[UIPageControl alloc]initWithFrame:CGRectMake(0, CGRectGetHeight(self.frame) - 50, CGRectGetWidth(self.frame), 50)];
    self.pageControl.numberOfPages = self.headerArray.count;
    [self addSubview:self.pageControl];
}
//手势点击方法
- (void)clickImageEvent{

    //获取对应的现在轮播的位置
    int index = self.coreView.contentOffset.x / CGRectGetWidth(self.coreView.frame);
    HomeModel *model = self.headerArray[index - 1];
    if ([self.delegate respondsToSelector:@selector(tranTapEventToVC:)]) {
        [self.delegate tranTapEventToVC:model];
    }
}
#pragma mark ----代理
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{

    [self.scrTimer invalidate];
    self.scrTimer = nil;
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{

    [self p_setScrTimer];
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    [self p_dealPageCurrent];
    //无限轮播的转换
    [self p_alwaysScrollView];
    
}
#pragma mark -----两个核心方法
- (void)p_dealPageCurrent{

    //page的变动
    int intX = (self.coreView.contentOffset.x) / CGRectGetWidth(self.frame);
    if (intX <= 1) {
        self.pageControl.currentPage = 0;
    }else if (intX >= self.headerArray.count){
        
        self.pageControl.currentPage = self.headerArray.count;
    }else{
        
        self.pageControl.currentPage = intX - 1;
    }
}
//无限轮播处理
- (void)p_alwaysScrollView{

    //判断是否处于将要改变顺序的两个位置
    if (self.coreView.contentOffset.x == 0) {
       //转换到最后一个
        [self.coreView setContentOffset:CGPointMake((self.headerArray.count) * CGRectGetWidth(self.frame), 0) animated:NO];
    }else if (self.coreView.contentOffset.x == (self.headerArray.count + 1) * CGRectGetWidth(self.frame)){
        
        //转换到第一个
        [self.coreView setContentOffset:CGPointMake(CGRectGetWidth(self.frame), 0) animated:NO];
    }
}

@end
