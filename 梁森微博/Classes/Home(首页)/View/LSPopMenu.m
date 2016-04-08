//
//  LSPopMenu.m
//  梁森微博
//
//  Created by pro on 16/4/8.
//  Copyright © 2016年 LS. All rights reserved.
//

#import "LSPopMenu.h"

@implementation LSPopMenu

+ (instancetype)showWithRect:(CGRect)rect
{
    LSPopMenu * menu = [[LSPopMenu alloc] initWithFrame:rect];
    // 让图片不难看的一个方法😄
    menu.image = [UIImage imageWithStretchableName:@"popover_background"];
    // 拦截点击事件
    menu.userInteractionEnabled = YES;
    [LSKeyWindow addSubview:menu];
    
    return menu;
}

+ (void)hide
{
    // 从主窗口上一次本视图(图片视图不同于视图，不能直接移除)
    for (UIView * menuView in LSKeyWindow.subviews) {
        if ([menuView isKindOfClass:self]) {
            
            [menuView removeFromSuperview];
        }
    }
    
}

// 设置菜单的内容视图
- (void)setContenView:(UIView *)contentView
{
    [_contenView removeFromSuperview];
    _contenView = contentView;
    _contenView.backgroundColor = [UIColor clearColor];
    [self addSubview:contentView];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    // 计算内容视图尺寸
    CGFloat y = 9;
    CGFloat margin = 5;
    CGFloat x = margin;
    CGFloat w = self.width - 2 * margin;
    CGFloat h = self.height - y - margin;
    _contenView.backgroundColor = [UIColor clearColor];
    _contenView.frame = CGRectMake(x, y, w, h);
    
}

@end
