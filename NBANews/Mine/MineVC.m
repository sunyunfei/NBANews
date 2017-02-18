//
//  MineVC.m
//  NBANews
//
//  Created by 孙云飞 on 2017/2/18.
//  Copyright © 2017年 孙云飞. All rights reserved.
//

#import "MineVC.h"
#import "LoginVC.h"
#import <SDWebImage/UIButton+WebCache.h>
@interface MineVC ()
@property (weak, nonatomic) IBOutlet UIButton *mineIcon;//头像
@property (weak, nonatomic) IBOutlet UILabel *mineName;//名字
@property (weak, nonatomic) IBOutlet UISwitch *mineType;//夜间模式
@property (weak, nonatomic) IBOutlet UILabel *loginLabel;//登录注册
- (IBAction)clickIconBtn:(UIButton *)sender;//点击头像事件

@end

@implementation MineVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.mineIcon.layer.cornerRadius = CGRectGetWidth(self.mineIcon.frame) / 2;
    self.mineIcon.layer.masksToBounds = YES;
    
    //判断是否登陆
    if ([YFDefaultsManager obtainIsLoginStatus:login_status]) {
        //请求用户信息
        [self p_loadData];
    }
    
    //接收登陆成功的通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loginSuccess) name:LOGIN_SUCCSESS object:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark ----通知方法
- (void)loginSuccess{
    
    [self p_loadData];
}

#pragma mark----数据处理
- (void)p_loadData{

    self.loginLabel.text = @"退出";
    //网络请求
    BmobQuery   *bquery = [BmobQuery queryWithClassName:@"news_user"];
    [bquery whereKey:@"user_id" equalTo:[YFDefaultsManager obtainUserId:login_userId]];
    [bquery findObjectsInBackgroundWithBlock:^(NSArray *array, NSError *error) {
        
        if (array.count > 0) {
            
            //比较密码是否正确
            BmobObject *obj = array[0];
            self.mineName.text = [obj objectForKey:@"user_name"];
            
            //查看是否有头像
            if ([obj objectForKey:@"user_icon"]) {
                
                [self.mineIcon sd_setImageWithURL:[NSURL URLWithString:[obj objectForKey:@"user_icon"]] forState:UIControlStateNormal];
            }
        }else{
            
            NSLog(@"mine error");
        }
    }];
}

- (IBAction)clickIconBtn:(UIButton *)sender {
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    switch (indexPath.section) {
        case 0:
        {
        
            switch (indexPath.row) {
                case 0:
                {
                
                    //收藏
                }
                    break;
                case 2:{
                
                    //清除缓存
                    
                }
                default:
                    break;
            }
        }
            break;
        case 1:{
        
            //判断是登陆还是退出
            if ([self.loginLabel.text isEqualToString:@"退出"]) {
                
                [YFDefaultsManager deleteUserDataForUserStatus:login_status withUserId:login_userId];
                self.mineName.text = @"无";
                [self.mineIcon setImage:[UIImage imageNamed:@"mine_icon.jpg"] forState:UIControlStateNormal];
                self.loginLabel.text = @"登陆/注册";
                
            }else{
            
                //登陆/注册
                [LoginManager skipLoginVC];
            }
            
        }
        default:
            break;
    }
}

//移除通知
- (void)dealloc{
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
@end
