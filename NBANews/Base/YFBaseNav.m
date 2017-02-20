//
//  YFBaseNav.m
//  NBANews
//
//  Created by 孙云飞 on 2017/2/19.
//  Copyright © 2017年 孙云飞. All rights reserved.
//

#import "YFBaseNav.h"

@interface YFBaseNav ()

@end

@implementation YFBaseNav

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self changeColor];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeColor) name:Night_Not object:nil];
}

- (void)changeColor{

    [YFDefaultsManager obtainIsNightStatus] ? (self.navigationBar.barTintColor = [UIColor blackColor]): (self.navigationBar.barTintColor = [UIColor whiteColor]);
    //标题颜色
    
    [YFDefaultsManager obtainIsNightStatus] ? ([self.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}]) : ([self.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor blackColor]}]);
    
    [YFDefaultsManager obtainIsNightStatus] ? ([[UINavigationBar appearance] setTintColor:[UIColor whiteColor]]) : ([[UINavigationBar appearance] setTintColor:[UIColor blackColor]]) ;
}
- (void)dealloc{

    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
@end
