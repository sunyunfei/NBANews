//
//  HomeCell.m
//  NBANews
//
//  Created by 孙云飞 on 2017/2/17.
//  Copyright © 2017年 孙云飞. All rights reserved.
//

#import "HomeCell.h"

@interface HomeCell()
@property (weak, nonatomic) IBOutlet UIImageView *cellImage;//图片
@property (weak, nonatomic) IBOutlet UILabel *cellTitleLabel;//标题
@property (weak, nonatomic) IBOutlet UILabel *cellTimeLabel;//时间
@property (weak, nonatomic) IBOutlet UILabel *cellTypeLabel;//类型

@end
@implementation HomeCell

//数据处理
- (void)setHomeModel:(HomeModel *)homeModel{

    _homeModel = homeModel;
    //图片
    [self.cellImage sd_setImageWithURL:[NSURL URLWithString:homeModel.home_image]];
    //标题
    self.cellTitleLabel.text = homeModel.home_title;
    //时间
    self.cellTimeLabel.text = homeModel.home_time;
    //类别
    self.cellTypeLabel.text = homeModel.home_type;
}
@end
