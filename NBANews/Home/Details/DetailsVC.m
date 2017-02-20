//
//  DetailsVC.m
//  NBANews
//
//  Created by 孙云飞 on 2017/2/17.
//  Copyright © 2017年 孙云飞. All rights reserved.
//

#import "DetailsVC.h"
#import "CommentVC.h"
@interface DetailsVC ()<UIWebViewDelegate>
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
    _webView.delegate = self;
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
    
    //首先判断是否已经登陆
    if ([YFDefaultsManager obtainIsLoginStatus:login_status]) {
       
        BmobObject *newData = [BmobObject objectWithClassName:@"news_like"];
        [newData setObject:[YFDefaultsManager obtainUserId:login_userId] forKey:@"user_id"];
        [newData setObject:self.homeModel.home_title forKey:@"home_title"];
        [newData setObject:self.homeModel.home_url forKey:@"home_url"];
        [newData setObject:self.homeModel.home_time forKey:@"home_time"];
        [newData setObject:self.homeModel.home_image forKey:@"home_image"];
        [newData setObject:self.homeModel.home_id forKey:@"home_id"];
        [newData setObject:self.homeModel.home_type forKey:@"home_type"];
        
        [newData saveInBackgroundWithResultBlock:^(BOOL isSuccessful, NSError *error) {
            
            if (isSuccessful) {
                
                NSLog(@"收藏成功");
            }else{
                
                NSLog(@"收藏失败");
            }
        }];
    }else{
    
        [LoginManager skipLoginVC];
    }
    
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

#pragma mark ---代理
-(void)webViewDidFinishLoad:(UIWebView *)webView
{
    if ([YFDefaultsManager obtainIsNightStatus]) {
        
        //字体颜色
        [webView stringByEvaluatingJavaScriptFromString:@"document.getElementsByTagName('body')[0].style.webkitTextFillColor= 'white'"];
        //页面背景色
        [webView stringByEvaluatingJavaScriptFromString:@"document.getElementsByTagName('body')[0].style.background='black'"];
    }
    
}

@end
