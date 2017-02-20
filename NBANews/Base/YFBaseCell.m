//
//  YFBaseCell.m
//  NBANews
//
//  Created by 孙云飞 on 2017/2/19.
//  Copyright © 2017年 孙云飞. All rights reserved.
//

#import "YFBaseCell.h"

@implementation YFBaseCell

- (instancetype)init{

    self = [super init];
    if (self) {
        
       [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(setBaseColorForGlobal) name:Night_Not object:nil]; 
    }
    return self;
}
- (instancetype)initWithCoder:(NSCoder *)aDecoder{

    self = [super initWithCoder:aDecoder];
    if (self) {
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(setBaseColorForGlobal) name:Night_Not object:nil];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame{

    self = [super initWithFrame:frame];
    if (self) {
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(setBaseColorForGlobal) name:Night_Not object:nil];
    }
    return self;
}

//颜色设置
- (void)setBaseColorForGlobal{
        
    [YFDefaultsManager obtainIsNightStatus] ? (self.contentView.backgroundColor = [UIColor blackColor]): (self.contentView.backgroundColor = [UIColor whiteColor]);
        for (UIView *view in self.contentView.subviews) {
            
            if ([view isKindOfClass:[UILabel class]])
            {
                UILabel *lbl = (UILabel *)view;
                [YFDefaultsManager obtainIsNightStatus] ? (lbl.textColor = [UIColor whiteColor]) : (lbl.textColor = [UIColor blackColor])  ;
            }
            
        }

}

@end
