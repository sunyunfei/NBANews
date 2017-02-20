//
//  YFBaseTableView.m
//  NBANews
//
//  Created by 孙云飞 on 2017/2/19.
//  Copyright © 2017年 孙云飞. All rights reserved.
//

#import "YFBaseTableView.h"

@implementation YFBaseTableView

- (instancetype)init{
    
    self = [super init];
    if (self) {
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(setViewColor) name:Night_Not object:nil];
    }
    return self;
}
- (instancetype)initWithCoder:(NSCoder *)aDecoder{
    
    self = [super initWithCoder:aDecoder];
    if (self) {
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(setViewColor) name:Night_Not object:nil];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    if (self) {
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(setViewColor) name:Night_Not object:nil];
    }
    return self;
}
- (void)setViewColor{

    [YFDefaultsManager obtainIsNightStatus] ? (self.backgroundColor = [UIColor blackColor]): (self.backgroundColor = [UIColor whiteColor]);
}
@end
