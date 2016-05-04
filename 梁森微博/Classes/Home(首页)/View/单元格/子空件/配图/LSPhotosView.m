//
//  LSPhotosView.m
//  梁森微博
//
//  Created by 梁森 on 16/5/4.
//  Copyright © 2016年 LS. All rights reserved.
//

#import "LSPhotosView.h"

#import "UIImageView+WebCache.h"
// 图片模型
#import "LSPhonto.h"
@implementation LSPhotosView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setUpChildView];
//        self.backgroundColor = [UIColor redColor];
    }
    return self;
}

- (void)setUpChildView
{
    // 最多显示9张图片
    for (int i = 0 ; i < 9 ; i ++) {
        UIImageView * imageView = [[UIImageView alloc] init];
        imageView.contentMode = UIViewContentModeScaleAspectFill;
        // 裁剪图片，超出控件的部分裁剪掉
        imageView.clipsToBounds = YES;
        [self addSubview:imageView];
    }
}

- (void)setPic_urls:(NSArray *)pic_urls
{
    _pic_urls = pic_urls;
    NSUInteger counts = self.subviews.count;
    for (int i = 0; i < counts; i ++) {
        UIImageView * imageView = self.subviews[i];
        // 9张图片以内显示上传的所有图片
        if (i < _pic_urls.count) {
            // 显示
            imageView.hidden = NO;
            LSPhonto * photo = _pic_urls[i];
            [imageView sd_setImageWithURL:photo.thumbnail_pic placeholderImage:[UIImage imageNamed:@"timeline_image_placeholder"]];
        }else
        {
            // 隐藏
            imageView.hidden = YES;
        }
    }
}
// 计算尺寸
- (void)layoutSubviews
{
    [super layoutSubviews];
    CGFloat x = 0;
    CGFloat y = 0;
    CGFloat w = 70;
    CGFloat h = 70;
    CGFloat margin = 10;
    int col = 0;
    int rol = 0;
    int cols = _pic_urls.count==4?2:3;
    // 计算显示出来的imageView
    for (int i = 0; i < _pic_urls.count; i++) {
        col = i % cols;
        rol = i / cols;
        UIImageView *imageV = self.subviews[i];
        x = col * (w + margin);
        y = rol * (h + margin);
        imageV.frame = CGRectMake(x, y, w, h);
        imageV.backgroundColor = [UIColor yellowColor];
//        NSLog(@"%@", imageV.frame);
    }
    
    
}

@end
