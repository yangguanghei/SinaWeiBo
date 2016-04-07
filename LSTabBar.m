//
//  LSTabBar.m
//  梁森微博
//
//  Created by pro on 16/4/7.
//  Copyright © 2016年 LS. All rights reserved.
//

#import "LSTabBar.h"

@interface LSTabBar ()

@property (nonatomic, weak) UIButton *plusBtn;

@end

@implementation LSTabBar

// 懒加载
- (UIButton *)plusBtn
{
    if (_plusBtn == nil) {
        UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setImage:[UIImage imageNamed:@"tabbar_compose_icon_add"] forState:UIControlStateNormal];
        [btn setImage:[UIImage imageNamed:@"tabbar_compose_background_icon_add"] forState:UIControlStateHighlighted];
        
        [btn setBackgroundImage:[UIImage imageNamed:@"tabbar_compose_button"] forState:UIControlStateNormal];
        [btn setBackgroundImage:[UIImage imageNamed:@"tabbar_compose_button_highlighted"] forState:UIControlStateHighlighted];
        
        [btn sizeToFit];
        _plusBtn = btn;
        
        [self addSubview:_plusBtn];
    }
    return _plusBtn;
}


// 调整子控件的位置
- (void)layoutSubviews
{
    [super layoutSubviews];
    NSLog(@"%s", __func__);
    // UITabBarButton
    
    CGFloat height = self.bounds.size.height;
    CGFloat w = self.bounds.size.width;
    // self.subviews 的个数不是UITabBarButton的个数
    CGFloat width = self.bounds.size.width / (self.items.count + 1);
    
    CGFloat btnX = 0;
    int i = 0;
    for (UIView * tabBarButton in self.subviews) {
        if ([tabBarButton isKindOfClass:NSClassFromString(@"UITabBarButton")]) {
            
            if (i == 2) {
                // 右移一个距离
                i = 3;
            }
            
            btnX = i * width;
            tabBarButton.frame = CGRectMake(btnX, 0, width, height);
            
            i ++;
        }
    }
    // 添加中间的按钮
    // 设置添加按钮的位置
//    self.plusButton.center = CGPointMake(w * 0.5, height * 0.5);
    self.plusBtn.center = CGPointMake(w * 0.5, height * 0.5);
}

@end
