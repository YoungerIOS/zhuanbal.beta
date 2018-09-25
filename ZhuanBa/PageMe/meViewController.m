//
//  meViewController.m
//  ZhuanBa
//
//  Created by developer on 2018/8/27.
//  Copyright © 2018年 developer. All rights reserved.
//

#import "meViewController.h"
#import "submitViewController.h"
#import "editInfoViewController.h"
#import "LoginViewController.h"
#import "aboutUsViewController.h"

@interface meViewController ()
@property (nonatomic,strong) UIScrollView * scrollview;
@property (nonatomic,strong) UIButton * shareButton;
@property (nonatomic,strong) UIImageView * headImageView;
@property (nonatomic,strong) UILabel * nicknameLabel;
@property (nonatomic,strong) UILabel * genderLabel;
@property (nonatomic,strong) UILabel * ageLabel;
@property (nonatomic,strong) UILabel * totalLabel;
@property (nonatomic,strong) UILabel * totalSaleLabel;
@property (nonatomic,strong) UIImage * userHeader;

@end

@implementation meViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"帐户";
    
    [self initSubView];
    [self getUserInfo];
    [self getUserHeader];
    [self getPhoneScale];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changUserInfoSucc) name:@"changeInfoSuccess" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getPhoneScale) name:@"updatePhoneScale" object:nil];
    
}
-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
    self.tabBarController.tabBar.hidden = false;
    
}
-(void)getPhoneScale{
    
    Network * nt = [[Network alloc] init];
    NSString * phone = [[NSUserDefaults standardUserDefaults] objectForKey:@"phone"];
    
    [nt getphoneSaleinfo:phone success:^(NSDictionary * dict){
        
        NSString * code = [NSString stringWithFormat:@"%@",dict[@"code"]];
        if ([code isEqualToString:@"200"]) {
            
            NSDictionary * data = dict[@"data"];
            
          
            self.totalLabel.text =  [NSString stringWithFormat:@"%@.0",data[@"totalcount"]] ;
            self.totalSaleLabel.text = [NSString stringWithFormat:@"%@.0",data[@"totalscalecount"]] ;
        }
        
    } fail:^(NSError * error){
        
        
        
    }];
}
-(void)initSubView{
    UIView *topBackground = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 264)];
    [self.view addSubview:topBackground];
    
    topBackground.backgroundColor = [UIColor orangeColor];
    
    UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 60, 30)];
    CGPoint center = title.center;
    center.x = topBackground.center.x;
    center.y = 40;
    title.center = center;
    title.text = @"账户";
    title.font = [UIFont boldSystemFontOfSize:17.0];
    title.textAlignment = NSTextAlignmentCenter;
    title.font = [UIFont systemFontOfSize:18.0];
    title.backgroundColor = [UIColor clearColor];
    [topBackground addSubview:title];
    
    UIImageView * headView = [[UIImageView alloc] initWithFrame:CGRectMake(self.view.center.x - 37.5, 80, 75, 75)];
    [topBackground addSubview:headView];
//    CGRect rect = headView.frame;
//    rect.size = CGSizeMake(75, 75);
//    headView.frame = rect;
//    CGPoint point = headView.center;
//    center.x = self.view.center.x;
//    center.y = 130;
//    headView.center = point;
    headView.backgroundColor = [UIColor clearColor];
    headView.layer.cornerRadius = 37.5;
    headView.layer.masksToBounds = true;
//    headView.layer.backgroundColor = [UIColor clearColor].CGColor;
    headView.image = [UIImage imageNamed:@"avatar"];
    headView.userInteractionEnabled = true;
    UITapGestureRecognizer * avatar = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(changeInfo)];
    [headView addGestureRecognizer:avatar];
    self.headImageView = headView;
    
    
    
    UILabel * nickLabel = [[UILabel alloc] initWithFrame:CGRectMake(120, 110, 100, 10)];
    nickLabel.font = [UIFont systemFontOfSize:12.0];
    self.nicknameLabel = nickLabel;
    
    UILabel * sexlabel = [[UILabel alloc] initWithFrame:CGRectMake(120, 140, 40, 10)];
    sexlabel.font = [UIFont systemFontOfSize:12.0];
    self.genderLabel = sexlabel;
    self.genderLabel.text = @"";
    
    UILabel * ageLabel = [[UILabel alloc] initWithFrame:CGRectMake(160, 140, 40, 10)];
    ageLabel.font = [UIFont systemFontOfSize:12.0];
    
    self.ageLabel = ageLabel;
    
    UIButton * infoChangeButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 100, self.view.frame.size.width, 80)];
    [infoChangeButton addTarget:self action:@selector(changeInfo) forControlEvents:UIControlEventTouchUpInside];
    infoChangeButton.hidden = YES;
    
    UILabel *zhuan = [[UILabel alloc] initWithFrame:CGRectMake(0, 200, self.view.frame.size.width / 2, 30)];
    zhuan.text = @"赚取佣金";
    zhuan.textAlignment = NSTextAlignmentCenter;
    
    UILabel * zhuanqulabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 230, self.view.frame.size.width / 2, 30)];
    zhuanqulabel.font = [UIFont systemFontOfSize:18.0];
    zhuanqulabel.text = @"00.0";
    zhuanqulabel.textColor = [UIColor yellowColor];
    zhuanqulabel.textAlignment = NSTextAlignmentCenter;
//    zhuanqulabel.numberOfLines = 2;
    self.totalLabel = zhuanqulabel;
    
    UIView * line = [[UIView alloc] initWithFrame:CGRectMake(self.view.frame.size.width / 2 - 0.5, 210, 1.0, 20)];
    line.backgroundColor = [UIColor grayColor];
    
    UILabel *zhi = [[UILabel alloc] initWithFrame:CGRectMake(self.view.frame.size.width / 2, 200, self.view.frame.size.width / 2, 30)];
    zhi.text = @"支出佣金";
    zhi.textAlignment = NSTextAlignmentCenter;
    
    UILabel * zhichuLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.view.frame.size.width / 2, 230, self.view.frame.size.width / 2,30)];
    zhichuLabel.font = [UIFont systemFontOfSize:18.0];
    zhichuLabel.text = @"00.0";
    zhichuLabel.textColor = [UIColor yellowColor];
    zhichuLabel.textAlignment = NSTextAlignmentCenter;
//    zhichuLabel.numberOfLines = 2;
    self.totalSaleLabel = zhichuLabel;
    
    
    UILabel * fankuiLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 280 , self.view.frame.size.width, 60)];
    fankuiLabel.font = [UIFont systemFontOfSize:14.0];
    [fankuiLabel setText:@"意见反馈"];
    
    UILabel * guanyu = [[UILabel alloc] initWithFrame:CGRectMake(20, 340, self.view.frame.size.width, 60)];
    guanyu.font  = [UIFont systemFontOfSize:14.0];
    [guanyu setText:@"关于我们"];
    
    
    UIButton * exitButton = [[UIButton alloc] initWithFrame:CGRectMake(40, 460, self.view.frame.size.width - 80, 40)];
    [exitButton setTitle:@"退出登录" forState:UIControlStateNormal];
    [exitButton setBackgroundColor:[UIColor orangeColor]];
//    [UIColor colorWithRed:228/255.0 green:102/255.0 blue:43/255.0 alpha:1.0]
    [exitButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [exitButton addTarget:self action:@selector(exitLogin) forControlEvents:UIControlEventTouchUpInside];
    exitButton.layer.cornerRadius = 4.0;

    fankuiLabel.userInteractionEnabled = true;
    guanyu.userInteractionEnabled = true;
    UITapGestureRecognizer * submitTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(fankuimethod)];
    [fankuiLabel addGestureRecognizer:submitTap];
    UITapGestureRecognizer * fenxiangTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(aboutMethod)];
    [guanyu addGestureRecognizer:fenxiangTap];
    
    
//    [self.view addSubview:ageLabel];
//    [self.view addSubview:sexlabel];
//    [self.view addSubview:nickLabel];
//    [self.view addSubview:infoChangeButton];
    [self.view addSubview:zhuan];
    [self.view addSubview:zhuanqulabel];
    [self.view addSubview:line];
    [self.view addSubview:zhi];
    [self.view addSubview:zhichuLabel];
    [self.view addSubview:fankuiLabel];
    [self.view addSubview:guanyu];
    [self.view addSubview:exitButton];
   
    
   
}


-(void)changUserInfoSucc{
    
    [self getUserInfo];
    [self getUserHeader];
}
-(void)getUserInfo{
    
    Network * nt = [[Network alloc] init];
    NSString * phone = [[NSUserDefaults standardUserDefaults] objectForKey:@"phone"];
    
    [nt getInfoPhone:phone success:^(NSDictionary * dict){
        
        NSString * code = [NSString stringWithFormat:@"%@",dict[@"code"]];
        
        if ([code isEqualToString:@"200"]) {
            
            NSDictionary * dataDict = dict[@"data"];
            id nickname = dataDict[@"nickname"];
            
            if ([nickname isKindOfClass:[NSNull class]]) {
                
            }else{
                
                self.nicknameLabel.text = [NSString stringWithFormat:@"%@",nickname];
            }
            
//            NSString * text = [NSString stringWithFormat:@"%@",dataDict[@"gender"]];
//
//            self.genderLabel.text = [text isEqualToString:@"1"] ? @"男" : @"女";
            
            id age = dataDict[@"age"];
            
            if ([age isKindOfClass:[NSNull class]]) {
                
                NSLog(@"age is null");
            }else{
                
                 self.ageLabel.text = [NSString stringWithFormat:@"%@",age];
            }
            
           
        }
    
        
    } fail:^(NSError * error){
        
        
    }];
    
    
    
}
-(void)getUserHeader{
    
    
    Network * nt = [[Network alloc] init];
    
    NSString * phone = [[NSUserDefaults standardUserDefaults] objectForKey:@"phone"];
    
    [nt getUserHeaderInfo:phone success:^(id data){
        
        UIImage * imag = [UIImage imageWithData:(NSData *)data];
        NSLog(@"头像图片------%@",imag);
        if (imag) {
            self.userHeader = imag;
            self.headImageView.image = imag;
        }else {
            self.headImageView.image = [UIImage imageNamed:@"avatar"];
        }

    } fail:^(NSError * error){
        
        
        
    }];
    
}
-(void)changeInfo{
    
    editInfoViewController * info = [[editInfoViewController alloc] init];
    info.headimag = self.userHeader;
    [self.navigationController pushViewController:info animated:YES];
    
    
}
-(void)fankuimethod{
    
    submitViewController * submit = [[submitViewController alloc] init];
    [self.navigationController pushViewController:submit animated:YES];
    
    
}
-(void)exitLogin{
 
    LoginViewController * login = [[LoginViewController alloc] init];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"isLogin"];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"phone"];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"city"];
//    UINavigationController *exit = [[UINavigationController alloc] initWithRootViewController:login];
//    exit.navigationBar.barTintColor = [UIColor orangeColor];
//    [UIApplication sharedApplication].delegate.window.rootViewController = exit;

    [self presentViewController:login animated:YES completion:nil];
}
-(void)aboutMethod{
    
    aboutUsViewController *about = [[aboutUsViewController alloc] init];
    [self.navigationController pushViewController:about animated:NO];
    
}
-(void)showtitle:(NSString *)title{
    
    UIAlertController * control = [UIAlertController alertControllerWithTitle:@"提示" message:title preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction * action = [UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action){}];
    
    [control addAction:action];
    
    
    [self presentViewController:control animated:YES completion:nil];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
