//
//  CommentCell.m
//  NBANews
//
//  Created by 孙云飞 on 2017/2/17.
//  Copyright © 2017年 孙云飞. All rights reserved.
//

#import "CommentCell.h"
@interface CommentCell()
@property (weak, nonatomic) IBOutlet UILabel *cellName;
@property (weak, nonatomic) IBOutlet UIImageView *cellIcon;
@property (weak, nonatomic) IBOutlet UILabel *cellTime;
@property (weak, nonatomic) IBOutlet UILabel *cellConment;

@end
@implementation CommentCell

- (void)setCommentModel:(CommentModel *)commentModel{

    _commentModel = commentModel;
    self.cellName.text = commentModel.comment_name;
    self.cellTime.text = commentModel.comment_time;
    self.cellConment.text = commentModel.comment_content;
    [self.cellIcon sd_setImageWithURL:[NSURL URLWithString:commentModel.comment_icon]];
}
@end
