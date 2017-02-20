//
//  ClassifyVC.m
//  NBANews
//
//  Created by 孙云飞 on 2017/2/18.
//  Copyright © 2017年 孙云飞. All rights reserved.
//

#import "ClassifyVC.h"
#import "YFSearchView.h"
#import "YFRClassifyightView.h"
#import "ClassCenterView.h"
#import "DetailsVC.h"
@interface ClassifyVC ()<YFSearchViewDelegate,YFRClassifyightViewDelegate,ClassCenterViewDelegate>
@property(nonatomic,strong)YFSearchView *searchView;//搜索视图
@property(nonatomic,strong)YFRClassifyightView *rightView;//类别视图
@property(nonatomic,strong)ClassCenterView *centerView;//显示数据视图
@end

@implementation ClassifyVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self p_loadClassView];
    [self p_loadCenterView];
}

- (void)viewWillAppear:(BOOL)animated{

    [super viewWillAppear:animated];
    [self p_loadSearchView];
}

- (void)viewWillDisappear:(BOOL)animated{

    [super viewWillDisappear:animated];
    [self.searchView removeFromSuperview];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

#pragma mark ---ui

//加载搜索视图
- (void)p_loadSearchView{

    CGRect mainViewBounds = self.navigationController.view.bounds;
    self.searchView = [[YFSearchView alloc]initWithFrame:CGRectMake(8, CGRectGetMinY(mainViewBounds)+22, K_W - 16, 40)];
    self.searchView.delegate = self;
    [self.navigationController.view addSubview:self.searchView];
}

//加载类别视图
- (void)p_loadClassView{

    self.rightView = [[YFRClassifyightView alloc]initWithFrame:CGRectMake(0, 64, K_W * 0.25, CGRectGetHeight(self.view.frame) - 64 - 49)];
    self.rightView.backgroundColor = [UIColor yellowColor];
    self.rightView.delegate = self;
    [self.view addSubview:_rightView];
    //默认隐藏
    self.rightView.transform = CGAffineTransformMakeTranslation(-K_W * 0.25 + 15, 0);
        
}
//加载显示数据表
- (void)p_loadCenterView{
    
    self.centerView = [[ClassCenterView alloc]initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame))];
    self.centerView.centerDelegate = self;
    [self.view addSubview:self.centerView];
    //把类别视图放在最上面
    [self.view bringSubviewToFront:self.rightView];
}

#pragma mark ----代理

//传递搜索到的内容
- (void)giveTextToVC:(NSString *)typeName{

    //传入数据搜索显示
    self.centerView.typeName = typeName;
}

//是否显示分类视图
- (void)hiddenOrShowRightView:(BOOL)flag{

    if (flag) {
        //展开
        [UIView animateKeyframesWithDuration:0.3 delay:0.0 options:UIViewKeyframeAnimationOptionBeginFromCurrentState animations:^{
            
            self.rightView.transform = CGAffineTransformIdentity;
        } completion:^(BOOL finished) {
            
        }];
    }else{
    
        [UIView animateKeyframesWithDuration:0.3 delay:0.0 options:UIViewKeyframeAnimationOptionBeginFromCurrentState animations:^{
            
            self.rightView.transform = CGAffineTransformMakeTranslation(-K_W * 0.25 + 15, 0);
            
        } completion:^(BOOL finished) {
            
        }];
        
    }
}

//传递需要搜索的数据
- (void)giveRightTextToVC:(NSString *)typeName{

    //传入数据搜索显示
    self.centerView.typeName = typeName;
}

//跳转界面
- (void)skipVcToShow:(HomeModel *)model{

    UIStoryboard *story = [UIStoryboard storyboardWithName:@"DetailsVC" bundle:nil];
    DetailsVC *vc = [story instantiateViewControllerWithIdentifier:@"details"];
    vc.title = model.home_title;
    vc.homeModel = model;
    self.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
    self.hidesBottomBarWhenPushed = NO;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{

    //键盘消失
    [self.view endEditing:YES];
}
@end
