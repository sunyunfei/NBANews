//
//  RegisterVC.m
//  NBANews
//
//  Created by 孙云飞 on 2017/2/18.
//  Copyright © 2017年 孙云飞. All rights reserved.
//

#import "RegisterVC.h"

@interface RegisterVC ()
@property (weak, nonatomic) IBOutlet UITextField *accountField;
@property (weak, nonatomic) IBOutlet UITextField *pwdField;
@property (weak, nonatomic) IBOutlet UITextField *likeField;
@property (weak, nonatomic) IBOutlet UITextField *nameField;
@property (weak, nonatomic) IBOutlet UIButton *registerBtn;
- (IBAction)clickRegisterBtn:(id)sender;

@end

@implementation RegisterVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.registerBtn.layer.cornerRadius = 5;
    self.registerBtn.layer.masksToBounds = YES;
}

//注册
- (IBAction)clickRegisterBtn:(id)sender {
    
    //判断是否有空值
    if(self.accountField.text.length <= 0 || self.pwdField.text.length <= 0 || self.nameField.text.length <= 0){
    
        NSLog(@"不能为空");
        return;
    }
    
    //注册
    BmobObject *userData = [BmobObject objectWithClassName:@"news_user"];
    [userData setObject:self.accountField.text forKey:@"user_account"];
    [userData setObject:self.pwdField.text forKey:@"user_pwd"];
    [userData setObject:self.nameField.text forKey:@"user_name"];
    if (self.likeField.text.length > 0) {
        
        [userData setObject:self.likeField.text forKey:@"user_troops"];
    }
    [userData saveInBackgroundWithResultBlock:^(BOOL isSuccessful, NSError *error) {
        
        if (isSuccessful) {
            
            NSLog(@"注册成功,去登陆");
            [self.navigationController popViewControllerAnimated:YES];
        }else{
        
            NSLog(@"注册失败");
        }
    }];
}
@end
