//
//  binPhoneViewController.m
//  ZhuanBa
//
//  Created by developer on 2018/8/22.
//  Copyright © 2018年 developer. All rights reserved.
//

#import "binPhoneViewController.h"

@interface binPhoneViewController ()
@property (nonnull,strong) UITextField * phoneField;
@property (nonnull,strong) UIButton * doneButton;
@end

@implementation binPhoneViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
}
-(void)initUI{
    
    UILabel * phoneLabel = [[UILabel alloc] init];
    self.phoneField = [[UITextField alloc] init];
    self.doneButton = [[UIButton alloc] init];
    [self.doneButton setBackgroundColor:[UIColor orangeColor]];

    phoneLabel.font = [UIFont systemFontOfSize:14.0];
    phoneLabel.text = @"请输入手机号码";
    
    _phoneField.placeholder = @"手机号码";
    _phoneField.borderStyle = UITextBorderStyleRoundedRect;
    
    
    [self.view addSubview:phoneLabel];
    [self.view addSubview:self.phoneField];
    [self.view addSubview:self.doneButton];
    
    

    [phoneLabel mas_makeConstraints:^(MASConstraintMaker * marker){
        
        marker.left.equalTo(@20);
        marker.top.equalTo(@200);
        marker.width.equalTo(@200);
        marker.height.equalTo(@40);
        
    }];


    [self.phoneField mas_makeConstraints:^(MASConstraintMaker * make){

        make.left.mas_equalTo(self.view.mas_left).mas_offset(20);
        make.right.mas_equalTo(self.view.mas_right).mas_offset(-20);
        make.height.mas_equalTo(@40);
        make.top.mas_equalTo(phoneLabel.mas_bottom).mas_offset(40);

    }];

   
    [self.doneButton mas_makeConstraints:^(MASConstraintMaker * make){


        make.left.mas_equalTo(self.view.mas_left).mas_offset(20);
        make.right.mas_equalTo(self.view.mas_right).mas_offset(-20);
        make.top.mas_equalTo(self.phoneField.mas_bottom).mas_offset(60);
        make.height.mas_equalTo(@40);

    
    }];
    
   
    [self.doneButton setTitle:@"确定" forState:UIControlStateNormal];
    [self.doneButton setBackgroundColor:[UIColor orangeColor]];
    
 
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
