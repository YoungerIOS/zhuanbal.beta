//
//  fabuTaskVC.m
//  ZhuanBa
//
//  Created by developer on 2018/8/23.
//  Copyright © 2018年 developer. All rights reserved.
//

#import "fabuTaskView.h"
#import "SVProgressHUD.h"


@interface fabuTaskView ()<UITextFieldDelegate>
@property (nonnull,strong) UILabel * quhuoLabel;
@property (nonnull,strong) UILabel * songhuoLabel;
@property (nonnull,strong) UILabel * detailLabel;
@property (nonnull,strong) UILabel * remulLabel;
@property (nonnull,strong) UITextField * sourceAddressField;
@property (nonnull,strong) UITextField * destioAddressField;
@property (nonnull,strong) UITextView * taskDetailTxView;
@property (nonnull,strong) UITextField * remunerationField;

@end

@implementation fabuTaskView

-(id)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
    
        [self initUI];
        
        //注册键盘弹出通知
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(keyboardWillShow:)
                                                     name:UIKeyboardWillShowNotification
                                                   object:nil];
        //注册键盘隐藏通知
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(keyboardWillHide:)
                                                     name:UIKeyboardWillHideNotification
                                                   object:nil];
    }
    
    return self;
}
- (void)keyboardWillShow:(NSNotification *)note {
    
    NSDictionary *info = [note userInfo];
    
    CGSize keyboardSize = [[info objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue].size;
    
    //目标视图UITextField
    
    NSTimeInterval animationDuration = 0.30f;
    
    [UIView beginAnimations:@"ResizeView" context:nil];
    
    [UIView setAnimationDuration:animationDuration];
    
   
    for (UIView *view in self.subviews) {
        if ([view isKindOfClass:[UITextField class]]||[view isKindOfClass:[UITextView class]]) {
            if (((UITextField *)view).isEditing || ((UITextView *)view).isTracking) {
                if (view.frame.origin.y == _remunerationField.frame.origin.y) {
                    CGRect textRect = _remunerationField.frame;
                    int y = (textRect.origin.y + textRect.size.height) - (self.frame.size.height - keyboardSize.height);
                    if(y > 0) {
                        self.frame = CGRectMake(0, -y, self.frame.size.width, self.frame.size.height);
                    }
                    return;
                    
                } else if(view.frame.origin.y == _taskDetailTxView.frame.origin.y){
                    CGRect textRect = _taskDetailTxView.frame;
                    int y = (textRect.origin.y + textRect.size.height) - (self.frame.size.height - keyboardSize.height);
                    if(y > 0) {
                        self.frame = CGRectMake(0, -y, self.frame.size.width, self.frame.size.height);
                    }
                    return;
                }
                
            }
        }
        
    }
    
    [UIView commitAnimations];
    
    
}

- (void)keyboardWillHide:(NSNotification *)note {
    
    NSTimeInterval animationDuration = 0.30f;
    
    [UIView beginAnimations:@"ResizeView" context:nil];
    
    [UIView setAnimationDuration:animationDuration];
    
    self.frame = CGRectMake(0, 60, self.frame.size.width, self.frame.size.height);
    
    [UIView commitAnimations];
    
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
}

-(void)initUI{
    
    UILabel * quhuoLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 100, 100 , 20)];
    quhuoLabel.font = [UIFont systemFontOfSize:12.0];
    quhuoLabel.text = @"取货地址";
    
    self.sourceAddressField = [[UITextField alloc] init];
    self.sourceAddressField.font = [UIFont systemFontOfSize:12.0];
    self.sourceAddressField.placeholder = @"请输入起始地址";
    self.sourceAddressField.borderStyle = UITextBorderStyleRoundedRect;
    
    UILabel * destionLabel = [[UILabel alloc] init];
    destionLabel.font = [UIFont systemFontOfSize:12.0];
    destionLabel.text= @"送货地址";
    
    self.destioAddressField = [[UITextField alloc] init];
    self.destioAddressField.font = [UIFont systemFontOfSize:12.0];
    self.destioAddressField.placeholder  = @"请输入终点地址";
    self.destioAddressField.borderStyle = UITextBorderStyleRoundedRect;
    
    UILabel * detailLabel = [[UILabel alloc] init];
    detailLabel.font = [UIFont systemFontOfSize:12.0];
    detailLabel.text = @"任务详情";
    
    self.taskDetailTxView = [[UITextView alloc] init];
    self.taskDetailTxView.font = [UIFont systemFontOfSize:12.0];
    self.taskDetailTxView.layer.cornerRadius = 4.0;
    self.taskDetailTxView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.taskDetailTxView.layer.borderWidth = 1.0;
    
    UILabel * taskremunerLabel = [[UILabel alloc] init];
    taskremunerLabel.font = [UIFont systemFontOfSize:12.0];
    taskremunerLabel.text = @"任务酬金";
    
    self.remunerationField = [[UITextField alloc] init];
    self.remunerationField.font = [UIFont systemFontOfSize:12.0];
    self.remunerationField.placeholder = @"请输入任务酬金";
    self.remunerationField.borderStyle = UITextBorderStyleRoundedRect;
    self.remunerationField.keyboardType = UIKeyboardTypeNumberPad;
    self.remunerationField.delegate = self;

    
    self.fabuButton = [[UIButton alloc] init];
    [self.fabuButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.fabuButton setBackgroundColor:[UIColor orangeColor]];
    [self.fabuButton setTitle:@"发布任务" forState:UIControlStateNormal];
    self.fabuButton.layer.cornerRadius = 4.0;
    
    self.quhuoLabel = quhuoLabel;
    self.songhuoLabel = destionLabel;
    self.detailLabel = detailLabel;
    self.remulLabel = taskremunerLabel;
    
    [self addSubview:quhuoLabel];
    [self addSubview:self.sourceAddressField];
    [self addSubview:destionLabel];
    [self addSubview:self.destioAddressField];
    [self addSubview:detailLabel];
    [self addSubview:self.taskDetailTxView];
    [self addSubview:taskremunerLabel];
    [self addSubview:self.remunerationField];
    [self addSubview:self.fabuButton];
     

  
    [self.fabuButton addTarget:self action:@selector(fabuTask) forControlEvents:UIControlEventTouchUpInside];
    
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clearFocus)];
    [self addGestureRecognizer:tap];
}

-(void)layoutSubviews{
    
    [self.quhuoLabel mas_updateConstraints:^(MASConstraintMaker * maker){
        
        maker.left.equalTo(@20);
        maker.top.equalTo(@80);
        maker.height.equalTo(@20);
        maker.right.equalTo(@-20);
    }];
    
    [self.sourceAddressField mas_updateConstraints:^(MASConstraintMaker * maker){
        
        
        maker.left.equalTo(@20);
        maker.right.equalTo(@-20);
        maker.top.equalTo(@120);
        maker.height.equalTo(@30);
    }];
    
    [self.songhuoLabel mas_updateConstraints:^(MASConstraintMaker * maker){
        
        maker.left.equalTo(self.quhuoLabel);
        maker.right.equalTo(self.quhuoLabel);
        maker.height.equalTo(@20);
        maker.top.equalTo(@160);
        
    }];
    
    [self.destioAddressField mas_updateConstraints:^(MASConstraintMaker * maker){
        
        maker.left.equalTo(self.sourceAddressField);
        maker.height.equalTo(self.sourceAddressField);
        maker.right.equalTo(self.sourceAddressField);
        maker.top.equalTo(@200);
        
    }];
    
    [self.detailLabel mas_updateConstraints:^(MASConstraintMaker * maker){
        
        maker.left.equalTo(self.quhuoLabel);
        maker.right.equalTo(self.quhuoLabel);
        maker.height.equalTo(self.quhuoLabel);
        maker.top.equalTo(@240);
        
    }];
    
    [self.taskDetailTxView mas_updateConstraints:^(MASConstraintMaker * maker){
        
        maker.left.equalTo(self.quhuoLabel);
        maker.right.equalTo(self.quhuoLabel);
        maker.height.equalTo(@120);
        maker.top.equalTo(@280);
        
    }];
    
    [self.remulLabel mas_updateConstraints:^(MASConstraintMaker * maker){
        
        maker.left.equalTo(self.quhuoLabel);
        maker.right.equalTo(self.quhuoLabel);
        maker.height.equalTo(self.quhuoLabel);
        maker.top.equalTo(@420);
        
    }];
    
    
    [self.remunerationField mas_updateConstraints:^(MASConstraintMaker * maker){
        
        
        maker.left.equalTo(self.sourceAddressField);
        maker.right.equalTo(self.sourceAddressField);
        maker.height.equalTo(self.sourceAddressField);
        maker.top.equalTo(@460);
    }];
    
    [self.fabuButton mas_updateConstraints:^(MASConstraintMaker * maker){
        
        maker.left.equalTo(@20);
        maker.right.equalTo(@-20);
        maker.height.equalTo(@40);
        maker.top.equalTo(@520);
    }];
    
    
    
}
-(void)fabuTask{
    
    
    __weak typeof(self) weakSelf = self;
    
    if (self.fabuBlock) {
        
        
        NSString * city = [[NSUserDefaults standardUserDefaults] objectForKey:@"city"];
        NSString * phone = [[NSUserDefaults standardUserDefaults] objectForKey:@"phone"];
        
        NSString * sous = self.sourceAddressField.text;
        NSString * dess = self.destioAddressField.text;
        NSString * deta = self.taskDetailTxView.text;
        NSString * sale = self.remunerationField.text;
        
        Network * nt = [[Network alloc] init];
        
        [nt fabupaiDan:phone sourceAddress:sous desAddress:dess taskDetail:deta scale:[sale floatValue] taskCity:city success:^(NSDictionary * dict){
            
                    NSString * code = [NSString stringWithFormat:@"%@",dict[@"code"]];
            
                    if ([code isEqualToString:@"200"]) {
                
                       
                          weakSelf.fabuBlock(1);
                    }else{
                        
                         weakSelf.fabuBlock(2);
                        
                    }
            
                } fail:^(NSError * error){
            
                        
        }];
        
    }
    
    
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    
    if (textField == self.remunerationField) {
        //这里的if时候为了获取删除操作,如果没有次if会造成当达到字数限制后删除键也不能使用的后果.
        if (range.length == 1 && string.length == 0) {
            return YES;
        }
        //so easy
        else if(self.remunerationField.text.length >= 5) {
            self.remunerationField.text = [textField.text substringToIndex:5];
            [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
            [SVProgressHUD showErrorWithStatus:@"暂不支持大金额任务"];

            return NO;
        }
    }
    return YES;
}

-(void)clearFocus{
    
    [self.sourceAddressField resignFirstResponder];
    [self.destioAddressField resignFirstResponder];
    [self.taskDetailTxView resignFirstResponder];
    [self.remunerationField resignFirstResponder];
}
@end
