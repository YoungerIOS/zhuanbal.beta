//
//  fabuTaskVC.h
//  ZhuanBa
//
//  Created by developer on 2018/8/23.
//  Copyright © 2018年 developer. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface fabuTaskView : UIView
@property (nonatomic,copy) void (^fabuBlock)(int state);            // 1.成功   2.失败
@property (nonnull,strong) UIButton * fabuButton;
-(void)fabuTask;
@end
