//
//  LSSendToolBar.m
//  梁森微博
//
//  Created by 梁森 on 16/5/9.
//  Copyright © 2016年 LS. All rights reserved.
//

#import "LSSendToolBar.h"

@implementation LSSendToolBar

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        // 设置所有子控件
        [self setUpAllChildView];
    }
    
    return self;
}
#pragma mark ------ 设置所有子控件
- (void)setUpAllChildView
{
    // 相册
    [self SetButtonWithImage:[UIImage imageNamed:@"compose_toolbar_picture"] highImage:[UIImage imageNamed:@"compose_toolbar_picture_highlighted"] target:self action:@selector(sendBtn:) forControlEvents:UIControlEventTouchUpInside];
    // 提及
    [self SetButtonWithImage:[UIImage imageNamed:@"compose_mentionbutton_background"] highImage:[UIImage imageNamed:@"compose_mentionbutton_background_highlighted"] target:self action:@selector(sendBtn:) forControlEvents:UIControlEventTouchUpInside];
    
    // 话题
    [self SetButtonWithImage:[UIImage imageNamed:@"compose_trendbutton_background"] highImage:[UIImage imageNamed:@"compose_trendbutton_background_highlighted"] target:self action:@selector(sendBtn:) forControlEvents:UIControlEventTouchUpInside];
    // 表情
    [self SetButtonWithImage:[UIImage imageNamed:@"compose_emoticonbutton_background"] highImage:[UIImage imageNamed:@"compose_emoticonbutton_background_highlighted"] target:self action:@selector(sendBtn:) forControlEvents:UIControlEventTouchUpInside];
    // 键盘
    [self SetButtonWithImage:[UIImage imageNamed:@"compose_keyboardbutton_background"] highImage:[UIImage imageNamed:@"compose_keyboardbutton_background_highlighted"] target:self action:@selector(sendBtn:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)SetButtonWithImage:(UIImage *)image highImage:(UIImage *)highImage target:(id)target action:(SEL)action forControlEvents:(UIControlEvents)controlEvents
{
    // btn
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setImage:image forState:UIControlStateNormal];
    [btn setImage:image forState:UIControlStateHighlighted];
    
    [btn addTarget:target action:action forControlEvents:controlEvents];
    
    [self addSubview:btn];
}

- (void)sendBtn:(UIButton *)btn
{
    NSLog(@".....");
}

#pragma mark ------ 对子控件进行布局
- (void)layoutSubviews
{
    [super layoutSubviews];
    NSUInteger count = self.subviews.count;
    for ( int i = 0; i < count; i ++) {
        
        UIButton * btn = self.subviews[i];
        CGFloat x = 0;
        CGFloat y = 0;
        CGFloat w = self.width / count;
        CGFloat h = self.height;
        x = i * w;
        btn.frame = CGRectMake(x, y, w, h);
    }
}

@end






