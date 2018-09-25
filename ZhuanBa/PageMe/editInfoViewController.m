//
//  editInfoViewController.m
//  ZhuanBa
//
//  Created by developer on 2018/8/27.
//  Copyright © 2018年 developer. All rights reserved.
//

#import "editInfoViewController.h"

@interface editInfoViewController () <UINavigationBarDelegate,UIImagePickerControllerDelegate>
@property (nonatomic,strong) UIImageView * headView;
@property (nonatomic,strong) UITextField * nickLabel;
@property (nonatomic,strong) UILabel * genderLabel;
@property (nonatomic,strong) UITextField * ageLabel;
@property (nonatomic,strong) UIImage * placeImage;
@end

@implementation editInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tabBarController.tabBar.hidden = true;
    self.navigationController.navigationBar.hidden = NO;
    self.view.backgroundColor = [UIColor whiteColor];
    [self initSubView];
    [self getUserInfo];
//    [self.nickLabel becomeFirstResponder];
    
    UIButton * button = [[UIButton alloc] init];
    [button setImage:[UIImage imageNamed:@"返回"] forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:@"返回"] forState:UIControlStateHighlighted];
    [button addTarget:self action:@selector(esc) forControlEvents:UIControlEventTouchUpInside];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];

    
}
-(void)esc{
    
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)initSubView{
    
    UILabel * headtitle = [[UILabel alloc] initWithFrame:CGRectMake(20, 100,100 , 60)];
    headtitle.font  =  [UIFont systemFontOfSize:14.0];
    headtitle.text  = @"头像";
    
    self.headView = [[UIImageView alloc] initWithFrame:CGRectMake(self.view.frame.size.width - 100 , 96, 60, 60)];
    self.headView.layer.cornerRadius = 30.0;
    self.headView.layer.masksToBounds = true;
    
    if (self.headimag) {
        
        self.headView.image = self.headimag;
    }else {
        self.headView.image = [UIImage imageNamed:@"avatar"];
    }
    
    UIView * lineOne = [[UIView alloc] initWithFrame:CGRectMake(0, 160, self.view.frame.size.width, 0.6)];
    lineOne.backgroundColor = [UIColor blackColor];
    lineOne.alpha = 0.2;
    
    UILabel * nicktitle = [[UILabel alloc] initWithFrame:CGRectMake(20, 160, 100, 60)];
    nicktitle.font = [UIFont systemFontOfSize:14.0];
    nicktitle.text = @"昵称";
    
    self.nickLabel = [[UITextField alloc] initWithFrame:CGRectMake(120, 160, self.view.bounds.size.width - 140, 60)];
    self.nickLabel.font = [UIFont systemFontOfSize:14.0];
    self.nickLabel.placeholder = @"未填写";
    self.nickLabel.textAlignment = NSTextAlignmentRight;
  
    
    UIView * lineTwo = [[UIView alloc] initWithFrame:CGRectMake(0, 220, self.view.frame.size.width, 0.6)];
    lineTwo.backgroundColor = [UIColor blackColor];
    lineTwo.alpha = 0.2;
    
    UILabel * gendertitle = [[UILabel alloc] initWithFrame:CGRectMake(20, 220, 100, 60)];
    gendertitle.font = [UIFont systemFontOfSize:14.0];
    gendertitle.text = @"性别";
    
    self.genderLabel = [[UILabel alloc] initWithFrame:CGRectMake(120, 220, self.view.bounds.size.width - 140, 60)];
    self.genderLabel.font = [UIFont systemFontOfSize:14.0];
    self.genderLabel.textAlignment = NSTextAlignmentRight;
    self.genderLabel.text = @"未填写";
    
    UIView * lineThr = [[UIView alloc] initWithFrame:CGRectMake(0, 280, self.view.frame.size.width, 0.6)];
    lineThr.backgroundColor = [UIColor blackColor];
    lineThr.alpha = 0.2;
    
    
    
    UILabel * agetitle = [[UILabel alloc] initWithFrame:CGRectMake(20, 280, 100, 60)];
    agetitle.font = [UIFont systemFontOfSize:14.0];
    agetitle.text = @"年龄";
    
    self.ageLabel = [[UITextField alloc] initWithFrame:CGRectMake(120, 280, self.view.bounds.size.width - 140, 60)];
    self.ageLabel.font = [UIFont systemFontOfSize:14.0];
    self.ageLabel.placeholder = @"未填写";
    self.ageLabel.textAlignment = NSTextAlignmentRight;
    self.ageLabel.keyboardType = UIKeyboardTypeNumberPad;
    
    UIView * lineFor = [[UIView alloc] initWithFrame:CGRectMake(0, 340, self.view.frame.size.width, 0.6)];
    lineFor.backgroundColor = [UIColor blackColor];
    lineFor.alpha = 0.2;
    
    UIButton * headbutton = [[UIButton alloc] initWithFrame:CGRectMake(0, 100, self.view.frame.size.width, 60)];
    UIButton * genderBtn =  [[UIButton alloc] initWithFrame:CGRectMake(0, 220, self.view.frame.size.width, 60)];
    
    [headbutton addTarget:self action:@selector(headButtonMethod) forControlEvents:UIControlEventTouchUpInside];
    [genderBtn addTarget:self action:@selector(genderButtonMethod) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton * baocun = [[UIButton alloc] initWithFrame:CGRectMake(20, 400, self.view.frame.size.width - 40, 40)];
    baocun.backgroundColor = [UIColor orangeColor];
    [baocun setTitle:@"保存" forState:UIControlStateNormal];
    [baocun setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [baocun addTarget:self action:@selector(baocunInfo) forControlEvents:UIControlEventTouchUpInside];
    baocun.layer.cornerRadius = 4.0;
    
    [self.view addSubview:headtitle];
    [self.view addSubview:self.headView];
    [self.view addSubview:nicktitle];
    [self.view addSubview:self.nickLabel];
    [self.view addSubview:gendertitle];
    [self.view addSubview:self.genderLabel];
    [self.view addSubview:agetitle];
    [self.view addSubview:self.ageLabel];
    [self.view addSubview:headbutton];
    [self.view addSubview:genderBtn];
    [self.view addSubview:baocun];
    [self.view addSubview:lineOne];
    [self.view addSubview:lineTwo];
    [self.view addSubview:lineThr];
    [self.view addSubview:lineFor];
}
-(void)getUserInfo{
    
    Network * nt = [[Network alloc] init];
    NSString * phone = [[NSUserDefaults standardUserDefaults] objectForKey:@"phone"];
    
    [nt getInfoPhone:phone success:^(NSDictionary * dict){
        
        NSString * code = [NSString stringWithFormat:@"%@",dict[@"code"]];
        
        if ([code isEqualToString:@"200"]) {
            
            NSDictionary * dataDict = dict[@"data"];
            id nickname = dataDict[@"nickname"];
            if (![nickname isKindOfClass:[NSNull class]]) {
                 self.nickLabel.text = [NSString stringWithFormat:@"%@",nickname];
            }
            
           
            NSString * text = [NSString stringWithFormat:@"%@",dataDict[@"gender"]];
            self.genderLabel.text = [text isEqualToString:@"1"] ? @"男" : @"女";
            id age = dataDict[@"age"];
            if(![age isKindOfClass:[NSNull class]]){
                
                self.ageLabel.text = [NSString stringWithFormat:@"%@",age];
                
            }
            
        
        }
    } fail:^(NSError * error){
        
        
    }];
    
    
    
}
-(void)headButtonMethod{
    
    UIAlertController * controller = [[UIAlertController alloc] init];
    
    UIImagePickerController * imagePicker = [[UIImagePickerController alloc] init];
    imagePicker.delegate = self;
    imagePicker.allowsEditing = YES;
    UIAlertAction * camera = [UIAlertAction actionWithTitle:@"相机" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action){
        
        imagePicker.sourceType   =  UIImagePickerControllerSourceTypeCamera;
        
        [self presentViewController:imagePicker animated:YES completion:nil];
        
    }];
    UIAlertAction * photo  = [UIAlertAction actionWithTitle:@"相册" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action){
        
        [self presentViewController:imagePicker animated:YES completion:nil];
        
        
    }];
    UIAlertAction * cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * action){
        
            [controller dismissViewControllerAnimated:YES completion:nil];
        
    }];
    
    
    [controller addAction:camera];
    [controller addAction:photo];
    [controller addAction:cancel];
    
    [self presentViewController:controller animated:YES completion:nil];
    
}

-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    
    [picker dismissViewControllerAnimated:YES completion:nil];
    
}
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    
    [picker dismissViewControllerAnimated:YES completion:nil];
    
    self.headView.image = info[UIImagePickerControllerEditedImage];
    
    self.placeImage = info[UIImagePickerControllerEditedImage];
    
 

}

-(void)genderButtonMethod{
    
    UIAlertAction * fem = [UIAlertAction actionWithTitle:@"男性" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action){
        
        self.genderLabel.text = @"男";
        
    }];
    UIAlertAction * mal = [UIAlertAction actionWithTitle:@"女性" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action){
        
        self.genderLabel.text = @"女";
        
    }];
    
    UIAlertController * contr = [[UIAlertController alloc] init];
    
    [contr addAction:fem];
    [contr addAction:mal];
    
    [self presentViewController:contr animated:YES completion:nil];
    
}
-(void)baocunInfo{
    
    UIImage * head = self.placeImage;
    NSString * nick = self.nickLabel.text;
    NSString * gender = self.genderLabel.text;
    NSString * age = self.ageLabel.text;
 
    NSString * phone = [[NSUserDefaults standardUserDefaults] objectForKey:@"phone"];
    
    NSMutableDictionary * mutable = [NSMutableDictionary dictionary];
    
    
    NSData * headData;
    if (head) {
        
       headData = UIImageJPEGRepresentation(head, 0.01);
        
    }
    [mutable setObject:phone forKey:@"phone"];
    [mutable setObject:nick forKey:@"nickname"];
    if ([gender isEqualToString:@"男"]) {
        
        [mutable setObject:@"1" forKey:@"gender"];
    }else{
        
        [mutable setObject:@"2" forKey:@"gender"];
    }
    
    [mutable setObject:age forKey:@"age"];
    
    Network * nt = [[Network alloc] init];
    
    [nt changInfoMation:phone headData:headData parmars:mutable success:^(NSDictionary *dict){
        
        NSString * code = [NSString stringWithFormat:@"%@",dict[@"code"]];
        
            if ([code isEqualToString:@"200"]) {
                
                [self showtitle:@"修改成功"];
                
                [[NSNotificationCenter defaultCenter] postNotificationName:@"changeInfoSuccess" object:nil];
                
            }
        
                } fail:^(NSError * error){
        
                    NSLog(@"修改出错------%@",error);

        
            }];
    
}
-(void)showtitle:(NSString *)title{
    
    UIAlertController * control = [UIAlertController alertControllerWithTitle:@"提示" message:title preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction * action = [UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action){
        
        [self.navigationController popViewControllerAnimated:YES];
        
        
    }];
    
    [control addAction:action];
    
    [self presentViewController:control animated:YES completion:nil];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
//    [self.view endEditing:YES];
    [self.nickLabel resignFirstResponder];
    [self.ageLabel resignFirstResponder];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
  
}


@end
