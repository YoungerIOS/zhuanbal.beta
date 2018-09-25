//
//  LoginViewController.m
//  ZhuanBa
//
//  Created by developer on 2018/8/22.
//  Copyright © 2018年 developer. All rights reserved.
//

#import "LoginViewController.h"
#import "resetPwdViewController.h"
#import "registerViewController.h"
#import "taskbaseVC.h"

@interface LoginViewController ()
@property (nonnull,strong) UITextField * phoneField;
@property (nonnull,strong) UITextField * pwdField;
@property (nonnull,strong) UIButton * loginButton;
@property (nonnull,strong) UIButton * forgetPwd;
@property (nonnull,strong) UIButton * registPwd;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initUI];
    self.view.backgroundColor = [UIColor whiteColor];
    
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissKeyboard)];
    [self.view addGestureRecognizer:tap];
}
-(void)initUI{
    
    self.title = @"登录";
    UIImageView * iconImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 120, 60, 60)];
    iconImageView.image = [UIImage imageNamed:@"app_iconi"];
    iconImageView.center = CGPointMake(self.view.frame.size.width / 2, 140);
    iconImageView.layer.cornerRadius = 30.0;
    iconImageView.layer.masksToBounds = true;
    iconImageView.backgroundColor = [UIColor orangeColor];
    
    UILabel * desLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 170, 170, 20)];
    desLabel.text = @"每天跑跑腿 轻松又挣钱";
    desLabel.textAlignment = NSTextAlignmentCenter;
    desLabel.font = [UIFont systemFontOfSize:10.0];
    desLabel.center = CGPointMake(self.view.frame.size.width / 2, 180);
    
    UIView * accountBgView = [[UIView alloc] initWithFrame:CGRectMake(60, 240, self.view.frame.size.width - 120, 40)];
    accountBgView.backgroundColor = [UIColor grayColor];
    accountBgView.layer.cornerRadius = 4.0;
    
    
    UIImageView * phoneIcon = [[UIImageView alloc] initWithFrame:CGRectMake(5, 10, 20, 20)];
    phoneIcon.image = [UIImage imageNamed:@"手机号码"];
    phoneIcon.contentMode = UIViewContentModeScaleAspectFit;
    
    
    self.phoneField = [[UITextField alloc] initWithFrame:CGRectMake(40, 0, accountBgView.frame.size.width - 40, 40)];
    self.phoneField.placeholder = @"请输入手机号码";
    self.phoneField.keyboardType = UIKeyboardTypeNumberPad;
    
    [accountBgView addSubview:phoneIcon];
    [accountBgView addSubview:self.phoneField];
    
    
    
    UIView * pwdBgView = [[UIView alloc] initWithFrame:CGRectMake(60, 300, accountBgView.frame.size.width, 40)];
    pwdBgView.backgroundColor = [UIColor grayColor];
    pwdBgView.layer.cornerRadius = 4.0;
    
    UIImageView * pwdIcon = [[UIImageView alloc] initWithFrame:CGRectMake(5, 10, 20, 20)];
    pwdIcon.image = [UIImage imageNamed:@"密码"];
    pwdIcon.contentMode = UIViewContentModeScaleAspectFit;
    
    
    self.pwdField = [[UITextField alloc] initWithFrame:CGRectMake(40, 0, accountBgView.frame.size.width - 40, 40)];
    self.pwdField.placeholder = @"请输入密码";
    self.pwdField.secureTextEntry = YES;
    
    [pwdBgView addSubview:pwdIcon];
    [pwdBgView addSubview:self.pwdField];
    
    self.loginButton = [[UIButton alloc] initWithFrame:CGRectMake(60, 380, self.view.frame.size.width - 120, 40)];
    self.loginButton.backgroundColor = [UIColor orangeColor];
    [self.loginButton setTitle:@"登录" forState:UIControlStateNormal];
    self.loginButton.layer.cornerRadius = 20.0;
    self.loginButton.layer.masksToBounds = true;
    [self.loginButton addTarget:self action:@selector(loginButtonMethod) forControlEvents:UIControlEventTouchUpInside];
    
    self.forgetPwd  = [[UIButton alloc] initWithFrame:CGRectMake(60, 440, 100, 20)];
    self.forgetPwd.titleLabel.font = [UIFont systemFontOfSize:10.0];
    [self.forgetPwd setTitle:@"忘记密码" forState:UIControlStateNormal];
    [self.forgetPwd setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [self.forgetPwd addTarget:self action:@selector(resetPwdMethod) forControlEvents:UIControlEventTouchUpInside];
    
    
    self.registPwd = [[UIButton alloc] initWithFrame:CGRectMake(self.view.frame.size.width - 60 - 100, 440, 100, 20)];
    self.registPwd.titleLabel.textAlignment = NSTextAlignmentRight;
    self.registPwd.titleLabel.font = [UIFont systemFontOfSize:10.0];
    [self.registPwd setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [self.registPwd setTitle:@"一键注册" forState:UIControlStateNormal];
    [self.registPwd addTarget:self action:@selector(registerButtonMethod) forControlEvents:UIControlEventTouchUpInside];
    
 
    

    UILabel * contactQQ = [[UILabel alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height - 60, self.view.frame.size.width, 20)];
    contactQQ.textAlignment = NSTextAlignmentCenter;
    contactQQ.font = [UIFont systemFontOfSize:10.0];
    contactQQ.text = @"官方客服QQ：870365120";
    
    
    
    [self.view addSubview:iconImageView];
    [self.view addSubview:desLabel];
    [self.view addSubview:accountBgView];
    [self.view addSubview:pwdBgView];
    [self.view addSubview:self.loginButton];
    [self.view addSubview:self.forgetPwd];
    [self.view addSubview:self.registPwd];
    [self.view addSubview:contactQQ];

}
-(void)dismissKeyboard{
    
    [self.phoneField resignFirstResponder];
    [self.pwdField resignFirstResponder];
}
-(void)loginButtonMethod{
    
    
    NSString * phone = self.phoneField.text;
    NSString * pwd   = self.pwdField.text;
    
    if (phone.length >= 11 && pwd.length >= 6) {
        
        Network * nt = [[Network alloc] init];
        
        [nt loginWithPhone:phone password:pwd success:^(NSDictionary *  data){
            
            NSString * code = [NSString stringWithFormat:@"%@",data[@"code"]];
            
            if ([code isEqualToString:@"200"]) {
                
                [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"isLogin"];
                [[NSUserDefaults standardUserDefaults] setObject:phone forKey:@"phone"];
                [[NSUserDefaults standardUserDefaults] synchronize];
                
                taskbaseVC * task = [[taskbaseVC alloc] init];

                [self presentViewController:task animated:YES completion:nil];
                
             
            }else{
                
                 [self showtitle:@"登录失败"];
                
            }
            
                } fail:^(NSError * error){
            
        }];
    }else{
        
        
        
    }
    
    
}

-(void)resetPwdMethod{
    
    resetPwdViewController * resetPwd = [[resetPwdViewController alloc] init];
    
    [self.navigationController pushViewController:resetPwd animated:YES];
}
-(void)registerButtonMethod{
    
    registerViewController * registPwd = [[registerViewController alloc] init];
    
    [self.navigationController pushViewController:registPwd animated:YES];
}
-(void)showtitle:(NSString *)title{
    
    UIAlertController * control = [UIAlertController alertControllerWithTitle:@"提示" message:title preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction * action = [UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action){}];
    UIAlertAction * cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * action){}];
    
    [control addAction:action];
    [control addAction:cancel];
    
    
    [self presentViewController:control animated:YES completion:nil];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}



@end
