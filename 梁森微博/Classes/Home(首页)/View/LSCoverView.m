//
//  LSCoverView.m
//  梁森微博
//
//  Created by pro on 16/4/8.
//  Copyright © 2016年 LS. All rights reserved.
//

#import "LSCoverView.h"

@implementation LSCoverView

+ (instancetype)show
{
    LSCoverView * coverView = [[LSCoverView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    coverView.backgroundColor = [UIColor colorWithRed:29 / 255.f green:29 / 255.f blue:29 / 255.f alpha:0.5];
    UIWindow * keyWindow = [UIApplication sharedApplication].keyWindow;
    // 将蒙板添加到主窗口上  如果要让它消失，我会添加一个手势在上面
    [keyWindow addSubview:coverView];
    return coverView;
}

// 视图上就有点击这个方法
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    NSLog(@"点击蒙板。。。");
    // 移除本视图即蒙板
    [self removeFromSuperview];
    // 同时需要将菜单移除
    if ([self.delegate respondsToSelector:@selector(didClickCoverView)]) {
        // 代理响应协议中的方法
        [self.delegate didClickCoverView];
    }
}

@end
