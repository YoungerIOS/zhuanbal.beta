//
//  taskCell.h
//  ZhuanBa
//
//  Created by developer on 2018/8/27.
//  Copyright © 2018年 developer. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface taskCell : UITableViewCell
@property (nonatomic,strong) UILabel * numberLabel;
@property (nonatomic,strong) UILabel * stateLabel;
@property (nonatomic,strong) UILabel * saleLabel;
@property (nonatomic,strong) UILabel * destionLabel;
@property (nonatomic,strong) NSDictionary * taskData;
@end
