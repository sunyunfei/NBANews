//
//  DetailsVC.m
//  NBANews
//
//  Created by 孙云飞 on 2017/2/17.
//  Copyright © 2017年 孙云飞. All rights reserved.
//

#import "DetailsVC.h"
#import "CommentVC.h"
@interface DetailsVC ()
//加载网页
@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (weak, nonatomic) IBOutlet UIView *footView;//底部视图
- (IBAction)clickLikeBtn:(UIButton *)sender;//点击收藏
- (IBAction)clickCommentBtn:(UIButton *)sender;//点击评论
- (IBAction)clickShareBtn:(UIButton *)sender;//点击分享
@end

@implementation DetailsVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.footView.hidden = YES;
    //加载网页
    [_webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.homeModel.home_url]]];
    [_webView sizeToFit];
}

- (void)viewDidAppear:(BOOL)animated{

    [super viewDidAppear:animated];
    self.footView.hidden = NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

#pragma mark -----按钮事件
//点击收藏
- (IBAction)clickLikeBtn:(UIButton *)sender {
}
//点击评论
- (IBAction)clickCommentBtn:(UIButton *)sender {
    
    //跳转
    CommentVC *commentVC = [[CommentVC alloc]init];
    commentVC.homeId = self.homeModel.home_id;
    self.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:commentVC animated:YES];
}
//点击分享
- (IBAction)clickShareBtn:(UIButton *)sender {
}

@end
