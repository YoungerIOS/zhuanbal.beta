//
//  taskCell.m
//  ZhuanBa
//
//  Created by developer on 2018/8/27.
//  Copyright © 2018年 developer. All rights reserved.
//

#import "taskCell.h"

@implementation taskCell

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.numberLabel = [[UILabel alloc] init];
        self.numberLabel.font = [UIFont systemFontOfSize:14.0];
        self.stateLabel = [[UILabel alloc] init];
        self.stateLabel.font = [UIFont systemFontOfSize:14.0];
        self.stateLabel.textAlignment = NSTextAlignmentRight;
        self.saleLabel = [[UILabel alloc] init];
        self.saleLabel.font = [UIFont systemFontOfSize:14.0];
        self.destionLabel = [[UILabel alloc] init];
        self.destionLabel.font = [UIFont systemFontOfSize:14.0];
        self.destionLabel.textAlignment = NSTextAlignmentRight;
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        [self addSubview:self.numberLabel];
        [self addSubview:self.stateLabel];
        [self addSubview:self.saleLabel];
        [self addSubview:self.destionLabel];
    }
    
    return self;
}
-(void)layoutSubviews{
    
    [super layoutSubviews];
    
    [self.numberLabel mas_remakeConstraints:^(MASConstraintMaker  * maker){
        
        maker.left.top.equalTo(@20);
        maker.width.equalTo(@100);
        maker.height.equalTo(@20);
        
    }];
    [self.stateLabel mas_remakeConstraints:^(MASConstraintMaker * maker){
        
        maker.top.equalTo(@20);
        maker.width.equalTo(@120);
        maker.height.equalTo(@20);
        maker.right.equalTo(@-20);
    }];
    [self.saleLabel mas_remakeConstraints:^(MASConstraintMaker * maker){
        
        maker.left.equalTo(@20);
        maker.top.equalTo(self.numberLabel.mas_bottom).offset(10);
        maker.width.equalTo(@80);
        maker.height.equalTo(@20);
        
    }];
    [self.destionLabel mas_remakeConstraints:^(MASConstraintMaker * maker){
        
        maker.left.equalTo(self.saleLabel.mas_right).offset(10);
        maker.top.equalTo(self.saleLabel);
        maker.right.equalTo(@-20);
        
    }];
 
    if (self.taskData) {
        
        self.numberLabel.text = [NSString stringWithFormat:@"%@",self.taskData[@"tasknumber"]];
        NSString * state = [NSString stringWithFormat:@"%@",self.taskData[@"taskstatus"]];
        
        if ([state isEqualToString:@"1"]) {
            
            self.stateLabel.text = @"等待抢单";
            
        }else if ([state isEqualToString:@"2"]){
            
            self.stateLabel.text = @"已经抢单";
            
        }else if ([state isEqualToString:@"3"]){
            
            self.stateLabel.text = @"任务完成";
            
        }else if ([state isEqualToString:@"4"]){
            
            self.stateLabel.text = @"支付完成";
            
        }
        
        self.saleLabel.text = [NSString stringWithFormat:@"%@",self.taskData[@"taskscale"]];
        self.destionLabel.text = [NSString stringWithFormat:@"%@",self.taskData[@"desaddress"]];
        
        
    }
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
