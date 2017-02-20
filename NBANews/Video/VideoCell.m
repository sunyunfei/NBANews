//
//  VideoCell.m
//  NBANews
//
//  Created by 孙云飞 on 2017/2/18.
//  Copyright © 2017年 孙云飞. All rights reserved.
//

#import "VideoCell.h"
@interface VideoCell()
@property (weak, nonatomic) IBOutlet UILabel *cell_time;//时间
@property (weak, nonatomic) IBOutlet UILabel *cell_title;//标题
@property (weak, nonatomic) IBOutlet UIImageView *cell_image;//图片

@end
@implementation VideoCell

- (void)awakeFromNib{

    [super awakeFromNib];
    [self setBaseColorForGlobal];
}
- (void)setModel:(VideoModel *)model{

    _model = model;
    self.cell_time.text = model.video_createTime;
    self.cell_title.text = model.video_content;
    [self.cell_image sd_setImageWithURL:[NSURL URLWithString:model.video_coverUrl]];
}
@end
