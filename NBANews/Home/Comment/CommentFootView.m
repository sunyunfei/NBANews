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
    //判断是否登陆
    if ([YFDefaultsManager obtainIsLoginStatus:login_status]) {
        
        //首先判断输入是否为空
        if (_commentField.text.length <= 0) {
            
            NSLog(@"评论不能为空");
        }else{
            //键盘下去
            [self.commentField resignFirstResponder];
            //1.首先获取用户的信息
            //网络请求
            BmobQuery   *bquery = [BmobQuery queryWithClassName:@"news_user"];
            [bquery whereKey:@"user_id" equalTo:[YFDefaultsManager obtainUserId:login_userId]];
            [bquery findObjectsInBackgroundWithBlock:^(NSArray *array, NSError *error) {
                
                if (array.count > 0) {
                    
                    //比较密码是否正确
                    BmobObject *obj = array[0];
                    NSString *name = [obj objectForKey:@"user_name"];
                    NSString *icon = [obj objectForKey:@"user_icon"];
                    if (icon.length <= 0) {
                        icon = @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1487505999260&di=ec5eff29b6eb4dd031ee3390eca53ba7&imgtype=jpg&src=http%3A%2F%2Fimg4.imgtn.bdimg.com%2Fit%2Fu%3D3443117432%2C1239143495%26fm%3D214%26gp%3D0.jpg";
                    }
                    //2.其次上传信息
                    BmobObject *newData = [BmobObject objectWithClassName:@"news_comment"];
                    [newData setObject:[YFDefaultsManager obtainUserId:login_userId] forKey:@"user_id"];
                    [newData setObject:name forKey:@"comment_name"];
                    [newData setObject:icon forKey:@"comment_icon"];
                    [newData setObject:self.commentField.text forKey:@"comment_content"];
                    [newData setObject:self.homeId forKey:@"home_id"];
                    
                    [newData saveInBackgroundWithResultBlock:^(BOOL isSuccessful, NSError *error) {
                        
                        if (isSuccessful) {
                            
                            NSLog(@"评论成功");
                            if ([self.delegate respondsToSelector:@selector(refreshData)]) {
                                [self.delegate refreshData];
                            }
                        }else{
                            
                            NSLog(@"评论失败");
                        }
                    }];
                }else{
                    
                    NSLog(@"mine error");
                }
            }];
            
        }
    }else{
    
        [LoginManager skipLoginVC];
    }
}
@end
