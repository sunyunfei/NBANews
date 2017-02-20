//
//  YFBaseTabBarVC.m
//  NBANews
//
//  Created by 孙云飞 on 2017/2/19.
//  Copyright © 2017年 孙云飞. All rights reserved.
//

#import "YFBaseTabBarVC.h"

@interface YFBaseTabBarVC ()

@end

@implementation YFBaseTabBarVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self changeBaseColor];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeBaseColor) name:Night_Not object:nil];
    
    [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor darkGrayColor],NSForegroundColorAttributeName,nil] forState:UIControlStateNormal];
    
    UIColor *titleHighlightedColor = [UIColor blueColor];
    
    [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:titleHighlightedColor, NSForegroundColorAttributeName,nil] forState:UIControlStateSelected];
}

- (void)changeBaseColor{

    UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, K_W, 49)];
    backView.backgroundColor = [UIColor lightGrayColor];
    [self.tabBar insertSubview:backView atIndex:0];
    self.tabBar.opaque = YES;
    
}

- (void)dealloc{

    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
@end
