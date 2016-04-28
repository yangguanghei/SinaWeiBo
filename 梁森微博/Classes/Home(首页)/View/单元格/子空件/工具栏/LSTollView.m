//
//  LSTollView.m
//  梁森微博
//
//  Created by 梁森 on 16/4/27.
//  Copyright © 2016年 LS. All rights reserved.
//

#import "LSTollView.h"

@interface LSTollView()

@end

@implementation LSTollView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        // 添加子控件
        [self setUpChildView];
        self.backgroundColor = [UIColor redColor];
    }
    
    return self;
}

- (void)setUpChildView
{
    
}

- (void)setStatusF:(LSStatusFrame *)statusF
{
    _statusF = statusF;
}

@end
