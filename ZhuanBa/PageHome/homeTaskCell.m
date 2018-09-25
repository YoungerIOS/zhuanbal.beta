//
//  homeTaskCell.m
//  ZhuanBa
//
//  Created by developer on 2018/8/22.
//  Copyright © 2018年 developer. All rights reserved.
//

#import "homeTaskCell.h"

@implementation homeTaskCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.priceLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 80, 40)];
        self.priceLabel.font = [UIFont systemFontOfSize:18.0];
        self.priceLabel.textColor = [UIColor redColor];
        self.priceLabel.text = @"10";
        
        CGSize size = [UIScreen mainScreen].bounds.size;
        
        self.originLabel = [[UILabel alloc] initWithFrame:CGRectMake(80, 0, size.width - 80 - 60 , 40 )];
        self.originLabel.textColor = [UIColor grayColor];
        self.originLabel.font = [UIFont systemFontOfSize:14.0];
        self.originLabel.numberOfLines = 2;
        
        self.destionLabel = [[UILabel alloc] initWithFrame:CGRectMake(80, 40, self.originLabel.frame.size.width, 40)];
        self.destionLabel.textColor = [UIColor grayColor];
        self.destionLabel.font = [UIFont systemFontOfSize:14.0];
        self.destionLabel.numberOfLines = 2;
        
        self.confirmButton = [[UIButton alloc] initWithFrame:CGRectMake(size.width - 60, 0, 60, 40)];
        [self.confirmButton setTitle:@"立即抢单" forState:UIControlStateNormal];
        self.confirmButton.center = CGPointMake(size.width - 35, 40);
        self.confirmButton.titleLabel.font = [UIFont systemFontOfSize:14.0];
        [self.confirmButton setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
        [self.confirmButton addTarget:self action:@selector(qiangdanButtonMethod) forControlEvents:UIControlEventTouchUpInside];
        
        
        [self addSubview:self.priceLabel];
        [self addSubview:self.originLabel];
        [self addSubview:self.destionLabel];
        [self addSubview:self.confirmButton];
    }
    
    return self;
}

-(void)qiangdanButtonMethod{
    
    __weak typeof(self) weakSelf = self;
    if (self.qinagDan) {
        
        weakSelf.qinagDan(weakSelf);
    }
}
- (void)awakeFromNib {
    [super awakeFromNib];
   
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}

- (NSMutableAttributedString *)attributedLabelTextWithText:(float)text {
    
    if (text) {
        
        NSString *string = [NSString stringWithFormat:@"%.f%%",text];
        
        NSRange range = NSMakeRange(2, 1);
        
        NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:string];
        //设置字体颜色
        [str addAttribute:NSForegroundColorAttributeName value:[UIColor yellowColor] range:range];
        //设置字体大小
        [str addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"CourierNewPS-ItalicMT" size:24] range: range];
        
        return str;
        
    }else {
        return nil;
    }
    
    
}

@end
