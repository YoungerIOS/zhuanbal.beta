//
//  taskDetailView.h
//  ZhuanBa
//
//  Created by developer on 2018/8/27.
//  Copyright © 2018年 developer. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef enum {
    chakanxinxi,
    qiangdanSuccess,
    qiangdanlist,
    paidanlist
}cellType;
@interface taskDetailView : UIView
@property (nonatomic,strong) UILabel * quHuotitle;
@property (nonatomic,strong) UILabel * souHuotitle;
@property (nonatomic,strong) UILabel * tasktitle;
@property (nonatomic,strong) UIView * titleView;
@property (nonatomic,strong) UIView * contentView;
@property (nonatomic,strong) UIView * bgView;
@property (nonatomic,strong) UIView * lineOne;
@property (nonatomic,strong) UIView * lineTwo;
@property (nonatomic,strong) UILabel * orderScale;
@property (nonatomic,strong) UILabel * dateLabel;
@property (nonatomic,strong) UILabel * huowudizhi;
@property (nonatomic,strong) UILabel * destiondizhi;
@property (nonatomic,strong) UILabel * detailLabel;
@property (nonatomic,strong) UIButton * doneButton;
@property (nonatomic) cellType detailView;
@property (nonatomic,strong) NSDictionary * detailTask;
@property (nonatomic,copy) void (^buttonMethod)(taskDetailView * detailView);
@end
