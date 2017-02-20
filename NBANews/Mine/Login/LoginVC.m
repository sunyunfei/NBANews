//
//  LoginVC.m
//  NBANews
//
//  Created by 孙云飞 on 2017/2/18.
//  Copyright © 2017年 孙云飞. All rights reserved.
//

#import "LoginVC.h"
#import "RegisterVC.h"
@interface LoginVC ()

@property (weak, nonatomic) IBOutlet UITextField *pwdField;//密码
@property (weak, nonatomic) IBOutlet UITextField *accountField;//账号
@property (weak, nonatomic) IBOutlet UIButton *registerBtn;//注册按钮
@property (weak, nonatomic) IBOutlet UIButton *loginBtn;//登陆按钮
- (IBAction)clickRegisterBtn:(id)sender;//事件
- (IBAction)clickLoginBtn:(id)sender;

@end

@implementation LoginVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
  
}

//ui设置
- (void)p_loadSetUI{

    self.registerBtn.layer.cornerRadius = 5;
    self.registerBtn.layer.masksToBounds = YES;
    self.loginBtn.layer.cornerRadius = 5;
    self.loginBtn.layer.masksToBounds = YES;
}

#pragma mark ----按钮事件
//注册事件
- (IBAction)clickRegisterBtn:(id)sender {
    
    UIStoryboard *story = [UIStoryboard storyboardWithName:@"Login" bundle:nil];
    RegisterVC *registerVC = [story instantiateViewControllerWithIdentifier:@"RegisterVC"];
    registerVC.title = @"注册";
    [self.navigationController pushViewController:registerVC animated:YES];
}

//登陆事件
- (IBAction)clickLoginBtn:(id)sender {
    
    //判断账号或者密码是否为空
    if (self.accountField.text.length <= 0 || self.pwdField.text.length <= 0) {
        NSLog(@"账号密码不能为空");
        return;
    }
    
    //网络请求
    BmobQuery   *bquery = [BmobQuery queryWithClassName:@"news_user"];
    [bquery whereKey:@"user_account" equalTo:self.accountField.text];
    [bquery findObjectsInBackgroundWithBlock:^(NSArray *array, NSError *error) {
        
        if (array.count > 0) {
            
            //比较密码是否正确
            BmobObject *obj = array[0];
            if ([self.pwdField.text isEqualToString:[obj objectForKey:@"user_pwd"]]) {
                //到这里数据登录成功
                [self dismissViewControllerAnimated:YES completion:^{
                    //记录登陆的状态
                    [YFDefaultsManager saveBoolDefaults:login_status withData:YES];
                    [YFDefaultsManager saveNumber:login_userId withData:[obj objectForKey:@"object_id"]];
                    //发出一个通知，登陆成功
                    [[NSNotificationCenter defaultCenter] postNotificationName:LOGIN_SUCCSESS object:nil];
                }];
            }else{
            
                NSLog(@"账号或者密码不对");
            }
        }else{
        
            NSLog(@"账号或者密码不对");
        }
    }];
}

@end
