//
//  LKToolbar.m
//  GoBangGraduationProject
//
//  Created by xiejifan on 2017/12/13.
//  Copyright © 2017年 dahua. All rights reserved.
//

#import "BottomToolbar.h"

@interface BottomToolbar()

@property (nonatomic, strong) UIView *line;
@property (nonatomic, strong) NSArray<UIButton *> *items;

@property (nonatomic, strong) UIButton *backButton;
@property (nonatomic, strong) UIButton *forwardButton;


@end

@implementation BottomToolbar

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupSubViews];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGRect rect = self.bounds;
    rect.origin.y = rect.origin.y - separatorHeight();
    rect.size.height = separatorHeight();
//    [self.line setFrame:rect];
    _line.frame=rect;
    
    rect = self.bounds;
    CGFloat item_w = rect.size.width / self.items.count;
    CGFloat item_h = rect.size.height;
    
    [self.items enumerateObjectsUsingBlock:^(UIButton * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        CGRect frame = CGRectMake(item_w * idx, 0.0, item_w, item_h);
//        [obj setFrame:frame];
        obj.frame=frame;
    }];
}

- (void)setupSubViews
{
    self.backgroundColor = [UIColor whiteColor];
    
    [self addSubview:self.line];
    
    NSArray *canImages = @[@"BottomBarSource.bundle/lkweb_home_nor",@"BottomBarSource.bundle/lkweb_back_can", @"BottomBarSource.bundle/lkweb_next_can", @"BottomBarSource.bundle/lkweb_refresh_nor", @"BottomBarSource.bundle/lkweb_clear_nor"];
    NSArray *hilImages = @[@"BottomBarSource.bundle/lkweb_home_hil",@"BottomBarSource.bundle/lkweb_back_hil", @"BottomBarSource.bundle/lkweb_next_hil", @"BottomBarSource.bundle/lkweb_refresh_hil", @"BottomBarSource.bundle/lkweb_clear_hil"];
    NSMutableArray *items = [NSMutableArray array];
    for (NSInteger i = 0; i < canImages.count; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        if (i == 1) {
            self.backButton = button;
            [button setImage:[UIImage imageNamed:@"BottomBarSource.bundle/lkweb_back_disable"] forState:UIControlStateDisabled];
        }
        if (i == 2) {
            self.forwardButton = button;
            [button setImage:[UIImage imageNamed:@"BottomBarSource.bundle/lkweb_next_disable"] forState:UIControlStateDisabled];
        }
        button.tag = i;
        [button setImage:[UIImage imageNamed:canImages[i]] forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:hilImages[i]] forState:UIControlStateHighlighted];
        [button addTarget:self action:@selector(buttonEvent:) forControlEvents:UIControlEventTouchUpInside];
        [items addObject:button];
        [self addSubview:button];
    }
    self.items = [NSArray arrayWithArray:items];
    
    self.backButton.enabled = NO;
    self.forwardButton.enabled = NO;
}

- (void)buttonEvent:(UIButton *)sender
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(toolbar:event:)]) {
        [self.delegate toolbar:self event:sender.tag];
    }
}

- (UIView *)line
{
    if (!_line) {
        _line = [UIView new];
        _line.backgroundColor = [UIColor grayColor];
    }
    return _line;
}

CG_INLINE CGFloat separatorHeight()
{
    static CGFloat separatorHeight;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        separatorHeight = 1.0 / [UIScreen mainScreen].scale;
    });
    return separatorHeight;
}

@end
