//
//  CommentFootView.m
//  NBANews
//
//  Created by 孙云飞 on 2017/2/18.
//  Copyright © 2017年 孙云飞. All rights reserved.
//

#import "CommentFootView.h"
@interface CommentFootView()
@property (weak, nonatomic) IBOutlet UITextField *commentField;//评论输入
- (IBAction)clickSubmitBtn:(id)sender;//点击提交评论事件
@end
@implementation CommentFootView

+ (instancetype)createView{

    return [[[NSBundle mainBundle] loadNibNamed:@"CommentFootView" owner:self options:nil] lastObject];
}

- (IBAction)clickSubmitBtn:(id)sender {
    //首先判断输入是否为空
    if (_commentField.text.length <= 0) {
        
        NSLog(@"评论不能为空");
    }else{
    
        //1.首先获取用户的信息
        //2.其次上传信息
    }
}
@end
