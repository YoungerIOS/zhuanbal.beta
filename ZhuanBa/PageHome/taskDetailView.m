//
//  taskDetailView.m
//  ZhuanBa
//
//  Created by developer on 2018/8/27.
//  Copyright © 2018年 developer. All rights reserved.
//

#import "taskDetailView.h"

@implementation taskDetailView

-(id)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
   
        self.contentView = [[UIView alloc] init];
        self.bgView = [[UIView alloc] init];
        self.titleView = [[UIView alloc] init];
        self.orderScale = [[UILabel alloc] init];
        self.dateLabel = [[UILabel alloc] init];
        self.huowudizhi = [[UILabel alloc] init];
        self.destiondizhi = [[UILabel alloc] init];
        self.detailLabel = [[UILabel alloc] init];
        self.lineOne = [[UIView alloc] init];
        self.lineTwo = [[UIView alloc] init];
        self.quHuotitle = [[UILabel alloc] init];
        self.souHuotitle = [[UILabel alloc] init];
        self.tasktitle = [[UILabel alloc] init];
        self.doneButton = [[UIButton alloc] init];
    
        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(taskdismiss)];
        [self.bgView addGestureRecognizer:tap];

        
        self.bgView.backgroundColor = [UIColor blackColor];
        self.bgView.alpha = 0.4;
        self.contentView.backgroundColor = [UIColor whiteColor];
        self.orderScale.textAlignment = NSTextAlignmentCenter;
        self.dateLabel.textAlignment = NSTextAlignmentCenter;
        
        self.orderScale.textColor = [UIColor whiteColor];
        self.dateLabel.textColor  = [UIColor whiteColor];
        self.lineOne.backgroundColor = [UIColor grayColor];
        self.lineOne.alpha = 0.2;
        self.lineTwo.backgroundColor = [UIColor grayColor];
        self.lineTwo.alpha = 0.2;
        
        self.quHuotitle.font = [UIFont systemFontOfSize:12.0];
        self.huowudizhi.font = [UIFont systemFontOfSize:14.0];
        self.souHuotitle.font = [UIFont systemFontOfSize:12.0];
        self.destiondizhi.font = [UIFont systemFontOfSize:14.0];
        self.tasktitle.font   = [UIFont systemFontOfSize:12.0];
        self.detailLabel.font = [UIFont systemFontOfSize:14.0];
        
        self.orderScale.numberOfLines = 2;
        self.huowudizhi.numberOfLines = 2;
        self.destiondizhi.numberOfLines = 2;
        self.detailLabel.numberOfLines  = 0;
        self.quHuotitle.text = @"起始地";
        self.souHuotitle.text = @"目的地";
        self.tasktitle.text   = @"注意事项";
        
        [self.doneButton addTarget:self action:@selector(buttonTarget) forControlEvents:UIControlEventTouchUpInside];
        [self.doneButton.titleLabel setFont:[UIFont systemFontOfSize:14.0]];
        
        [self addSubview:self.bgView];
        
        [self.titleView addSubview:self.orderScale];
        [self.titleView addSubview:self.dateLabel];
        
        [self.contentView addSubview:self.titleView];
        [self.contentView addSubview:self.huowudizhi];
        [self.contentView addSubview:self.destiondizhi];
        [self.contentView addSubview:self.detailLabel];
        [self.contentView addSubview:self.quHuotitle];
        [self.contentView addSubview:self.souHuotitle];
        [self.contentView addSubview:self.tasktitle];
        [self.contentView addSubview:self.lineOne];
        [self.contentView addSubview:self.lineTwo];
        [self.contentView addSubview:self.doneButton];
        [self addSubview:self.contentView];
        
        self.contentView.layer.cornerRadius = 4.0;
        self.contentView.layer.masksToBounds = YES;
    }
    
    return self;
}
-(void)layoutSubviews{
    [super layoutSubviews];

    self.titleView.backgroundColor = [SchemeColor schemeColor];
    self.doneButton.backgroundColor = [SchemeColor schemeColor];
    

    [self.bgView mas_updateConstraints:^(MASConstraintMaker * maker){
        
        maker.edges.mas_equalTo(UIEdgeInsetsMake(0, 0, 0, 0));
        
    }];
    [self.contentView mas_updateConstraints:^(MASConstraintMaker * maker){

        maker.left.equalTo(@20);
        maker.right.equalTo(@-20);
        maker.height.equalTo(@400);
        maker.center.equalTo(@0);
    }];

    [self.titleView mas_updateConstraints:^(MASConstraintMaker * maker){
        
        maker.left.equalTo(@0);
        maker.right.equalTo(@0);
        maker.top.equalTo(@0);
        maker.height.equalTo(@60);
        
    }];

    [self.lineOne mas_updateConstraints:^(MASConstraintMaker * maker){

        maker.left.and.right.equalTo(@0);
        maker.height.equalTo(@1.0);
        maker.top.equalTo(@120);

    }];
    [self.lineTwo mas_updateConstraints:^(MASConstraintMaker * maker){

        maker.left.and.right.equalTo(@0);
        maker.height.equalTo(@1.0);
        maker.top.equalTo(@180);

    }];

    [self.orderScale mas_updateConstraints:^(MASConstraintMaker * maker){

        maker.left.equalTo(@10);
        maker.top.equalTo(@0);
        maker.width.equalTo(@90);
        maker.height.equalTo(@60);

    }];

    [self.dateLabel mas_updateConstraints:^(MASConstraintMaker * maker){

        maker.top.and.bottom.equalTo(@0);
        maker.left.mas_equalTo(100);
        maker.right.mas_equalTo(-100);
        maker.height.mas_equalTo(60);

    }];

    
    
    [self.quHuotitle mas_updateConstraints:^(MASConstraintMaker * maker){

        maker.left.mas_equalTo(20);
        maker.width.mas_equalTo(90);
        maker.top.equalTo(@60);
        maker.height.equalTo(@60);
       

    }];
    
    [self.huowudizhi mas_updateConstraints:^(MASConstraintMaker * maker){

        maker.left.equalTo(@90);
        maker.right.equalTo(@-20);
        maker.top.equalTo(@60);
        maker.height.equalTo(@60);


    }];
    
    [self.souHuotitle mas_updateConstraints:^(MASConstraintMaker * maker){

        maker.left.mas_equalTo(20);
        maker.width.mas_equalTo(90);
        maker.top.equalTo(@120);
        maker.height.equalTo(@60);

    }];
    [self.destiondizhi mas_updateConstraints:^(MASConstraintMaker * maker){
        
        maker.left.equalTo(@90);
        maker.right.equalTo(@-20);
        maker.top.equalTo(@120);
        maker.height.equalTo(@60);

    }];
    [self.tasktitle mas_updateConstraints:^(MASConstraintMaker * maker){

        maker.left.equalTo(@20);
        maker.width.equalTo(@90);
        maker.top.equalTo(@180);
        maker.height.equalTo(@60);
        


    }];
    [self.detailLabel mas_updateConstraints:^(MASConstraintMaker * maker){

        maker.left.equalTo(@90);
        maker.right.equalTo(@-20);
        maker.top.equalTo(@190);
        maker.height.equalTo(@120);

    }];
    
    [self.doneButton mas_updateConstraints:^(MASConstraintMaker * maker){
        
        maker.centerX.equalTo(self.contentView.mas_centerX);
        maker.bottom.equalTo(self.contentView.mas_bottom).offset(-20);
        maker.width.equalTo(@60);
        maker.height.equalTo(@60);
        
    }];
    
    self.detailLabel.contentMode = UIViewContentModeTop;
    self.doneButton.layer.cornerRadius = 30.0;
    
    if (self.detailTask) {
        
        self.huowudizhi.text = self.detailTask[@"sourceaddress"];
        self.destiondizhi.text = self.detailTask[@"desaddress"];
        self.detailLabel.text = self.detailTask[@"detail"];
        CGSize size = [self.detailLabel sizeThatFits:CGSizeMake(self.frame.size.width - 110, 120)];
        
        [self.detailLabel mas_updateConstraints:^(MASConstraintMaker * maker){
            
            maker.left.equalTo(@90);
            maker.right.equalTo(@-20);
            maker.top.equalTo(@190);
            maker.height.equalTo(@(size.height));
            
        }];
        
        self.orderScale.text  = [NSString stringWithFormat:@"服务费:\n%@元",self.detailTask[@"taskscale"]];
        self.dateLabel.text   = self.detailTask[@"taskdate"];
        
        if (self.detailView == chakanxinxi) {
         
            [self.doneButton setTitle:@"立即抢单" forState:UIControlStateNormal];
            
        }else if (self.detailView == qiangdanSuccess) {
            
            [self.doneButton setTitle:@"抢单成功" forState:UIControlStateNormal];
            
        }else if (self.detailView == qiangdanlist){
            
            [self.doneButton setTitle:@"确认支付" forState:UIControlStateNormal];
            
            int taskstatus = [[NSString stringWithFormat:@"%@",self.detailTask[@"taskstatus"]] intValue];
            
            if (taskstatus != 3) {
                
                [self.doneButton setHidden:YES];
            }
            
        }else if (self.detailView == paidanlist){
            
            [self.doneButton setTitle:@"确认完成" forState:UIControlStateNormal];
            
             int taskstatus = [[NSString stringWithFormat:@"%@",self.detailTask[@"taskstatus"]] intValue];
            
            if (taskstatus != 2) {
                
                [self.doneButton setHidden:YES];
            }
        }
        
        
    
    }
    
    
}

-(void)taskdismiss{
    
    [self removeFromSuperview];
    
}
-(void)buttonTarget{
    
    if (self.buttonMethod) {
        
        self.buttonMethod(self);
    }
    
}
@end
