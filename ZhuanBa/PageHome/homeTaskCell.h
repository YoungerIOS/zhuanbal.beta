//
//  homeTaskCell.h
//  ZhuanBa
//
//  Created by developer on 2018/8/22.
//  Copyright © 2018年 developer. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^qinangDanBlock)(UITableViewCell * cell);

@interface homeTaskCell : UITableViewCell
@property (nonnull,strong) UILabel * priceLabel;            // 金额
@property (nonnull,strong) UILabel * originLabel;           // 起点位置
@property (nonnull,strong) UILabel * destionLabel;          // 终点位置
@property (nonnull,strong) UIButton * confirmButton;         // 抢单
@property (nonnull,strong) qinangDanBlock qinagDan;

@end
