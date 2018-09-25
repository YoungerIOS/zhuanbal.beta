//
//  submitViewController.m
//  ZhuanBa
//
//  Created by developer on 2018/8/27.
//  Copyright © 2018年 developer. All rights reserved.
//

#import "submitViewController.h"

@interface submitViewController ()
@property (nonatomic,strong) UITextView * textview;
@property (nonatomic,strong) UIButton * submitButton;

@end

@implementation submitViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.hidden = NO;
    self.tabBarController.tabBar.hidden = true;
    [self initSubViews];
    self.view.backgroundColor = [UIColor whiteColor];

    UIButton * button = [[UIButton alloc] init];
    [button setImage:[UIImage imageNamed:@"返回"] forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:@"返回"] forState:UIControlStateHighlighted];
    [button addTarget:self action:@selector(esc) forControlEvents:UIControlEventTouchUpInside];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    
}
-(void)esc{
    
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)initSubViews{
    
    UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(20, 100, self.view.frame.size.width - 40, 20)];
    label.font = [UIFont systemFontOfSize:12.0];
    label.text = @"请提出您的意见建议";
    
    self.textview = [[UITextView alloc] initWithFrame:CGRectMake(20, 140, self.view.frame.size.width - 40, 100)];
    self.textview.layer.cornerRadius = 2.0;
    self.textview.layer.borderColor = [UIColor colorWithRed:55/255.0 green:55/255.0 blue:55/255.0 alpha:1.0].CGColor;
    self.textview.layer.borderWidth = 1.0;
    self.textview.contentMode = UIViewContentModeTop;
    
    self.submitButton = [[UIButton alloc] initWithFrame:CGRectMake(60, 260, self.view.frame.size.width - 120, 40)];
    self.submitButton.backgroundColor = [SchemeColor schemeColor];
    [self.submitButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.submitButton setTitle:@"提交" forState:UIControlStateNormal];
    self.submitButton.layer.cornerRadius = 4.0;
    [self.submitButton addTarget:self action:@selector(submitContent) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:label];
    [self.view addSubview:self.textview];
    [self.view addSubview:self.submitButton];
    
}

-(void)submitContent{
    
    NSString * str = [self.textview.text stringByReplacingOccurrencesOfString:@" " withString:@""];
    
    if (str.length <= 0) {
        
        [self showtitle:@"没有输入内容"];
    
    }else if (self.textview.text.length > 100){
        
        [self showtitle:@"超过100个字符"];
        
    }else{
        
        NSString * phone = [[NSUserDefaults standardUserDefaults] objectForKey:@"phone"];
        Network * nt = [[Network alloc] init];
        
        [nt submit:phone Content:self.textview.text success:^(NSDictionary * dict){
            
            NSString * code = [NSString stringWithFormat:@"%@",dict[@"code"]];
            
                    if ([code isEqualToString:@"200"]) {
                
                        [self showtitle:@"提交成功"];
                        
                    }
            
                } fail:^(NSError * error){
                    
                    
                    
                }];
    }
    
    
}
-(void)showtitle:(NSString *)title{
    
    UIAlertController * control = [UIAlertController alertControllerWithTitle:@"提示" message:title preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction * action = [UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action){
        
        [self.navigationController popViewControllerAnimated:YES];
        
    }];
    
    [control addAction:action];
    
    [self presentViewController:control animated:YES completion:nil];
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.textview resignFirstResponder];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
