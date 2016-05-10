//
//  LSPicturesView.m
//  梁森微博
//
//  Created by 梁森 on 16/5/9.
//  Copyright © 2016年 LS. All rights reserved.
//

#import "LSPicturesView.h"

@interface LSPicturesView()

@property (nonatomic, strong) UIButton * btn;

@end

@implementation LSPicturesView

- (UIButton *)btn
{
    if (_btn == nil) {
        _btn = [UIButton buttonWithType:UIButtonTypeCustom];
    }
    return _btn;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
//        [self setUpChildView];
    }
    
    return self;
}

- (void)setUpChildView
{
    UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];   // 为什么按钮的大小位置已经固定
    btn.backgroundColor = [UIColor greenColor];
    [btn addTarget:self action:@selector(choosePics) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:btn];
    _btn = btn;
}

- (void)choosePics
{
    NSLog(@"chosePics....");
}

- (void)setImage:(UIImage *)image
{
    _image = image;
    UIImageView * imageView = [[UIImageView alloc] init];
    imageView.image = image;
    [self addSubview:imageView];
}

- (void)layoutSubviews
{
    NSInteger cols = 3;  // 总列数
    CGFloat margin = 10;  // 间距
    CGFloat wh = (self.width - (cols - 1) * margin) / cols;  // 图片的宽和高
    
    CGFloat x = 0;
    CGFloat y = 0;
    NSInteger col = 0;
    NSInteger row = 0;
    
    for (int i = 0; i < self.subviews.count; i ++) {
        if (i < 6) {    // 最多上传6张图片
            UIImageView * imageView = self.subviews[i];
            
            col = i % cols; // 列数
            row = i / cols; // 行数
            x = (wh + margin) * col;
            y = (wh + margin) * row;
            imageView.frame = CGRectMake(x, y, wh, wh);
        }
        
    }
    
}

@end
