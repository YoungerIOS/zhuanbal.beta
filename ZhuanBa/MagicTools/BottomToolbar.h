//
//  LKToolbar.h
//  GoBangGraduationProject
//
//  Created by xiejifan on 2017/12/13.
//  Copyright © 2017年 dahua. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, LKToolbarEvent) {
    BottomToolbarHomeEvent    = 0, 
    BottomToolbarBackEvent    = 1,
    BottomToolbarNextEvent    = 2,
    BottomToolbarRefreshEvent = 3,
    BottomToolbarClearEvent   = 4
};

@class BottomToolbar;

@protocol BottomToolbarDelegate <NSObject>

- (void)toolbar:(BottomToolbar *)webToolbar event:(LKToolbarEvent)event;

@end

@interface BottomToolbar : UIView

@property (nonatomic, weak) id<BottomToolbarDelegate>delegate;
@property (readonly) UIButton *backButton;
@property (readonly) UIButton *forwardButton;

@end
