//
//  LSTollView.m
//  梁森微博
//
//  Created by 梁森 on 16/4/27.
//  Copyright © 2016年 LS. All rights reserved.
//

#import "LSTollView.h"

@interface LSTollView()
/**
 *  三个按钮
 */
@property (nonatomic, strong) NSMutableArray * btns;
/**
 *  按钮的分割线
 */
@property (nonatomic, strong) NSMutableArray *divideVs;

@end

@implementation LSTollView

- (NSMutableArray *)btns
{
    if (_btns == nil) {
        _btns = [NSMutableArray array];
    }
    return _btns;
}
- (NSMutableArray *)divideVs
{
    if (_divideVs == nil) {
        
        _divideVs = [NSMutableArray array];
    }
    
    return _divideVs;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        // 添加子控件
        [self setUpChildView];
        self.userInteractionEnabled = YES;
//        self.backgroundColor = [UIColor whiteColor];
        self.image = [UIImage imageWithStretchableName:@"timeline_card_bottom_background"];
    }
    
    return self;
}

- (void)setUpChildView
{
    // 转发
    UIButton * retweet = [self setUpOneButtonWithTitle:@"转发" image:[UIImage imageNamed:@"timeline_icon_retweet"]];
    // 评论
    UIButton * comment = [self setUpOneButtonWithTitle:@"评论" image:[UIImage imageNamed:@"timeline_icon_comment"]];
    // 赞
    UIButton * like = [self setUpOneButtonWithTitle:@"赞" image:[UIImage imageNamed:@"timeline_icon_unlike"]];
    // 添加分隔线
    for (int i = 0; i < 2; i++) {
        UIImageView *divideV = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"timeline_card_bottom_line"]];
        [self addSubview:divideV];
        [self.divideVs addObject:divideV];
    }
    
}
- (UIButton *)setUpOneButtonWithTitle:(NSString *)title image:(UIImage *)image
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setImage:image forState:UIControlStateNormal];
    
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    // 设置字体大小
    btn.titleLabel.font = [UIFont systemFontOfSize:12];
    // 设置文字和图片的间距
    btn.titleEdgeInsets = UIEdgeInsetsMake(0, 5, 0, 0);
    btn.titleLabel.textColor = [UIColor blackColor];
    
    [self addSubview:btn];
    [self.btns addObject:btn];
    return btn;
}
// 设置子控件的位置
- (void)layoutSubviews
{
    [super layoutSubviews];
    // 设置三个按钮的位置
    for (int i = 0; i < self.btns.count; i ++) {
        UIButton * btn = self.btns[i];
        NSUInteger count = self.btns.count;
        CGFloat w = WIDTH / count;
        CGFloat x = i * w;
        CGFloat y = 0;
        CGFloat h = self.height;
        btn.frame = CGRectMake(x, y, w, h);
    }
    // 分割线的位置
    int i = 1;
    
    for (UIImageView *divide in self.divideVs) {
        UIButton *btn = self.btns[i];
        divide.x = btn.x;
        i++;
    }
}

@end
